package com.wondersgroup.operation.meal.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.wondersgroup.data.jpa.entity.PartyMeal;

import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FileUploadUtils;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.meal.model.DTOPartyMeal;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.service.export.ReadandWriteExcel;
import com.wondersgroup.service.meal.PartyMealService;
import com.wondersgroup.util.FileUtil;
import com.wondersgroup.util.TimeOrDateUtils;
@Controller
@RequestMapping("/meal/partyMeal")
public class PartyMealController extends AbstractBaseController {
	
	@Autowired
	private PartyMealService partyMealService;
	@Autowired
	private DataDictService dataDictService;
	
	/**
	 * @author linzhixiang
	 * @param partyMealSeq  餐次
	 * @param diningCount   人数
	 * @param partyMealDate  宴会日期
	 * @param partyMealType  就餐方式
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@ResponseBody
	@ResponseStatus(HttpStatus.OK)
	@RequestMapping(value = "/queryPartyMeal/{pageNo}/{pageSize}", method = RequestMethod.POST)
	public CommonStatusResult queryPartyMeal(	
			@RequestBody Map<String, Object> paramMap,
			@PathVariable int pageNo, @PathVariable int pageSize
			)throws UnsupportedEncodingException {
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
		String companyName= getStringParam(paramMap, "companyName");	
		Integer partyMealSeq= getIntParam(paramMap, "partyMealSeq");
		String startDate = getStringParam(paramMap, "startDate");
		String endDate = getStringParam(paramMap, "endDate");
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
		QueryResult queryResult = partyMealService
				.queryPartyMeal(  companyId,  companyName,  mealTimeStartDate,  mealTimeEndDate, partyMealSeq, pageNo,  pageSize);
		  if(queryResult!=null && queryResult.getResultList()!=null) {
			  List<DTOPartyMeal> newList=
					  DTOPartyMeal.createListByEntities(queryResult.getResultList());
			  queryResult.setResultList(newList);
			  }
	
			return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS,
					queryResult);
	
	}
	
	
	/**
	 * @author linzhixiang
	 * @param partyMealSeq  餐次
	 * @param diningCount   人数
	 * @param partyMealDate  宴会日期
	 * @param partyMealType  就餐方式
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/updatePartyMeal", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updatePartyMeal(@RequestBody Map<String, Object> paramMap){
	
		Integer id=getIntParam(paramMap, "id");
		int companyId = getLoginCompanyId();
		Date partyMealDate= getDateParam(paramMap, "partyMealDate");
		Integer partyMealSeq= getIntParam(paramMap, "partyMealSeq");	
		String createDateing= getStringParam(paramMap,"createDate");		
		Date createDate= TimeOrDateUtils.parseDate(createDateing);	
		String partyMealName= (String)paramMap.get("partyMealName");
		Integer diningCount= getIntParam(paramMap, "diningCount");
		Integer partyMealType=getIntParam(paramMap, "partyMealType");
		String remark= (String)paramMap.get("remark");
		Date lastModifiedDate= getDateParam(paramMap, "lastModifiedDate");
		String partyMealTypeDesc= (String)paramMap.get("partyMealTypeDesc");

		PartyMeal entity =new PartyMeal();		
		entity.setId(id);
		entity.setCompanyId(companyId);
		entity.setPartyMealDate(partyMealDate);
		entity.setPartyMealSeq(partyMealSeq);
		entity.setPartyMealName(partyMealName);
		entity.setDiningCount(diningCount);
		entity.setPartyMealType(partyMealType);
		entity.setRemark(remark);
		entity.setCreateDate(createDate);
		entity.setLastModifiedDate(new Date());
		entity.setDelFlag(1);
		entity.setPartyMealTypeDesc(null);

	
		if (entity == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		partyMealService.UpdateGroupMeal(entity);
		System.out.println(entity.toString());
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, entity);
	}
	

	/**
	 * @author linzhixiang
	 * @param partyMealSeq  餐次
	 * @param diningCount   人数
	 * @param partyMealDate  宴会日期
	 * @param partyMealType  就餐方式
	 * @param remark         备注
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/createPartyMeal", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult createPartyMeal(@RequestBody Map<String, Object> paramMap){
	

		int companyId = getLoginCompanyId();
		Date partyMealDate= getDateParam(paramMap, "partyMealDate");
		Integer partyMealSeq= getIntParam(paramMap, "partyMealSeq");
		Date createDate= getDateParam(paramMap, "createDate");
		String partyMealName= (String)paramMap.get("partyMealName");
		Integer diningCount= getIntParam(paramMap, "diningCount");
		Integer partyMealType=getIntParam(paramMap, "partyMealType");
		String remark= (String)paramMap.get("remark");
		Date lastModifiedDate= getDateParam(paramMap, "lastModifiedDate");
		String partyMealTypeDesc= (String)paramMap.get("partyMealTypeDesc");


		PartyMeal entity =new PartyMeal();
		entity.setCompanyId(companyId);
		entity.setPartyMealDate(partyMealDate);
		entity.setPartyMealSeq(partyMealSeq);
		entity.setPartyMealName(partyMealName);
		entity.setDiningCount(diningCount);
		entity.setPartyMealType(partyMealType);
		entity.setRemark(remark);
		entity.setCreateDate(new Date());
		entity.setLastModifiedDate(new Date());
		entity.setDelFlag(null);
		entity.setPartyMealTypeDesc(null);

	
		if (entity == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		partyMealService.createGroupMeal(entity);
		System.out.println(entity.toString());
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, entity);
	}
	
	
	@RequestMapping(value = "/deletePartyMeal/{id}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult deletePartyMeal(@PathVariable int id){
		partyMealService.deleteGroupMeal(id);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, id);
	}
	

	
	@RequestMapping(value = "/getPartyMealById/{partyMealId}", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult getPartyMealById(@PathVariable int partyMealId){
		PartyMeal entity=partyMealService.getPartyMealById(partyMealId);
	
		if (entity == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		DTOPartyMeal dto = DTOPartyMeal.getPartyMealById(entity);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, dto);
	}
	
	@RequestMapping(value = "/queryPartyMealForExport", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryPartyMealForExport(@RequestBody Map<String, Object> paramMap) throws IOException {
		int companyId = getLoginCompanyId();
		String companyName= getStringParam(paramMap, "companyName");	
		Integer partyMealSeq= getIntParam(paramMap, "partyMealSeq");
		String startDate = getStringParam(paramMap, "startDate");
		String endDate = getStringParam(paramMap, "endDate");
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
		QueryResult<PartyMeal> queryResult = partyMealService.queryPartyMeal(companyId,companyName,mealTimeStartDate,mealTimeEndDate,partyMealSeq,-1,-1);
		List<Map> list=new ArrayList<Map>();
		if(queryResult!=null&&queryResult.getResultList()!=null&&queryResult.getResultList().size()>0){
			for(PartyMeal entity:queryResult.getResultList()){
				Map<String,Object> map=new HashMap<String,Object>();
				map.put("partyMealDate", entity.getPartyMealDate());
				map.put("partyMealSeq", dataDictService.getDataDicDetailNameById(entity.getPartyMealSeq()));
				map.put("partyMealName", entity.getPartyMealName());
				map.put("diningCount", entity.getDiningCount());
				map.put("partyMealType", dataDictService.getDataDicDetailNameById(entity.getPartyMealType()));
				map.put("remark", entity.getRemark());
				map.put("id", entity.getId());
				list.add(map);
			}
		}
		String errorFolderPath = "/attach/" + companyId + "_" + "groupMeal";
		String dirURI = FileUploadUtils.contextPath + errorFolderPath;
		Path exportFilePath = FileUtil.createFile(dirURI, "queryPartyMealForExport" + companyId + ".xlsx");

		ReadandWriteExcel.writExlsxFlatly(exportFilePath.toAbsolutePath().toString(), "大型宴会", list,ReadandWriteExcel.PARTYMEAL,ReadandWriteExcel.partymealParameters, ReadandWriteExcel.partymealType);
		
		String remotePath = FileUploadUtils.uploadLocalFileToRemote(exportFilePath.toFile(), FoodConstant.ATT_IMPORT_PARTYMEAL_FILE);

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, remotePath);
	}
}