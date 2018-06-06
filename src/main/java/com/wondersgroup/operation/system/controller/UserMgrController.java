package com.wondersgroup.operation.system.controller;

import java.util.ArrayList;
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

import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.AppRole;
import com.wondersgroup.data.jpa.entity.AppUserRole;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.employee.model.DTOComEmployeeListData;
import com.wondersgroup.operation.system.model.DTOLoginUserCreate;
import com.wondersgroup.operation.system.model.DTOLoginUserInfo;
import com.wondersgroup.operation.system.model.DTOLoginUserQueryData;
import com.wondersgroup.operation.system.model.DTOLoginUserUpdate;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.operation.util.annotation.HasPermission;
import com.wondersgroup.service.company.CompanyService;
import com.wondersgroup.service.empuser.RestaurantEmployeeLoginService;
import com.wondersgroup.service.empuser.RestaurantEmployeeService;
import com.wondersgroup.util.CollectionUtils;
import com.wondersgroup.util.StringUtils;

@Controller
@RequestMapping("/system/userMgr")
public class UserMgrController extends AbstractBaseController {

	private static Logger logger = LoggerFactory.getLogger(UserMgrController.class);

	// service
	@Autowired
	private RestaurantEmployeeLoginService empLoginService;
	@Autowired
	private CompanyService cs;
	@Autowired
	private RestaurantEmployeeLoginService restaurantEmployeeLoginService;
	@Autowired
	private RestaurantEmployeeService restaurantEmployeeService;   
	   
	
	/**
	 * 保存登录用户信息
	 */
	@RequestMapping(value = "/createLoginUser",method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult createLoginUser(@RequestBody DTOLoginUserCreate dto) {
		Integer loginCompanyId = getLoginCompanyId();
		Company company = cs.getCompanyById(loginCompanyId);
		//(1)添加用户信息
		AppLoginUser loginUser = DTOLoginUserCreate.toEntity(dto,company,restaurantEmployeeService);
		if (loginUser == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		 List<AppUserRole> comSecRoleUserList = new ArrayList<>();
	        AppRole role = restaurantEmployeeLoginService.getAppRoleById(FoodConstant.EMP_ADMIN);
         if (role != null) {
             AppUserRole roleUser = new AppUserRole();
             roleUser.setRole(role);
             roleUser.setUser(loginUser);
             comSecRoleUserList.add(roleUser);
             loginUser.setAppUserRoleList(comSecRoleUserList);
         }
		loginUser = empLoginService.createAppLoginUser(loginUser);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, loginUser);
	}


	/**
	 * 更新登录用户信息
	 */
	@RequestMapping( value = "/updateLoginUser",method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateLoginUser(@RequestBody DTOLoginUserUpdate dto) throws Exception {
		AppLoginUser entity = DTOLoginUserUpdate.toEntity(dto, empLoginService,restaurantEmployeeService);
		if(entity==null){
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		empLoginService.updateAppLoginUser(entity);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}	
	
	/**
	 * 删除登录用户
	 * @param username
	 * @return
	 */
	
	@RequestMapping( value = "/deleteLoginUser/{id}",method = RequestMethod.POST)
	@ResponseBody
	@HasPermission("EMP_COM_EMPLOYEE_EDIT")
	public CommonStatusResult deleteLoginUser(@PathVariable int id) {
		Integer loginUserId=getLoginUserId();
		if(loginUserId==id){
			AppLoginUser sysUser = restaurantEmployeeLoginService.getAppLoginUserById(loginUserId);
			if (sysUser == null) {
				throw FoodException.returnException("000003");
			}
			throw FoodException.returnException("014004");
		}
		empLoginService.deleteAppLoginUserById(id);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}
	
	/**
	 *查看用户 
	 */
	@RequestMapping( value = "/getLoginUser/{id}",method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult getLoginUser(@PathVariable int id) {
		AppLoginUser loginUser = empLoginService.getAppLoginUserById(id);
		if(loginUser==null){
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		DTOLoginUserInfo dto = DTOLoginUserInfo.toDTO(loginUser);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, dto);
	}
	
	
	/**
	 * 查询用户
	 */
    @RequestMapping(value = "/queryLoginUser/{pageNo}/{pageSize}", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult queryLoginUser(@RequestBody Map paramMap,@PathVariable int pageNo, @PathVariable int pageSize) {
    	
    	String newSearch = getStringParam(paramMap, "newSearch");
		//如果是第一次查询将查询参数放入session中
		if(StringUtils.isNotEmpty(newSearch)){
			this.getRequest().getSession().setAttribute("paramMap", paramMap);
			this.getRequest().getSession().setAttribute("pageNo", pageNo);
		}else{
			paramMap = (Map)this.getRequest().getSession().getAttribute("paramMap");
			pageNo=(int)this.getRequest().getSession().getAttribute("pageNo");
		}
		
    	Integer companyId = getLoginCompanyId();
    	String personName = getStringParam(paramMap, "personName");
		QueryResult qrResult = empLoginService.queryAppLoginUsers(companyId, AppLoginUser.TYPE_EMP, null, null, null, pageNo, pageSize,personName );
    	 if(qrResult!=null && qrResult.getResultList()!=null){
    		 List<Object[]> resultList = qrResult.getResultList();
    		 List userList = CollectionUtils.extractSubList(resultList,0);
             List<DTOLoginUserQueryData> newResultList = DTOLoginUserQueryData.createListByEntities(userList);
             qrResult.setResultList(newResultList);
         }else{
        	 qrResult = new QueryResult<>();
         }
        return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, qrResult);
    }
    
    
    /**
	 * 判断用户名是否可用
	 */
    @RequestMapping(value = "/checkLoginUsernameAvailable/", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult checkLoginUsernameAvailable(@RequestBody String username) {
    	Integer companyId = getLoginCompanyId();
    	boolean exists = empLoginService.isLoginNameExist(username, null, AppLoginUser.TYPE_EMP);
        return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, !exists);
    }
    
    
    
    /**
	 * 查询某一餐饮企业下的未注册从业人员列表

	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/queryComEmployee/{pageNo}/{pageSize}")
	public CommonStatusResult queryComEmployee(
			@RequestBody Map<String, Object> paramMap,
			@PathVariable int pageNo, @PathVariable int pageSize)
			throws Exception {
    	int companyId = getLoginCompanyId();
		String name = (String)paramMap.get("name");
		QueryResult result = restaurantEmployeeService.searchAvailableComEmployee(companyId, name, ComEmployee.TYPE_EMP, pageNo, pageSize);
		if(result!=null && result.getResultList()!=null) {
			List<DTOComEmployeeListData> newList= DTOComEmployeeListData.createListByEntities(result.getResultList(), restaurantEmployeeService);
			result.setResultList(newList);
		}
		
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result);
	}
	
    
}