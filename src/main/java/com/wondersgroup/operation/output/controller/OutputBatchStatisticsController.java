package com.wondersgroup.operation.output.controller;

import java.nio.file.Path;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.dao.entity.IntCompanyInfoBatchDetail;
import com.wondersgroup.framework.dao.entity.MatInfoBatchDetail;
import com.wondersgroup.framework.file.excel.ImportService;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FileUploadUtils;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.service.company.CompanyService;
import com.wondersgroup.service.company.InternalCompanyService;
import com.wondersgroup.service.company.RestaurantService;
import com.wondersgroup.service.export.ReadandWriteExcel;
import com.wondersgroup.service.output.OutputBatchImportService;
import com.wondersgroup.service.output.OutputBatchService;
import com.wondersgroup.service.output.OutputMaterialService;
import com.wondersgroup.service.statistics.StatisticsService;
import com.wondersgroup.util.FileUtil;

@Controller
@RequestMapping("/statistics/outputBatch")
public class OutputBatchStatisticsController extends AbstractBaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(OutputBatchStatisticsController.class);

	@Autowired
	private OutputBatchImportService outputBatchImportService;
	@Autowired
	private CompanyService companyService;
	@Autowired
	private OutputMaterialService outputMaterialService;
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
	private StatisticsService statisticsService;

	@RequestMapping(value = "/getStatisticOfOutputBatchByOutputMaterial/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult getStatisticOfOutputBatchByOutputMaterial(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		int companyId = getLoginCompanyId();
		String outputDateStart = getStringParam(paramMap, "outputDateStart");
		String outputDateEnd = getStringParam(paramMap, "outputDateEnd");
		String receiverName = getStringParam(paramMap, "receiverName");
		String outputMatName = getStringParam(paramMap, "outputMatName");
		String sortBy = "lastModifiedDate";
		String sortDirection = "desc";
		QueryResult<Map> queryResult = statisticsService.getStatisticOfOutputBatchByOutputMaterial(companyId, outputDateStart, outputDateEnd, receiverName, outputMatName, sortBy, sortDirection,
				pageNo, pageSize);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}

	@RequestMapping(value = "/getStatisticOfOutputBatchByReceiver/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult getStatisticOfOutputBatchByReceiver(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		int companyId = getLoginCompanyId();
		String outputDateStart = getStringParam(paramMap, "outputDateStart");
		String outputDateEnd = getStringParam(paramMap, "outputDateEnd");
		String receiverName = getStringParam(paramMap, "receiverName");
		String outputMatName = getStringParam(paramMap, "outputMatName");
		String sortBy = "lastModifiedDate";
		String sortDirection = "desc";
		QueryResult<Map> queryResult = statisticsService.getStatisticOfOutputBatchByReceiver(companyId, outputDateStart, outputDateEnd, receiverName, outputMatName, sortBy, sortDirection, pageNo,
				pageSize);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}

	/**
	 * 数据导出-按产出品
	 * 
	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/exportStatisticOfOutputBatchByOutputMaterial", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult exportStatisticOfOutputBatchByOutputMaterial(@RequestBody Map<String, Object> paramMap) throws Exception {
		int companyId = getLoginCompanyId();
		String outputDateStart = getStringParam(paramMap, "outputDateStart");
		String outputDateEnd = getStringParam(paramMap, "outputDateEnd");
		String receiverName = getStringParam(paramMap, "receiverName");
		String outputMatName = getStringParam(paramMap, "outputMatName");
		String sortBy = "lastModifiedDate";
		String sortDirection = "desc";
		QueryResult<Map> queryResult = statisticsService
				.getStatisticOfOutputBatchByOutputMaterial(companyId, outputDateStart, outputDateEnd, receiverName, outputMatName, sortBy, sortDirection, 1, 10);
		String errorFolderPath = "/attach/" + companyId + "_" + "outputMaterial";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;

		Path exportFilePath = FileUtil.createFile(dirURI, "exportStatisticOfOutputBatchByOutputMaterial" + companyId + ".xlsx");
		ReadandWriteExcel.writexlsxByOutputMaterial(exportFilePath.toAbsolutePath().toString(), "outputMaterial", queryResult.getResultList());
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_OUTPUTMETERIAL_FILE);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}

	/**
	 * 数据导出-按收货商
	 * 
	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
//	@RequestMapping(value = "/exportStatisticOfOutputBatchByReceiver", method = RequestMethod.POST)
//	@ResponseBody
//	public CommonStatusResult exportStatisticOfOutputBatchByReceiver(@RequestBody Map<String, Object> paramMap) throws Exception {
//		int companyId = getLoginCompanyId();
//		String outputDateStart = getStringParam(paramMap, "outputDateStart");
//		String outputDateEnd = getStringParam(paramMap, "outputDateEnd");
//		String receiverName = getStringParam(paramMap, "receiverName");
//		String outputMatName = getStringParam(paramMap, "outputMatName");
//		String sortBy = "lastModifiedDate";
//		String sortDirection = "desc";
//		QueryResult<Map> queryResult = statisticsService.getStatisticOfOutputBatchByReceiver(companyId, outputDateStart, outputDateEnd, receiverName, outputMatName, sortBy, sortDirection, 1, 10);
//		// 清空文件夹，没有需要创建
//		String errorFolderPath = "/attach/" + companyId + "_" + "outputreceiver";
//		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
//		Path exportFilePath = FileUtil.createFile(dirURI, "exportStatisticOfOutputBatchByReceiver" + companyId + ".xlsx");
//		ReadandWriteExcel.writexlsxByReceiver(exportFilePath.toAbsolutePath().toString(), "outputreceiver", queryResult.getResultList());
//		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_OUTPUTRECEIVER_FILE);
//		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
//	}

	/**
	 * 大数据 按产出品查询 by linzhengkang
	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/getStatisticOfOBDByOutputMaterial/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult getStatisticOfOBDByOutputMaterial(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		int companyId = getLoginCompanyId();
		String outputDateStart = getStringParam(paramMap, "outputDateStart");
		String outputDateEnd = getStringParam(paramMap, "outputDateEnd");
		String receiverName = getStringParam(paramMap, "receiverName");
		String outputMatName = getStringParam(paramMap, "outputMatName");
		String sortBy = "lastModifiedDate";
		String sortDirection = "desc";
		List<MatInfoBatchDetail> result=statisticsService.getStatisticOfOBDByOutputMaterial(companyId, outputDateStart, outputDateEnd, receiverName, outputMatName, sortBy, sortDirection, pageNo, pageSize);
		List<String> list = new ArrayList<String>();
		for(MatInfoBatchDetail mat:result){
			for(Map<String,Object> map:mat.getIntCompanyInfoList()){
				String receiver=map.get("receiverName").toString();
				if(!list.contains(receiver)){
					list.add(receiver);
				}
			}
		}
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("recCount", list.size());
		resultMap.put("body", result);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, resultMap);
	}
	/**
	 * 大数据 按收货商查询 by linzhengkang
	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/getStatisticOfOBDByReceiver/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult getStatisticOfOBDByReceiver(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		int companyId = getLoginCompanyId();
		String outputDateStart = getStringParam(paramMap, "outputDateStart");
		String outputDateEnd = getStringParam(paramMap, "outputDateEnd");
		String receiverName = getStringParam(paramMap, "receiverName");
		String outputMatName = getStringParam(paramMap, "outputMatName");
		String sortBy = "lastModifiedDate";
		String sortDirection = "desc";
		QueryResult result=statisticsService.getStatisticOfOBDByReceiver(companyId, outputDateStart, outputDateEnd, receiverName, outputMatName, sortBy, sortDirection, pageNo, pageSize);
		if(result.getResultList()!=null&&result.getResultList().size()>0){
			List<Map<String, Object>> list=result.getResultList();
			List<IntCompanyInfoBatchDetail> dtos=new ArrayList<IntCompanyInfoBatchDetail>();
			for(int i=0;i<list.size();i++){
				IntCompanyInfoBatchDetail dto=IntCompanyInfoBatchDetail.toDTO(list.get(i));
				dtos.add(dto);
			}
			result.setResultList(dtos);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result);
	}
	/**
	 * 大数据导出-按采购品 by linzhengkang 
	 * 
	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/exportStatisticOfOBDByOutputMaterial", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult exportStatisticOfOBDByOutputMaterial(@RequestBody Map<String, Object> paramMap) throws Exception {
		int companyId = getLoginCompanyId();
		String outputDateStart = getStringParam(paramMap, "outputDateStart");
		String outputDateEnd = getStringParam(paramMap, "outputDateEnd");
		String receiverName = getStringParam(paramMap, "receiverName");
		String outputMatName = getStringParam(paramMap, "outputMatName");
		String sortBy = "lastModifiedDate";
		String sortDirection = "desc";
		List<MatInfoBatchDetail> result = statisticsService.getStatisticOfOBDByOutputMaterial(companyId, outputDateStart, outputDateEnd, receiverName, outputMatName, sortBy, sortDirection, -1, -1);
		List<Map> list=new ArrayList<Map>();
		for(MatInfoBatchDetail entity:result){
			Map map=new HashMap();
			map.put("outputMatName", entity.getMatName());
			map.put("manufacture", entity.getManufacture());
			map.put("spec", entity.getSpec());
			map.put("totalNum", entity.getCount());
			map.put("receivers", entity.getIntCompanyInfoList());
			list.add(map);
		}
		// 清空文件夹，没有需要创建
		String errorFolderPath = "/attach/" + companyId + "_" + "outputMeterial";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "exportStatisticOfOutputBatchByOutputMaterial" + companyId + ".xlsx");

		ReadandWriteExcel.writexlsxByOutputMaterial(exportFilePath.toAbsolutePath().toString(), "outputMeterial", list);
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_INPUTMETERIAL_FILE);

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}
	
	/**
	 * 大数据导出-按收货商
	 * 
	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/exportStatisticOfOBDByReceiver", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult exportStatisticOfOBDByReceiver(@RequestBody Map<String, Object> paramMap) throws Exception {
		int companyId = getLoginCompanyId();
		String outputDateStart = getStringParam(paramMap, "outputDateStart");
		String outputDateEnd = getStringParam(paramMap, "outputDateEnd");
		String receiverName = getStringParam(paramMap, "receiverName");
		String outputMatName = getStringParam(paramMap, "outputMatName");
		String sortBy = "lastModifiedDate";
		String sortDirection = "desc";
		QueryResult result = statisticsService.getStatisticOfOBDByReceiver(companyId, outputDateStart, outputDateEnd, receiverName, outputMatName, sortBy, sortDirection, -1, -1);
		List<Map<String, Object>> list=result.getResultList();
		if(result.getResultList()!=null&&result.getResultList().size()>0){
			List<IntCompanyInfoBatchDetail> dtos=new ArrayList<IntCompanyInfoBatchDetail>();
			for(int i=0;i<list.size();i++){
				IntCompanyInfoBatchDetail dto=IntCompanyInfoBatchDetail.toDTO(list.get(i));
				dtos.add(dto);
			}
			result.setResultList(dtos);
			list=new ArrayList<Map<String, Object>>();
			for(IntCompanyInfoBatchDetail entity:dtos){
				Map map=new HashMap();
				map.put("receiverName", receiverName);
				map.put("outputMatName", entity.getMatName());
				map.put("manufacture", entity.getManufacture());
				map.put("spec", entity.getSpec());
				map.put("totalNum", entity.getCount());
				list.add(map);
			}
		}
		
		// 清空文件夹，没有需要创建
		String errorFolderPath = "/attach/" + companyId + "_" + "outputReceiver";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "exportStatisticOfOutputBatchByReceiver" + companyId + ".xlsx");
		ReadandWriteExcel.writexlsxByReceiver(exportFilePath.toAbsolutePath().toString(), "outputReceiver", list);
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_INPUTSUPPLIER_FILE);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}
}
