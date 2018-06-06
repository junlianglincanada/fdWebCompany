package com.wondersgroup.operation.input.controller;

import java.io.IOException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.wondersgroup.data.jpa.entity.InputMaterial;
import com.wondersgroup.framework.common.DataDictService;
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
import com.wondersgroup.operation.input.model.DTOInputMaterialCreate;
import com.wondersgroup.operation.input.model.DTOInputMaterialInfo;
import com.wondersgroup.operation.input.model.DTOInputMaterialQueryData;
import com.wondersgroup.operation.input.model.DTOInputMaterialUpdate;
import com.wondersgroup.operation.input.model.DTOOutputMatBomQueryData;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.operation.util.file.UploadUtils;
import com.wondersgroup.service.company.CompanyService;
import com.wondersgroup.service.export.ReadandWriteExcel;
import com.wondersgroup.service.input.InputMaterialImportService;
import com.wondersgroup.service.input.InputMaterialService;
import com.wondersgroup.util.FileUtil;

@Controller
@RequestMapping("/inputManage/inputMaterial")
public class InputMaterialController extends AbstractBaseController {
	private static final Logger LOGGER = LoggerFactory.getLogger(InputMaterialController.class);
	@Autowired
	private InputMaterialService inputMaterialService;
	@Autowired
	private CompanyService companyService;
	@Autowired
	private InputMaterialImportService inputMaterialImportService;
	@Autowired
	private ImportService importService;
	@Autowired
	private UploadUtils uploadUtils;
	// 上传类型 -- 采购品图片
	public static final String UPLOAD_TYPE_INPUTMAT_IMAGE = "INPUTMAT_IMAGE";
	// 上传类型 -- 检验检测报告
	public static final String UPLOAD_TYPE_INPUTMAT_JY_JC_REPORT = "JY_JC_REPORT";// +FoodConstant.ATT_JY_JC_REPORT;
	// 上传类型 -- 生产许可证
	public static final String UPLOAD_TYPE_INPUTMAT_PRODUCTION_CERTIFICATE = "PRODUCTION_CERTUFUCATE";// +FoodConstant.ATT_PRODUCTION_CERTUFUCATE;
	public static final Map<String, String> uploadTypeToAttachTypeMap = new HashMap<String, String>() {
		private static final long serialVersionUID = 1948879947792327281L;

		{
			put(UPLOAD_TYPE_INPUTMAT_IMAGE, FoodConstant.ATT_INPUTMAT_IMAGE);
			put(UPLOAD_TYPE_INPUTMAT_JY_JC_REPORT, FoodConstant.ATT_INPUTMAT_JY_JC_REPORT);
			put(UPLOAD_TYPE_INPUTMAT_PRODUCTION_CERTIFICATE, FoodConstant.ATT_INPUTMAT_PROD_CERT);
		}
	};
	private static final List<String> singleImageTypes = new ArrayList<String>() {
		private static final long serialVersionUID = 6694506005823947192L;

		{
			add(UPLOAD_TYPE_INPUTMAT_IMAGE);
		}
	};

	/**
	 * 搜索所有可用的公共采购品类别
	 *
	 */
	@RequestMapping(value = "/getAllGeneralType", method = RequestMethod.GET)
	@ResponseBody
	public Map<Integer, String> getAllGeneralType() {
		Map<Integer, String> map = DataDictService.getDataDicDetailByType(DataDicConstant.DIC_INPUT_MAT_GENERAL_TYPE);
		return map;
	}

