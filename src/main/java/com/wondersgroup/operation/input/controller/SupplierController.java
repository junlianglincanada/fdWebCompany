package com.wondersgroup.operation.input.controller;

import java.io.IOException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.wondersgroup.data.jpa.entity.Attachment;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.data.jpa.entity.InputMaterial;
import com.wondersgroup.data.jpa.entity.IntCompany;
import com.wondersgroup.framework.file.excel.ImportService;
import com.wondersgroup.framework.file.excel.model.ValidationResult;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.DataUtil;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FileUploadUtils;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.input.model.DTOInputSuppli;
import com.wondersgroup.operation.input.model.DTOLinkCompanyQueryData;
import com.wondersgroup.operation.input.model.DTORelationSupplierQueryData;
import com.wondersgroup.operation.input.model.DTOSupplierCreate;
import com.wondersgroup.operation.input.model.DTOSupplierInfo;
import com.wondersgroup.operation.input.model.DTOSupplierQueryData;
import com.wondersgroup.operation.input.model.DTOSupplierQueryDataForSelect;
import com.wondersgroup.operation.input.model.DTOSupplierUpdate;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.operation.util.file.UploadUtils;
import com.wondersgroup.service.company.CompanyService;
import com.wondersgroup.service.company.InternalCompanyService;
import com.wondersgroup.service.export.ReadandWriteExcel;
import com.wondersgroup.service.input.InputMaterialService;
import com.wondersgroup.service.input.SupplierImportService;
import com.wondersgroup.util.TimeOrDateUtils;
import com.wondersgroup.util.FileUtil;

/**
 *
 * @author wanglei
 *
 */
