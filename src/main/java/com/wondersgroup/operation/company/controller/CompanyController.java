package com.wondersgroup.operation.company.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.wondersgroup.data.jpa.entity.Attachment;
import com.wondersgroup.data.jpa.entity.ComRelationship;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.data.jpa.entity.EmpUserOperationHistory;
import com.wondersgroup.data.jpa.entity.Restaurant;
import com.wondersgroup.framework.cache.RedisService;
import com.wondersgroup.framework.common.GeoAdminRegionService;
import com.wondersgroup.framework.dao.JdbcAbstractDao;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.company.model.DTOCompanyInfo;
import com.wondersgroup.operation.company.model.DTOCompanyInfoUpdate;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.operation.util.file.UploadUtils;
import com.wondersgroup.service.company.ComRelationshipService;
import com.wondersgroup.service.company.CompanyService;
import com.wondersgroup.service.company.EmpUserOperationService;
import com.wondersgroup.service.company.RestaurantService;

@Controller
@RequestMapping("/company")
public class CompanyController extends AbstractBaseController {

	private static final Logger logger = LoggerFactory.getLogger(CompanyController.class);
    @Autowired
    private RestaurantService restaurantService;
    @Autowired
    private GeoAdminRegionService geoAdminRegionService;
	@Autowired
	private UploadUtils uploadUtils;
	@Autowired
	private RedisService redisService;
	@Autowired
	private ComRelationshipService comRelationshipService;
	@Autowired
	private EmpUserOperationService empUserOperationService;
	private String LOCATION = JdbcAbstractDao.getLocation();
    
	
    public static final String UPLOAD_TYPE_COM_GSYYZZ = "COM_GSYYZZ"; //注册企业 -- 工商营业执照
    public static final String UPLOAD_TYPE_COM_ZZJGDM = "COM_ZZJGDM"; //注册企业 -- 组织机构代码
    public static final String UPLOAD_TYPE_COM_SWDJZ = "COM_SWDJZ"; //注册企业 -- 税务登记证
    public static final String UPLOAD_TYPE_COM_FRSFZ = "COM_FRSFZ"; //注册企业 -- 法人身份证
    public static final String UPLOAD_TYPE_COM_GAJMLWNDTXZ = "COM_GAJMLWNDTXZ"; //注册企业 -- 港澳居民来往内地通行证
    public static final String UPLOAD_TYPE_COM_TWJMLWNDTXZ = "COM_TWJMLWNDTXZ"; //注册企业 -- 台湾居民来往内地通行证
    public static final String UPLOAD_TYPE_COM_SPLTXKZ = "COM_SPLTXKZ"; //注册企业 -- 食品流通许可证
    public static final String UPLOAD_TYPE_COM_SPSCXKZ = "COM_SPSCXKZ"; //注册企业 -- 食品生产许可证
    public static final String UPLOAD_TYPE_COM_CYFWXKZ = "COM_CYFWXKZ"; //注册企业 -- 餐饮服务许可证
    public static final String UPLOAD_TYPE_COM_SPJYXKZ = "COM_SPJYXKZ"; //注册企业 -- 食品经营许可证
    public static final String UPLOAD_TYPE_COM_OTHER = "COM_OTHER"; //供应商 -- 其他证照
	
