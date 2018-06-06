package com.wondersgroup.operation.common.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.framework.cache.RedisService;
import com.wondersgroup.framework.common.AlarmService;
import com.wondersgroup.framework.dao.JdbcAbstractDao;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.ConfigPropertiesUtil;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.service.empuser.RestaurantEmployeeLoginService;
import com.wondersgroup.util.EncodeUtils;
import com.wondersgroup.util.StringUtils;
import com.wondersgroup.util.TimeOrDateUtils;

@Controller
@RequestMapping("/forgetPwd")
public class ForgetPwdController extends AbstractBaseController{
	
	private static final Logger logger = LoggerFactory.getLogger(ForgetPwdController.class);
	
	private static final String KEY_STRING = JdbcAbstractDao.getLocation()+"FDWebCompany_ForgetPWD_Verification_Code_Mobile_";
	
	@Autowired
	private RestaurantEmployeeLoginService employeeService;
	
	@Autowired
	private AlarmService alarmService;

	@Autowired
	private RedisService redisService;
	
	/**
	 * 忘记密码--查询验证手机号码
	 * @param username
	 * @return
	 */
	@RequestMapping(value = "/getUserMobilephone", method = RequestMethod.POST)
    @ResponseBody
	public CommonStatusResult getUserMobilephone(@RequestParam String username){
		if(StringUtils.isBlank(username)){
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		//查询账户是否存在
		AppLoginUser user = employeeService.getAppLoginUserByUsername(username, AppLoginUser.TYPE_EMP);
		if(user == null||user.getEmp() == null){
			return CommonStatusResult.fail("012005",null);
		}
		//查询手机是否验证
		ComEmployee emp = user.getEmp();
		if(emp.getIsPhoneReg()== null || emp.getIsPhoneReg()<1||!isMobilePhone(emp.getMobilePhone())){
			return CommonStatusResult.fail("014005",null);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, emp.getMobilePhone());
	}
	/**
	 * 发送验证码短信
	 * @return
	 */
	@RequestMapping(value = "/sendCheckMsg", method = RequestMethod.POST)
    @ResponseBody
	public CommonStatusResult sendCheckMsg(@RequestParam String username,@RequestParam String phone,HttpServletRequest request){
		AppLoginUser user = employeeService.getAppLoginUserByUsername(username, AppLoginUser.TYPE_EMP);
		if (user == null || user.getEmp() == null || phone == null || phone.isEmpty()||user.getEmp().getIsPhoneReg()<1||!phone.equals(user.getEmp().getMobilePhone())) {
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
	 * 验证用户验证码
	 * 
	 * @param phone
	 *            手机号码
	 * @param code
	 *            验证码
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/checkCode", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult checkCode(@RequestParam String phone,
			@RequestParam String code, HttpServletRequest request) {
		if (phone == null || phone.isEmpty() || code == null || code.isEmpty()) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
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
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS,null);
	}
	/**
	 * 设置新密码
	 * @param username
	 * @param password
	 * @return
	 */
	@RequestMapping(value = "/setNewPassword", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult setNewPassword(@RequestParam String username,@RequestParam String password){
		if(!StringUtils.isEmpty(password)){
			password = EncodeUtils.encodePassword(password);
			AppLoginUser user = employeeService.getAppLoginUserByUsername(username, AppLoginUser.TYPE_EMP);
			user.setPassword(password);
			employeeService.updateAppLoginUser(user);
    		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
        }else{
        	throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
        }
	}
	/**
	 * 手机号码正则验证
	 * @param mobilePhone
	 * @return
	 */
	public boolean isMobilePhone(String mobilePhone){
		Pattern p=Pattern.compile("^(13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9])\\d{8}$");
		Matcher m = p.matcher(mobilePhone);
		return m.matches();
	}
}
