package com.wondersgroup.operation.relationship.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.ComRelationship;
import com.wondersgroup.data.jpa.entity.CompanyImport;
import com.wondersgroup.data.jpa.entity.IntCompany;
import com.wondersgroup.data.jpa.entity.Restaurant;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.common.GeoAdminRegionService;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.common.model.DTOCompanyImportInfo;
import com.wondersgroup.operation.common.model.DTOCompanyInfoWithUserInfoCreate;
import com.wondersgroup.operation.relationship.model.DTOComRelationshipForSearch;
import com.wondersgroup.operation.relationship.model.DTOComRelationshipUpdate;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.service.company.ComRelationshipService;
import com.wondersgroup.service.company.CompanyImportService;
import com.wondersgroup.service.company.InternalCompanyService;
import com.wondersgroup.service.company.RestaurantService;
import com.wondersgroup.service.empuser.RestaurantEmployeeLoginService;
import com.wondersgroup.service.input.InputBatchService;
import com.wondersgroup.util.TimeOrDateUtils;

/**
 * 连锁企业管理
 */
@Controller
@RequestMapping("/comRelationship/relationship")
public class ComRelationshipController extends AbstractBaseController {

	private static Logger LOGGER = LoggerFactory.getLogger(ComRelationshipController.class);

	@Autowired
	ComRelationshipService comRelationshipService;
	
	@Autowired
	private CompanyImportService companyImportService;
	
	@Autowired
	private RestaurantService restaurantService;
	
	@Autowired
    private GeoAdminRegionService geoAdminRegionService;
	
    @Autowired
    private RestaurantEmployeeLoginService restaurantEmployeeLoginService;
    
    @Autowired
    private InternalCompanyService intCompanyService;
    
	@Autowired
	private InputBatchService inputBatchService;

	public final static String INPUT_TYPE = "inputType";//

