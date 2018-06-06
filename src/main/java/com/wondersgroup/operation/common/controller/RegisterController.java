package com.wondersgroup.operation.common.controller;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.data.jpa.entity.CompanyImport;
import com.wondersgroup.framework.common.GeoAdminRegionService;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.operation.common.model.DTOCompanyImportInfo;
import com.wondersgroup.operation.common.model.DTOCompanyInfoWithUserInfoCreate;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.service.company.CompanyBaseService;
import com.wondersgroup.service.company.CompanyImportService;
import com.wondersgroup.service.company.CompanyService;
import com.wondersgroup.service.company.RestaurantService;
import com.wondersgroup.service.empuser.RestaurantEmployeeLoginService;

@Controller
@RequestMapping("/register")
public class RegisterController extends AbstractBaseController {

	private static final Logger logger = LoggerFactory.getLogger(RegisterController.class);
	
    @Autowired
	private CompanyImportService companyImportService;
    
    @Autowired
    private CompanyService companyService;
    
    @Autowired
    private GeoAdminRegionService geoAdminRegionService;
    @Autowired
    private RestaurantEmployeeLoginService restaurantEmployeeLoginService;
    @Autowired
    private RestaurantService restaurantService;
    @Autowired
    private CompanyBaseService companyBaseService;
    
    /**
	 * 通过单位名称，模糊匹配10条单位信息
	 * @return
	 */
    @RequestMapping(value = "/getCompanyListByName", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult getCompanyListByCompanyName(@RequestBody Map<String, Object> paramMap) {
    	String companyName = getStringParam(paramMap, "companyName");
    	
    	List<CompanyImport> list = companyImportService.getCompanyImportByCompanyName(companyName);
    	return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, DTOCompanyImportInfo.createListByEntities(list));
    }
    
    /**
	 * 通过单位ID,获取单位信息
	 * @return
	 */
    @RequestMapping(value = "/getCompanyById", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult getCompanyById(@RequestBody Map<String, Object> paramMap) {
    	String companyId = getStringParam(paramMap, "companyId");
    	
    	CompanyImport companyImport = companyImportService.getCompanyImportById(Integer.parseInt(companyId));
    	return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, DTOCompanyImportInfo.toDTO(companyImport));
    }
    
    /**
	 * 通过单位证照编号,获取单位信息
	 * @return
	 */
    @RequestMapping(value = "/getCompanyByCert", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult getCompanyByCert(@RequestBody Map<String, Object> paramMap) {
    	String certType = getStringParam(paramMap, "certType");
    	String certNo = getStringParam(paramMap, "certNo");
    	Map resultMap = companyBaseService.getCompanyBaseByCert(certType, certNo);
    	return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, DTOCompanyImportInfo.createByMap(resultMap));
    	//CompanyImport companyImport = companyImportService.getCompanyImportByCert(certType, certNo);
    	//return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, DTOCompanyImportInfo.toDTO(companyImport));
    }
    
    /**
	 * 注册用户
	 * @return
	 */
    @RequestMapping(value = "/createCompanyWithLoginAdmin", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult createCompanyWithLoginAdmin(@RequestBody Map<String, Object> paramMap) {
    	String companyWithLoginAdmin = getStringParam(paramMap, "companyWithLoginAdmin");
    	DTOCompanyInfoWithUserInfoCreate dto = getDTOFromString(companyWithLoginAdmin, DTOCompanyInfoWithUserInfoCreate.class);
       if (null==dto||null==dto.getCompanyName()) {
   		throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
	  }
    	
    	AppLoginUser appLoginUser = companyService.loginCompany( DTOCompanyInfoWithUserInfoCreate.toEntityRestaurant(dto, geoAdminRegionService), DTOCompanyInfoWithUserInfoCreate.toEntityComEmployee(dto), DTOCompanyInfoWithUserInfoCreate.toEntityAppLoginUser(dto,restaurantEmployeeLoginService));
  
    	System.out.println(appLoginUser.getPassword());
    	return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, appLoginUser);
    }
    /**
     * 注册验证判断用户名是否唯一
     * @param userName 用户名
     * @return
     */
    @RequestMapping(value = "/checkUserExists", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult checkUserExists(@RequestParam String userName){
    	boolean exists=restaurantEmployeeLoginService.isLoginNameExist(userName, null, ComEmployee.TYPE_EMP);
    	return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, exists);
    }
    /**
     * 注册验证判断公司名称是否唯一
     * @param companyName 公司名
     * @return
     */
    @RequestMapping(value = "/checkCompanyExists", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult checkCompanyExists(@RequestParam String companyName){
    	boolean exists=companyService.checkCompanyExists(companyName);
    	return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, exists);
    }
    
    /**
     * 3.18 增加注册证件号码唯一性验证
     * @param paramMap
     * @return
     */
    @RequestMapping(value = "/isCertExist", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult isCertExist(@RequestBody Map<String, Object> paramMap) {
    	String certType=getStringParam(paramMap, "certType");
    	String certNo=getStringParam(paramMap, "certNo");
    	if(!StringUtils.isEmpty(certType)&&!StringUtils.isEmpty(certNo)){
    		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, restaurantService.isCertExist(certType, certNo,null));
    	}else{
    		return CommonStatusResult.fail(ErrorMessageConstant.CODE_FAIL, null);
    	}
    }
}
