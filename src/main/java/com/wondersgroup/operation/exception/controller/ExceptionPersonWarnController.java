package com.wondersgroup.operation.exception.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.exception.model.DTOComEmployeeListValue;
import com.wondersgroup.operation.exception.model.DTOException;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.service.empuser.RestaurantEmployeeService;
import com.wondersgroup.service.input.InputBatchService;
import com.wondersgroup.service.output.OutputBatchService;
import com.wondersgroup.service.warn.WarnService;
import com.wondersgroup.util.StringUtils;
import com.wondersgroup.util.TimeOrDateUtils;


@Controller
@RequestMapping("/exception")
public class ExceptionPersonWarnController extends AbstractBaseController{

	@Autowired
	private RestaurantEmployeeService restaurantEmployeeService;
	
	@Autowired
	private WarnService WarnService;
	
	@Autowired
	private InputBatchService inputBatchService;
	
	@Autowired
	private OutputBatchService outputBatchService;
	/**
	 * 查询人员预警信息 健康证预警信息
	 * @author yangtaisong
	 * @return
	 */
	@RequestMapping(value = "/searchWarnPersonHistory/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult searchWarnPersonHistory(
			@RequestBody Map<String, Object> paramMap,
			@PathVariable int pageNo, @PathVariable int pageSize){
		String newSearch = getStringParam(paramMap, "newSearch");
		//如果是第一次查询将查询参数放入session中
		if(!StringUtils.isEmpty(newSearch)){
			this.getRequest().getSession().setAttribute("paramMap", paramMap);
			this.getRequest().getSession().setAttribute("pageNo", pageNo);
		}else{
			paramMap = (Map)this.getRequest().getSession().getAttribute("paramMap");
			pageNo=(int)this.getRequest().getSession().getAttribute("pageNo");
		}
		 int companyId = getLoginCompanyId();
		String warnStatus=(String) paramMap.get("warnStatus");
		 String personName=(String) paramMap.get("key");
		 int status_ = -1;
		 Date date=null;
		 Date notDate=null;
		 if(!StringUtils.isEmpty(warnStatus)){ 
			 if(warnStatus.equals("1")){//查询已过期  证照过期时间 小于今天凌晨
				 date=new Date();
				 String newDate=TimeOrDateUtils.formateDate(date,TimeOrDateUtils.FULL_YMD);
				 date=TimeOrDateUtils.parseDate(newDate);//当前时间凌晨
			 }
			 if(warnStatus.equals("0")){//查询快过期 大于
				 Calendar cal = Calendar.getInstance();    
				   cal.add(cal.MONTH, 1);    
				   date = cal.getTime();//一个月以后的时间
				   notDate=new Date();
				   String newDate=TimeOrDateUtils.formateDate(notDate,TimeOrDateUtils.FULL_YMD);
				   notDate=TimeOrDateUtils.parseDate(newDate); //当前时间凌晨
			 }
		 }else{
			 Calendar cal = Calendar.getInstance();    
			   cal.add(cal.MONTH, 1);    
			   date = cal.getTime();
		 }
		QueryResult queryResult = WarnService.queryEmployeesWithLicence(companyId, personName,status_,"","",status_,FoodConstant.COM_EMP_LICENCE_HEALTH_ID,date,notDate,pageNo, pageSize);
		if(queryResult!=null&&queryResult.getResultList()!=null&&queryResult.getResultList().size()>0){
			List<DTOComEmployeeListValue> newList=DTOComEmployeeListValue.createListByEntities(queryResult.getResultList(), restaurantEmployeeService ,FoodConstant.COM_EMP_LICENCE_HEALTH_ID);
			queryResult.setResultList(newList);
		}

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}
	
