package com.wondersgroup.operation.input.controller;

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
import com.wondersgroup.service.input.InputBatchImportService;
import com.wondersgroup.service.input.InputBatchService;
import com.wondersgroup.service.input.InputMaterialService;
import com.wondersgroup.service.output.OutputBatchService;
import com.wondersgroup.service.statistics.StatisticsService;
import com.wondersgroup.util.FileUtil;

@Controller
@RequestMapping("/statistics/inputBatch")
public class InputBatchStatisticsController extends AbstractBaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(InputBatchStatisticsController.class);

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
	private StatisticsService statisticsService;

	@RequestMapping(value = "/getStatisticOfInputBatchByInputMaterial/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult getStatisticOfInputBatchByInputMaterial(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		int companyId = getLoginCompanyId();
		String inputDateStart = getStringParam(paramMap, "inputDateStart");
		String inputDateEnd = getStringParam(paramMap, "inputDateEnd");
		String supplierName = getStringParam(paramMap, "supplierName");
		String inputMatName = getStringParam(paramMap, "inputMatName");
		String sortBy = "lastModifiedDate";
		String sortDirection = "desc";
		QueryResult<Map> queryResult = statisticsService.getStatisticOfInputBatchByInputMaterial(companyId, inputDateStart, inputDateEnd, supplierName, inputMatName, sortBy, sortDirection, pageNo,
				pageSize);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}

	@RequestMapping(value = "/getStatisticOfInputBatchBySupplier/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult getStatisticOfInputBatchBySupplier(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		int companyId = getLoginCompanyId();
		String inputDateStart = getStringParam(paramMap, "inputDateStart");
		String inputDateEnd = getStringParam(paramMap, "inputDateEnd");
		String supplierName = getStringParam(paramMap, "supplierName");
		String inputMatName = getStringParam(paramMap, "inputMatName");
		String sortBy = "lastModifiedDate";
		String sortDirection = "desc";
		QueryResult<Map> queryResult = statisticsService.getStatisticOfInputBatchBySupplier(companyId, inputDateStart, inputDateEnd, supplierName, inputMatName, sortBy, sortDirection, pageNo,
				pageSize);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}

	/**
	 * 数据导出-按采购品
	 * 
	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/exportStatisticOfInputBatchByInputMaterial", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult exportStatisticOfInputBatchByInputMaterial(@RequestBody Map<String, Object> paramMap) throws Exception {
		int companyId = getLoginCompanyId();
		String inputDateStart = getStringParam(paramMap, "inputDateStart");
		String inputDateEnd = getStringParam(paramMap, "inputDateEnd");
		String supplierName = getStringParam(paramMap, "supplierName");
		String inputMatName = getStringParam(paramMap, "inputMatName");
		String sortBy = "lastModifiedDate";
		String sortDirection = "desc";
		QueryResult<Map> queryResult = statisticsService.getStatisticOfInputBatchByInputMaterial(companyId, inputDateStart, inputDateEnd, supplierName, inputMatName, sortBy, sortDirection, 1, 10);
		// 清空文件夹，没有需要创建
		String errorFolderPath = "/attach/" + companyId + "_" + "inputMeterial";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "exportStatisticOfInputBatchByInputMaterial" + companyId + ".xlsx");

		ReadandWriteExcel.writexlsxByInputMaterial(exportFilePath.toAbsolutePath().toString(), "inputMeterial", queryResult.getResultList());
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_INPUTMETERIAL_FILE);

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}

	/**
	 * 数据导出-按供应商
	 * 
	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	/*@RequestMapping(value = "/exportStatisticOfInputBatchBySupplier", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult exportStatisticOfInputBatchBySupplier(@RequestBody Map<String, Object> paramMap) throws Exception {
		int companyId = getLoginCompanyId();
		String inputDateStart = getStringParam(paramMap, "inputDateStart");
		String inputDateEnd = getStringParam(paramMap, "inputDateEnd");
		String supplierName = getStringParam(paramMap, "supplierName");
		String inputMatName = getStringParam(paramMap, "inputMatName");
		String sortBy = "lastModifiedDate";
		String sortDirection = "desc";
		QueryResult<Map> queryResult = statisticsService.getStatisticOfInputBatchBySupplier(companyId, inputDateStart, inputDateEnd, supplierName, inputMatName, sortBy, sortDirection, 1, 10);
		// 清空文件夹，没有需要创建
		String errorFolderPath = "/attach/" + companyId + "_" + "inputSupplier";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "exportStatisticOfInputBatchBySupplier" + companyId + ".xlsx");
		ReadandWriteExcel.writexlsxBySupplier(exportFilePath.toAbsolutePath().toString(), "inputSupplier", queryResult.getResultList());
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_INPUTSUPPLIER_FILE);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}*/

	/**
	 * 大数据 按采购品查询 by linzhengkang
	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/getStatisticOfIBDByInputMaterial/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult getStatisticOfIBDByInputMaterial(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		int companyId = getLoginCompanyId();
		String inputDateStart = getStringParam(paramMap, "inputDateStart");
		String inputDateEnd = getStringParam(paramMap, "inputDateEnd");
		String supplierName = getStringParam(paramMap, "supplierName");
		String inputMatName = getStringParam(paramMap, "inputMatName");
		String sortBy = "inputDate";
		String sortDirection = "desc";
		List<MatInfoBatchDetail> result=statisticsService.getStatisticOfIBDByInputMaterial(companyId, inputDateStart, inputDateEnd, supplierName, inputMatName, sortBy, sortDirection, pageNo, pageSize);
		List<String> list = new ArrayList<String>();
		for(MatInfoBatchDetail mat:result){
			for(Map<String,Object> map:mat.getIntCompanyInfoList()){
				String supplier=map.get("supplierName").toString();
				if(!list.contains(supplier)){
					list.add(supplier);
				}
			}
		}
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("supCount", list.size());
		resultMap.put("body", result);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, resultMap);
	}
	/**
	 * 大数据 按供应商查询 by linzhengkang
	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/getStatisticOfIBDBySupplier/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult getStatisticOfIBDBySupplier(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		int companyId = getLoginCompanyId();
		String inputDateStart = getStringParam(paramMap, "inputDateStart");
		String inputDateEnd = getStringParam(paramMap, "inputDateEnd");
		String supplierName = getStringParam(paramMap, "supplierName");
		String inputMatName = getStringParam(paramMap, "inputMatName");
		String sortBy = "inputDate";
		String sortDirection = "desc";
		QueryResult result=statisticsService.getStatisticOfIBDBySupplier(companyId, inputDateStart, inputDateEnd, supplierName, inputMatName, sortBy, sortDirection, pageNo, pageSize);
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
	@RequestMapping(value = "/exportStatisticOfIBDByInputMaterial", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult exportStatisticOfIBDByInputMaterial(@RequestBody Map<String, Object> paramMap) throws Exception {
		int companyId = getLoginCompanyId();
		String inputDateStart = getStringParam(paramMap, "inputDateStart");
		String inputDateEnd = getStringParam(paramMap, "inputDateEnd");
		String supplierName = getStringParam(paramMap, "supplierName");
		String inputMatName = getStringParam(paramMap, "inputMatName");
		String sortBy = "lastModifiedDate";
		String sortDirection = "desc";
		List<MatInfoBatchDetail> result = statisticsService.getStatisticOfIBDByInputMaterial(companyId, inputDateStart, inputDateEnd, supplierName, inputMatName, sortBy, sortDirection, -1, -1);
		List<Map> list=new ArrayList<Map>();
		for(MatInfoBatchDetail entity:result){
			Map map=new HashMap();
			map.put("inputMatName", entity.getMatName());
			map.put("manufacture", entity.getManufacture());
			map.put("spec", entity.getSpec());
			map.put("totalNum", entity.getCount());
			map.put("suppliers", entity.getIntCompanyInfoList());
			list.add(map);
		}
		// 清空文件夹，没有需要创建
		String errorFolderPath = "/attach/" + companyId + "_" + "inputMeterial";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "exportStatisticOfInputBatchByInputMaterial" + companyId + ".xlsx");

		ReadandWriteExcel.writexlsxByInputMaterial(exportFilePath.toAbsolutePath().toString(), "inputMeterial", list);
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_INPUTMETERIAL_FILE);

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}
	
	/**
	 * 数据导出-按供应商
	 * 
	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/exportStatisticOfIBDBySupplier", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult exportStatisticOfIBDBySupplier(@RequestBody Map<String, Object> paramMap) throws Exception {
		int companyId = getLoginCompanyId();
		String inputDateStart = getStringParam(paramMap, "inputDateStart");
		String inputDateEnd = getStringParam(paramMap, "inputDateEnd");
		String supplierName = getStringParam(paramMap, "supplierName");
		String inputMatName = getStringParam(paramMap, "inputMatName");
		String sortBy = "lastModifiedDate";
		String sortDirection = "desc";
		QueryResult result=statisticsService.getStatisticOfIBDBySupplier(companyId, inputDateStart, inputDateEnd, supplierName, inputMatName, sortBy, sortDirection, -1, -1);
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
				map.put("supplierName", supplierName);
				map.put("inputMatName", entity.getMatName());
				map.put("manufacture", entity.getManufacture());
				map.put("spec", entity.getSpec());
				map.put("totalNum", entity.getCount());
				list.add(map);
			}
		}
		
		// 清空文件夹，没有需要创建
		String errorFolderPath = "/attach/" + companyId + "_" + "inputSupplier";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "exportStatisticOfInputBatchBySupplier" + companyId + ".xlsx");
		ReadandWriteExcel.writexlsxBySupplier(exportFilePath.toAbsolutePath().toString(), "inputSupplier", list);
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_INPUTSUPPLIER_FILE);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}
}
