package com.wondersgroup.operation.employee.controller;

import java.nio.file.Path;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.Attachment;
import com.wondersgroup.data.jpa.entity.ComEmpLicence;
import com.wondersgroup.data.jpa.entity.ComEmpTraining;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.data.jpa.entity.LastUpdateBizData;
import com.wondersgroup.framework.common.AttachmentService;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.common.LastUpdateBizDataService;
import com.wondersgroup.framework.file.excel.ImportService;
import com.wondersgroup.framework.file.excel.model.ValidationResult;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.DataDicConstant;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FileUploadUtils;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.employee.model.DTOComEmpLicence;
import com.wondersgroup.operation.employee.model.DTOComEmpLicenceCreate;
import com.wondersgroup.operation.employee.model.DTOComEmpLicenceUpdate;
import com.wondersgroup.operation.employee.model.DTOComEmpTrainingData;
import com.wondersgroup.operation.employee.model.DTOComEmployeeCreate;
import com.wondersgroup.operation.employee.model.DTOComEmployeeData;
import com.wondersgroup.operation.employee.model.DTOComEmployeeListData;
import com.wondersgroup.operation.employee.model.DTOComEmployeeUpdate;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.operation.util.annotation.HasPermission;
import com.wondersgroup.operation.util.file.UploadUtils;
import com.wondersgroup.service.company.CompanyService;
import com.wondersgroup.service.empuser.EmployeeImportService;
import com.wondersgroup.service.empuser.RestaurantEmployeeService;
import com.wondersgroup.service.export.ReadandWriteExcel;
import com.wondersgroup.util.FileUtil;

@Controller
@RequestMapping(value = "/restaurant/comEmployee")
public class ComEmployeeController extends AbstractBaseController {

	@Autowired
	private RestaurantEmployeeService restaurantEmployeeService;
	@Autowired
	private CompanyService companyService;
	@Autowired
	private AttachmentService attachmentService;
	@Autowired
	private UploadUtils uploadUtils;
	@Autowired
	private LastUpdateBizDataService updateService;
	@Autowired
	private ImportService importService;
	@Autowired
	private EmployeeImportService employeeImportService;

	// 上传类型 -- 从业人员照片
	public static final String UPLOAD_TYPE_EMP_IMAGE = "EMPLOYEE_IMAGE";
	// 上传类型 -- 健康证照
	public static final String UPLOAD_TYPE_EMP_LINCENCE = "EMPLOYEE_LINCENCE";
	// 上传类型 -- 培训证照
	public static final String UPLOAD_TYPE_EMP_TRAIN_LINCENCE = "EMPLOYEE_TRAIN_LINCENCE";

	public static final Map<String, String> uploadTypeToAttachTypeMap = new HashMap<String, String>() {
		private static final long serialVersionUID = 1948879947792327281L;
		{
			put(UPLOAD_TYPE_EMP_IMAGE, FoodConstant.ATT_EMPLOYEE);

		}
	};

	public static final Map<String, String> uploadTypeToAttachTypeMap2 = new HashMap<String, String>() {
		private static final long serialVersionUID = 1948879947792327281L;
		{
			put(UPLOAD_TYPE_EMP_LINCENCE, FoodConstant.ATT_EMPLOYEE_ID_PHOTO);

		}
	};

	public static final Map<String, String> uploadTypeToAttachTypeMap3 = new HashMap<String, String>() {
		private static final long serialVersionUID = 1948879947792327281L;
		{
			put(UPLOAD_TYPE_EMP_TRAIN_LINCENCE, FoodConstant.ATT_EMPLOYEE_ID_PHOTO);
		}
	};

	private static final List<String> singleImageTypes = new ArrayList<String>() {
		private static final long serialVersionUID = 6694506005823947192L;
		{
			add(UPLOAD_TYPE_EMP_IMAGE);
			add(UPLOAD_TYPE_EMP_LINCENCE);
			add(UPLOAD_TYPE_EMP_TRAIN_LINCENCE);
		}
	};

