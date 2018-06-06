package com.wondersgroup.operation.output.controller;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.wondersgroup.data.jpa.entity.Attachment;
import com.wondersgroup.data.jpa.entity.Company;
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
import com.wondersgroup.operation.input.model.DTOLinkCompanyQueryData;
import com.wondersgroup.operation.output.model.DTOReceiverCreate;
import com.wondersgroup.operation.output.model.DTOReceiverInfo;
import com.wondersgroup.operation.output.model.DTOReceiverQueryData;
import com.wondersgroup.operation.output.model.DTOReceiverQueryDataForSelect;
import com.wondersgroup.operation.output.model.DTOReceiverUpdate;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.operation.util.file.UploadUtils;
import com.wondersgroup.service.company.CompanyService;
import com.wondersgroup.service.company.InternalCompanyService;
import com.wondersgroup.service.export.ReadandWriteExcel;
import com.wondersgroup.service.input.InputMaterialService;
import com.wondersgroup.service.output.ReceiverImportService;
import com.wondersgroup.util.FileUtil;

/**
 * 
 * @author wanglei
 * 
 */
@Controller
@RequestMapping("/inputManage/receiver")
public class ReceiverController extends AbstractBaseController {
	private static Logger LOGGER = LoggerFactory.getLogger(ReceiverController.class);
	@Autowired
	private InternalCompanyService intCompanyService;
	@Autowired
	private InputMaterialService inputMaterialService;
	@Autowired
	private CompanyService companyService;
	@Autowired
	private InternalCompanyService internalCompanyService;
	@Autowired
	private ReceiverImportService receiverImportService;
	@Autowired
	private ImportService importService;
	@Autowired
	private UploadUtils uploadUtils;
	public static final String UPLOAD_TYPE_REC_GSYYZZ = "REC_GSYYZZ"; // 收货商 --
																		// 工商营业执照
	public static final String UPLOAD_TYPE_REC_ZZJGDM = "REC_ZZJGDM"; // 收货商 --
																		// 组织机构代码
	public static final String UPLOAD_TYPE_REC_SWDJZ = "REC_SWDJZ"; // 收货商 --
																	// 税务登记证
	public static final String UPLOAD_TYPE_REC_FRSFZ = "REC_FRSFZ"; // 收货商 --
																	// 法人身份证
	public static final String UPLOAD_TYPE_REC_GAJMLWNDTXZ = "REC_GAJMLWNDTXZ"; // 收货商
																				// --
																				// 港澳居民来往内地通行证
	public static final String UPLOAD_TYPE_REC_TWJMLWNDTXZ = "REC_TWJMLWNDTXZ"; // 收货商
																				// --
																				// 台湾居民来往内地通行证
	public static final String UPLOAD_TYPE_REC_SPLTXKZ = "REC_SPLTXKZ"; // 收货商
																		// --
																		// 食品流通许可证
	public static final String UPLOAD_TYPE_REC_SPSCXKZ = "REC_SPSCXKZ"; // 收货商
																		// --
																		// 食品生产许可证
	public static final String UPLOAD_TYPE_REC_CYFWXKZ = "REC_CYFWXKZ"; // 收货商
																		// --
																		// 餐饮服务许可证
	public static final String UPLOAD_TYPE_REC_SPJYXKZ = "REC_SPJYXKZ"; // 收货商
																		// --
																		// 食品生产许可证
	public static final String UPLOAD_TYPE_REC_OTHER = "REC_OTHER"; // 收货商 -- 其他
	public static final Map<String, String> uploadTypeToAttachTypeMap = new HashMap<String, String>() {
		private static final long serialVersionUID = 1948879947792327281L;

		{
			put(UPLOAD_TYPE_REC_GSYYZZ, FoodConstant.ATT_REC_GSYYZZ);
			put(UPLOAD_TYPE_REC_ZZJGDM, FoodConstant.ATT_REC_ZZJGDM);
			put(UPLOAD_TYPE_REC_SWDJZ, FoodConstant.ATT_REC_SWDJZ);
			put(UPLOAD_TYPE_REC_FRSFZ, FoodConstant.ATT_REC_FRSFZ);
			put(UPLOAD_TYPE_REC_GAJMLWNDTXZ, FoodConstant.ATT_REC_GAJMLWNDTXZ);
			put(UPLOAD_TYPE_REC_TWJMLWNDTXZ, FoodConstant.ATT_REC_TWJMLWNDTXZ);
			put(UPLOAD_TYPE_REC_SPLTXKZ, FoodConstant.ATT_REC_SPLTXKZ);
			put(UPLOAD_TYPE_REC_SPSCXKZ, FoodConstant.ATT_REC_SPSCXKZ);
			put(UPLOAD_TYPE_REC_CYFWXKZ, FoodConstant.ATT_REC_CYFWXKZ);
			put(UPLOAD_TYPE_REC_SPJYXKZ, FoodConstant.ATT_REC_SPJYXKZ);
			put(UPLOAD_TYPE_REC_OTHER, FoodConstant.ATT_REC_OTHER);
		}
	};
	private static final List<String> singleImageTypes = new ArrayList<String>() {
		private static final long serialVersionUID = 6694506005823947192L;

		{
			add(UPLOAD_TYPE_REC_GSYYZZ);
			add(UPLOAD_TYPE_REC_ZZJGDM);
			add(UPLOAD_TYPE_REC_SWDJZ);
			add(UPLOAD_TYPE_REC_FRSFZ);
			add(UPLOAD_TYPE_REC_GAJMLWNDTXZ);
			add(UPLOAD_TYPE_REC_TWJMLWNDTXZ);
			add(UPLOAD_TYPE_REC_SPLTXKZ);
			add(UPLOAD_TYPE_REC_SPSCXKZ);
			add(UPLOAD_TYPE_REC_CYFWXKZ);
			add(UPLOAD_TYPE_REC_SPJYXKZ);
			add(UPLOAD_TYPE_REC_OTHER);
		}
	};

