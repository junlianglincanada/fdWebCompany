package com.wondersgroup.operation.output.controller;

import java.io.IOException;
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
import com.wondersgroup.data.jpa.entity.OutputBatchDetail;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.dao.entity.OutputBatchDetailData;
import com.wondersgroup.framework.file.excel.ImportService;
import com.wondersgroup.framework.file.excel.model.ValidationResult;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.DataUtil;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FileUploadUtils;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.input.model.DTOImportFileListQueryData;
import com.wondersgroup.operation.output.model.DTOOutBatchDetailDate;
import com.wondersgroup.operation.output.model.DTOOutputBatchCreate;
import com.wondersgroup.operation.output.model.DTOOutputBatchInfo;
import com.wondersgroup.operation.output.model.DTOOutputBatchQueryData;
import com.wondersgroup.operation.output.model.DTOOutputBatchUpdate;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.operation.util.ObjecttToMaoUtil;
import com.wondersgroup.operation.util.file.UploadUtils;
import com.wondersgroup.service.company.CompanyService;
import com.wondersgroup.service.company.InternalCompanyService;
import com.wondersgroup.service.company.RestaurantService;
import com.wondersgroup.service.export.ReadandWriteExcel;
import com.wondersgroup.service.input.InputBatchService;
import com.wondersgroup.service.output.OutputBatchHistoryService;
import com.wondersgroup.service.output.OutputBatchImportService;
import com.wondersgroup.service.output.OutputBatchService;
import com.wondersgroup.service.output.OutputMaterialService;
import com.wondersgroup.util.FileUtil;

@Controller
@RequestMapping("/outputManage/outputBatch")
public class OutputBatchController extends AbstractBaseController {
	private static final Logger LOGGER = LoggerFactory.getLogger(OutputBatchController.class);
	@Autowired
	private InputBatchService inputBatchService;
	@Autowired
	private CompanyService companyService;
	@Autowired
	private OutputMaterialService outputMaterialService;
	@Autowired
	private InternalCompanyService intCompanyService;
	@Autowired
	private OutputBatchImportService outputBatchImportService;
	@Autowired
	private OutputBatchService outputBatchService;
	@Autowired
	private DataDictService dds;
	@Autowired
	private RestaurantService rs;
	@Autowired
	private ImportService importService;
	@Autowired
	private UploadUtils uploadUtils;
	@Autowired
	private OutputBatchHistoryService outputBatchHistoryService;

	

	@RequestMapping(value = "/getOutputBatchById/{id}", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult getOutputBatchById(@PathVariable String id) {
		OutputBatchDetail entity = outputBatchService.getOutputBatchDetailById(id);
		if (entity == null || DataUtil.isDeleted(entity.getDelFlag())) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		DTOOutputBatchInfo dto = DTOOutputBatchInfo.toDTO(entity);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, dto);
	}