@Controller
@RequestMapping("/inputManage/supplier")
public class SupplierController extends AbstractBaseController {
	private static Logger LOGGER = LoggerFactory.getLogger(SupplierController.class);
	@Autowired
	private InputMaterialService inputMaterialService;
	@Autowired
	private InternalCompanyService intCompanyService;
	@Autowired
	private CompanyService companyService;
	@Autowired
	private SupplierImportService supplierImportService;
	@Autowired
	private ImportService importService;
	@Autowired
	private UploadUtils uploadUtils;
	public static final String UPLOAD_TYPE_SUP_GSYYZZ = "SUP_GSYYZZ"; // 供应商 --
																		// 工商营业执照
	public static final String UPLOAD_TYPE_SUP_ZZJGDM = "SUP_ZZJGDM"; // 供应商 --
																		// 组织机构代码
	public static final String UPLOAD_TYPE_SUP_SWDJZ = "SUP_SWDJZ"; // 供应商 --
																	// 税务登记证
	public static final String UPLOAD_TYPE_SUP_FRSFZ = "SUP_FRSFZ"; // 供应商 --
																	// 法人身份证
	public static final String UPLOAD_TYPE_SUP_GAJMLWNDTXZ = "SUP_GAJMLWNDTXZ"; // 供应商
																				// --
																				// 港澳居民来往内地通行证
	public static final String UPLOAD_TYPE_SUP_TWJMLWNDTXZ = "SUP_TWJMLWNDTXZ"; // 供应商
																				// --
																				// 台湾居民来往内地通行证
	public static final String UPLOAD_TYPE_SUP_SPLTXKZ = "SUP_SPLTXKZ"; // 供应商
																		// --
																		// 食品流通许可证
	public static final String UPLOAD_TYPE_SUP_SPSCXKZ = "SUP_SPSCXKZ"; // 供应商
																		// --
																		// 食品生产许可证
	public static final String UPLOAD_TYPE_SUP_CYFWXKZ = "SUP_CYFWXKZ"; // 供应商
																		// --
																		// 餐饮服务许可证
	public static final String UPLOAD_TYPE_SUP_SPJYXKZ = "SUP_SPJYXKZ"; // 供应商
																		// --
																		// 食品经营许可证
	public static final String UPLOAD_TYPE_SUP_OTHER = "SUP_OTHER"; // 供应商 --
																	// 其他证照
	public static final Map<String, String> uploadTypeToAttachTypeMap = new HashMap<String, String>() {
		private static final long serialVersionUID = 1948879947792327281L;

		{
			put(UPLOAD_TYPE_SUP_GSYYZZ, FoodConstant.ATT_SUP_GSYYZZ);
			put(UPLOAD_TYPE_SUP_ZZJGDM, FoodConstant.ATT_SUP_ZZJGDM);
			put(UPLOAD_TYPE_SUP_SWDJZ, FoodConstant.ATT_SUP_SWDJZ);
			put(UPLOAD_TYPE_SUP_FRSFZ, FoodConstant.ATT_SUP_FRSFZ);
			put(UPLOAD_TYPE_SUP_GAJMLWNDTXZ, FoodConstant.ATT_SUP_GAJMLWNDTXZ);
			put(UPLOAD_TYPE_SUP_TWJMLWNDTXZ, FoodConstant.ATT_SUP_TWJMLWNDTXZ);
			put(UPLOAD_TYPE_SUP_SPLTXKZ, FoodConstant.ATT_SUP_SPLTXKZ);
			put(UPLOAD_TYPE_SUP_SPSCXKZ, FoodConstant.ATT_SUP_SPSCXKZ);
			put(UPLOAD_TYPE_SUP_CYFWXKZ, FoodConstant.ATT_SUP_CYFWXKZ);
			put(UPLOAD_TYPE_SUP_SPJYXKZ, FoodConstant.ATT_SUP_SPJYXKZ);
			put(UPLOAD_TYPE_SUP_OTHER, FoodConstant.ATT_SUP_OTHER);
		}
	};
	private static final List<String> singleImageTypes = new ArrayList<String>() {
		private static final long serialVersionUID = 6694506005823947192L;

		{
			add(UPLOAD_TYPE_SUP_GSYYZZ);
			add(UPLOAD_TYPE_SUP_ZZJGDM);
			add(UPLOAD_TYPE_SUP_SWDJZ);
			add(UPLOAD_TYPE_SUP_FRSFZ);
			add(UPLOAD_TYPE_SUP_GAJMLWNDTXZ);
			add(UPLOAD_TYPE_SUP_TWJMLWNDTXZ);
			add(UPLOAD_TYPE_SUP_SPLTXKZ);
			add(UPLOAD_TYPE_SUP_SPSCXKZ);
			add(UPLOAD_TYPE_SUP_CYFWXKZ);
			add(UPLOAD_TYPE_SUP_SPJYXKZ);
			add(UPLOAD_TYPE_SUP_OTHER);
		}
	};

