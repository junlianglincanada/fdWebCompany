package com.wondersgroup.operation.util.security;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.util.UrlUtils;
import org.springframework.util.Assert;

import com.wondersgroup.data.jpa.entity.EmpUserLoginHistory;
import com.wondersgroup.data.jpa.entity.EmpUserVisitHistory;
import com.wondersgroup.framework.cache.OnlineService;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.util.tools.IPUtil;
import com.wondersgroup.service.history.AccessHistoryService;

public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

	protected final Log logger = LogFactory.getLog(this.getClass());

	@Autowired
	private AccessHistoryService accessHistoryService;
	@Autowired
	private OnlineService onlineService;

	private String defaultTargetUrl = "default.do";

	public CustomAuthenticationSuccessHandler() {
	}

	public CustomAuthenticationSuccessHandler(String defaultTargetUrl) {
		Assert.isTrue(UrlUtils.isValidRedirectUrl(defaultTargetUrl), "defaultTarget must start with '/' or with 'http(s)'");
		this.defaultTargetUrl = defaultTargetUrl;
	}

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		EmpUserVisitHistory visitHistory = new EmpUserVisitHistory();
		visitHistory.setClientSystemType(FoodConstant.CLIENT_SYSTEM_TYPE_WEBCOMPANY);
		visitHistory.setClientUserId(SecurityUtils.getCurrentUserId());
		visitHistory.setClientUserName(SecurityUtils.getCurrentUserRealName());
		visitHistory.setClientUserLoginName(SecurityUtils.getCurrentUsername());
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
		loginHistory.setCompanyId(SecurityUtils.getCurrentUserCompanyId());
		loginHistory.setClientUserId(SecurityUtils.getCurrentUserId());
		loginHistory.setClientUserName(SecurityUtils.getCurrentUserRealName());
		loginHistory.setClientUserLoginName(SecurityUtils.getCurrentUsername());
		loginHistory.setSuccessfulLogin(FoodConstant.FIELD_STATUS_VALID);
		loginHistory.setLoginDate(new Date());
		accessHistoryService.createEmpUserLoginHistory(loginHistory);
		onlineService.addOnline(SecurityUtils.getCurrentUserCompanyId(), SecurityUtils.getCurrentUserId());
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
