package com.wondersgroup.operation.exception.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wondersgroup.data.jpa.entity.IntCompany;
import com.wondersgroup.data.jpa.entity.Restaurant;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.exception.model.DTOIntCompany;
import com.wondersgroup.operation.exception.model.DTORestaurant;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.service.company.InternalCompanyService;
import com.wondersgroup.service.operation.OperationRestaurantService;
import com.wondersgroup.util.TimeOrDateUtils;

@Controller
@RequestMapping("/certificate")
public class ExceptionCertificateController extends AbstractBaseController{
	@Autowired
	private OperationRestaurantService operationRestaurantService;
	@Autowired
	private InternalCompanyService intCompanyService;
	
	@RequestMapping(value="/getCertificateWarningById/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	private CommonStatusResult getCertificateWarning(
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
		   String zjType=(String) paramMap.get("zjType");
		   String zjStatus=(String) paramMap.get("zjStatus");
		   if (!StringUtils.isEmpty(zjType)) {
				if (zjType.equals("1")) {
					zjType = FoodConstant.ATT_COM_GSYYZZ;
				} else if (zjType.equals("2")) {
					zjType = FoodConstant.ATT_COM_CYFWXKZ;
				} else if (zjType.equals("3")) {
					zjType = FoodConstant.ATT_COM_SPSCXKZ;
				} else if (zjType.equals("4")) {
					zjType = FoodConstant.ATT_COM_SPLTXKZ;
				}else if (zjType.equals("5")) {
					zjType = FoodConstant.ATT_COM_SPJYXKZ;
				}
			}
		   String companyName=(String) paramMap.get("companyName");
		   Calendar cal = Calendar.getInstance();    
		   cal.add(cal.MONTH, 1);    
		   Date date = cal.getTime();    
		   String intCompanyType = "SUPPLIER";
			QueryResult queryResult = operationRestaurantService.queryIntCompany(companyName,intCompanyType, companyId, date,"","",zjType,zjStatus,pageNo, pageSize);
			if (queryResult != null && queryResult.getResultList() != null&&queryResult.getResultList().size()>0) {
				List<DTOIntCompany> newList = DTOIntCompany.createListByEntities(queryResult.getResultList(),zjType,zjStatus);
				queryResult.setResultList(newList);
			}
		   return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS,queryResult);
		   
		 
	}
	
	@RequestMapping(value="/getCertificateById", method = RequestMethod.GET)
	@ResponseBody
	private CommonStatusResult getCertificateWarningByid(){
		int companyId = getLoginCompanyId();
		   if(StringUtils.isEmpty(companyId)){
			   throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		   }
		   Restaurant restaurant=operationRestaurantService.queryCertificateWarningById(companyId);
		   Map map=new HashMap();
		   
		   Date date=new Date();//当前时间
		  String dateStr =TimeOrDateUtils.formateDate(date,TimeOrDateUtils.FULL_YMD);
		   
		  
		   Calendar cal = Calendar.getInstance();    
		   cal.add(cal.MONTH, 1);
		   Date date1 = cal.getTime();//当前时间一个月以后
		   String dateStr1 =TimeOrDateUtils.formateDate(date1,TimeOrDateUtils.FULL_YMD);
		   DTORestaurant res=DTORestaurant.toDTO(restaurant);
		   map.put("restaurant", res);
		   map.put("date", dateStr);
		   map.put("date1", dateStr1);
		   return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS,map);
		   
		 
	}
	
	@RequestMapping(value="/queryCertificateWarningById/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	private CommonStatusResult queryCertificateWarning(
			@PathVariable int pageNo, @PathVariable int pageSize,
			@RequestParam(value = "companyType", required = false) String companyType,
			@RequestParam(value = "companyStreet", required = false) String companyStreet){
		  Date date=new Date();
		  String intCompanyType = "SUPPLIER";
		  QueryResult queryResult= operationRestaurantService.queryCertificateWarning(companyType, companyStreet,date, pageNo, pageSize);
		  Map hashMap=new HashMap();
		  List<DTORestaurant> map=null;
		  if(queryResult!=null&&queryResult.getResultList() != null&&queryResult.getResultList().size()>0){
			   map=DTORestaurant.createListByEntities(queryResult.getResultList());
			 QueryResult<IntCompany> result=null;
			 for(DTORestaurant r:map){
				 int cunTo=0;
				 int cun=0;
				 Integer companyId= r.getCompanyId();
				 Date bizCertExpDateTo= r.getBizCertExpDate();
					if(bizCertExpDateTo!=null){
						if(bizCertExpDateTo.getTime()<=date.getTime()){
							cunTo++;
						}
					}
					Date cateringCertExpDateTo= r.getCateringCertExpDate();
					if(cateringCertExpDateTo!=null){
						if(cateringCertExpDateTo.getTime()<=date.getTime()){
							cunTo++;
						}
					}
					Date foodCircuCertExpDateTo= r.getFoodCircuCertExpDate();
					if(foodCircuCertExpDateTo!=null){
						if(foodCircuCertExpDateTo.getTime()<=date.getTime()){
							cunTo++;
						}
					}
					Date foodProdCertExpDateTo= r.getFoodProdCertExpDate();
					if(foodProdCertExpDateTo!=null){
						if(foodProdCertExpDateTo.getTime()<=date.getTime()){
							cunTo++;
						}
					}
					 result= operationRestaurantService.queryIntCompany("",intCompanyType, companyId,date,"","","","",-1,-1);
					 if(result!=null&&result.getResultList() != null&&queryResult.getResultList().size()>0){
							List<IntCompany> resultMap=result.getResultList();
					 for(IntCompany inc:resultMap){
								Date bizCertExpDate=inc.getBizCertExpDate();
								if(bizCertExpDate!=null){
									if(bizCertExpDate.getTime()<=date.getTime()){
										cun++;
									}
								}
								Date cateringCertExpDate= inc.getCateringCertExpDate();
								if(cateringCertExpDate!=null){
									if(cateringCertExpDate.getTime()<=date.getTime()){
										cun++;
									}
								}
								Date foodCircuCertExpDate= inc.getFoodCircuCertExpDate();
								if(foodCircuCertExpDate!=null){
									if(foodCircuCertExpDate.getTime()<=date.getTime()){
										cun++;
									}
								}
								Date foodProdCertExpDate= inc.getFoodProdCertExpDate();
								if(foodProdCertExpDate!=null){
									if(foodProdCertExpDate.getTime()<=date.getTime()){
										cun++;
									}
								}
						}
					 }
					 r.setCunTo(cunTo);
					 r.setCun(cun);
				  }
			 queryResult.setResultList(map);
			 hashMap.put("map", result);
			 }
		  hashMap.put("list", queryResult);
		  return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS,hashMap);
	}

}