	@RequestMapping(value = "/createSupplier", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult createSupplier(@Valid @RequestBody DTOSupplierCreate dto) {
		int companyId = getLoginCompanyId();
		String cateringCert = dto.getCateringCert();
		String foodCircuCert = dto.getFoodCircuCert();
		String foodProdCert = dto.getFoodProdCert();
		String foodBusinessCert = dto.getFoodBusinessCert();
		String companyType = "SUPPLIER";
		Map certMap = new HashMap<>();
		if (!StringUtils.isEmpty(cateringCert)) {
			boolean cateringCertOne = intCompanyService.isCertExist(null, "cateringCert", cateringCert, companyId, companyType);
			if (cateringCertOne == true) {
				certMap.put("cateringCert", true);
			}
		}
		if (!StringUtils.isEmpty(foodCircuCert)) {
			boolean foodCircuCertOne = intCompanyService.isCertExist(null, "foodCircuCert", foodCircuCert, companyId, companyType);
			if (foodCircuCertOne == true) {
				certMap.put("foodCircuCert", true);
			}
		}
		if (!StringUtils.isEmpty(foodProdCert)) {
			boolean foodProdCertOne = intCompanyService.isCertExist(null, "foodProdCert", foodProdCert, companyId, companyType);
			if (foodProdCertOne == true) {
				certMap.put("foodProdCert", true);
			}
		}
		if (!StringUtils.isEmpty(foodBusinessCert)) {
			boolean foodBusinessCertOne = intCompanyService.isCertExist(null, "foodBusinessCert", foodBusinessCert, companyId, companyType);
			if (foodBusinessCertOne == true) {
				certMap.put("foodBusinessCert", true);
			}
		}

		if (certMap != null && certMap.size() > 0) {
			return CommonStatusResult.fail("证件号码已存在", certMap);
		}
		Company company = companyService.getCompanyById(companyId);
		if (company == null) {
			throw FoodException.returnException("000011");
		}
		// linjunliang 20151103 fix SFENTWEB-304 判断CODE唯一性
		if (dto != null && dto.getCode() != null && !dto.getCode().equals("")) {
			QueryResult queryResult = intCompanyService.querySuppliersByCompanyCode(companyId, "SUPPLIER", dto.getCode(), 1, 10);
			if (queryResult.getResultList() != null && queryResult.getResultList().size() > 0) {
				throw FoodException.returnException("供应商编码已存在！");
			}
		}
		IntCompany supplier = DTOSupplierCreate.toEntity(dto, company, dto.getLinkedCompanyId());
		if (supplier == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		supplier = intCompanyService.createInternalCompany(supplier);
		return CommonStatusResult.success("success", supplier);
	}

	@RequestMapping(value = "/updateSupplier", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateSupplier(@Valid @RequestBody DTOSupplierUpdate dto) {
		int companyId = getLoginCompanyId();
		String cateringCert = dto.getCateringCert();
		String foodCircuCert = dto.getFoodCircuCert();
		String foodProdCert = dto.getFoodProdCert();
		String foodBusinessCert = dto.getFoodBusinessCert();
		String companyType = "SUPPLIER";
		Map certMap = new HashMap<>();
		if (!StringUtils.isEmpty(cateringCert)) {
			boolean cateringCertOne = intCompanyService.isCertExist(dto.getId(), "cateringCert", cateringCert, companyId, companyType);
			if (cateringCertOne == true) {
				certMap.put("cateringCert", true);
			}
		}
		if (!StringUtils.isEmpty(foodCircuCert)) {
			boolean foodCircuCertOne = intCompanyService.isCertExist(dto.getId(), "foodCircuCert", foodCircuCert, companyId, companyType);
			if (foodCircuCertOne == true) {
				certMap.put("foodCircuCert", true);
			}
		}
		if (!StringUtils.isEmpty(foodProdCert)) {
			boolean foodProdCertOne = intCompanyService.isCertExist(dto.getId(), "foodProdCert", foodProdCert, companyId, companyType);
			if (foodProdCertOne == true) {
				certMap.put("foodProdCert", true);
			}
		}
		if (!StringUtils.isEmpty(foodBusinessCert)) {
			boolean foodBusinessCertOne = intCompanyService.isCertExist(dto.getId(), "foodBusinessCert", foodBusinessCert, companyId, companyType);
			if (foodBusinessCertOne == true) {
				certMap.put("foodBusinessCert", true);
			}
		}

		if (certMap != null && certMap.size() > 0) {
			return CommonStatusResult.fail("证件号码已存在", certMap);
		}
		IntCompany beforeUpdateEntity = intCompanyService.getInternalCompanyById(dto.getId());
		// linjunliang 20151103 fix SFENTWEB-304 更新前数据不一致，则判断唯一性
		if (dto.getCode() != null && !dto.getCode().equals("")) {
			if (!dto.getCode().equals(beforeUpdateEntity.getCode())) {
				if (dto != null && dto.getCode() != null && !dto.getCode().equals("")) {
					QueryResult queryResult = intCompanyService.querySuppliersByCompanyCode(companyId, "SUPPLIER", dto.getCode(), 1, 10);
					if (queryResult.getResultList() != null && queryResult.getResultList().size() > 0) {
						throw FoodException.returnException("供应商编码已存在！");
					}
				}
			}
		}
		IntCompany supplier = DTOSupplierUpdate.toEntity(dto, intCompanyService, companyService);
		if (supplier == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		intCompanyService.updateInternalCompany(supplier);
		return CommonStatusResult.success("success", supplier);
	}

	@RequestMapping(value = "/deleteSupplier/{supplierId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult deleteSupplier(@PathVariable int supplierId) {
		intCompanyService.deleteInternalCompany(supplierId);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, supplierId);
	}

	@RequestMapping(value = "/getSupplierById/{supplierId}", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult getSupplierInfoById(@PathVariable int supplierId) {
		IntCompany entity = intCompanyService.getInternalCompanyById(supplierId);
		if (entity == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		DTOSupplierInfo dto = DTOSupplierInfo.createByEntity(entity);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, dto);
	}

	@RequestMapping(value = "/querySuppliers/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult querySuppliers(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
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
		String sortBy = "LAST_MODIFIED_DATE";
		String sortDirection = "DESC";
		String intCompanyType = "SUPPLIER";
		QueryResult queryResult = intCompanyService.queryIntCompanyByCompanyId(companyId, name, intCompanyType, sortBy, sortDirection, pageNo, pageSize);
		if (queryResult != null && queryResult.getResultList() != null) {
			List<DTOSupplierQueryData> newList = DTOSupplierQueryData.createListByEntities(queryResult.getResultList(),intCompanyService,companyId);
			queryResult.setResultList(newList);
		} else {
			queryResult = new QueryResult();
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}
	
	@RequestMapping(value = "/queryRelationSuppliers/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryRelationSuppliers(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
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
		QueryResult queryResult = intCompanyService.queryRelationIntCompanyByCompanyId(companyId, name, pageNo, pageSize);
		if (queryResult != null && queryResult.getResultList() != null) {
			List<DTORelationSupplierQueryData> newList = DTORelationSupplierQueryData.createListByEntities(queryResult.getResultList());
			queryResult.setResultList(newList);
		} else {
			queryResult = new QueryResult();
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}
	
	@RequestMapping(value = "/intCompanyByTime/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult intCompanyByTime(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		int companyId = getLoginCompanyId();
		String type=getStringParam(paramMap, "type");
		Date date = TimeOrDateUtils.getOneMonthBeforeCurrentTime();
		String sortBy = "total";
		String sortDirection = "DESC";
		QueryResult<Map> queryResult = intCompanyService.queryIntCompanyByDate(companyId,type,date,sortBy, sortDirection, pageNo, pageSize);
		/*if (queryResult != null && queryResult.getResultList() != null) {
			List<DTOInputSuppli> newList = DTOInputSuppli.createListByEntities(queryResult.getResultList());
			queryResult.setResultList(newList);
		} else {
			queryResult = new QueryResult();
		}*/
		System.out.print(queryResult.toString());
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult.getResultList());
	}
	/**
	 * author 江正鹏
	 * @param paramMap
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value = "/querySuppliers", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult exportSuppliers(@RequestBody Map<String, Object> paramMap) throws IOException {
		int companyId = getLoginCompanyId();
		String name = getStringParam(paramMap, "name");
		String sortBy = "LAST_MODIFIED_DATE";
		String sortDirection = "DESC";
		String intCompanyType = "SUPPLIER";
		QueryResult<Map> queryResult = intCompanyService.querySupplierForExport(companyId, name, intCompanyType, sortBy, sortDirection, -1, -1);
		// 清空文件夹，没有需要创建
				String errorFolderPath = "/attach/" + companyId + "_" + "supplier";
				String dirURI = FileUploadUtils.contextPath + errorFolderPath;
				Path exportFilePath = FileUtil.createFile(dirURI, "exportSuppliers" + companyId + ".xlsx");

				ReadandWriteExcel.writExlsxFlatly(exportFilePath.toAbsolutePath().toString(), "供应商", queryResult.getResultList(),ReadandWriteExcel.INPUTSUPPLIER,ReadandWriteExcel.inputsupplierParameters,ReadandWriteExcel.inputsupplierType);
				String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_INPUTMETERIAL_FILE);

				return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}
	
	
	@RequestMapping(value = "/querySuppliersByName/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult querySuppliersByName(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		int companyId = getLoginCompanyId();
		String name = getStringParam(paramMap, "name");
		String sortBy = "LAST_MODIFIED_DATE";
		String sortDirection = "DESC";
		String intCompanyType = "SUPPLIER";
		QueryResult queryResult = intCompanyService.queryIntCompanyByCompanyId(companyId, name, intCompanyType, sortBy, sortDirection, pageNo, pageSize);
		if (queryResult != null && queryResult.getResultList() != null) {
			List<DTOSupplierQueryDataForSelect> newList = DTOSupplierQueryDataForSelect.createListByEntities(queryResult.getResultList());
			queryResult.setResultList(newList);
		} else {
			queryResult = new QueryResult();
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}

	/**
	 * 查询可用于关联的注册单位
	 */
	@RequestMapping(value = "/queryLinkCompany/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryLinkCompany(@RequestParam String companyName, @PathVariable int pageNo, @PathVariable int pageSize) {
		Integer loginCompanyId = getLoginCompanyId();
		QueryResult<Company> qr = intCompanyService.searchAvailableCompany(loginCompanyId, companyName, IntCompany.COMPANY_TYPE_SUPPLIER, pageNo, pageSize);
		QueryResult<DTOLinkCompanyQueryData> result = null;
		List<DTOLinkCompanyQueryData> datas = new ArrayList<>();
		if (qr != null && qr.getResultList() != null) {
			List<Company> rs = qr.getResultList();
			List<DTOLinkCompanyQueryData> list = DTOLinkCompanyQueryData.createListByEntities(rs);
			if (list != null) {
				datas.addAll(list);
			}
			result = new QueryResult<>(datas, qr.getTotalRecord(), qr.getCurrPageNo(), qr.getPageSize());
		} else {
			result = new QueryResult<>(datas, 0l, pageNo, pageSize);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result);
	}

	/**
	 * 批量导入供应商
	 */
	@RequestMapping(value = "/importSupplier", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult importSupplier(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		Boolean flag = importService.checkFileName(file.getOriginalFilename(), comId, SupplierImportService.IMPORT_TYPE);
		if (!flag) {
			throw FoodException.returnException("error.excel.file.name.duplicate");
		}
		// 检验上传文件
		ValidationResult result = supplierImportService.checkSupplierImport(comId, file, loginUserId, userName, response);
		LOGGER.error("errorFilename" + result.getErrorFilePath());
		// 检验通过，上传文件; 否则返回文件路径
		if (StringUtils.isBlank(result.getErrorFilePath())) {
			supplierImportService.importSupplier(comId,result.getData(),file.getOriginalFilename(), loginUserId, userName);
			return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
		} else {
			return CommonStatusResult.fail(ErrorMessageConstant.CODE_FAIL, result.getErrorFilePath());
		}
	}

	@RequestMapping(value = "/updateSupplierImage/{supplierId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateSupplierImage(@PathVariable int supplierId, HttpServletRequest request) {
		IntCompany intCompany = intCompanyService.getInternalCompanyById(supplierId);
		if (intCompany == null || !IntCompany.COMPANY_TYPE_SUPPLIER.equals(intCompany.getType()) || DataUtil.isDeleted(intCompany.getDelFlag())) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		// 添加新图片
		LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
		try {
			Map<String, List<MultipartFile>> fileMap = getMultipartFileMapFromRequest(request);
			uploadUtils.uploadFiles(supplierId, uploadTypeToAttachTypeMap, fileMap, singleImageTypes, resultMap, getLoginCompanyId());
		} catch (Exception e) {
			throw FoodException.returnException("上传文件失败！");
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, resultMap);
	}

	@RequestMapping(value = "/querySupplierImage/{supplierId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult querySupplierImage(@RequestBody String[] imageTypes, @PathVariable int supplierId) {
		IntCompany intCompany = intCompanyService.getInternalCompanyById(supplierId);
		if (intCompany == null || !IntCompany.COMPANY_TYPE_SUPPLIER.equals(intCompany.getType()) || DataUtil.isDeleted(intCompany.getDelFlag())) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
		for (String imageType : imageTypes) {
			String attachType = uploadTypeToAttachTypeMap.get(imageType);
			if (StringUtils.isNotBlank(attachType)) {
				List<Attachment> resultList = uploadUtils.queryAttFile(attachType, supplierId, null, null);
				resultMap.put(imageType, resultList);
			}
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, resultMap);
	}
	/**
	 * 根据采购品ID查询供应商信息
	 * 
	 */
	@RequestMapping(value = "/querySupplierByid/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult querySupplierByid(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		System.out.println(87);
		int companyId = getLoginCompanyId();
		int inputMaterialId = getIntParam(paramMap, "inputMaterialId");
		int status =1;
		String sortBy = "ims.CREATE_DATE";
		String sortDirection = "DESC";
		QueryResult<IntCompany> queryResult = inputMaterialService.querySuppliersByInputId(companyId,inputMaterialId,status,sortBy,sortDirection,pageNo, pageSize);
		/*if (queryResult != null && queryResult.getResultList() != null) {
			List<DTOInputMaterialQueryData> newList = DTOInputMaterialQueryData.createListByEntities(queryResult.getResultList());
			queryResult.setResultList(newList);
		} else {
			queryResult = new QueryResult();
		}*/
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}
	// 查找已经存在的收货商，并且不是供应商的企业
	@RequestMapping(value = "/queryReceiverButNotSupplier/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryReceiverButNotSupplier(@RequestParam(required = false) String companyName, @PathVariable int pageNo, @PathVariable int pageSize) {
		Integer loginCompanyId = getLoginCompanyId();
		QueryResult<Map> qr = intCompanyService.searchIntCompanyInclusiveAndExlusive(loginCompanyId, companyName, IntCompany.COMPANY_TYPE_RECEIVER, IntCompany.COMPANY_TYPE_SUPPLIER, pageNo, pageSize);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, qr);
	}

	// 把收货商添加成为供应商
	@RequestMapping(value = "/addSuppliersByReceiverIds", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult addSuppliersByReceiverIds(@RequestBody(required = true) List<Integer> ids) {
		Company loginCompany = getLoginCompany();
		intCompanyService.spawnIntCompany(ids, IntCompany.COMPANY_TYPE_SUPPLIER, loginCompany);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}
	
	/**
     * 3.18 增加注册证件号码唯一性验证
     * @param paramMap
     * @return
     */
    @RequestMapping(value = "/isSupplierCertExist", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult isSupplierCertExist(@RequestBody Map<String, Object> paramMap) {
    	String certType=getStringParam(paramMap, "certType");
    	String certNo=getStringParam(paramMap, "certNo");
    	Integer companyId = getLoginCompanyId();
    	Integer supplierId=getIntParam(paramMap, "supplierId");
    	String companyType = "SUPPLIER";
    	if(!StringUtils.isEmpty(certType)&&!StringUtils.isEmpty(certNo)){
    		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS,intCompanyService.isCertExist(supplierId,certType, certNo, companyId, companyType));
    	}else{
    		return CommonStatusResult.fail(ErrorMessageConstant.CODE_FAIL, null);
    	}
    }
}