	/**
	 * 查询某一餐饮企业下的从业人员信息 use:一户一档-从业人员
	 * 
	 * @author hwj
	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/queryComEmployee/{pageNo}/{pageSize}")
	public CommonStatusResult getComEmployee(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) throws Exception {
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
		String key = (String) paramMap.get("key");
		String pubVisible = (String) paramMap.get("pubVisible");
		int pubVisible_ = -1;
		if (!StringUtils.isEmpty(pubVisible)) {
			pubVisible_ = Integer.parseInt(pubVisible);
		}
		String status = (String) paramMap.get("status");
		int status_ = -1;
		if (!StringUtils.isEmpty(status)) {
			status_ = Integer.parseInt(status);
		}
		QueryResult result = restaurantEmployeeService.queryRestaurantEmployeesWithLicence(companyId, key, status_, "", "", pubVisible_, null, pageNo, pageSize);
		if (result != null && result.getResultList() != null) {
			List<DTOComEmployeeListData> newList = DTOComEmployeeListData.createListByEntities(result.getResultList(), restaurantEmployeeService);
			result.setResultList(newList);
		}

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result);
	}
	

	/**导出从业人员
	 * author 江正鹏
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/queryComEmployeeExport")
	public CommonStatusResult queryComEmployeeExport(@RequestBody Map<String, Object> paramMap) throws Exception {

		int companyId = getLoginCompanyId();
		String key = (String) paramMap.get("key");
		String pubVisible = (String) paramMap.get("pubVisible");
		int pubVisible_ = -1;
		if (!StringUtils.isEmpty(pubVisible)) {
			pubVisible_ = Integer.parseInt(pubVisible);
		}
		String status = (String) paramMap.get("status");
		int status_ = -1;
		if (!StringUtils.isEmpty(status)) {
			status_ = Integer.parseInt(status);
		}
		QueryResult<Map> result = restaurantEmployeeService.queryRestaurantEmployeesExport(companyId, key, status_, "", "", pubVisible_, null, -1, -1);
		String errorFolderPath = "/attach/" + companyId + "_" + "restEmployee";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "queryComEmployeeExport" + companyId + ".xlsx");

		ReadandWriteExcel.writExlsxFlatly(exportFilePath.toAbsolutePath().toString(), "从业人员", result.getResultList(),ReadandWriteExcel.COMPANYEMPLOYEE,ReadandWriteExcel.companyemployeeParameters,ReadandWriteExcel.companyemployeeType);
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_INPUTMETERIAL_FILE);

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}
	

	/**
	 * 添加从业人员信息 use:一户一档-从业人员-新增
	 * 
	 * @author hwj
	 * @param DTOComEmployee
	 * @return
	 */
	@RequestMapping(value = "/createComEmployee", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult createComEmployee(DTOComEmployeeCreate dto, HttpServletRequest request) {
		int companyId = getLoginCompanyId();
		ComEmployee comEmployee = DTOComEmployeeCreate.toEntity(dto, companyService, companyId);
		if (comEmployee == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		Map<String, List<MultipartFile>> fileMap = getMultipartFileMapFromRequest(request);
		comEmployee = restaurantEmployeeService.createComEmployee(comEmployee);
		// 添加新图片
		LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
		if (null != comEmployee) {
			uploadUtils.uploadFiles(comEmployee.getPersonId(), uploadTypeToAttachTypeMap, fileMap, singleImageTypes, resultMap, companyId);
		}
		updateService.updateLastUpdateBizData(companyId, LastUpdateBizData.TYPE_COM_EMPLOYEE);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, comEmployee.getPersonId());
	}

	/**
	 * 添加从业人员证照信息 use:一户一档-从业人员-新增
	 * 
	 * @author hwj
	 * @param DTOComEmployee
	 * @return
	 */
	@RequestMapping(value = "/createComEmpLicence", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult createComEmpLicence(DTOComEmpLicenceCreate dto, HttpServletRequest request) {
		int companyId = getLoginCompanyId();
		ComEmployee comEmployee = restaurantEmployeeService.getRestaurantEmployeeById(dto.getPersonId());
		if (comEmployee == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		Map<String, List<MultipartFile>> fileMap = getMultipartFileMapFromRequest(request);
		// 添加新图片
		LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
		ComEmpLicence comEmpLicence = restaurantEmployeeService.createComEmpLicence(DTOComEmpLicenceCreate.toLicenceEntity(dto, comEmployee));
		if (comEmpLicence != null) {
			uploadUtils.uploadFiles(comEmpLicence.getId(), uploadTypeToAttachTypeMap2, fileMap, singleImageTypes, resultMap, companyId);
		}
		ComEmpLicence trainComEmpLicence = restaurantEmployeeService.createComEmpLicence(DTOComEmpLicenceCreate.toTrainLicenceEntity(dto, comEmployee));
		if (trainComEmpLicence != null) {
			uploadUtils.uploadFiles(trainComEmpLicence.getId(), uploadTypeToAttachTypeMap3, fileMap, singleImageTypes, resultMap, companyId);
		}
		updateService.updateLastUpdateBizData(companyId, LastUpdateBizData.TYPE_COM_EMP_LICENCE);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, comEmployee.getPersonId());
	}

	/**
	 * 根据id获取人员信息 use:一户一档-从业人员-修改、查看
	 * 
	 * @author hwj
	 * @param personId
	 * @return
	 */
	@RequestMapping(value = "/getComEmployee/{personId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult getComEmployeeById(@PathVariable("personId") int personId) {
		Map<String, Object> resultData = new HashMap<String, Object>();
		// （1）从业人员基本信息
		ComEmployee comEmployee = restaurantEmployeeService.getRestaurantEmployeeById(personId);
		if (comEmployee == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}

		DTOComEmployeeData dto = DTOComEmployeeData.createByEntity(comEmployee, attachmentService);

		resultData.put("employee", dto);

		// （2）相关证件
		QueryResult<ComEmpLicence> queryResult = restaurantEmployeeService.queryComEmpLicenceByCompanyEmpId(personId, -1, "expireDate", "desc", -1, -1);
		List<DTOComEmpLicence> searchDTOs = new ArrayList<DTOComEmpLicence>();
		// 根据条件获取当前ComEmployee下证件
		if (queryResult != null && queryResult.getResultList() != null && queryResult.getTotalRecord() > 0) {
			List<ComEmpLicence> comEmpLicences = queryResult.getResultList();
			for (ComEmpLicence licence : comEmpLicences) {
				QueryResult<Attachment> files = attachmentService.queryAttFile(FoodConstant.ATT_EMPLOYEE_ID_PHOTO, licence.getId(), null, null);
				Attachment file = null;
				if (files != null && files.getResultList() != null && !files.getResultList().isEmpty()) {
					file = files.getResultList().get(0);
				}
				DTOComEmpLicence dtocel = DTOComEmpLicence.toDTO(licence, file);
				if (dtocel != null) {
					searchDTOs.add(dtocel);
				}
			}
		}
		resultData.put("licence", searchDTOs);

		// (3)相关培训
		List<DTOComEmpTrainingData> trainingDatas = new ArrayList<>();
		QueryResult<ComEmpTraining> trainingQr = restaurantEmployeeService.getComEmpTrainingByComEmpId(personId, null, null, null, -1, -1);
		if (trainingQr != null && trainingQr.getResultList() != null) {
			trainingDatas = DTOComEmpTrainingData.createListByEntities(trainingQr.getResultList());
		}
		resultData.put("training", trainingDatas);

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, resultData);
	}

	/**
	 * 修改从业人员信息 use:一户一档-从业人员-修改
	 * 
	 * @author hwj
	 * @param DTOComEmployeeUpdate
	 * @return
	 */
	@RequestMapping(value = "/updateComEmployee", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateComEmployee(DTOComEmployeeUpdate dto, HttpServletRequest request) {
		int companyId = getLoginCompanyId();
		ComEmployee comEmployee = DTOComEmployeeUpdate.toEntity(dto, restaurantEmployeeService);
		if (comEmployee == null || comEmployee.getPersonId() == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		Map<String, List<MultipartFile>> fileMap = getMultipartFileMapFromRequest(request);
		restaurantEmployeeService.updateComEmployee(comEmployee);

		// 添加新图片
		LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
		if (null != comEmployee) {

			uploadUtils.uploadFiles(comEmployee.getPersonId(), uploadTypeToAttachTypeMap, fileMap, singleImageTypes, resultMap, companyId);

		}
		updateService.updateLastUpdateBizData(companyId, LastUpdateBizData.TYPE_COM_EMPLOYEE);

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}

	/**
	 * 修改从业人员证照信息 use:一户一档-从业人员-修改
	 * 
	 * @author hwj
	 * @param DTOComEmployeeUpdate
	 * @return
	 */
	@RequestMapping(value = "/updateComEmpLicence", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateComEmpLicence(DTOComEmpLicenceUpdate dto, HttpServletRequest request) {
		int companyId = getLoginCompanyId();
		ComEmployee comEmployee = restaurantEmployeeService.getRestaurantEmployeeById(dto.getPersonId());
		if (comEmployee == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		Map<String, List<MultipartFile>> fileMap = getMultipartFileMapFromRequest(request);
		// 添加新图片
		LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();

		ComEmpLicence comEmpLicence = DTOComEmpLicenceUpdate.toLicenceEntity(dto, restaurantEmployeeService);
		if (null != comEmpLicence) {
			if (comEmpLicence.getId() != null) {
				restaurantEmployeeService.updateComEmpLicence(comEmpLicence);
			} else {
				comEmpLicence.setEmp(comEmployee);
				restaurantEmployeeService.createComEmpLicence(comEmpLicence);
			}
		}

		if (comEmpLicence != null) {
			uploadUtils.uploadFiles(comEmpLicence.getId(), uploadTypeToAttachTypeMap2, fileMap, singleImageTypes, resultMap, companyId);
		}
		ComEmpLicence trainComEmpLicence = DTOComEmpLicenceUpdate.toTrainLicenceEntity(dto, restaurantEmployeeService);
		if (null != trainComEmpLicence) {
			if (trainComEmpLicence.getId() != null) {
				restaurantEmployeeService.updateComEmpLicence(trainComEmpLicence);
			} else {
				trainComEmpLicence.setEmp(comEmployee);
				restaurantEmployeeService.createComEmpLicence(trainComEmpLicence);
			}
		}
		if (trainComEmpLicence != null) {
			uploadUtils.uploadFiles(trainComEmpLicence.getId(), uploadTypeToAttachTypeMap3, fileMap, singleImageTypes, resultMap, companyId);
		}
		updateService.updateLastUpdateBizData(companyId, LastUpdateBizData.TYPE_COM_EMP_LICENCE);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}

	/**
	 * 删除从业人员信息 use:暂无
	 * 
	 * @param personId
	 * @return
	 */
	@RequestMapping(value = "/deleteComEmployee/{personId}", method = RequestMethod.GET)
	@ResponseBody
	@HasPermission("EMP_COM_EMPLOYEE_EDIT")
	public ResponseEntity<CommonStatusResult> deleteComEmployee(@PathVariable("personId") Integer personId) {
		int companyId = getLoginCompanyId();
		try {
			restaurantEmployeeService.deleteComEmployee(personId, true, companyId);
			updateService.updateLastUpdateBizData(companyId, LastUpdateBizData.TYPE_COM_EMPLOYEE);

			return returnJSONWithStatus(CommonStatusResult.addSuccess(""), HttpStatus.OK);
		} catch (Exception e) {
			return returnJSONWithStatus(CommonStatusResult.addFail(), HttpStatus.OK);
		}
	}

	/**
	 * 查询关联账户
	 * 
	 * @param personId
	 * @return
	 */
	@RequestMapping(value = "/accountExistAbooutEmp/{personId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult accountExistAbooutEmp(@PathVariable("personId") int personId) {
		Map<String, Object> resultData = new HashMap<String, Object>();
		ComEmployee comEmployee = restaurantEmployeeService.getRestaurantEmployeeById(personId);
		if (comEmployee == null || comEmployee.getAppLoginUserList() == null || comEmployee.getAppLoginUserList().size() <= 0) {
			return CommonStatusResult.fail(ErrorMessageConstant.CODE_FAIL, null);
		}
		DTOComEmployeeData dto = DTOComEmployeeData.createByEntity(comEmployee, attachmentService);
		resultData.put("resultList", dto.getAppLoginUserList());
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, resultData);
	}

	/**
	 * 搜索培训证等级
	 * 
	 */
	@RequestMapping(value = "/getLicenceLevel", method = RequestMethod.GET)
	@ResponseBody
	public Map<Integer, String> getAllGeneralType() {
		Map<Integer, String> map = DataDictService.getDataDicDetailByType(DataDicConstant.DIC_COMPANY_EMPLOYEE_CREDENTIALS_GRADE);
		return map;
	}

	@RequestMapping(value = "/getRelatedAppLoginUsers", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult getRelatedAppLoginUsers(int empId) {
		int companyId = getLoginCompanyId();
		Set<AppLoginUser> relatedAppLoginUsers = restaurantEmployeeService.checkIfLastEmpAdmin(empId, companyId);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, relatedAppLoginUsers);
	}

	/**
	 * 批量导入从业人员
	 */
	@RequestMapping(value = "/importComEmployee", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult importComEmployee(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		Boolean flag = importService.checkFileName(file.getOriginalFilename(), comId, EmployeeImportService.IMPORT_TYPE);
		if (!flag) {
			throw FoodException.returnException("error.excel.file.name.duplicate");
		}
		// 检验上传文件
		ValidationResult result = employeeImportService.checkComEmployeeImport(comId, file, loginUserId, userName, response);
		// 检验通过，上传文件; 否则返回文件路径
		if (StringUtils.isBlank(result.getErrorFilePath())) {
			employeeImportService.importComEmployee(comId, result.getData(), file.getOriginalFilename(), loginUserId, userName);
			return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
		} else {
			return CommonStatusResult.fail(ErrorMessageConstant.CODE_FAIL, result.getErrorFilePath());
		}
	}

}