	@RequestMapping(value = "/createReceiver", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult createReceiver(@Valid @RequestBody DTOReceiverCreate dto) {
		int companyId = getLoginCompanyId();
		String cateringCert = dto.getCateringCert();
		String foodCircuCert = dto.getFoodCircuCert();
		String foodProdCert = dto.getFoodProdCert();
		String foodBusinessCert = dto.getFoodBusinessCert();
		String companyType = "RECEIVER";
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
			QueryResult queryResult = intCompanyService.querySuppliersByCompanyCode(companyId, "RECEIVER", dto.getCode(), 1, 10);
			if (queryResult.getResultList() != null && queryResult.getResultList().size() > 0) {
				throw FoodException.returnException("收货商编码已存在！");
			}
		}
		Company linkCompany = null;
		if (dto.getLinkedCompanyId() != null) {
			linkCompany = companyService.getCompanyById(dto.getLinkedCompanyId());
		}
		IntCompany receiver = DTOReceiverCreate.toEntity(dto, company, linkCompany);
		if (receiver == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		receiver = intCompanyService.createInternalCompany(receiver);
		return CommonStatusResult.success("success", receiver);
	}

	@RequestMapping(value = "/updateReceiver", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateReceiver(@Valid @RequestBody DTOReceiverUpdate dto) {
		int companyId = getLoginCompanyId();
		String cateringCert = dto.getCateringCert();
		String foodCircuCert = dto.getFoodCircuCert();
		String foodProdCert = dto.getFoodProdCert();
		String foodBusinessCert = dto.getFoodBusinessCert();
		String companyType = "RECEIVER";
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
					QueryResult queryResult = intCompanyService.querySuppliersByCompanyCode(companyId, "RECEIVER", dto.getCode(), 1, 10);
					if (queryResult.getResultList() != null && queryResult.getResultList().size() > 0) {
						throw FoodException.returnException("收货商编码已存在！");
					}
				}
			}
		}
		IntCompany receiver = DTOReceiverUpdate.toEntity(dto, intCompanyService, companyService);
		if (receiver == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		intCompanyService.updateInternalCompany(receiver);
		return CommonStatusResult.success("success", receiver);
	}

