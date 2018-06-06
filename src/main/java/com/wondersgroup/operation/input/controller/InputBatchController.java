package com.wondersgroup.operation.input.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.wondersgroup.data.jpa.entity.ImportFileList;
import com.wondersgroup.data.jpa.entity.InputBatchDetail;
import com.wondersgroup.data.jpa.entity.OutputBatchDetail;
import com.wondersgroup.data.jpa.entity.Restaurant;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.dao.entity.InputBatchDetilData;
import com.wondersgroup.framework.file.excel.ImportService;
import com.wondersgroup.framework.file.excel.model.ValidationResult;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.DataUtil;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FileUploadUtils;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.input.model.DTOAutoReceiveCreate;
import com.wondersgroup.operation.input.model.DTOAutoReceiveQueryData;
import com.wondersgroup.operation.input.model.DTOImportFileListQueryData;
import com.wondersgroup.operation.input.model.DTOInputBatchCreate;
import com.wondersgroup.operation.input.model.DTOInputBatchDetailDate;
import com.wondersgroup.operation.input.model.DTOInputBatchInfo;
import com.wondersgroup.operation.input.model.DTOInputBatchQueryData;
import com.wondersgroup.operation.input.model.DTOInputBatchUpdate;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.operation.util.ObjecttToMaoUtil;
import com.wondersgroup.operation.util.file.UploadUtils;
import com.wondersgroup.service.company.CompanyService;
import com.wondersgroup.service.company.InternalCompanyService;
import com.wondersgroup.service.company.RestaurantService;
import com.wondersgroup.service.export.ReadandWriteExcel;
import com.wondersgroup.service.input.InputBatchHistoryService;
import com.wondersgroup.service.input.InputBatchImportService;
import com.wondersgroup.service.input.InputBatchService;
import com.wondersgroup.service.input.InputMaterialService;
import com.wondersgroup.service.output.AutoReceiveService;
import com.wondersgroup.service.output.OutputBatchService;
import com.wondersgroup.util.FileUtil;
import com.wondersgroup.util.TimeOrDateUtils;

@Controller
@RequestMapping("/inputManage/inputBatch")
public class InputBatchController extends AbstractBaseController {
	private static final Logger LOGGER = LoggerFactory.getLogger(InputBatchController.class);
	@Autowired
	private InputBatchService inputBatchService;
	@Autowired
	private InputBatchImportService inputBatchImportService;
	@Autowired
	private CompanyService companyService;
	@Autowired
	private InputMaterialService inputMaterialService;
	@Autowired
	private InternalCompanyService intCompanyService;
	@Autowired
	private OutputBatchService outputBatchService;
	@Autowired
	private DataDictService dds;
	@Autowired
	private RestaurantService rs;
	@Autowired
	private ImportService importService;
	@Autowired
	private AutoReceiveService autoReceiveService;
	@Autowired
	private UploadUtils uploadUtils;
	@Autowired
	private InputBatchHistoryService inputBatchHistoryService;

