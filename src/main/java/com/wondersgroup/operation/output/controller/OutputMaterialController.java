package com.wondersgroup.operation.output.controller;

import java.io.IOException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javassist.runtime.DotClass;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.wondersgroup.data.jpa.entity.Attachment;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.data.jpa.entity.LastUpdateBizData;
import com.wondersgroup.data.jpa.entity.OutputMatBom;
import com.wondersgroup.data.jpa.entity.OutputMaterial;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.common.LastUpdateBizDataService;
import com.wondersgroup.framework.file.excel.ImportService;
import com.wondersgroup.framework.file.excel.model.ValidationResult;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.DataDicConstant;
import com.wondersgroup.framework.util.DataUtil;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FileUploadUtils;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.output.model.DTOOutputMaterialCreate;
import com.wondersgroup.operation.output.model.DTOOutputMaterialInfo;
import com.wondersgroup.operation.output.model.DTOOutputMaterialQueryData;
import com.wondersgroup.operation.output.model.DTOOutputMaterialUpdate;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.operation.util.file.UploadUtils;
import com.wondersgroup.service.company.CompanyService;
import com.wondersgroup.service.export.ReadandWriteExcel;
import com.wondersgroup.service.input.InputMaterialService;
import com.wondersgroup.service.input.SupplierImportService;
import com.wondersgroup.service.output.OutputMaterialImportService;
import com.wondersgroup.service.output.OutputMaterialService;
import com.wondersgroup.util.FileUtil;

/**
 *
 * @author wanglei
 */
@Controller
@RequestMapping("/outputManage/outputMaterial")
public class OutputMaterialController extends AbstractBaseController {
	private static final Logger LOGGER = LoggerFactory.getLogger(OutputMaterialController.class);
	@Autowired
	private OutputMaterialService outputMaterialService;
	@Autowired
	private LastUpdateBizDataService lastUpdateBizDataService;
	@Autowired
	private CompanyService companyService;
	@Autowired
	private InputMaterialService inputMaterialService;
	@Autowired
	private OutputMaterialImportService outputMaterialImportService;
	@Autowired
	private ImportService importService;
	@Autowired
	private UploadUtils uploadUtils;
	// 上传类型 -- 产出品 品图片
	public static final String UPLOAD_TYPE_OUTPUTMAT_IMAGE = "OUTPUTMAT_IMAGE";
	// 上传类型 -- 产出品 检验检测报告
	public static final String UPLOAD_TYPE_OUTPUTMAT_JY_JC_REPORT = "OUTPUTMAT_JY_JC_REPORT";//
	// 上传类型 -- 产出品 生产许可证
	public static final String UPLOAD_TYPE_OUTPUTMAT_PRODUCTION_CERTIFICATE = "OUTPUTMAT_PRODUCTION_CERTIFICATE";//
	public static final Map<String, String> uploadTypeToAttachTypeMap = new HashMap<String, String>() {
		private static final long serialVersionUID = 6629562394177052992L;

		{
			put(UPLOAD_TYPE_OUTPUTMAT_IMAGE, FoodConstant.ATT_OUTPUTMAT_IMAGE);
			put(UPLOAD_TYPE_OUTPUTMAT_JY_JC_REPORT, FoodConstant.ATT_OUTPUTMAT_JY_JC_REPORT);
			put(UPLOAD_TYPE_OUTPUTMAT_PRODUCTION_CERTIFICATE, FoodConstant.ATT_OUTPUTMAT_PROD_CERT);
		}
	};
	private static final List<String> singleImageTypes = new ArrayList<String>() {
		private static final long serialVersionUID = 6694506005823947192L;

		{
			add(UPLOAD_TYPE_OUTPUTMAT_IMAGE);
		}
	};