	@RequestMapping(value = "/deleteReceiver/{receiverId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult deleteReceiver(@PathVariable int receiverId) {
		intCompanyService.deleteInternalCompany(receiverId);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, receiverId);
	}

	@RequestMapping(value = "/getReceiverById/{receiverId}", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult getReceiverInfoById(@PathVariable int receiverId) {
		IntCompany entity = intCompanyService.getInternalCompanyById(receiverId);
		if (entity == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		DTOReceiverInfo dto = DTOReceiverInfo.createByEntity(entity);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, dto);
	}

	@RequestMapping(value = "/queryReceivers/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryReceivers(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		String newSearch = getStringParam(paramMap, "newSearch");
		// 如果是第一次查询将查询参数放入session中
		if (StringUtils.isNotEmpty(newSearch)) {
			this.getRequest().getSession().setAttribute("paramMap", paramMap);
			this.getRequest().getSession().setAttribute("pageNo", pageNo);
		} else {
			paramMap = (Map) this.getRequest().getSession().getAttribute("paramMap");
			pageNo = (int) this.getRequest().getSession().getAttribute("pageNo");
		}

		int companyId = getLoginCompanyId();
		String name = getStringParam(paramMap, "name");
		String sortBy = "LAST_MODIFIED_DATE";
		String sortDirection = "DESC";
		String intCompanyType = "RECEIVER";
		QueryResult queryResult = intCompanyService.queryIntCompanyByCompanyId(companyId, name, intCompanyType, sortBy, sortDirection, pageNo, pageSize);
		if (queryResult != null && queryResult.getResultList() != null) {
			List<DTOReceiverQueryData> newList = DTOReceiverQueryData.createListByEntities(queryResult.getResultList(), intCompanyService, companyId);
			queryResult.setResultList(newList);
		} else {
			queryResult = new QueryResult();
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}

	/**
	 * author 江正鹏
	 * 
	 * @param paramMap
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/queryReceiverExport", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryReceiverExport(@RequestBody Map<String, Object> paramMap) throws IOException {
		int companyId = getLoginCompanyId();
		String name = getStringParam(paramMap, "name");
		String sortBy = "LAST_MODIFIED_DATE";
		String sortDirection = "DESC";
		String intCompanyType = "RECEIVER";
		QueryResult<Map> queryResult = intCompanyService.querySupplierForExport(companyId, name, intCompanyType, sortBy, sortDirection, -1, -1);
		// 清空文件夹，没有需要创建
		String errorFolderPath = "/attach/" + companyId + "_" + "supplier";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "queryReceiverExport" + companyId + ".xlsx");

		ReadandWriteExcel.writExlsxFlatly(exportFilePath.toAbsolutePath().toString(), "收货商", queryResult.getResultList(), ReadandWriteExcel.OUTPUTRECEIVER,
				ReadandWriteExcel.outputreceiverParameters, ReadandWriteExcel.outputreceiverType);
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_INPUTMETERIAL_FILE);

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}

	@RequestMapping(value = "/queryReceiversByName/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryReceiversByName(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		int companyId = getLoginCompanyId();
		String name = getStringParam(paramMap, "name");
		String sortBy = "LAST_MODIFIED_DATE";
		String sortDirection = "DESC";
		String intCompanyType = "RECEIVER";
		QueryResult queryResult = intCompanyService.queryIntCompanyByCompanyId(companyId, name, intCompanyType, sortBy, sortDirection, pageNo, pageSize);
		if (queryResult != null && queryResult.getResultList() != null) {
			List<DTOReceiverQueryDataForSelect> newList = DTOReceiverQueryDataForSelect.createListByEntities(queryResult.getResultList());
			queryResult.setResultList(newList);
		} else {
			queryResult = new QueryResult();
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}

	/**
	 * 批量导入收货商
	 */
	@RequestMapping(value = "/importReceiver", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult importReceiver(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		boolean valid = uploadUtils.checkFilesSize(files, new int[]{0}, null);
		if (!valid) {
			throw FoodException.returnExceptionWithPars("error.exceed.max_import_file_size", UploadUtils.maxUploadSize / 1024 / 1024);
		}
		MultipartFile file = files.get(0);// 取第一个文件作为上传文件
		// 检验上传文件名是否上传过
		Boolean flag = importService.checkFileName(file.getOriginalFilename(), comId, ReceiverImportService.IMPORT_TYPE);
		if (!flag) {
			throw FoodException.returnException("error.excel.file.name.duplicate");
		}
		// 检验上传文件
		ValidationResult result = receiverImportService.checkReceiverImport(comId, file, loginUserId, userName, response);
		LOGGER.error("errorFilename" + result.getErrorFilePath());
		// 检验通过，上传文件; 否则返回文件路径
		if (StringUtils.isBlank(result.getErrorFilePath())) {
			receiverImportService.importReceiver(comId, result.getData(), file.getOriginalFilename(), loginUserId, userName);
			return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
		} else {
			return CommonStatusResult.fail(ErrorMessageConstant.CODE_FAIL, result.getErrorFilePath());
		}
	}

	@RequestMapping(value = "/updateReceiverImage/{receiverId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateReceiverImage(@PathVariable int receiverId, HttpServletRequest request) {
		IntCompany intCompany = intCompanyService.getInternalCompanyById(receiverId);
		if (intCompany == null || !IntCompany.COMPANY_TYPE_RECEIVER.equals(intCompany.getType()) || DataUtil.isDeleted(intCompany.getDelFlag())) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		// 添加新图片
		LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
		try {
			Map<String, List<MultipartFile>> fileMap = getMultipartFileMapFromRequest(request);
			uploadUtils.uploadFiles(receiverId, uploadTypeToAttachTypeMap, fileMap, singleImageTypes, resultMap, getLoginCompanyId());
		} catch (Exception e) {
			throw FoodException.returnException("上传文件失败！");
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, resultMap);
	}

	@RequestMapping(value = "/queryReceiverImage/{receiverId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryReceiverImage(@RequestBody String[] imageTypes, @PathVariable int receiverId) {
		IntCompany intCompany = intCompanyService.getInternalCompanyById(receiverId);
		if (intCompany == null || !IntCompany.COMPANY_TYPE_RECEIVER.equals(intCompany.getType()) || DataUtil.isDeleted(intCompany.getDelFlag())) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
		for (String imageType : imageTypes) {
			String attachType = uploadTypeToAttachTypeMap.get(imageType);
			if (StringUtils.isNotBlank(attachType)) {
				List<Attachment> resultList = uploadUtils.queryAttFile(attachType, receiverId, null, null);
				resultMap.put(imageType, resultList);
			}
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, resultMap);
	}

	/**
	 * 查询可用于关联的注册单位
	 */
	@RequestMapping(value = "/queryLinkCompany/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryLinkCompany(@RequestParam String companyName, @PathVariable int pageNo, @PathVariable int pageSize) {
		Integer loginCompanyId = getLoginCompanyId();
		QueryResult<Company> qr = intCompanyService.searchAvailableCompany(loginCompanyId, companyName, IntCompany.COMPANY_TYPE_RECEIVER, pageNo, pageSize);
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

	// 查找已经存在的收货商，并且不是供应商的企业
	@RequestMapping(value = "/querySupplierButNotReceiver/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult querySupplierButNotReceiver(@RequestParam(required = false) String companyName, @PathVariable int pageNo, @PathVariable int pageSize) {
		Integer loginCompanyId = getLoginCompanyId();
		QueryResult<Map> qr = intCompanyService.searchIntCompanyInclusiveAndExlusive(loginCompanyId, companyName, IntCompany.COMPANY_TYPE_SUPPLIER,
				IntCompany.COMPANY_TYPE_RECEIVER, pageNo, pageSize);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, qr);
	}

	// 把供应商添加成为收货商
	@RequestMapping(value = "/addReceiversBySuppliersIds", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult addReceiversBySuppliersIds(@RequestBody(required = true) List<Integer> ids) {
		Company loginCompany = getLoginCompany();
		intCompanyService.spawnIntCompany(ids, IntCompany.COMPANY_TYPE_RECEIVER, loginCompany);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}

	/**
	 * 3.18 增加注册证件号码唯一性验证
	 * 
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "/isReceiverCertExist", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult isReceiverCertExist(@RequestBody Map<String, Object> paramMap) {
		String certType = getStringParam(paramMap, "certType");
		String certNo = getStringParam(paramMap, "certNo");
		Integer companyId = getLoginCompanyId();
		Integer receiverId = getIntParam(paramMap, "receiverId");
		String companyType = "RECEIVER";
		if (!StringUtils.isEmpty(certType) && !StringUtils.isEmpty(certNo)) {
			return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, intCompanyService.isCertExist(receiverId, certType, certNo, companyId, companyType));
		} else {
			return CommonStatusResult.fail(ErrorMessageConstant.CODE_FAIL, null);
		}
	}
}
