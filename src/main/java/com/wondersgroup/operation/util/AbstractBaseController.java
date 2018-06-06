package com.wondersgroup.operation.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.wondersgroup.data.jpa.entity.AppLoginDevice;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.framework.support.BaseController;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.operation.util.security.LoginUser;
import com.wondersgroup.service.empuser.RestaurantEmployeeLoginService;

public abstract class AbstractBaseController extends BaseController {

	private static Logger logger = LoggerFactory.getLogger(AbstractBaseController.class);

	@Autowired
	public RestaurantEmployeeLoginService employeeLoginService;

	public static LoginUser getCurrentUser() {
		SecurityContext ctx = SecurityContextHolder.getContext();
		return (LoginUser) ctx.getAuthentication().getPrincipal();
	}

	protected HttpServletRequest getRequest() {
		ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = sra.getRequest();
		return request;
	}

	/**
	 * 获取session中的companyId信息
	 * 
	 * @param session
	 * @return
	 */
	public Integer getLoginCompanyId() {
		LoginUser user = getCurrentUser();
		if (user != null) {
			return user.getAppLoginUser().getEmp().getCompany().getCompanyId();
		}

		return null;
	}

	/**
	 * 获取session中的company信息
	 * 
	 * @param session
	 * @return
	 */
	public Company getLoginCompany() {
		LoginUser user = getCurrentUser();
		if (user != null) {
			return user.getAppLoginUser().getEmp().getCompany();
		}

		return null;
	}

	/**
	 * 获取session中的companyName信息
	 * 
	 * @param session
	 * @return
	 */
	public String getLoginCompanyName() {
		ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = attr.getRequest().getSession(true);
		String companyName = getCompanyName(session);
		return companyName;
	}

	/**
	 * 获取session中的登录用户ID
	 * 
	 * @return
	 */
	protected Integer getLoginUserId() {
		LoginUser user = getCurrentUser();
		if (user != null) {
			return user.getAppLoginUser().getId();
		}

		return null;
	}

	/**
	 * 获取登录用户名
	 * 
	 * @return
	 */
	protected String getLoginUserName() {
		String userName = null;
		LoginUser user = getCurrentUser();
		if (user != null) {
			userName = user.getUsername();
		}
		return userName;
	}

	private String getCompanyName(HttpSession session) {
		String companyName = "";
		// 二期
		AppLoginDevice appLoginDevice = (AppLoginDevice) session.getAttribute("appLoginDevice");
		if (null != appLoginDevice) {
			companyName = appLoginDevice.getComName();
		} else {
			// 在session
			throw FoodException.returnException("000015");
		}

		logger.info("companyName = " + companyName);
		return companyName;
	}
}