	/**
	 * 新增产出品 ,并且更新产出品与采购品的关联
	 * 
	 * @param dto
	 * @return
	 */
	@RequestMapping(value = "/createOutputMaterial", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult createOutputMaterial(@Valid @RequestBody DTOOutputMaterialCreate dto) {
		int companyId = getLoginCompanyId();
		if (StringUtils.isNotBlank(dto.getProductionBarcode())) {
			OutputMaterial material = outputMaterialService.getOutputMaterialByProductionBarcode(dto.getProductionBarcode(), companyId);
			if (null != material) {
				throw FoodException.returnException("000005");
			}
		}
		OutputMaterial material = DTOOutputMaterialCreate.toEntity(dto, companyId);
		if (material == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		List<Integer> list = new ArrayList<>();
		list.addAll(dto.getInputMatIdList());
		material = outputMaterialService.createOutputMaterial(material);
		outputMaterialService.updateOutputMatBom(material.getId(), list, companyId);
		lastUpdateBizDataService.updateLastUpdateBizData(companyId, LastUpdateBizData.TYPE_OUTPUT_MAT_BOM);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, material);
	}

	/**
	 * 修改产出品
	 * 
	 * @param dto
	 * @return
	 */
	@RequestMapping(value = "/updateOutputMaterial", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateOutputMaterial(@Valid @RequestBody DTOOutputMaterialUpdate dto) {
		int companyId = getLoginCompanyId();
		OutputMaterial material = DTOOutputMaterialUpdate.toEntity(dto, outputMaterialService);
		if (material == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		List<Integer> list = new ArrayList<>();
		list.addAll(dto.getInputMatIdList());
		outputMaterialService.updateOutputMatBom(material.getId(), list, companyId);
		outputMaterialService.updateOutputMaterial(material);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, material.getId());
	}

	/**
	 * 采购品详细
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/getOutputMaterialById/{id}", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult getOutputMaterialById(@PathVariable int id) {
		int companyId = getLoginCompanyId();
		OutputMaterial material = outputMaterialService.getOutputMaterialById(id);
		// outputMaterialService.queryOutputMatBomList(outputMatId, companyId)
		if (material == null || DataUtil.isDeleted(material.getDelFlag())) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		// 9.28添加采购品关联进货
		List<OutputMatBom> outputMatBomlist = outputMaterialService.queryOutputMatBomList(id, companyId);
		DTOOutputMaterialInfo dto = DTOOutputMaterialInfo.createByEntity(material, outputMatBomlist, inputMaterialService);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, dto);
	}

	/**
	 * 删除采购品
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/deleteOutputMaterial/{id}", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult deleteMaterialInfo(@PathVariable int id) {
		outputMaterialService.deleteOutputMaterial(id);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, id);
	}

	/**
	 * 查询采购品
	 * 
	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/queryOutputMaterials/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryOutputMaterials(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		String newSearch = getStringParam(paramMap, "newSearch");
		//如果是第一次查询将查询参数放入session中
		if(StringUtils.isNotEmpty(newSearch)){
			this.getRequest().getSession().setAttribute("paramMap", paramMap);
			this.getRequest().getSession().setAttribute("pageNo", pageNo);
		}else{
			paramMap = (Map)this.getRequest().getSession().getAttribute("paramMap");
			pageNo=(int)this.getRequest().getSession().getAttribute("pageNo");
		}
		int companyId = getLoginCompanyId();
		String name = getStringParam(paramMap, "name");
		String productionBarcode = getStringParam(paramMap, "productionBarcode");
		String code = getStringParam(paramMap, "code");
		Integer typeGeneral = getIntParam(paramMap, "typeGeneral");
		String sortBy = "LAST_MODIFIED_DATE";
		String sortDirection = "DESC";
		//QueryResult queryResult = outputMaterialService.queryOutputMaterialsByConditions(companyId, name, productionBarcode, code, pageNo, pageSize, sortBy, sortDirection);
		QueryResult queryResult = outputMaterialService.queryOutputMaterialsByConditions(companyId, name, productionBarcode, null, code, null, typeGeneral, null, null, pageNo, pageSize, null, sortBy, sortDirection);
		if (queryResult != null && queryResult.getResultList() != null) {
			List<DTOOutputMaterialQueryData> newList = DTOOutputMaterialQueryData.createListByEntities(queryResult.getResultList());
			queryResult.setResultList(newList);
		} else {
			queryResult = new QueryResult();
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}

	

	/**
	 * 导出产出品
	 * author 江正鹏
	 * @param paramMap
	 * @return
	 * @throws IOException 
	 * @throws FoodException 
	 */
	@RequestMapping(value = "/queryOutputMaterialsExport", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryOutputMaterialsExport(@RequestBody Map<String, Object> paramMap) throws IOException, FoodException {
		int companyId = getLoginCompanyId();
		String name = getStringParam(paramMap, "name3");
		String productionBarcode = getStringParam(paramMap, "productionBarcode");
		String code = getStringParam(paramMap, "code");
		Integer typeGeneral = getIntParam(paramMap, "typeGeneral");
		String sortBy = "LAST_MODIFIED_DATE";
		String sortDirection = "DESC";
		QueryResult<Map> queryResult = outputMaterialService.queryOutputMaterialsExport(companyId, name, productionBarcode, null, code, null, typeGeneral, 1, null, -1, -1, null, sortBy,
				sortDirection);
		String errorFolderPath = "/attach/" + companyId + "_" + "OutputMat";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "queryOutputMaterialsExport" + companyId + ".xlsx");

		ReadandWriteExcel.writExlsxFlatly(exportFilePath.toAbsolutePath().toString(), "产出品", queryResult.getResultList(),ReadandWriteExcel.OUTPUTMATERIAL,ReadandWriteExcel.outputmaterialParameters,ReadandWriteExcel.outputmaterialType);
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_INPUTMETERIAL_FILE);

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}

	
	
	@RequestMapping(value = "/queryOutputMaterialsByName/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryOutputMaterialsByName(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		int companyId = getLoginCompanyId();
		String name = getStringParam(paramMap, "name");
		String sortBy = "outputBatchDetailList.size";
		String sortDirection = "DESC";
		QueryResult queryResult = outputMaterialService.queryOutputMaterialsByName(companyId, name, sortBy, sortDirection, pageNo, pageSize);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}

	/**
	 * 上传采购品图片
	 * 
	 * @param outputMaterialId
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/updateOutputMaterialImage/{outputMaterialId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateOutputMaterialImage(@PathVariable int outputMaterialId, HttpServletRequest request) {
		OutputMaterial outputMaterial = outputMaterialService.getOutputMaterialById(outputMaterialId);
		if (outputMaterial == null || DataUtil.isDeleted(outputMaterial.getDelFlag())) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		// 添加新图片
		LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
		try {
			Map<String, List<MultipartFile>> fileMap = getMultipartFileMapFromRequest(request);
			uploadUtils.uploadFiles(outputMaterialId, uploadTypeToAttachTypeMap, fileMap, singleImageTypes, resultMap, getLoginCompanyId());
		} catch (Exception e) {
			throw FoodException.returnException("上传文件失败！");
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, resultMap);
	}

	/**
	 * 查询图片
	 * 
	 * @param outputMaterialId
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/queryOutputMaterialImage/{outputMaterialId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryOutputMaterialImage(@RequestBody String[] imageTypes, @PathVariable int outputMaterialId) {
		OutputMaterial outputMaterial = outputMaterialService.getOutputMaterialById(outputMaterialId);
		if (outputMaterial == null || DataUtil.isDeleted(outputMaterial.getDelFlag())) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
		for (String imageType : imageTypes) {
			String attachType = uploadTypeToAttachTypeMap.get(imageType);
			if (StringUtils.isNotBlank(attachType)) {
				List<Attachment> resultList = uploadUtils.queryAttFile(attachType, outputMaterialId, null, null);
				resultMap.put(imageType, resultList);
			}
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, resultMap);
	}

	/**
	 * 批量导入产出品
	 * 
	 * @param request
	 * @return
	 * @throws java.lang.Exception
	 */
	@RequestMapping(value = "/importOutputMaterial", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult importOutputMaterial(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int comId = getLoginCompanyId();
//		Company company = companyService.getCompanyById(comId);
//		if (company == null) {
//			throw FoodException.returnException("000011");
//		}
		Integer loginUserId = getLoginUserId();
		String userName = getLoginUserName();
		if (loginUserId == null || userName == null) {
			throw FoodException.returnException("000010");
		}
		List<MultipartFile> files = getMultipartFilesFromRequest(request);
		// 检验文件大小
		boolean valid = uploadUtils.checkFilesSize(files, new int[] { 0 }, null);
		if (!valid) {
			throw FoodException.returnExceptionWithPars("error.exceed.max_import_file_size", UploadUtils.maxUploadSize / 1024 / 1024);
		}
		MultipartFile file = files.get(0);// 取第一个文件作为上传文件
		// 检验上传文件名是否上传过
		Boolean flag = importService.checkFileName(file.getOriginalFilename(), comId, OutputMaterialImportService.IMPORT_TYPE);
		if (!flag) {
			throw FoodException.returnException("error.excel.file.name.duplicate");
		}
		// 检验上传文件
		ValidationResult result = outputMaterialImportService.checkOutputMaterialImport(comId, file, loginUserId, userName, response);
		LOGGER.error("errorFilename" + result.getErrorFilePath());
		// 检验通过，上传文件; 否则返回文件路径
		if (StringUtils.isBlank(result.getErrorFilePath())) {
			outputMaterialImportService.importOutputMaterial(comId, result.getData(), file.getOriginalFilename(), loginUserId, userName);
			outputMaterialImportService.updateOutputMaterialBarcode(comId);
			return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
		} else {
			return CommonStatusResult.fail(ErrorMessageConstant.CODE_FAIL, result.getErrorFilePath());
		}
	}

	/**
	 * 获取所有配送品类型
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getOutputMaterialType", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult getOutputMaterialType() {
		Map<Integer, String> types = DataDictService.getDataDicDetailByType(DataDicConstant.DIC_INPUT_MAT_GENERAL_TYPE);
		if (types == null) {
			types = new LinkedHashMap<>();
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, types);
	}

	/**
	 * 获取所有日期单位
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getDateType", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult getDateType() {
		Map<Integer, String> types = DataDictService.getDataDicDetailByType(DataDicConstant.DIC_DATE_UNIT);
		if (types == null) {
			types = new LinkedHashMap<>();
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, types);
	}
}
