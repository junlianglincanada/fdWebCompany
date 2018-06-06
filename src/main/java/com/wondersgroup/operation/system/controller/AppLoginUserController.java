package com.wondersgroup.operation.system.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.DependsOn;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.AppPermission;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.framework.cache.RedisService;
import com.wondersgroup.framework.common.AlarmService;
import com.wondersgroup.framework.common.AttachmentService;
import com.wondersgroup.framework.dao.JdbcAbstractDao;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.ConfigPropertiesUtil;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.system.model.DTOAppLoginUserData;
import com.wondersgroup.operation.system.model.DTOAppLoginUserEditData;
import com.wondersgroup.operation.system.model.DTOAppLoginUserPasswordChangeData;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.operation.util.security.UserService;
import com.wondersgroup.service.device.DeviceService;
import com.wondersgroup.service.empuser.RestaurantEmployeeLoginService;
import com.wondersgroup.service.empuser.RestaurantEmployeeService;
import com.wondersgroup.util.EncodeUtils;
import com.wondersgroup.util.TimeOrDateUtils;

/**
 * 
 * @author wanglei
 */
@Controller
@RequestMapping("/security/systemUser")
public class AppLoginUserController extends AbstractBaseController {

	private static Logger LOGGER = LoggerFactory
			.getLogger(AppLoginUserController.class);
	
	private static final String KEY_STRING = JdbcAbstractDao.getLocation()+"FDWebCompany_Reset_Verification_Code_Mobile_";

	@Autowired
	private RestaurantEmployeeService comEmployeeService;
	@Autowired
	private RestaurantEmployeeLoginService restaurantEmployeeLoginService;

	@Autowired
	private DeviceService deviceService;
	@Autowired
	private AttachmentService attachmentService;

	@Autowired
	protected UserService userService;
	
	@Autowired
	private AlarmService alarmService;

	@Autowired
	private RedisService redisService;

	/**
	 * 获取当前登陆用户信息
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/getUser")
	@ResponseBody
	public CommonStatusResult login() {
		DTOAppLoginUserData userData = null;
		Integer loginUserId = getLoginUserId();
		int companyId = getLoginCompanyId();
		AppLoginUser sysUser = restaurantEmployeeLoginService.getAppLoginUserById(loginUserId);
		if (sysUser == null) {
			throw FoodException.returnException("000003");
		} else {
			userData = DTOAppLoginUserData.createByEntity(sysUser);
			userData.setCompanyId(companyId);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS,userData);

	}

	/**
	 * 修改密码
	 * 
	 * @param changeData
	 * @return
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/changePassword")
	@ResponseBody
	public CommonStatusResult changePassword(
			@RequestBody DTOAppLoginUserPasswordChangeData changeData) {

		if (changeData != null) {
			try {
				String newPassword = changeData.getNewPassword();
				if (!StringUtils.isEmpty(newPassword)) {
					byte[] s = Base64.decodeBase64(newPassword.getBytes());
					newPassword = new String(s, "utf8");
					newPassword = EncodeUtils.encodePassword(newPassword);
				}
				String currPassword = changeData.getCurrentPassword();
				if (!StringUtils.isEmpty(currPassword)) {
					byte[] s = Base64.decodeBase64(currPassword.getBytes());
					currPassword = new String(s, "utf8");
					currPassword = EncodeUtils.encodePassword(currPassword);
				}

				restaurantEmployeeLoginService.changePassword(getLoginUserId(),currPassword, newPassword);

			} catch (UnsupportedEncodingException e) {

				e.printStackTrace();
			}
			return CommonStatusResult.success(
					ErrorMessageConstant.CODE_SUCCESS, null);
		} else {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
	}

	/**
	 * 修改用户
	 * 
	 * @param systemUser
	 * @param request
	 * @return
	 */

