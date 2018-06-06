package com.wondersgroup.operation.meal.controller;

import java.io.IOException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.wondersgroup.data.jpa.entity.GroupMeal;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FileUploadUtils;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.meal.model.DTOGroupMealCreate;
import com.wondersgroup.operation.meal.model.DTOGroupMealInfo;
import com.wondersgroup.operation.meal.model.DTOGroupMealQueryData;
import com.wondersgroup.operation.meal.model.DTOGroupMealUpdate;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.service.export.ReadandWriteExcel;
import com.wondersgroup.service.meal.GroupMealService;
import com.wondersgroup.util.FileUtil;
import com.wondersgroup.util.TimeOrDateUtils;

@Controller
@RequestMapping("meal/groupMeal")
public class GroupMealController extends AbstractBaseController{

	private static Logger LOGGER = LoggerFactory.getLogger(GroupMealController.class);
	@Autowired
	private GroupMealService groupMealService;
	@Autowired
	private DataDictService dataDictService;
	
	@RequestMapping(value = "/queryGroupMeals/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryGroupMeals(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize){
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
		//int companyId=2010;
		String diningCompanyName=getStringParam(paramMap,"diningCompanyName");
		String startDate = getStringParam(paramMap, "startDate");
		String endDate = getStringParam(paramMap, "endDate");
		Integer groupMealSeq = getIntParam(paramMap, "groupMealSeq");
		Date mealTimeStartDate=null;
		Date mealTimeEndDate=null;
		if(StringUtils.isNotBlank(startDate)){
			mealTimeStartDate = TimeOrDateUtils.parseDate(startDate, TimeOrDateUtils.FULL_YMD);
			mealTimeStartDate = TimeOrDateUtils.getDayBegin(mealTimeStartDate);
		}
		if(StringUtils.isNotBlank(endDate)){
			mealTimeEndDate = TimeOrDateUtils.parseDate(endDate, TimeOrDateUtils.FULL_YMD);
			mealTimeEndDate = TimeOrDateUtils.getDayEnd(mealTimeEndDate);
		}
		QueryResult queryResult = groupMealService.queryGroupMeal(companyId, null,null, diningCompanyName,null, mealTimeStartDate, mealTimeEndDate, groupMealSeq, pageNo, pageSize);
		if (queryResult != null && queryResult.getResultList() != null) {
			List<DTOGroupMealQueryData> newlist = DTOGroupMealQueryData.createListByEntities(queryResult.getResultList());
			queryResult.setResultList(newlist);
		}else{
			queryResult = new QueryResult();
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}
	
	@RequestMapping(value = "/getGroupMealById/{groupMealId}", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult queryGroupMealInfoById(@PathVariable int groupMealId){
		GroupMeal entity=groupMealService.getGroupMealById(groupMealId);
		if (entity == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		DTOGroupMealInfo dto = DTOGroupMealInfo.createByEntity(entity);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, dto);
	}
	
	@RequestMapping(value = "/createGroupMeal", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult createGroupMeal(@Valid @RequestBody DTOGroupMealCreate dto){
		int companyId = getLoginCompanyId();
		//int companyId = 2010;
		GroupMeal entity=DTOGroupMealCreate.toEntity(dto, companyId);
		if(entity == null){
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		entity=groupMealService.createGroupMeal(entity);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, entity);
	}
	
	@RequestMapping(value = "/updateGroupMeal", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateGroupMeal(@Valid @RequestBody DTOGroupMealUpdate dto){
		GroupMeal entity=DTOGroupMealUpdate.toEntity(dto, groupMealService);
		if (entity == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		groupMealService.updateGroupMeal(entity);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, entity);
	}
	
	@RequestMapping(value = "/deleteGroupMeal/{groupMealId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult deleteSample(@PathVariable int groupMealId){
		groupMealService.deleteGroupMeal(groupMealId);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, groupMealId);
	}
	
	@RequestMapping(value = "/queryGroupMealForExport", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryGroupMealForExport(@RequestBody Map<String, Object> paramMap) throws IOException{
		int companyId = getLoginCompanyId();
		//int companyId=2010;
		String diningCompanyName=getStringParam(paramMap,"diningCompanyName");
		String startDate = getStringParam(paramMap, "startDate");
		String endDate = getStringParam(paramMap, "endDate");
		Integer groupMealSeq = getIntParam(paramMap, "groupMealSeq");
		Date mealTimeStartDate=null;
		Date mealTimeEndDate=null;
		if(StringUtils.isNotBlank(startDate)){
			mealTimeStartDate = TimeOrDateUtils.parseDate(startDate, TimeOrDateUtils.FULL_YMD);
			mealTimeStartDate = TimeOrDateUtils.getDayBegin(mealTimeStartDate);
		}
		if(StringUtils.isNotBlank(endDate)){
			mealTimeEndDate = TimeOrDateUtils.parseDate(endDate, TimeOrDateUtils.FULL_YMD);
			mealTimeEndDate = TimeOrDateUtils.getDayEnd(mealTimeEndDate);
		}
		QueryResult<GroupMeal> queryResult = groupMealService.queryGroupMeal(companyId, null,null, diningCompanyName,null, mealTimeStartDate, mealTimeEndDate, groupMealSeq, -1, -1);
		List<Map> list=new ArrayList<Map>();
		if(queryResult!=null&&queryResult.getResultList()!=null&&queryResult.getResultList().size()>0){
			for(GroupMeal entity:queryResult.getResultList()){
				Map<String,Object> map=new HashMap<String,Object>();
				map.put("groupMealDate", entity.getGroupMealDate());
				map.put("groupMealSeq", dataDictService.getDataDicDetailNameById(entity.getGroupMealSeq()));
				map.put("diningCompanyName", entity.getDiningCompanyName());
				map.put("diningCompanyAddress", entity.getDiningCompanyAddress());
				map.put("diningCompanyContactPerson", entity.getDiningCompanyContactPerson());
				map.put("diningCompanyContactPhone", entity.getDiningCompanyContactPhone());
				map.put("diningCount", entity.getDiningCount());
				map.put("groupMealType", dataDictService.getDataDicDetailNameById(entity.getGroupMealType()));
				map.put("foodSafeStaff", entity.getFoodSafeStaff());
				map.put("foodSafeStaffPhone", entity.getFoodSafeStaffPhone());
				map.put("id", entity.getId());
				String[] outputCategories = entity.getOutputCategory().split(",");
				String outputCategory = "";
				for(int i = 0; i < outputCategories.length; i++){
					outputCategory+=dataDictService.getDataDicDetailNameById(Integer.parseInt(outputCategories[i]))+",";
				}
				outputCategory=outputCategory.substring(0, outputCategory.length()-1);
				map.put("outputCategory", outputCategory);
				list.add(map);
			}
		}
		String errorFolderPath = "/attach/" + companyId + "_" + "groupMeal";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "queryGroupMealForExport" + companyId + ".xlsx");
		ReadandWriteExcel.writExlsxFlatly(exportFilePath.toAbsolutePath().toString(), "团膳外卖", list,ReadandWriteExcel.GROUPMEAL,ReadandWriteExcel.groupmealParameters, ReadandWriteExcel.groupmealType);
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_GROUPMEAL_FILE);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}
}