	/**
	 * 查询门店清单
	 * 
	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/queryComRelationship/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryComRelationship(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		String companyName = getStringParam(paramMap, "companyName");
		int companyToType = getIntParam(paramMap, "companyToType");
		int companyId = getLoginCompanyId();
		QueryResult<Map> queryMap = comRelationshipService.queryComRelationship(companyId, companyToType, companyName, pageNo, pageSize);

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryMap);
	}

	/**
	 * 门店台账录入统计 inputType=1 录入 0 未录入 -1 全部
	 * 
	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/queryComRelationshipLedger/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryComRelationshipLedger(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		String companyName = getStringParam(paramMap, "companyName");
		int inputType = getIntParam(paramMap, "inputType");
		String startDate = getStringParam(paramMap, "startDate");
		String endDate = getStringParam(paramMap, "endDate");
		int companyToType = getIntParam(paramMap, "companyToType");
		int companyId = getLoginCompanyId();
		// int companyId=100169;
		Map resultMap = new HashMap<>();
		int count = comRelationshipService.searchComRelationshipCount(companyId);
		long notInput = 0;
		long input = 0;
		// QueryResult<Map>
		// queryMapCount=comRelationshipService.queryComRelationshipInput(companyId);
		Map mapCount = new HashMap<>();
		// if (null!=queryMapCount&&queryMapCount.getResultList().size()>0) {
		// for (Map map:queryMapCount.getResultList()) {
		// if(map.get("inputType")!=null){
		// if(map.get("inputType").toString().equals("input")){
		// mapCount.put("input",
		// map.get("companyCount")==null?0:map.get("companyCount"));
		// }else if(map.get("inputType").toString().equals("notInput")){
		// mapCount.put("notInput",
		// map.get("companyCount")==null?0:map.get("companyCount"));
		// }
		// }
		// }
		// if (mapCount!=null) {
		// resultMap.put("mapCount", mapCount);
		// }
		// }
		QueryResult<Map> queryMap = comRelationshipService.queryComRelationshipInputBatchDetail(companyId, inputType, companyToType, companyName, startDate, endDate, pageNo, pageSize);
		if (null != queryMap) {
			List<Map> resutList = queryMap.getResultList();
			for (Map map : resutList) {
				Integer cpId = Integer.parseInt((map.get("companyId") == null ? -1 : map.get("companyId")).toString());
				if (cpId != null && cpId > -1) {
					if(map.get("inputDate") == null){
						QueryResult queryResult = inputBatchService.searchHBaseComRelationshipInputBatchDetail(cpId, null, null, null, null, null, 1, 1);
						if(queryResult!=null&&queryResult.getResultList()!=null&&queryResult.getResultList().size()>0){
							Map newest = (Map) queryResult.getResultList().get(0);
							if(newest!=null&&newest.get("input_date")!=null){
								map.put("inputDate", newest.get("input_date").toString());
							}
						}
					}
					Map cleanOilMap = comRelationshipService.queryComRelationshipCleanOilRecycle(cpId, startDate, endDate);
					if (cleanOilMap != null) {
						map.putAll(cleanOilMap);
					}
				}
			}
			if (null != resutList) {
				resultMap.put("resultList", resutList);
				resultMap.put("currPageNo", queryMap.getCurrPageNo());
				resultMap.put("pageCount", queryMap.getPageCount());
				resultMap.put("pageSize", queryMap.getPageSize());
				resultMap.put("totalCount", queryMap.getTotalCount());
				resultMap.put("totalRecord", queryMap.getTotalRecord());
			}
			if (inputType == -1) {
				QueryResult<Map> queryMapcount = comRelationshipService.queryComRelationshipInputBatchDetail(companyId, 1, companyToType, companyName, startDate, endDate, pageNo, pageSize);
				if (null != queryMapcount) {
					input = queryMapcount.getTotalRecord();
					notInput = count - input;
				}
			} else if (inputType == 1) {
				input = queryMap.getTotalRecord();
				notInput = count - input;
			} else {
				notInput = queryMap.getTotalRecord();
				input = count - notInput;
			}
		}
		mapCount.put("notInput", notInput);
		mapCount.put("input", input);
		resultMap.put("mapCount", mapCount);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, resultMap);
	}

	/**
	 * 总店删除分店 2016.04.22 by linzhengkang
	 * @param comRelationshipId
	 * @return
	 */
	@RequestMapping(value = "/deleteComRelationship/{comRelationshipId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult deleteComRelationship(@PathVariable int comRelationshipId){
		comRelationshipService.deleteComRelationship(comRelationshipId);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, comRelationshipId);
	}
	
	/**
	 * 总店修改分店 2016.04.22 by linzhengkang
	 * @param dto
	 * @return
	 */
	@RequestMapping(value = "/updateComRelationship", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateComRelationship(@Valid @RequestBody DTOComRelationshipUpdate dto){
		ComRelationship entity = DTOComRelationshipUpdate.toEntity(dto, comRelationshipService);
		if (entity == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		comRelationshipService.updateComRelationship(entity);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, entity);
	}
	
	/**
	 * 通过单位证照编号,获取单位信息 2016.04.25 by linzhengkang
	 * @return
	 */
    @RequestMapping(value = "/getCompanyByCert", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult getCompanyByCert(@RequestBody Map<String, Object> paramMap) {
    	String certType = getStringParam(paramMap, "certType");
    	String certNo = getStringParam(paramMap, "certNo");
    	List<Map> companies= restaurantService.findCompanyByCert(certType, certNo);
    	if(companies!=null && companies.size()>0){
    		DTOComRelationshipForSearch dto=DTOComRelationshipForSearch.createByMap(companies.get(0), geoAdminRegionService);
    		ComRelationship comRelationship = comRelationshipService.findComRelationshipByCompanyFromAndCompanyTo(getLoginCompanyId(), dto.getCompanyId(), FoodConstant.COMPANY_RELATIONSHIP_ACCEPTED_STATUS_CONFIRMED);
    		if(comRelationship!=null){
    			dto.setStatus(comRelationship.getCompanyToType());
    			return CommonStatusResult.success(FoodConstant.COMPANY_RELATIONSHIP_REG_IN_SYSTEM_NOT_BRANCH_OR_TRUNK, dto);//已经申请待确认添加的门店
    		}
    		if(comRelationshipService.isCompanyTrunkOrBranch(dto.getCompanyId())){
    			return CommonStatusResult.success(FoodConstant.COMPANY_RELATIONSHIP_IS_BRANCH_OR_TRUNK, dto);//已经是总店或分店的注册企业
    		}else{
    			return CommonStatusResult.success(FoodConstant.COMPANY_RELATIONSHIP_REG_IN_SYSTEM_NOT_BRANCH_OR_TRUNK, dto);//非总店分店注册企业
    		}
    	}
    	CompanyImport companyImport = companyImportService.getCompanyImportByCert(certType, certNo);
    	if(companyImport!=null){
    		DTOCompanyImportInfo dto = DTOCompanyImportInfo.toDTO(companyImport);
    		return CommonStatusResult.success(FoodConstant.COMPANY_RELATIONSHIP_NOT_REG_IN_SYSTEM_BUT_IN_OFFICIAL, dto);////未在系统但在证件库内注册企业
    	}
    	return CommonStatusResult.success(FoodConstant.COMPANY_RELATIONSHIP_NOT_REG_IN_SYSTEM_AND_OFFICIAL, null);//未在系统以及证件库内注册企业
    }
    
    /**
     * 注册并添加门店 2016.04.27 by linzhengkang
     * @param paramMap
     * @return
     */
    @RequestMapping(value = "/registerBranchStore", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult registerBranchStore(@RequestBody Map<String, Object> paramMap) {
    	String companyWithLoginAdmin = getStringParam(paramMap, "companyWithLoginAdmin");
    	DTOCompanyInfoWithUserInfoCreate dto = getDTOFromString(companyWithLoginAdmin, DTOCompanyInfoWithUserInfoCreate.class);
    	if (null==dto||null==dto.getCompanyName()) {
    		throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
       	}
    	Restaurant restaurant = comRelationshipService.regCompany( DTOCompanyInfoWithUserInfoCreate.toEntityRestaurant(dto, geoAdminRegionService), DTOCompanyInfoWithUserInfoCreate.toEntityComEmployee(dto), DTOCompanyInfoWithUserInfoCreate.toEntityAppLoginUser(dto,restaurantEmployeeLoginService));
    	int companyToType = getIntParam(paramMap, "companyToType");
    	ComRelationship comRelationship = new ComRelationship();
    	comRelationship.setCompanyIdFrom(getLoginCompanyId());
    	comRelationship.setCompanyIdTo(restaurant.getCompanyId());
    	comRelationship.setCompanyRelationType(FoodConstant.COMPANY_RELATIONSHIP_TRUNK_TO_BRANCH);
    	comRelationship.setCompanyToType(companyToType);
    	comRelationship.setIsAccepted(FoodConstant.COMPANY_RELATIONSHIP_ACCEPTED_STATUS_ACCEPTED);
    	comRelationship.setDelFlag(FoodConstant.DELETE_FLAG_CREATE);
    	comRelationship.setCreateDate(new Date());
    	comRelationship.setLastModifiedDate(new Date());
    	ComRelationship result=comRelationshipService.createComRelationship(comRelationship);
    	createSupplierAndReceiverByComRelationship(comRelationship,getLoginCompany().getCompanyName(),dto.getCompanyName());//新增供应关系
    	return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result);
    }
    
    /**
     * 添加已注册门店 2016.04.27 by linzhengkang
     * @param paramMap
     * @return
     */
    @RequestMapping(value = "/createBranchStore", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult createBranchStore(@RequestBody Map<String, Object> paramMap){
    	int companyToId = getIntParam(paramMap, "companyToId");
    	int companyToType = getIntParam(paramMap, "companyToType");
    	ComRelationship comRelationship = new ComRelationship();
    	comRelationship.setCompanyIdFrom(getLoginCompanyId());
    	comRelationship.setCompanyIdTo(companyToId);
    	comRelationship.setCompanyRelationType(FoodConstant.COMPANY_RELATIONSHIP_TRUNK_TO_BRANCH);
    	comRelationship.setCompanyToType(companyToType);
    	comRelationship.setIsAccepted(FoodConstant.COMPANY_RELATIONSHIP_ACCEPTED_STATUS_CONFIRMED);
    	comRelationship.setDelFlag(FoodConstant.DELETE_FLAG_CREATE);
    	comRelationship.setCreateDate(new Date());
    	comRelationship.setLastModifiedDate(new Date());
    	ComRelationship result=comRelationshipService.createComRelationship(comRelationship);
    	return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result);
    }
    
    /**
     * 查询可添加门店列表2016.04.27 by linzhengkang
     * @param paramMap
     * @return
     */
    @RequestMapping(value = "/queryCompanyListForCreateBranch/{pageNo}/{pageSize}", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult queryCompanyListForCreateBranch(@RequestBody Map<String, Object> paramMap,@PathVariable int pageNo, @PathVariable int pageSize){
    	String keyword = getStringParam(paramMap, "keyword");
    	QueryResult<Map> result= restaurantService.getCompanyListForBranch(keyword, getLoginCompanyId(),pageNo,pageSize);
    	return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result);
    }
    
    /**
     * 查询门店确认总店列表2016.04.27 by linzhengkang
     * @return
     */
    @RequestMapping(value = "/queryCompanyListForAttachTrunk", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult queryCompanyListForAttachTrunk(){
    	List<Map> companyList=restaurantService.getCompanyListForTrunk(getLoginCompanyId());
    	return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, companyList);
    }
    
    /**
     * 与一家总店建立关系2016.04.27 by linzhengkang
     * @param companyIdFrom
     * @return
     */
    @RequestMapping(value = "/createLinkToTrunk/{companyIdFrom}", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult createLinkToTrunk(@PathVariable int companyIdFrom){
    	if(companyIdFrom <1){
    		throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
    	}
    	ComRelationship comRelationship = comRelationshipService.findComRelationshipByCompanyFromAndCompanyTo(companyIdFrom, getLoginCompanyId(),FoodConstant.COMPANY_RELATIONSHIP_ACCEPTED_STATUS_CONFIRMED);
    	comRelationship.setIsAccepted(FoodConstant.COMPANY_RELATIONSHIP_ACCEPTED_STATUS_ACCEPTED);
    	comRelationshipService.updateComRelationship(comRelationship);
    	Restaurant trunk = restaurantService.getRestaurantById(comRelationship.getCompanyIdFrom());
    	createSupplierAndReceiverByComRelationship(comRelationship,getLoginCompany().getCompanyName(),trunk.getCompanyName());
    	return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, comRelationship);
    }
    
    /**
     * 与一家总店取消关系2016.04.27 by linzhengkang
     * @param companyIdFrom
     * @return
     */
    @RequestMapping(value = "/removeLinkToTrunk/{companyIdFrom}", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult removeLinkToTrunk(@PathVariable int companyIdFrom){
    	if(companyIdFrom <1){
    		throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
    	}
    	ComRelationship comRelationship = comRelationshipService.findComRelationshipByCompanyFromAndCompanyTo(companyIdFrom, getLoginCompanyId(),FoodConstant.COMPANY_RELATIONSHIP_ACCEPTED_STATUS_ACCEPTED);
    	comRelationship.setIsAccepted(FoodConstant.COMPANY_RELATIONSHIP_ACCEPTED_STATUS_REFUSED);
    	comRelationshipService.updateComRelationship(comRelationship);
    	return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, comRelationship);
    }
    
    public void createSupplierAndReceiverByComRelationship(ComRelationship comRelationship,String supplierName,String receiverName){
		if(comRelationship == null || comRelationship.getCompanyIdFrom() < 1 || comRelationship.getCompanyIdTo()<1){
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		IntCompany hasSupplier = intCompanyService.getInternalCompany(comRelationship.getCompanyIdTo(), IntCompany.COMPANY_TYPE_SUPPLIER, supplierName, true, null, null);
		if(hasSupplier==null){
			//新建供应商
			IntCompany supplier = new IntCompany();
			Restaurant sup = restaurantService.getRestaurantById(comRelationship.getCompanyIdFrom());
			supplier.setCompanyId(comRelationship.getCompanyIdTo());
			supplier.setLinkedCompanyId(comRelationship.getCompanyIdFrom());
			supplier.setType(IntCompany.COMPANY_TYPE_SUPPLIER);
			supplier.setStatus(FoodConstant.FIELD_STATUS_VALID);
			supplier.setName(sup.getCompanyName());
			supplier.setNameAbbrev(sup.getNameAbbrev());
			supplier.setBizCertNum(sup.getBizCertNumber());
			supplier.setBizCertExpDate(sup.getBizCertExpDate());
			supplier.setCateringCert(sup.getCateringCert());
			supplier.setCateringCertExpDate(sup.getCateringCertExpDate());
			supplier.setFoodCircuCert(sup.getFoodCircuCert());
			supplier.setFoodCircuCertExpDate(sup.getFoodCircuCertExpDate());
			supplier.setFoodProdCert(sup.getFoodProdCert());
			supplier.setFoodProdCertExpDate(sup.getFoodProdCertExpDate());
			supplier.setFoodBusinessCert(sup.getFoodBusinessCert());
			supplier.setFoodBusinessCertExpDate(sup.getFoodBusinessCertExpDate());
			supplier.setContactAddress(sup.getCompanyAddress());
			supplier.setContactPerson(sup.getContactPerson());
			supplier.setContactPhone(sup.getContactPhone());
			intCompanyService.createInternalCompany(supplier);
		}else{
			//供应商重名情况，如果没有关联注册企业，添加关联关系
			if(hasSupplier.getLinkedCompanyId()==null){
				hasSupplier.setLinkedCompanyId(comRelationship.getCompanyIdFrom());
				intCompanyService.updateInternalCompany(hasSupplier);
			}
		}
		IntCompany hasReceiver = intCompanyService.getInternalCompany(comRelationship.getCompanyIdFrom(), IntCompany.COMPANY_TYPE_RECEIVER, receiverName, true, null, null);
		if(hasReceiver==null){
			//新建收货商
			IntCompany receiver = new IntCompany();
			Restaurant rec = restaurantService.getRestaurantById(comRelationship.getCompanyIdTo());
			receiver.setCompanyId(comRelationship.getCompanyIdFrom());
			receiver.setLinkedCompanyId(comRelationship.getCompanyIdTo());
			receiver.setType(IntCompany.COMPANY_TYPE_RECEIVER);
			receiver.setStatus(FoodConstant.FIELD_STATUS_VALID);
			receiver.setName(rec.getCompanyName());
			receiver.setNameAbbrev(rec.getNameAbbrev());
			receiver.setBizCertNum(rec.getBizCertNumber());
			receiver.setBizCertExpDate(rec.getBizCertExpDate());
			receiver.setCateringCert(rec.getCateringCert());
			receiver.setCateringCertExpDate(rec.getCateringCertExpDate());
			receiver.setFoodCircuCert(rec.getFoodCircuCert());
			receiver.setFoodCircuCertExpDate(rec.getFoodCircuCertExpDate());
			receiver.setFoodProdCert(rec.getFoodProdCert());
			receiver.setFoodProdCertExpDate(rec.getFoodProdCertExpDate());
			receiver.setFoodBusinessCert(rec.getFoodBusinessCert());
			receiver.setFoodBusinessCertExpDate(rec.getFoodBusinessCertExpDate());
			receiver.setContactAddress(rec.getCompanyAddress());
			receiver.setContactPerson(rec.getContactPerson());
			receiver.setContactPhone(rec.getContactPhone());
			intCompanyService.createInternalCompany(receiver);
		}else{
			if(hasReceiver.getLinkedCompanyId()==null){
				hasReceiver.setLinkedCompanyId(comRelationship.getCompanyIdTo());
				intCompanyService.updateInternalCompany(hasReceiver);
			}
		}
	}
}