    public static final Map<String, String> uploadTypeToAttachTypeMap = new HashMap<String, String>() {
		private static final long serialVersionUID = 1948879947792327281L;
		{
			put(UPLOAD_TYPE_COM_GSYYZZ, FoodConstant.ATT_COM_GSYYZZ);
			put(UPLOAD_TYPE_COM_ZZJGDM, FoodConstant.ATT_COM_ZZJGDM);
			put(UPLOAD_TYPE_COM_SWDJZ, FoodConstant.ATT_COM_SWDJZ);
			put(UPLOAD_TYPE_COM_FRSFZ, FoodConstant.ATT_COM_FRSFZ);
			put(UPLOAD_TYPE_COM_GAJMLWNDTXZ, FoodConstant.ATT_COM_GAJMLWNDTXZ);
			put(UPLOAD_TYPE_COM_TWJMLWNDTXZ, FoodConstant.ATT_COM_TWJMLWNDTXZ);
			put(UPLOAD_TYPE_COM_SPLTXKZ, FoodConstant.ATT_COM_SPLTXKZ);
			put(UPLOAD_TYPE_COM_SPSCXKZ, FoodConstant.ATT_COM_SPSCXKZ);
			put(UPLOAD_TYPE_COM_CYFWXKZ, FoodConstant.ATT_COM_CYFWXKZ);
			put(UPLOAD_TYPE_COM_SPJYXKZ, FoodConstant.ATT_COM_SPJYXKZ);
			put(UPLOAD_TYPE_COM_OTHER, FoodConstant.ATT_COM_OTHER);
	}};
	
	private static final List<String> singleImageTypes = new ArrayList<String>() {
		private static final long serialVersionUID = 6694506005823947192L;
		{
			add(UPLOAD_TYPE_COM_GSYYZZ);
			add(UPLOAD_TYPE_COM_ZZJGDM);
			add(UPLOAD_TYPE_COM_SWDJZ);
			add(UPLOAD_TYPE_COM_FRSFZ);
			add(UPLOAD_TYPE_COM_GAJMLWNDTXZ);
			add(UPLOAD_TYPE_COM_TWJMLWNDTXZ);
			add(UPLOAD_TYPE_COM_SPLTXKZ);
			add(UPLOAD_TYPE_COM_SPSCXKZ);
			add(UPLOAD_TYPE_COM_CYFWXKZ);
			add(UPLOAD_TYPE_COM_SPJYXKZ);
			add(UPLOAD_TYPE_COM_OTHER);
		}
	};
	
    /**
	 * 读取单位基本信息
	 * @return
	 */
    @RequestMapping(value = "/getOnline", method = RequestMethod.GET)
    @ResponseBody
    public CommonStatusResult getOnline() {
    	return CommonStatusResult.success("success", redisService.keys(LOCATION+"online-*").size());
    }
	
    /**
	 * 读取单位基本信息
	 * @return
	 */
    @RequestMapping(value = "/getCompanyInfo", method = RequestMethod.GET)
    @ResponseBody
    public CommonStatusResult getCompanyInfo() {
    	int companyId = getLoginCompanyId();
    	Restaurant rest = restaurantService.getRestaurantById(companyId);
    	return CommonStatusResult.success("success", DTOCompanyInfo.toDTO(rest));
    }
    
    /**
     * 读取单位基本信息--用于总店查询门店信息 2016.04.22 by linzhengkang
     * @param companyId
     * @return
     */
    @RequestMapping(value = "/getCompanyInfo/{companyId}", method = RequestMethod.GET)
    @ResponseBody
    public CommonStatusResult getCompanyInfo(@PathVariable int companyId) {
    	if(companyId <=0){
    		throw FoodException.returnException("参数异常");
    	}
    	Restaurant rest = restaurantService.getRestaurantById(companyId);
    	return CommonStatusResult.success("success", DTOCompanyInfo.toDTO(rest));
    }
    
    /**
     * 读取总店信息信息--用于总店查询门店信息 2016.05.5 by linzhengkang
     * @param companyId
     * @return
     */
    @RequestMapping(value = "/getHeadquartersInfo", method = RequestMethod.GET)
    @ResponseBody
    public CommonStatusResult getHeadquartersInfo(){
    	ComRelationship comRelationship=comRelationshipService.findComRelationshipByCompanyFromAndCompanyTo(null, getLoginCompanyId(), FoodConstant.COMPANY_RELATIONSHIP_ACCEPTED_STATUS_ACCEPTED);
    	Restaurant rest = null;
    	if(comRelationship!=null&&comRelationship.getCompanyIdFrom()>0){
    		rest = restaurantService.getRestaurantById(comRelationship.getCompanyIdFrom());
    	}
    	return CommonStatusResult.success("success", DTOCompanyInfo.toDTO(rest));
    }
    