	/**
	 * 新增采购品信息
	 *
	 */
	@RequestMapping(value = "/createInputMaterial", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult createInputMaterial(@Valid @RequestBody DTOInputMaterialCreate dto) {
		int companyId = getLoginCompanyId();
		Company company = companyService.getCompanyById(companyId);
		if (company == null) {
			throw FoodException.returnException("000011");
		}
		if (StringUtils.isNotBlank(dto.getProductionBarcode())) {
			InputMaterial material = inputMaterialService.getMaterialByProductionBarcode(dto.getProductionBarcode(), companyId);
			if (null != material) {
				throw FoodException.returnException("000005");
			}
		}
		InputMaterial material = DTOInputMaterialCreate.toEntity(dto, company);
		if (material == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		material = inputMaterialService.createInputMaterial(material);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, material.getId());
	}

	/**
	 * 修改采购品信息
	 *
	 */
	@RequestMapping(value = "/updateInputMaterial", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateInputMaterial(@Valid @RequestBody DTOInputMaterialUpdate dto) {
		InputMaterial material = DTOInputMaterialUpdate.toEntity(dto, inputMaterialService);
		if (material == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		inputMaterialService.updateInputMaterial(material);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, material.getId());
	}

	/**
	 * 删除采购品
	 */
	@RequestMapping(value = "/deleteInputMaterial/{id}", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult deleteMaterialInfo(@PathVariable int id) {
		inputMaterialService.deleteInputMaterial(id);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, id);
	}

	/**
	 * 根据ID查询指定单位下的采购品信息
	 * 
	 */
	@RequestMapping(value = "/getInputMaterialById/{id}", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult getInputMaterialById(@PathVariable int id) {
		InputMaterial material = inputMaterialService.getInputMaterialById(id);
		if (material == null || DataUtil.isDeleted(material.getDelFlag())) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		DTOInputMaterialInfo dto = DTOInputMaterialInfo.createByEntity(material);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, dto);
	}

	@RequestMapping(value = "/queryInputMaterials/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryInputMaterials(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
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
		String sortBy = "LAST_MODIFIED_DATE";
		String sortDirection = "DESC";
		QueryResult queryResult = inputMaterialService.queryInputMaterialByCompanyId(companyId, name, productionBarcode, code, sortBy, sortDirection, pageNo, pageSize);
		if (queryResult != null && queryResult.getResultList() != null) {
			List<DTOInputMaterialQueryData> newList = DTOInputMaterialQueryData.createListByEntities(queryResult.getResultList());
			queryResult.setResultList(newList);
		} else {
			queryResult = new QueryResult();
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}
	
	/**导出采购品
	 * author 江正鹏
	 * @param paramMap
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value = "/queryInputMaterialsExport", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryInputMaterialsExport(@RequestBody Map<String, Object> paramMap) throws IOException {
		int companyId = getLoginCompanyId();
		String name = getStringParam(paramMap, "name3");
		String productionBarcode = getStringParam(paramMap, "productionBarcode");
		String code = getStringParam(paramMap, "code");
		String sortBy = "LAST_MODIFIED_DATE";
		String sortDirection = "DESC";
		QueryResult<Map> queryResult = inputMaterialService.queryInputMaterialExport(companyId, name, productionBarcode, code, sortBy, sortDirection, -1, -1);
		String errorFolderPath = "/attach/" + companyId + "_" + "inputMat";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "queryInputMaterialsExport" + companyId + ".xlsx");

		ReadandWriteExcel.writExlsxFlatly(exportFilePath.toAbsolutePath().toString(), "采购品", queryResult.getResultList(),ReadandWriteExcel.INPUTMATERIAL,ReadandWriteExcel.inputmaterialParameters, ReadandWriteExcel.inputmaterialType);
		
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_INPUTMETERIAL_FILE);

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}
	
	@RequestMapping(value = "/queryInputMaterialsByName/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryInputMaterialsByName(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		int companyId = getLoginCompanyId();
		String name = getStringParam(paramMap, "name");
		String sortBy = "lastModifiedDate";
		String sortDirection = "DESC";
		QueryResult queryResult = inputMaterialService.queryInputMaterialsByName(companyId, name, sortBy, sortDirection, pageNo, pageSize);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}

	/**
	 * 根据供应商ID查询采购品信息
	 * 
	 */
	@RequestMapping(value = "/queryInputMaterial/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryInputMaterial(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		System.out.println(87);
		int companyId = getIntParam(paramMap, "companyId");
		String sortBy = "im.LAST_MODIFIED_DATE";
		String sortDirection = "DESC";
		QueryResult<InputMaterial> queryResult = inputMaterialService.queryInputMaterialByCompanyIdd(companyId,sortBy, sortDirection, pageNo, pageSize);
		/*if (queryResult != null && queryResult.getResultList() != null) {
			List<DTOInputMaterialQueryData> newList = DTOInputMaterialQueryData.createListByEntities(queryResult.getResultList());
			queryResult.setResultList(newList);
		} else {
			queryResult = new QueryResult();
		}*/
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}

	/**
	 * 上传采购品图片
	 * 
	 * @param inputMaterialId
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/updateInputMaterialImage/{inputMaterialId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateInputMaterialImage(@PathVariable int inputMaterialId, HttpServletRequest request) {
		InputMaterial inputMaterial = inputMaterialService.getInputMaterialById(inputMaterialId);
		if (inputMaterial == null || DataUtil.isDeleted(inputMaterial.getDelFlag())) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		// 添加新图片
		LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
		try {
			Map<String, List<MultipartFile>> fileMap = getMultipartFileMapFromRequest(request);
			uploadUtils.uploadFiles(inputMaterialId, uploadTypeToAttachTypeMap, fileMap, singleImageTypes, resultMap, getLoginCompanyId());
		} catch (Exception e) {
			e.printStackTrace();
			throw FoodException.returnException("上传文件失败！");
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, resultMap);
	}

	/**
	 * 查询采购品图片
	 * 
	 * @param inputMaterialId
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/queryInputMaterialImage/{inputMaterialId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryInputMaterialImage(@RequestBody String[] imageTypes, @PathVariable int inputMaterialId) {
		InputMaterial inputMaterial = inputMaterialService.getInputMaterialById(inputMaterialId);
		if (inputMaterial == null || DataUtil.isDeleted(inputMaterial.getDelFlag())) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
		for (String imageType : imageTypes) {
			String attachType = uploadTypeToAttachTypeMap.get(imageType);
			if (StringUtils.isNotBlank(attachType)) {
				List<Attachment> resultList = uploadUtils.queryAttFile(attachType, inputMaterialId, null, null);
				resultMap.put(imageType, resultList);
			}
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, resultMap);
	}

	/**
	 * 查询采购品（用于“关联进货原料”）
	 */
	@RequestMapping(value = "/queryInputMaterialForCreateOutputBatch/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryInputMaterialForCreateOutputBatch(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		String materialName = getStringParam(paramMap, "materialName");
		int generalType = getIntParam(paramMap, "generalType");
		String ids = getStringParam(paramMap,"ids");
		int comId = getLoginCompanyId();
		QueryResult<InputMaterial> qr = inputMaterialService.queryInputMaterialForCreateOutputBatch(comId, materialName, generalType, ids, pageNo, pageSize);
		//QueryResult<InputMaterial> qr = inputMaterialService.queryInputMaterialsByCompanyId(comId, null, null, materialName, null, null, generalType, null, "m.NAME_PY", "ASC", pageNo, pageSize);
		QueryResult<DTOOutputMatBomQueryData> result = null;
		List<DTOOutputMatBomQueryData> datas = new ArrayList<>();
		if (qr != null && qr.getResultList() != null) {
			List<InputMaterial> inputMaterials = qr.getResultList();
			datas = DTOOutputMatBomQueryData.createListByEntities(inputMaterials);
			result = new QueryResult<>(datas, qr.getTotalRecord(), qr.getCurrPageNo(), qr.getPageSize());
		} else {
			result = new QueryResult<>(datas, 0l, pageNo, pageSize);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result);
	}

	/**
	 * 批量导入采购品
	 */
	@RequestMapping(value = "/importInputMaterial", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult importInputMaterial(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		MultipartFile file = files.get(0);// 取第一个文件作为上传文件
		// 检验文件大小
		boolean valid = uploadUtils.checkFilesSize(files, new int[] { 0 }, null);
		if (!valid) {
			throw FoodException.returnExceptionWithPars("error.exceed.max_import_file_size", UploadUtils.maxUploadSize / 1024 / 1024);
		}
		// 检验上传文件名是否上传过
		Boolean flag = importService.checkFileName(file.getOriginalFilename(), comId, InputMaterialImportService.IMPORT_TYPE);
		if (!flag) {
			throw FoodException.returnException("error.excel.file.name.duplicate");
		}
		// 检验上传文件
		ValidationResult result = inputMaterialImportService.checkInputMaterialImport(comId, file, loginUserId, userName, response);
		// 检验通过，上传文件; 否则返回文件路径
		if (StringUtils.isBlank(result.getErrorFilePath())) {
			inputMaterialImportService.importInputMaterial(comId,result.getData(),file.getOriginalFilename(), loginUserId, userName);
			inputMaterialImportService.updateInputMaterialBarcode(comId);
			return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
		} else {
			return CommonStatusResult.fail(ErrorMessageConstant.CODE_FAIL, result.getErrorFilePath());
		}
	}
}