	/**
	 * 查询培训证预警信息
	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/searchWarnPerson/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult searchWarnPerson(
			@RequestBody Map<String, Object> paramMap,
			@PathVariable int pageNo, @PathVariable int pageSize){
		String newSearch = getStringParam(paramMap, "newSearch");
		//如果是第一次查询将查询参数放入session中
		if(!StringUtils.isEmpty(newSearch)){
			this.getRequest().getSession().setAttribute("paramMap", paramMap);
			this.getRequest().getSession().setAttribute("pageNo", pageNo);
		}else{
			paramMap = (Map)this.getRequest().getSession().getAttribute("paramMap");
			pageNo=(int)this.getRequest().getSession().getAttribute("pageNo");
		}
		 int companyId = getLoginCompanyId();
		String warnStatus=(String) paramMap.get("warnStatus");
		 String personName=(String) paramMap.get("key");
		 Date date=null;
		 Date notDate=null;
		 if(!StringUtils.isEmpty(warnStatus)){
			 if(warnStatus.equals("1")){
				 date=new Date();
				 String newDate=TimeOrDateUtils.formateDate(date,TimeOrDateUtils.FULL_YMD);
				 date=TimeOrDateUtils.parseDate(newDate);
			 }
			 if(warnStatus.equals("0")){
				 Calendar cal = Calendar.getInstance();    
				   cal.add(cal.MONTH, 1);    
				   date = cal.getTime();
				   notDate=new Date();
				   String newDate=TimeOrDateUtils.formateDate(notDate,TimeOrDateUtils.FULL_YMD);
				   notDate=TimeOrDateUtils.parseDate(newDate); //当前时间凌晨
			 }
		 }else{
			 Calendar cal = Calendar.getInstance();    
			   cal.add(cal.MONTH, 1);    
			   date = cal.getTime();
		 }
		 int status_ = -1;
		QueryResult queryResult = WarnService.queryEmployeesWithLicence(companyId, personName,status_,"","",status_,FoodConstant.COM_EMP_LICENCE_TRAINING_ID,date,notDate,pageNo, pageSize);
		if(queryResult!=null&&queryResult.getResultList()!=null&&queryResult.getResultList().size()>0){
			List<DTOComEmployeeListValue> newList=DTOComEmployeeListValue.createListByEntities(queryResult.getResultList(), restaurantEmployeeService,FoodConstant.COM_EMP_LICENCE_TRAINING_ID);
			queryResult.setResultList(newList);
		}

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}
	
	/**
	 * 查询企业台帐预警
	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(value = "/searchAccountWarning", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult searchAccountWarning() throws ParseException{
		 int companyId = getLoginCompanyId();
		 List<Map> list=WarnService.queryAccountWarning(companyId);
		 Date date=new Date();
		 List<DTOException> resultList=new ArrayList<DTOException>();
		 if(list!=null&&list.size()>0){
			 for(int i=0;i<list.size();i++){
				 DTOException dto=new DTOException();
				 String accoutDateS=(String) list.get(i).get("date");
				 if(!StringUtils.isEmpty(accoutDateS)){
					 dto.setLastRecordDate(accoutDateS);
					 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					 Date accoutDate = sdf.parse(accoutDateS);
					 if(accoutDate!=null){
						 long searhDate=date.getTime()-accoutDate.getTime()-24*60*60*1000;
						 if(searhDate>0){
							 String day=String.valueOf(searhDate/86400000);
							 dto.setRecordDay(day);
						 }else{
							 dto.setRecordDay("0");
						 }
					 }
				 }else{
					 //2016-12-09 台账预警若30天内无数据则查HBASE表
				 	if(i==0){
				 		QueryResult queryResult = inputBatchService.searchHBaseInputBatch(companyId, null, null, null, null, null, 1, 1);
						if(queryResult!=null&&queryResult.getResultList()!=null&&queryResult.getResultList().size()>0){
							Map newest = (Map) queryResult.getResultList().get(0);
							if(newest!=null&&newest.get("input_date")!=null){
								dto.setLastRecordDate(newest.get("input_date").toString());
								Date newestDate = TimeOrDateUtils.parseDate(newest.get("input_date").toString());
								long diff = date.getTime() - newestDate.getTime() - 24 * 60 * 60 * 1000;
								if(diff > 0){
									dto.setRecordDay(String.valueOf(diff / 86400000));
								}
							}
						}
				 	}
				 	if(i==1){
				 		QueryResult queryResult = outputBatchService.searchHBaseOutputBatch(companyId, null, null, null, null, null, 1, 1);
						if(queryResult!=null&&queryResult.getResultList()!=null&&queryResult.getResultList().size()>0){
							Map newest = (Map) queryResult.getResultList().get(0);
							if(newest!=null&&newest.get("output_date")!=null){
								dto.setLastRecordDate(newest.get("output_date").toString());
								Date newestDate = TimeOrDateUtils.parseDate(newest.get("output_date").toString());
								long diff = date.getTime() - newestDate.getTime() - 24 * 60 * 60 * 1000;
								if(diff > 0){
									dto.setRecordDay(String.valueOf(diff / 86400000));
								}
							}
						}
				 	}
				 }
				
				 if(i==0){
					 dto.setAccountName("进货台帐");
				 }
				 if(i==1){
					 dto.setAccountName("配送台帐");
				 }
				 if(i==2){
					 dto.setAccountName("留样台帐");
				 }
				 if(i==3){
					 dto.setAccountName("废弃油脂台帐台帐");
				 }
				 if(i==4){
					 dto.setAccountName("餐厨垃圾回收台帐");
				 }
				
				 resultList.add(dto);
			 }
		 }

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, resultList);
	}
	
	
}