    /**
	 * 编辑单位基本信息
	 * @return
	 */
    @RequestMapping(value = "/updateCompanyInfo", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult updateCompanyInfo(@RequestBody Map<String, Object> paramMap) {
    	String companyInfo = getStringParam(paramMap, "companyInfo");
    	
    	DTOCompanyInfoUpdate dto = getDTOFromString(companyInfo, DTOCompanyInfoUpdate.class);
		String cateringCert = dto.getCateringCert();
		String foodCircuCert = dto.getFoodCircuCert();
		String foodProdCert = dto.getFoodProdCert();
		String foodBusinessCert = dto.getFoodBusinessCert();
		Map certMap = new HashMap<>();
		if (!StringUtils.isEmpty(cateringCert)) {
			boolean cateringCertOne = restaurantService.isCertExist("cateringCert", cateringCert,dto.getCompanyId());
			if (cateringCertOne == true) {
				certMap.put("cateringCert", true);
			}
		}
		if (!StringUtils.isEmpty(foodCircuCert)) {
			boolean foodCircuCertOne = restaurantService.isCertExist( "foodCircuCert", foodCircuCert,dto.getCompanyId());
			if (foodCircuCertOne == true) {
				certMap.put("foodCircuCert", true);
			}
		}
		if (!StringUtils.isEmpty(foodProdCert)) {
			boolean foodProdCertOne = restaurantService.isCertExist( "foodProdCert", foodProdCert,dto.getCompanyId());
			if (foodProdCertOne == true) {
				certMap.put("foodProdCert", true);
			}
		}
		if (!StringUtils.isEmpty(foodBusinessCert)) {
			boolean foodBusinessCertOne = restaurantService.isCertExist( "foodBusinessCert", foodBusinessCert,dto.getCompanyId());
			if (foodBusinessCertOne == true) {
				certMap.put("foodBusinessCert", true);
			}
		}

		if (certMap != null && certMap.size() > 0) {
			return CommonStatusResult.fail("证件号码已存在", certMap);
		}
    	Restaurant rest = DTOCompanyInfoUpdate.toEntity(dto, geoAdminRegionService);
    	
    	if(rest == null) {
    		throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
    	}
    	restaurantService.updateRestaurant(rest);

    	return CommonStatusResult.success("success", rest);
    }
	
    
    
    /**
     *  上传注册企业照片
     * @param request
     * @return
     */
    @RequestMapping(value = "/updateCompanyImage", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult updateSupplierImage(HttpServletRequest request) {
    	int companyId = getLoginCompanyId();
    
        //添加新图片
        LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
        try {

        	Map<String, List<MultipartFile>> fileMap = getMultipartFileMapFromRequest(request);
        	
        	uploadUtils.uploadFiles(companyId,uploadTypeToAttachTypeMap,fileMap,singleImageTypes,resultMap,companyId);
        	

        } catch (Exception e) {
            throw FoodException.returnException("上传文件失败！");
        }
        return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, resultMap);
    }
    
    
    @RequestMapping(value = "/queryCompanyImage", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult queryCompanyImage(@RequestBody String[] imageTypes) {
     	int companyId = getLoginCompanyId();
        LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
        
        for (String imageType : imageTypes) {
        	String attachType = uploadTypeToAttachTypeMap.get(imageType);
        	if(StringUtils.isNotBlank(attachType)){
        		List<Attachment> resultList = uploadUtils.queryAttFile(attachType, companyId, null, null);
        		resultMap.put(imageType, resultList);
        	}
		}
        
        return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, resultMap);
    }
	
    @RequestMapping(value = "/queryLinkCompanyImage/{linkCompanyId}", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult queryLinkCompanyImage(@RequestBody String[] imageTypes,@PathVariable int linkCompanyId) {
    	if(linkCompanyId <=0){
    		throw FoodException.returnException("参数异常");
    	}
        LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
        for (String imageType : imageTypes) {
        	String attachType = uploadTypeToAttachTypeMap.get(imageType);
        	if(StringUtils.isNotBlank(attachType)){
        		List<Attachment> resultList = uploadUtils.queryAttFile(attachType, linkCompanyId, null, null);
        		resultMap.put(imageType, resultList);
        	}
		}
        
        return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, resultMap);
    }
    
    /**
     * 3.18 增加证件号码唯一性验证
     * @param paramMap
     * @return
     */
    @RequestMapping(value = "/isCertExist", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult isCertExist(@RequestBody Map<String, Object> paramMap) {
    	int companyId = getLoginCompanyId();
    	String certType=getStringParam(paramMap, "certType");
    	String certNo=getStringParam(paramMap, "certNo");
    	if(!StringUtils.isEmpty(certType)&&!StringUtils.isEmpty(certNo)){
    		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, restaurantService.isCertExist(certType, certNo, companyId));
    	}else{
    		return CommonStatusResult.fail(ErrorMessageConstant.CODE_FAIL, null);
    	}
    }
    /**
     * 页面加载查询门店状态,1为总店，2为分店，0为普通企业
     * @return
     */
    @RequestMapping(value = "/getComRelations", method = RequestMethod.GET)
    @ResponseBody
    public CommonStatusResult getComRelations() {
    	int companyId = getLoginCompanyId();
    	int hasBranch = comRelationshipService.hasComRelationship(companyId);
    	if(hasBranch>0){
    		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, 1);
    	}
		int hasTrunk = comRelationshipService.hasHeadquarters(companyId);
		if(hasTrunk>0){
			return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, 2);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, 0);
    }
    /**
     * 设置营业状态
     * 
     * 
     * @return
     */
    @RequestMapping(value = "/setBusinessStatus", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult setBusinessStatus(@RequestParam(value="targetStatus", required = false) String targetStatus){
    	int companyId = getLoginCompanyId();
    	Restaurant restaurant = restaurantService.getRestaurantById(companyId);
    	if(StringUtils.isBlank(targetStatus)){
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
    	if(targetStatus.equals("NORMAL")){
    		restaurant.setAccountStatus(1);
    	}
    	if(targetStatus.equals("TEMP_CLOSED")){
    		restaurant.setAccountStatus(3);
    	}
    	if(targetStatus.equals("PERM_CLOSED")){
    		restaurant.setAccountStatus(2);
    	}
    	restaurantService.updateRestaurant(restaurant);
    	EmpUserOperationHistory empUserOperationHistory = new EmpUserOperationHistory();
    	empUserOperationHistory.setCompanyId(companyId);
    	empUserOperationHistory.setLoginUserId(getLoginUserId());
    	empUserOperationHistory.setActionType(EmpUserOperationHistory.ACTION_TYPE_MODIFY_BUSINESS_STATUS);
    	empUserOperationHistory.setTargetStatus(targetStatus);
    	empUserOperationHistory.setCreateDate(new Date());
    	empUserOperationService.createEmpUserOperationHistory(empUserOperationHistory);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
    }
    /**
     * 查询营业状态
     * @return
     */
    @RequestMapping(value = "/getBusinessStatus", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult getBusinessStatus(){
    	int companyId = getLoginCompanyId();
    	int loginUserId = getLoginUserId();
    	String sortBy = "CREATE_DATE";
    	String sortDirection = "DESC";
    	EmpUserOperationHistory queryResult = empUserOperationService.getBusinessStatusById(companyId, loginUserId,sortBy, sortDirection);
 		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
    	
    }
  
}
