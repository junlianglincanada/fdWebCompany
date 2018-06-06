package com.wondersgroup.operation.sample.controller;

import java.io.IOException;
import java.nio.file.Path;
import java.util.Date;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.data.jpa.entity.RetentionSamples;
import com.wondersgroup.framework.file.excel.ImportService;
import com.wondersgroup.framework.file.excel.model.ValidationResult;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FileUploadUtils;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.sample.model.DTOSampleCreate;
import com.wondersgroup.operation.sample.model.DTOSampleInfo;
import com.wondersgroup.operation.sample.model.DTOSampleQueryData;
import com.wondersgroup.operation.sample.model.DTOSampleUpdate;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.operation.util.file.UploadUtils;
import com.wondersgroup.service.company.CompanyService;
import com.wondersgroup.service.export.ReadandWriteExcel;
import com.wondersgroup.service.sample.SampleImportService;
import com.wondersgroup.service.sample.SampleService;
import com.wondersgroup.util.FileUtil;
import com.wondersgroup.util.TimeOrDateUtils;

@Controller
@RequestMapping("retentionSample")
public class SampleController extends AbstractBaseController{

	private static Logger LOGGER = LoggerFactory.getLogger(SampleController.class);
	
	@Autowired
	private SampleService sampleService;
	@Autowired
	private CompanyService companyService;
	@Autowired
	private ImportService importService;
	@Autowired
	private UploadUtils uploadUtils;
	@Autowired
	private SampleImportService sampleImportService;
	@RequestMapping(value = "/querySamples/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult querySamples(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize){
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
		String keyword = getStringParam(paramMap, "keyword");
		Integer sampleMealType = getIntParam(paramMap, "sampleMealType");
		Integer sampleType = getIntParam(paramMap, "sampleType");
		String startDate = getStringParam(paramMap, "startDate");
		String endDate = getStringParam(paramMap, "endDate");
		Date sampleTimeStartDate=null;
		Date sampleTimeEndDate=null;
		if(StringUtils.isNotBlank(startDate)){
			sampleTimeStartDate = TimeOrDateUtils.parseDate(startDate, TimeOrDateUtils.FULL_YMD);
			sampleTimeStartDate = TimeOrDateUtils.getDayBegin(sampleTimeStartDate);
		}
		if(StringUtils.isNotBlank(endDate)){
			sampleTimeEndDate = TimeOrDateUtils.parseDate(endDate, TimeOrDateUtils.FULL_YMD);
			sampleTimeEndDate = TimeOrDateUtils.getDayEnd(sampleTimeEndDate);
		}
		QueryResult queryResult = sampleService.querySample(companyId, keyword, sampleMealType, sampleType, sampleTimeStartDate, sampleTimeEndDate, pageNo, pageSize);
		if (queryResult != null && queryResult.getResultList() != null) {
			List<DTOSampleQueryData> newlist = DTOSampleQueryData.createListByEntities(queryResult.getResultList());
			queryResult.setResultList(newlist);
		}else{
			queryResult = new QueryResult();
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}
	
	@RequestMapping(value = "/getSampleById/{sampleId}", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult querySampleInfoById(@PathVariable int sampleId){
		RetentionSamples entity=sampleService.getRetentionSamplesById(sampleId);
		if (entity == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		DTOSampleInfo dto=DTOSampleInfo.createByEntity(entity);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, dto);
	}
	
	@RequestMapping(value = "/createSample", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult createSample(@Valid @RequestBody DTOSampleCreate dto){
		int companyId = getLoginCompanyId();
		//int companyId = 2010;
		Company company = companyService.getCompanyById(companyId);
		if (company == null) {
			throw FoodException.returnException("000011");
		}
		RetentionSamples sample=DTOSampleCreate.toEntity(dto,company);
		if (sample == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		sample=sampleService.createRetentionSamples(sample);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, sample);
	}
	
	@RequestMapping(value = "/updateSample", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateSample(@Valid @RequestBody DTOSampleUpdate dto){
		RetentionSamples sample=DTOSampleUpdate.toEntity(dto,sampleService);
		if (sample == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		sample=sampleService.updateRetentionSamples(sample);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, sample);
	}
	
	@RequestMapping(value = "/deleteSample/{sampleId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult deleteSample(@PathVariable int sampleId){
		sampleService.deleteRetentionSampleById(sampleId);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, sampleId);
	}
	
	/**
	 * 批量导入供应商
	 */
	@RequestMapping(value = "/importSample", method = RequestMethod.POST)
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
		Boolean flag = importService.checkFileName(file.getOriginalFilename(), comId, SampleImportService.IMPORT_TYPE);
		if (!flag) {
			throw FoodException.returnException("error.excel.file.name.duplicate");
		}
		// 检验上传文件
		ValidationResult result = sampleImportService.checkRetentionSamplesImport(comId, file, loginUserId, userName, response);
		LOGGER.error("errorFilename" + result.getErrorFilePath());
		// 检验通过，上传文件; 否则返回文件路径
		if (StringUtils.isBlank(result.getErrorFilePath())) {
			sampleImportService.importRetentionSamples(comId, result.getData(), file.getOriginalFilename(), loginUserId, userName);
			return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
		} else {
			return CommonStatusResult.fail(ErrorMessageConstant.CODE_FAIL, result.getErrorFilePath());
		}
	}
	
	@RequestMapping(value = "/queryRetentionSamplesForExport", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryRetentionSamplesForExport(@RequestBody Map<String, Object> paramMap) throws IOException {
		int companyId = getLoginCompanyId();
		String keyword = getStringParam(paramMap, "keyword");
		Integer sampleMealType = getIntParam(paramMap, "sampleMealType");
		Integer sampleType = getIntParam(paramMap, "sampleType");
		String startDate = getStringParam(paramMap, "startDate");
		String endDate = getStringParam(paramMap, "endDate");
		Date sampleTimeStartDate=null;
		Date sampleTimeEndDate=null;
		if(StringUtils.isNotBlank(startDate)){
			sampleTimeStartDate = TimeOrDateUtils.parseDate(startDate, TimeOrDateUtils.FULL_YMD);
			sampleTimeStartDate = TimeOrDateUtils.getDayBegin(sampleTimeStartDate);
		}
		if(StringUtils.isNotBlank(endDate)){
			sampleTimeEndDate = TimeOrDateUtils.parseDate(endDate, TimeOrDateUtils.FULL_YMD);
			sampleTimeEndDate = TimeOrDateUtils.getDayEnd(sampleTimeEndDate);
		}
		QueryResult<Map> queryResult = sampleService.queryRetentionSamplesForExport(companyId, keyword, sampleMealType, sampleType, sampleTimeStartDate, sampleTimeEndDate, -1, -1);
		String errorFolderPath = "/attach/" + companyId + "_" + "retentionSamples";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "queryRetentionSamplesForExport" + companyId + ".xlsx");

		ReadandWriteExcel.writExlsxFlatly(exportFilePath.toAbsolutePath().toString(), "留样台账", queryResult.getResultList(),ReadandWriteExcel.RETENTIONSAMPLES,ReadandWriteExcel.retentionsampleParameters, ReadandWriteExcel.retentionsampleType);
		
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_RETENTIONSAMPLES_FILE);

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}
}
