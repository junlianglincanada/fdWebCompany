package com.wondersgroup.operation.util.security;

import static com.wondersgroup.data.jpa.entity.AppLoginUser.TYPE_EMP;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.util.UrlUtils;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.EmpUserLoginHistory;
import com.wondersgroup.data.jpa.entity.EmpUserVisitHistory;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.util.tools.IPUtil;
import com.wondersgroup.service.empuser.RestaurantEmployeeLoginService;
import com.wondersgroup.service.history.AccessHistoryService;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

	protected final Log logger = LogFactory.getLog(this.getClass());

	@Autowired
	private AccessHistoryService accessHistoryService;

	@Autowired
	private RestaurantEmployeeLoginService restaurantEmployeeLoginService;

	private String defaultTargetUrl = "";

	public CustomAuthenticationFailureHandler() {
	}

	public CustomAuthenticationFailureHandler(String defaultTargetUrl) {
		Assert.isTrue(UrlUtils.isValidRedirectUrl(defaultTargetUrl), "defaultTarget must start with '/' or with 'http(s)'");
		this.defaultTargetUrl = defaultTargetUrl;
	}

	@Override
	@Transactional(readOnly = true)
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
		UsernamePasswordAuthenticationToken token = (UsernamePasswordAuthenticationToken) exception.getAuthentication();
		if (token != null) {
			AppLoginUser user = restaurantEmployeeLoginService.login(token.getName(), null, -1, TYPE_EMP);
			EmpUserVisitHistory visitHistory = new EmpUserVisitHistory();
			visitHistory.setClientSystemType(FoodConstant.CLIENT_SYSTEM_TYPE_WEBCOMPANY);

			if (user != null) {
				visitHistory.setClientUserId(user.getId());
				visitHistory.setClientUserName(user.getEmp().getPersonName());
			}
			visitHistory.setClientUserLoginName(token.getName());
			visitHistory.setServerIpAddress(IPUtil.getIpAddress(request));
			visitHistory.setServerHostName(request.getRemoteHost());
			visitHistory.setFunctionName("login.jsp");
			visitHistory.setInitialRequest(request.getRequestURI());
			visitHistory.setCreateDate(new Date());
			try {
				accessHistoryService.createEmpUserVisitHistory(visitHistory);
			} catch (Exception e) {
				throw FoodException.returnException(e.getMessage());
			}

			EmpUserLoginHistory loginHistory = new EmpUserLoginHistory();
			loginHistory.setClientSystemType(FoodConstant.CLIENT_SYSTEM_TYPE_WEBCOMPANY);

			if (user != null) {
				loginHistory.setClientUserId(user.getId());
				if (user.getEmp()!=null) {
					loginHistory.setClientUserName(user.getEmp().getPersonName());
					loginHistory.setCompanyId(user.getEmp().getCompany().getCompanyId());
				}
			}
			loginHistory.setClientUserLoginName(token.getName());
			loginHistory.setSuccessfulLogin(FoodConstant.FIELD_STATUS_INVALID);
			loginHistory.setLoginDate(new Date());
			accessHistoryService.createEmpUserLoginHistory(loginHistory);
		}
		Integer loginErrorCount = (Integer)request.getSession().getAttribute("loginErrorCount");
		//登录失败次数统计
		if(loginErrorCount == null || loginErrorCount <0){
			request.getSession().setAttribute("loginErrorCount", 1);
		}else{
			request.getSession().setAttribute("loginErrorCount", loginErrorCount+1);
		}

		RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
		redirectStrategy.sendRedirect(request, response, this.defaultTargetUrl);
	}

	public String getDefaultTargetUrl() {
		return defaultTargetUrl;
	}

	public void setDefaultTargetUrl(String defaultTargetUrl) {
		this.defaultTargetUrl = defaultTargetUrl;
	}

}