	@RequestMapping(value = "/createOutputBatch", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult createOutputBatch(@RequestBody DTOOutputBatchCreate dto) {
		int companyId = getLoginCompanyId();
		Integer loginUserId = getLoginUserId();
		String loginUserName = getLoginUserName();
		List<OutputBatchDetail> list = new ArrayList<>();
		for (Integer receiverId : dto.getReceiverId()) {
			OutputBatchDetail ibd = DTOOutputBatchCreate.toEntity(dto, receiverId, companyId, intCompanyService, outputMaterialService, loginUserId, loginUserName,rs);
			list.add(ibd);
		}
		if (null != list && list.size() > 0) {
			try {
				outputBatchService.processOutputBatchDetailUploadData(list, companyId);
				outputBatchImportService.callUpdateOutputBatchImportData(companyId);
			} catch (Exception e) {
				throw new FoodException(e);
			}
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, list);
	}

	@RequestMapping(value = "/updateOutputBatch", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateOutputBatch(@RequestBody DTOOutputBatchUpdate dto) {
		int companyId = getLoginCompanyId();
		Integer loginUserId = getLoginUserId();
		String loginUserName = getLoginUserName();
		OutputBatchDetail ibd = DTOOutputBatchUpdate.toEntity(dto, companyId, intCompanyService, outputMaterialService, outputBatchService, loginUserId, loginUserName);
		try {
			outputBatchService.processOutputBatchDetailUploadData(Arrays.asList(ibd), companyId);
		} catch (Exception e) {
			throw new FoodException(e);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, ibd);
	}

	/**
	 * 根据Id删除台账
	 */
	@RequestMapping(value = "/deleteOutputBatch/{id}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult deleteOutputBatch(@PathVariable String id) {
		OutputBatchDetail entity = outputBatchService.getOutputBatchDetailById(id);
		if (null == entity) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		outputBatchService.deleteOutputBatchDetail(entity);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}

	@RequestMapping(value = "/queryOutputBatchs/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryOutputBatchs(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
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
		String outDateStart = getStringParam(paramMap, "outDateStart");
		String outDateEnd = getStringParam(paramMap, "outDateEnd");
		String outputDate = getStringParam(paramMap, "outputDate");
		String materialName = getStringParam(paramMap, "materialName");
		String receiverName = getStringParam(paramMap, "receiverName");
//		String sortBy = "lastModifiedDate";
//		String sortDirection = "DESC";
		int limitDate=getIntParam(paramMap, "limitDate");
//		if(outDateStart==null&&limitDate>0){
//			outDateStart=TimeOrDateUtils.formateDate(TimeOrDateUtils.getDateByOffsetDays(new Date(), -32), TimeOrDateUtils.FULL_YMD);
//		}
		QueryResult queryResult = outputBatchService.queryOutputBatchDetails(companyId, outDateStart, outDateEnd, outputDate,null, null, materialName, receiverName, null, null, null, pageNo,
				pageSize);
		if (queryResult != null && queryResult.getResultList() != null) {
			List<DTOOutputBatchQueryData> newList = DTOOutputBatchQueryData.createListByEntities(queryResult.getResultList());
			queryResult.setResultList(newList);
		} else {
			queryResult = new QueryResult();
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}

	/**
	 * 批量导入 发货台账
	 */
	@RequestMapping(value = "/importOutputBatch", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult importOutputBatch(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		Boolean flag = importService.checkFileName(file.getOriginalFilename(), companyId, FoodConstant.IMPORT_TYPE_OUTPUT_BATCH);
		if (!flag) {
			throw FoodException.returnException("error.excel.file.name.duplicate");
		}
		// 检验上传文件
		ValidationResult result = outputBatchImportService.checkOutputBatchImport(companyId, file, loginUserId, userName, response);
		LOGGER.error("errorFilename" + result.getErrorFilePath());
		// 检验通过，上传文件; 否则返回文件路径
		if (StringUtils.isBlank(result.getErrorFilePath())) {
			outputBatchImportService.importOutputBatch(companyId, result.getData(), file.getOriginalFilename(), loginUserId, userName,result.getCache());
			outputBatchImportService.callUpdateOutputBatchImportData(companyId);
			return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
		} else {
			return CommonStatusResult.fail(ErrorMessageConstant.CODE_FAIL, result.getErrorFilePath());
		}
	}

	/**
	 * 根据单位Id获取发货台账上传文件记录列表
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
		QueryResult<ImportFileList> queryResult = importService.queryImportFileList(loginCompanyId, FoodConstant.IMPORT_TYPE_OUTPUT_BATCH, importDate, pageNo, pageSize, null, null);
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
	 * 根据Id删除发货台账上传文件记录，并且删除本次上传文件中对应的所有台账
	 */
	@RequestMapping(value = "/deleteImportFileList/{id}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult deleteImportFileList(@PathVariable Integer id) {
		Integer loginCompanyId = getLoginCompanyId();
		ImportFileList entity = outputBatchService.getImportFileListById(id);
		if (null == entity) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		outputBatchService.deleteImportFileList(loginCompanyId, id);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}

	/**
	 * 根据Id查询发货台账上传文件对应的所有发货台账记录
	 */
	@RequestMapping(value = "/queryImportOutputBatchDetail/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryImportOutputBatchDetail(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
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
		Date outputDate = getDateParam(paramMap, "outputDate");
		Date outputDateStart = getDateParam(paramMap, "outputDateStart");
		Date outputDateEnd = getDateParam(paramMap, "outputDateEnd");		
		String supplierName = getStringParam(paramMap, "supplierName");
		String materialName = getStringParam(paramMap, "materialName");
		String sortBy = "lastModifiedDate";
		String sortDirection = "DESC";
		QueryResult<OutputBatchDetail> queryResult = outputBatchService.queryOutputBatchDetailByImportFileName(loginCompanyId, fileName,outputDate, outputDateStart, outputDateEnd, supplierName, materialName, pageNo, pageSize,
				sortBy, sortDirection);
		List<DTOOutputBatchQueryData> list = new ArrayList<>();
		QueryResult<DTOOutputBatchQueryData> result = null;
		if (queryResult != null && queryResult.getResultList() != null) {
			list = DTOOutputBatchQueryData.createListByEntities(queryResult.getResultList());
			result = new QueryResult<>(list, queryResult.getTotalRecord(), queryResult.getCurrPageNo(), queryResult.getPageSize());
		} else {
			result = new QueryResult<>(list, 0l, pageNo, pageSize);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result);
	}
	
	/**
	 * 根据查询结果导出发货台账明细
	 * author: jzp
	 * param: Map<String, Object> paramMap
	 */
	@RequestMapping(value = "/exportBatchDetail", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult exportStatisticOfInputBatchByInputMaterial(@RequestBody Map<String, Object> paramMap) throws Exception {
		int companyId = getLoginCompanyId();
		/*String outputDate = getStringParam(paramMap, "outputDate");*/
		String outputDateStart = getStringParam(paramMap, "outDateStart");
		String outputDateEnd = getStringParam(paramMap, "outDateEnd");
		String receiverName = getStringParam(paramMap, "receiverName");
		String materialName = getStringParam(paramMap, "materialName");
		String sortBy = "LAST_MODIFIED_DATE";
		String sortDirection = "DESC";
		int limitDate=getIntParam(paramMap, "limitDate");
//		if(outputDateStart==null&&limitDate>0){
//			outputDateStart=TimeOrDateUtils.formateDate(TimeOrDateUtils.getDateByOffsetDays(new Date(), -32), TimeOrDateUtils.FULL_YMD);
//		}
		QueryResult<Map> queryResult = outputBatchService.queryOutputBatchForExport(companyId, outputDateStart, outputDateEnd, null, null, null, materialName, receiverName, null, sortBy, sortDirection);
		// 清空文件夹，没有需要创建
		String errorFolderPath = "/attach/" + companyId + "_" + "outputBatchDetail";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "exportBatchDetail" + companyId + ".xlsx");

		ReadandWriteExcel.writExlsxFlatly(exportFilePath.toAbsolutePath().toString(), "发货台账", queryResult.getResultList(),ReadandWriteExcel.OUTPUTBATCHDETAIL,ReadandWriteExcel.outputbatchdetailParameters,ReadandWriteExcel.outputbatchdetailType);
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_INPUTMETERIAL_FILE);

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}
	
	
	/**
	 * 大数据查询台账列表Habase
	 * @author zyk
	 */
	@RequestMapping(value = "/queryOutputBatchsData/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryOutputBatchsData(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
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
		String outDateStart = getStringParam(paramMap, "outDateStart");
		String outDateEnd = getStringParam(paramMap, "outDateEnd");
		String outputDate = getStringParam(paramMap, "outputDate");
		String materialName = getStringParam(paramMap, "materialName");
		String receiverName = getStringParam(paramMap, "receiverName");
		QueryResult result=outputBatchService.searchHBaseOutputBatchHabase(companyId,outDateStart,outDateEnd,receiverName,materialName,null,pageSize,pageNo);
		if(result.getResultList()!=null&&result.getResultList().size()>0){
			List<Map<String, Object>> list=result.getResultList();
			List<OutputBatchDetailData> lists=new ArrayList<>();
				for(int i=0;i<list.size();i++){
					OutputBatchDetailData dto=OutputBatchDetailData.toEntity(list.get(i));
					lists.add(dto);
				}
			result.setResultList(lists);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result);
	}
	
	/**大数据导出配送台账表格Habase
	 * @author zyk
	 * @param paramMap
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value = "/queryOutputBatchsExportData", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryOutputBatchsExportData(@RequestBody Map<String, Object> paramMap) throws IOException {
		int companyId = getLoginCompanyId();
		String outDateStart = getStringParam(paramMap, "outDateStart");
		String outDateEnd = getStringParam(paramMap, "outDateEnd");
		String outputDate = getStringParam(paramMap, "outputDate");
		String materialName = getStringParam(paramMap, "materialName");
		String receiverName = getStringParam(paramMap, "receiverName");
		QueryResult result=outputBatchService.searchHBaseOutputBatchHabase(companyId,outDateStart,outDateEnd,receiverName,materialName,null,-1,100000);
		List<DTOOutBatchDetailDate> newList=new ArrayList<DTOOutBatchDetailDate>();
		if (result != null && result.getResultList() != null && result.getResultList().size() > 0) {		
			List<Map> list = result.getResultList();
			for (Map o : list) {
				DTOOutBatchDetailDate dto = new DTOOutBatchDetailDate();
				dto = DTOOutBatchDetailDate.createByObj(o);
				newList.add(dto);
				}	 
		}
		String errorFolderPath = "/attach/" + companyId + "_" + "outputBatch";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "queryOutputBatchsExport" + companyId + ".xlsx");
		List<Map> qr=new ArrayList<Map>();
		for(Object o : newList){
		Map map=ObjecttToMaoUtil.getValue(o);
		qr.add(map);
		}
		ReadandWriteExcel.writExlsxFlatly(exportFilePath.toAbsolutePath().toString(), "配送台账", qr,ReadandWriteExcel.OUTPUTBATCHDETAIL,ReadandWriteExcel.outputbatchdetailParametersData,ReadandWriteExcel.outputbatchdetailType);
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_OUTPUTMETERIAL_FILE);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}

	@RequestMapping(value = "/queryOutputBatchsHistory/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryOutputBatchsHistory(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
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
		String outDateStart = getStringParam(paramMap, "outDateStart");
		String outDateEnd = getStringParam(paramMap, "outDateEnd");
		String outputDate = getStringParam(paramMap, "outputDate");
		String materialName = getStringParam(paramMap, "materialName");
		String receiverName = getStringParam(paramMap, "receiverName");
//		String sortBy = "lastModifiedDate";
//		String sortDirection = "DESC";
		int limitDate=getIntParam(paramMap, "limitDate");
//		if(outDateStart==null&&limitDate>0){
//			outDateStart=TimeOrDateUtils.formateDate(TimeOrDateUtils.getDateByOffsetDays(new Date(), -32), TimeOrDateUtils.FULL_YMD);
//		}
		QueryResult queryResult = outputBatchHistoryService.queryOutputBatchDetailHistory(companyId, outDateStart, outDateEnd, outputDate,null, null, materialName, receiverName, null, null, null, pageNo,
				pageSize);
		if (queryResult != null && queryResult.getResultList() != null) {
			List<DTOOutputBatchQueryData> newList = DTOOutputBatchQueryData.createListByHistoryEntities(queryResult.getResultList());
			queryResult.setResultList(newList);
		} else {
			queryResult = new QueryResult();
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}
	
	/**
	 * 根据查询结果导出发货台账明细
	 * author: jzp
	 * param: Map<String, Object> paramMap
	 */
	@RequestMapping(value = "/exportBatchDetailHistory", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult exportStatisticOfInputBatchHistoryByInputMaterial(@RequestBody Map<String, Object> paramMap) throws Exception {
		int companyId = getLoginCompanyId();
		/*String outputDate = getStringParam(paramMap, "outputDate");*/
		String outputDateStart = getStringParam(paramMap, "outDateStart");
		String outputDateEnd = getStringParam(paramMap, "outDateEnd");
		String receiverName = getStringParam(paramMap, "receiverName");
		String materialName = getStringParam(paramMap, "materialName");
		String sortBy = "LAST_MODIFIED_DATE";
		String sortDirection = "DESC";
		int limitDate=getIntParam(paramMap, "limitDate");
//		if(outputDateStart==null&&limitDate>0){
//			outputDateStart=TimeOrDateUtils.formateDate(TimeOrDateUtils.getDateByOffsetDays(new Date(), -32), TimeOrDateUtils.FULL_YMD);
//		}
		QueryResult<Map> queryResult = outputBatchHistoryService.queryOutputBatchHistoryForExport(companyId, outputDateStart, outputDateEnd, null, null, null, materialName, receiverName, null, sortBy, sortDirection);
		// 清空文件夹，没有需要创建
		String errorFolderPath = "/attach/" + companyId + "_" + "outputBatchDetail";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "exportBatchDetail" + companyId + ".xlsx");

		ReadandWriteExcel.writExlsxFlatly(exportFilePath.toAbsolutePath().toString(), "发货台账", queryResult.getResultList(),ReadandWriteExcel.OUTPUTBATCHDETAIL,ReadandWriteExcel.outputbatchdetailParameters,ReadandWriteExcel.outputbatchdetailType);
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_INPUTMETERIAL_FILE);

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}
}