	/**
	 * 获取台账
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/getInputBatchById/{id}", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult getInputBatchById(@PathVariable String id) {
		InputBatchDetail entity = inputBatchService.getInputBatchDetailById(id);
		if (entity == null || DataUtil.isDeleted(entity.getDelFlag())) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		DTOInputBatchInfo dto = DTOInputBatchInfo.toDTO(entity);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, dto);
	}

	/**
	 * 新增进货批量 （常用进货）
	 */
	@RequestMapping(value = "/createInputBatch", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult createInputBatch(@RequestBody DTOInputBatchCreate[] dto) {
		int companyId = getLoginCompanyId();
		Integer loginUserId = getLoginUserId();
		String loginUserName = getLoginUserName();
		List<InputBatchDetail> ibdList = new ArrayList<>();
		try {
			for (int i = 0; i < dto.length; i++) {
				DTOInputBatchCreate o = dto[i];
				InputBatchDetail ibd = DTOInputBatchCreate.toEntity(o, companyId, intCompanyService, inputMaterialService, loginUserId, loginUserName);
				ibdList.add(ibd);
			}
			inputBatchService.createOrUpdateInputBatchDetails(ibdList, companyId);
		} catch (Exception e) {
			throw new FoodException(e);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, ibdList);
	}

	/**
	 * 修改台账
	 */
	@RequestMapping(value = "/updateInputBatch", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateInputBatch(@RequestBody DTOInputBatchUpdate dto) {
		int companyId = getLoginCompanyId();
		Integer loginUserId = getLoginUserId();
		String loginUserName = getLoginUserName();
		InputBatchDetail ibd = DTOInputBatchUpdate.toEntity(dto, companyId, intCompanyService, inputMaterialService, inputBatchService, loginUserId, loginUserName);
		try {
			inputBatchService.createOrUpdateInputBatchDetails(Arrays.asList(ibd), companyId);
		} catch (Exception e) {
			throw new FoodException(e);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, ibd);
	}

	/**
	 * 根据Id删除台账
	 */
	@RequestMapping(value = "/deleteInputBatch/{id}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult deleteInputBatch(@PathVariable String id) {
		InputBatchDetail entity = inputBatchService.getInputBatchDetailById(id);
		if (null == entity) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		inputBatchService.deleteInputBatchDetail(entity);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}

	/**
	 * 查询台账列表
	 */
	@RequestMapping(value = "/queryInputBatchs/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryInputBatchs(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
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
		Date inputDateStart = getDateParam(paramMap, "inputDateStart");
		Date inputDateEnd = getDateParam(paramMap, "inputDateEnd");
		int typeGeneral = getIntParam(paramMap, "typeGeneral");
		String materialName = getStringParam(paramMap, "materialName");
		String supplierName = getStringParam(paramMap, "supplierName");
		int limitDate=getIntParam(paramMap, "limitDate");
		/*if(inputDateStart==null&&limitDate>0){
			inputDateStart=TimeOrDateUtils.getDateByOffsetDays(new Date(), -32);
		}*/
//		String sortBy = "lastModifiedDate";
//		String sortDirection = "desc";
		QueryResult queryResult = inputBatchService.queryInputBatchDetails(companyId, typeGeneral, null, materialName, null, null, inputDateStart, inputDateEnd, null, supplierName, null, null,
				null, pageNo, pageSize);
		if (queryResult != null && queryResult.getResultList() != null) {
			List<DTOInputBatchQueryData> newList = DTOInputBatchQueryData.createListByEntities(queryResult.getResultList());
			queryResult.setResultList(newList);
		} else {
			queryResult = new QueryResult();
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}
	
	/**
	 * 查询常用进货列表
	 */
	@RequestMapping(value = "/searchInputBatchs/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult searchInputBatchs(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		int companyId = getLoginCompanyId();
		Date inputDate = getDateParam(paramMap, "inputDate");
		int typeGeneral = getIntParam(paramMap, "typeGeneral");
		String materialName = getStringParam(paramMap, "materialName");
		String supplierName = getStringParam(paramMap, "supplierName");
		String sortBy = "lastModifiedDate";
		String sortDirection = "desc";
		QueryResult queryResult = inputBatchService.queryInputBatch(companyId, typeGeneral, null, materialName, null, null, inputDate, inputDate, null, supplierName, null,
				 pageNo, pageSize);
		if (queryResult != null && queryResult.getResultList() != null) {
			List<DTOInputBatchQueryData> newList = DTOInputBatchQueryData.createListByEntities(queryResult.getResultList());
			queryResult.setResultList(newList);
		} else {
			queryResult = new QueryResult();
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}


	/**导出进货台账
	 * 
	 * author 江正鹏
	 * @param paramMap
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value = "/queryInputBatchsExport", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryInputBatchsExport(@RequestBody Map<String, Object> paramMap) throws IOException {
		int companyId = getLoginCompanyId();
		Date inputDateStart = getDateParam(paramMap, "inputDateStart");
		Date inputDateEnd = getDateParam(paramMap, "inputDateEnd");
		int typeGeneral = getIntParam(paramMap, "typeGeneral");
		String materialName = getStringParam(paramMap, "materialName");
		String supplierName = getStringParam(paramMap, "supplierName");
		String sortBy = "lastModifiedDate";
		String sortDirection = "desc";
		int limitDate=getIntParam(paramMap, "limitDate");
//		if(inputDateStart==null&&limitDate>0){
//			inputDateStart=TimeOrDateUtils.getDateByOffsetDays(new Date(), -32);
//		}
		QueryResult<Map> queryResult = inputBatchService.queryInputBatchDetailsExport(companyId, typeGeneral, null, materialName, null, null, inputDateStart, inputDateEnd, null, supplierName, null, sortBy,
				sortDirection, -1, -1);
		// 清空文件夹，没有需要创建
		String errorFolderPath = "/attach/" + companyId + "_" + "inputBatch";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "queryInputBatchsExport" + companyId + ".xlsx");

		ReadandWriteExcel.writExlsxFlatly(exportFilePath.toAbsolutePath().toString(), "进货台账", queryResult.getResultList(),ReadandWriteExcel.INPUTBATCHDETAIL,ReadandWriteExcel.inputbatchdetailParameters,ReadandWriteExcel.inputbatchdetailType);
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_INPUTMETERIAL_FILE);

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}

	
	
	/**
	 * 进货台账里面的 查询自动收货接口
	 */
	@RequestMapping(value = "/queryAutoReceive/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryAutoReceive(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		int receiverCompanyId = getLoginCompanyId();
		String supplierName = getStringParam(paramMap, "supplierName");
		String outputDate = getStringParam(paramMap, "outputDate");
		String outputMatName = getStringParam(paramMap, "outputMatName");
		String startDate = outputDate;
		String endDate = outputDate;
		Date start = null;
		Date end = null;
		if (startDate != null && !startDate.isEmpty()) {
			start = TimeOrDateUtils.parseDate(startDate, TimeOrDateUtils.FULL_YMD);
			start = TimeOrDateUtils.getDayBegin(start);
		}
		if (endDate != null && !endDate.isEmpty()) {
			end = TimeOrDateUtils.parseDate(endDate, TimeOrDateUtils.FULL_YMD);
			end = TimeOrDateUtils.getDayEnd(end);
		}
		//4.19 isSync  2为关联未收货
		QueryResult<OutputBatchDetail> qr = outputBatchService.queryOutputBatchDetailByReceiverCompanyId(receiverCompanyId, null,OutputBatchDetail.SYNC_RELATION_REJECT, start, end, outputMatName, null, supplierName, pageNo, pageSize);

		QueryResult<DTOAutoReceiveQueryData> result = null;
		List<DTOAutoReceiveQueryData> list = new ArrayList<>();
		if (qr != null && qr.getResultList() != null) {
			list = DTOAutoReceiveQueryData.createListByEntities(qr.getResultList(), rs, dds);
			result = new QueryResult<>(list, qr.getTotalRecord(), qr.getCurrPageNo(), qr.getPageSize());
		} else {
			result = new QueryResult<>(list, 0l, pageNo, pageSize);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result);
	}

	/*
	 * 自动收货
	 */
	@RequestMapping(value = "createInputBatchOnAutoReceive", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult createInputBatchOnAutoReceive(@RequestBody List<DTOAutoReceiveCreate> outputBatchDetails) {
		int comId = getLoginCompanyId();
		Integer loginUserId = getLoginUserId();
		String userName = getLoginUserName();
		List<String> inputBatchIds = new ArrayList<>();
		if (outputBatchDetails != null && !outputBatchDetails.isEmpty()) {
			List<String> outputBatchDetailIdList = DTOAutoReceiveCreate.toIdList(outputBatchDetails);
			List<BigDecimal> quantityList = DTOAutoReceiveCreate.toQuantityList(outputBatchDetails);
			inputBatchService.createInputBatchOnAutoReceive(comId, outputBatchDetailIdList, quantityList, loginUserId, userName);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, inputBatchIds);
	}

	/**
	 * 忽略/拒绝收货
	 * 
	 */
	@RequestMapping(value = "/ignoreOutputBatchOnAutoReceive", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult ignoreOutputBatchOnAutoReceive(@RequestBody List<String> outputBatchDetailIds) {
		if (outputBatchDetailIds != null && !outputBatchDetailIds.isEmpty()) {
			inputBatchService.ignoreOutputBatchOnAutoReceive(outputBatchDetailIds);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, outputBatchDetailIds);
	}

	/**
	 * 批量导入 进货台账
	 */
	@RequestMapping(value = "/importInputBatch", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult importInputBatch(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int companyId = getLoginCompanyId();
		//Company company = companyService.getCompanyById(companyId);
		Integer loginUserId = getLoginUserId();
		String userName = getLoginUserName();
		List<MultipartFile> files = getMultipartFilesFromRequest(request);
		MultipartFile file = files.get(0);// 取第一个文件作为上传文件
		// 检验文件大小
		boolean valid = uploadUtils.checkFilesSize(files, new int[] { 0 }, null);
		if (!valid) {
			throw FoodException.returnExceptionWithPars("error.exceed.max_import_file_size", UploadUtils.maxUploadSize / 1024 / 1024);
		}
		// 检验上传文件名是否上传过
		Boolean flag = importService.checkFileName(file.getOriginalFilename(), companyId, FoodConstant.IMPORT_TYPE_INPUT_BATCH);
		if (!flag) {
			throw FoodException.returnException("error.excel.file.name.duplicate");
		}
		// 检验上传文件
		ValidationResult result = inputBatchImportService.checkInputBatchImport(companyId, file, loginUserId, userName, response);
		LOGGER.error("errorFilename" + result.getErrorFilePath());
		// 检验通过，上传文件; 否则返回文件路径
		if (StringUtils.isBlank(result.getErrorFilePath())) {
			inputBatchImportService.importInputBatch(companyId, result.getData(), file.getOriginalFilename(), loginUserId, userName,result.getCache());
			//inputBatchImportService.callUpdateInputBatchImportData(companyId);
			return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
		} else {
			return CommonStatusResult.fail(ErrorMessageConstant.CODE_FAIL, result.getErrorFilePath());
		}
	}

	/**
	 * 批量导入 进货台账
	 */
	@RequestMapping(value = "/switchAutoReceive", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult switchAutoReceive(@RequestBody Map<String, Object> paramMap) throws Exception {
		int switcher = getIntParam(paramMap, "switcher");
		if (switcher == 1 || switcher == 0) {
			Integer loginCompanyId = getLoginCompanyId();
			autoReceiveService.switchAutoReceive(switcher, loginCompanyId);
			return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
		} else {
			return CommonStatusResult.fail(ErrorMessageConstant.CODE_FAIL, null);
		}
	}
	@RequestMapping(value = "/switchRelationAutoReceive", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult switchRelationAutoReceive(@RequestBody Map<String, Object> paramMap) throws Exception {
		int switcher = getIntParam(paramMap, "switcher");
		int intCompanyId = getIntParam(paramMap, "intCompanyId");
		if ((switcher == 1 || switcher == 0)&&intCompanyId>0) {
			autoReceiveService.switchAutoReceiveIntCompany(switcher, intCompanyId);
			return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
		} else {
			return CommonStatusResult.fail(ErrorMessageConstant.CODE_FAIL, null);
		}
	}

	@RequestMapping(value = "/getAutoReceiveStatus", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult getAutoReceiveStatus() {
		Integer loginCompanyId = getLoginCompanyId();
		Restaurant restaurant = rs.getRestaurantById(loginCompanyId);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, restaurant.getIsAutoRecv());
	}
   
	/**
	 * 根据单位Id获取进货台账上传文件记录列表
	 */
	@RequestMapping(value = "/queryImportFileList/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryImportFileList(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		String newSearch = getStringParam(paramMap, "newSearch");
		//如果是第一次查询将查询参数放入session中
		if(StringUtils.isNotEmpty(newSearch)){
			this.getRequest().getSession().setAttribute("paramMap", paramMap);
			this.getRequest().getSession().setAttribute("pageNo", pageNo);
		}else{
			paramMap = (Map)this.getRequest().getSession().getAttribute("paramMap");
			pageNo=(int)this.getRequest().getSession().getAttribute("pageNo");
		}
		
		String importDate = getStringParam(paramMap, "importDate");
		Integer loginCompanyId = getLoginCompanyId();
		QueryResult<ImportFileList> queryResult = importService.queryImportFileList(loginCompanyId, FoodConstant.IMPORT_TYPE_INPUT_BATCH, importDate, pageNo, pageSize, null, null);
		List<DTOImportFileListQueryData> list = new ArrayList<>();
		QueryResult<DTOImportFileListQueryData> result = null;
		if (queryResult != null && queryResult.getResultList() != null) {
			list = DTOImportFileListQueryData.createListByEntities(queryResult.getResultList());
			result = new QueryResult<>(list, queryResult.getTotalRecord(), queryResult.getCurrPageNo(), queryResult.getPageSize());
		} else {
			result = new QueryResult<>(list, 0l, pageNo, pageSize);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result);
	}

	/**
	 * 根据Id删除进货台账上传文件记录，并且删除本次上传文件中对应的所有台账
	 */
	@RequestMapping(value = "/deleteImportFileList/{id}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult deleteImportFileList(@PathVariable Integer id) {
		Integer loginCompanyId = getLoginCompanyId();
		ImportFileList entity = inputBatchService.getImportFileListById(id);
		if (null == entity) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		inputBatchService.deleteImportFileList(loginCompanyId, id);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}

	/**
	 * 根据Id查询进货台账上传文件对应的所有进货台账记录
	 */
	@RequestMapping(value = "/queryImportInputBatchDetail/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryImportInputBatchDetail(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		String newSearch = getStringParam(paramMap, "newSearch");
		//如果是第一次查询将查询参数放入session中
//		if(StringUtils.isNotEmpty(newSearch)){
//			this.getRequest().getSession().setAttribute("paramMap", paramMap);
//			this.getRequest().getSession().setAttribute("pageNo", pageNo);
//		}else{
//			paramMap = (Map)this.getRequest().getSession().getAttribute("paramMap");
//			pageNo=(int)this.getRequest().getSession().getAttribute("pageNo");
//		}
		
		Integer loginCompanyId = getLoginCompanyId();
		String fileName = getStringParam(paramMap, "fileName");
		Date inputDateStart = getDateParam(paramMap, "inputDateStart");
		Date inputDateEnd = getDateParam(paramMap, "inputDateEnd");
		String supplierName = getStringParam(paramMap, "supplierName");
		String materialName = getStringParam(paramMap, "materialName");
		String sortBy = "LAST_MODIFIED_DATE";
		String sortDirection = "DESC";
		QueryResult<InputBatchDetail> queryResult = inputBatchService.queryInputBatchDetailByImportFileName(loginCompanyId, fileName, inputDateStart,inputDateEnd, supplierName, materialName, pageNo, pageSize, sortBy,
				sortDirection);
		List<DTOInputBatchQueryData> list = new ArrayList<>();
		QueryResult<DTOInputBatchQueryData> result = null;
		if (queryResult != null && queryResult.getResultList() != null) {
			list = DTOInputBatchQueryData.createListByEntities(queryResult.getResultList());
			result = new QueryResult<>(list, queryResult.getTotalRecord(), queryResult.getCurrPageNo(), queryResult.getPageSize());
		} else {
			result = new QueryResult<>(list, 0l, pageNo, pageSize);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result);
	}
	
	/**
	 * 大数据查询台账列表
	 */
	@RequestMapping(value = "/queryInputBatchsData/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryInputBatchsData(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
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
		String inputDateStart = getStringParam(paramMap, "inputDateStart");
		String inputDateEnd = getStringParam(paramMap, "inputDateEnd");
		int typeGeneral = getIntParam(paramMap, "typeGeneral");
		String materialName = getStringParam(paramMap, "materialName");
		String supplierName = getStringParam(paramMap, "supplierName");
		QueryResult result=inputBatchService.searchHBaseInputBatchHabase(companyId,inputDateStart,inputDateEnd,supplierName,materialName,null,pageSize,pageNo);

		Date end = new Date();
		if(result.getResultList()!=null&&result.getResultList().size()>0){
			List<Map<String, Object>> list=result.getResultList();
			List<InputBatchDetilData> lists=new ArrayList<>();
			for(int i=0;i<list.size();i++){
				InputBatchDetilData dto=InputBatchDetilData.toEntity(list.get(i));
				lists.add(dto);
			}
			result.setResultList(lists);
		}
		List<Map> OutputBatchDetailList = result.getResultList();
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result);
	}
	
	/**大数据导出进货台账表格
	 * 
	 * @param paramMap
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value = "/queryInputBatchsExportData", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryInputBatchsExportData(@RequestBody Map<String, Object> paramMap) throws IOException {
		int companyId = getLoginCompanyId();
		String inputDateStart = getStringParam(paramMap, "inputDateStart");
		String inputDateEnd = getStringParam(paramMap, "inputDateEnd");
		String supplierName = getStringParam(paramMap, "supplierName");
		String inputMatName = getStringParam(paramMap, "materialName");
		QueryResult result=inputBatchService.searchHBaseInputBatchHabase(companyId,inputDateStart,inputDateEnd,supplierName,inputMatName,null,-1,100000);
		List<DTOInputBatchDetailDate> newList=new ArrayList<DTOInputBatchDetailDate>();
		if (result != null && result.getResultList() != null && result.getResultList().size() > 0) {		
			List<Map> list = result.getResultList();
			for (Map o : list) {
				DTOInputBatchDetailDate dto = new DTOInputBatchDetailDate();
				dto = DTOInputBatchDetailDate.createByObj(o);
				newList.add(dto);
				}	 
		}
		String errorFolderPath = "/attach/" + companyId + "_" + "inputBatch";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "queryInputBatchsExport" + companyId + ".xlsx");
		
		List<Map> qr=new ArrayList<Map>();
		for(Object o : newList){
		Map map=ObjecttToMaoUtil.getValue(o);
		qr.add(map);
		}
		ReadandWriteExcel.writExlsxFlatly(exportFilePath.toAbsolutePath().toString(), "进货台账", qr,ReadandWriteExcel.INPUTBATCHDETAIL,ReadandWriteExcel.inputbatchdetailParametersData,ReadandWriteExcel.inputbatchdetailType);
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_INPUTMETERIAL_FILE);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}
	
	/**
	 * 查询历史台账列表
	 */
	@RequestMapping(value = "/queryInputBatchsHistory/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryInputBatchsHistory(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
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
		Date inputDateStart = getDateParam(paramMap, "inputDateStart");
		Date inputDateEnd = getDateParam(paramMap, "inputDateEnd");
		int typeGeneral = getIntParam(paramMap, "typeGeneral");
		String materialName = getStringParam(paramMap, "materialName");
		String supplierName = getStringParam(paramMap, "supplierName");
		int limitDate=getIntParam(paramMap, "limitDate");
//		if(inputDateStart==null&&limitDate>0){
//			inputDateStart=TimeOrDateUtils.getDateByOffsetDays(new Date(), -32);
//		}
//		String sortBy = "lastModifiedDate";
//		String sortDirection = "desc";
		QueryResult queryResult = inputBatchHistoryService.queryInputBatchDetailHistory(companyId, typeGeneral, null, materialName, null, null, inputDateStart, inputDateEnd, null, supplierName, null, null,
				null, pageNo, pageSize);
		if (queryResult != null && queryResult.getResultList() != null) {
			List<DTOInputBatchQueryData> newList = DTOInputBatchQueryData.createListByHistoryEntities(queryResult.getResultList());
			queryResult.setResultList(newList);
		} else {
			queryResult = new QueryResult();
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}
	
	/**导出历史进货台账
	 * 
	 * author 江正鹏
	 * @param paramMap
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value = "/queryInputBatchsHistoryExport", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryInputBatchsHistoryExport(@RequestBody Map<String, Object> paramMap) throws IOException {
		int companyId = getLoginCompanyId();
		Date inputDateStart = getDateParam(paramMap, "inputDateStart");
		Date inputDateEnd = getDateParam(paramMap, "inputDateEnd");
		int typeGeneral = getIntParam(paramMap, "typeGeneral");
		String materialName = getStringParam(paramMap, "materialName");
		String supplierName = getStringParam(paramMap, "supplierName");
		String sortBy = "lastModifiedDate";
		String sortDirection = "desc";
		int limitDate=getIntParam(paramMap, "limitDate");
//		if(inputDateStart==null&&limitDate>0){
//			inputDateStart=TimeOrDateUtils.getDateByOffsetDays(new Date(), -32);
//		}
		QueryResult<Map> queryResult = inputBatchHistoryService.queryInputBatchDetailHistoryExport(companyId, typeGeneral, null, materialName, null, null, inputDateStart, inputDateEnd, null, supplierName, null, sortBy,
				sortDirection, -1, -1);
		// 清空文件夹，没有需要创建
		String errorFolderPath = "/attach/" + companyId + "_" + "inputBatch";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "queryInputBatchsExport" + companyId + ".xlsx");

		ReadandWriteExcel.writExlsxFlatly(exportFilePath.toAbsolutePath().toString(), "进货台账", queryResult.getResultList(),ReadandWriteExcel.INPUTBATCHDETAIL,ReadandWriteExcel.inputbatchdetailParameters,ReadandWriteExcel.inputbatchdetailType);
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_INPUTMETERIAL_FILE);

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}
}