	@RequestMapping(method = RequestMethod.POST, value = "/edit")
	@ResponseBody
	public CommonStatusResult editAppLoginUser(
			@RequestBody DTOAppLoginUserEditData systemUser) {

		if (systemUser == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		Integer loginUserId = getLoginUserId();
		AppLoginUser sysUser = restaurantEmployeeLoginService.getAppLoginUserById(loginUserId);
		if (sysUser == null) {
			throw FoodException.returnException("000003");
		}
		Integer personId = systemUser.getPersonId();
		if (personId == null || personId < 1) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		ComEmployee comEmployee = comEmployeeService.getRestaurantEmployeeById(personId);
		if (comEmployee == null) {
			throw FoodException.returnException("012004");
		}
		sysUser = DTOAppLoginUserEditData.toEntity(sysUser, systemUser,comEmployee);

		restaurantEmployeeLoginService.updateAppLoginUser(sysUser);
		// List<AppPermission> permisssionList = restaurantEmployeeLoginService
		// .getAllPermissionsByLoginUserId(sysUser.getId());
		// Authentication authentication = new
		// UsernamePasswordAuthenticationToken(sysUser, sysUser.getUsername(),
		// getAuthorities(permisssionList));

		UserDetails user = userService.loadUserByUsername(sysUser.getUsername());

		UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(user, user.getPassword(), user.getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(authentication);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS,systemUser);
	}

	public Collection<GrantedAuthority> getAuthorities(List<AppPermission> permissionList) {
		List<GrantedAuthority> authList = new ArrayList<GrantedAuthority>();
		if (null != permissionList) {
			for (AppPermission permission : permissionList) {
				authList.add(new GrantedAuthorityImpl(permission.getPermissionId()));
			}
		}
		authList.add(new GrantedAuthorityImpl("ROLE_TEST"));
		return authList;
	}
	
	/**
	 * 发送验证码短信
	 * @return
	 */
	@RequestMapping(value = "/sendCheckMsg", method = RequestMethod.POST)
    @ResponseBody
	public CommonStatusResult sendCheckMsg(@RequestParam String phone,HttpServletRequest request){
		Integer loginUserId = getLoginUserId();
		AppLoginUser user = restaurantEmployeeLoginService.getAppLoginUserById(loginUserId);
		if (user == null || user.getEmp() == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		ConfigPropertiesUtil.initFromConfig("smsContent");
		String validTime = ConfigPropertiesUtil.getValue("msg.code.time");
		String key = KEY_STRING+phone;
		String code = "";
		if (request.getSession().getAttribute(key) != null && request.getSession().getAttribute("codeExpireDate") != null) {
			Date expireDate = TimeOrDateUtils.parseDate(request.getSession().getAttribute("codeExpireDate").toString(),TimeOrDateUtils.FULL_FROMAT);
			if (TimeOrDateUtils.AFTER == TimeOrDateUtils.compareTwoDate(expireDate, new Date())) {
				code = request.getSession().getAttribute(key).toString();
			}
		}
		if ("".equals(code)) {
			code = new Double(Math.random()).toString().substring(2, 8);
			request.getSession().setAttribute(key, code);
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.MINUTE, Integer.parseInt(validTime));// 失效时间设置为30分钟后
			request.getSession().setAttribute("codeExpireDate",TimeOrDateUtils.formateDate(calendar.getTime(),TimeOrDateUtils.FULL_FROMAT));
		}
		String content = ConfigPropertiesUtil.getValueWithPars("phone.msg.code", new String[] {code,validTime});
		List<String> toList = new ArrayList<String>();
		toList.add(phone);
		ConfigPropertiesUtil.initFromConfig("config");
		String keyString = KEY_STRING + phone;
		if (!redisService.hasKey(keyString)) {
			alarmService.sendSMSMessage(content, toList);
			redisService.set(keyString, phone, 60L);
		}
		
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, true);
	}
	
	/**
	 * 认证手机
	 * @param code
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/setVerifiedPhone", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult setVerifiedPhone(@RequestParam String code, HttpServletRequest request) {
		Integer loginUserId = getLoginUserId();
		AppLoginUser user = restaurantEmployeeLoginService.getAppLoginUserById(loginUserId);
		if (user == null || user.getEmp() == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		//验证手机验证码
		String phone = user.getEmp().getMobilePhone();
		String key = KEY_STRING+phone;
		String checkCode = "";
		System.out.println(request.getSession().getAttribute(key) + ":"+ request.getSession().getAttribute("codeExpireDate"));
		if (request.getSession().getAttribute(key) != null && request.getSession().getAttribute("codeExpireDate") != null) {
			Date expireDate = TimeOrDateUtils.parseDate(request.getSession().getAttribute("codeExpireDate").toString(),TimeOrDateUtils.FULL_FROMAT);
			if (TimeOrDateUtils.AFTER == TimeOrDateUtils.compareTwoDate(expireDate, new Date())) {
				checkCode = request.getSession().getAttribute(key).toString();
			}
		}
		if ("".equals(checkCode) || !checkCode.equals(code)) {
			return CommonStatusResult.fail("000016",null);
		}
		user.getEmp().setIsPhoneReg(FoodConstant.FIELD_STATUS_VALID);
		restaurantEmployeeLoginService.updateAppLoginUser(user);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS,null);
	}
	
	/**
	 * 修改手机
	 * @param password
	 * @param phone
	 * @param code
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/changedPhone", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult changePhone(@RequestParam String password,@RequestParam String phone,@RequestParam String code, HttpServletRequest request) {
		Integer loginUserId = getLoginUserId();
		AppLoginUser user = restaurantEmployeeLoginService.getAppLoginUserById(loginUserId);
		if (user == null || user.getEmp() == null || StringUtils.isBlank(phone)) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		//验证密码
		if(StringUtils.isNotBlank(password)){
			password = EncodeUtils.encodePassword(password);
			if(!password.equals(user.getPassword())){
				return CommonStatusResult.fail("012012",null);
			}
		}else{
			return CommonStatusResult.fail("000016",null);
		}
		//验证手机验证码
		String key = KEY_STRING+phone;
		String checkCode = "";
		System.out.println(request.getSession().getAttribute(key) + ":"+ request.getSession().getAttribute("codeExpireDate"));
		if (request.getSession().getAttribute(key) != null && request.getSession().getAttribute("codeExpireDate") != null) {
			Date expireDate = TimeOrDateUtils.parseDate(request.getSession().getAttribute("codeExpireDate").toString(),TimeOrDateUtils.FULL_FROMAT);
			if (TimeOrDateUtils.AFTER == TimeOrDateUtils.compareTwoDate(expireDate, new Date())) {
				checkCode = request.getSession().getAttribute(key).toString();
			}
		}
		if ("".equals(checkCode) || !checkCode.equals(code)) {
			return CommonStatusResult.fail("000016",null);
		}
		user.getEmp().setMobilePhone(phone);
		user.getEmp().setIsPhoneReg(FoodConstant.FIELD_STATUS_VALID);
		restaurantEmployeeLoginService.updateAppLoginUser(user);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS,null);
	}
}