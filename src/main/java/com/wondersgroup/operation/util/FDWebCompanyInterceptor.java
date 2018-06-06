package com.wondersgroup.operation.util;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.wondersgroup.data.jpa.entity.EmpUserVisitHistory;
import com.wondersgroup.framework.cache.RedisService;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.util.security.SecurityUtils;
import com.wondersgroup.operation.util.tools.IPUtil;
import com.wondersgroup.service.empuser.RestaurantEmployeeLoginService;
import com.wondersgroup.service.history.AccessHistoryService;

public class FDWebCompanyInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(FDWebCompanyInterceptor.class);
	@Autowired
	private AccessHistoryService accessHistoryService;
	@Autowired
	private RestaurantEmployeeLoginService restaurantEmployeeLoginService;
	
	@Autowired
	private RedisService redisService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// System.out.println("preHandle");
		if (SecurityUtils.getCurrentUser() == null) {
			return true;
		}
		// 判断用户是否存在
		Integer appLoginUserId = SecurityUtils.getCurrentUserId();
		boolean appLoginUserExists = restaurantEmployeeLoginService.isAppLoginUserExists(appLoginUserId);
		if (!appLoginUserExists) {
			String loginPage = request.getContextPath();
			response.setStatus(302);
			response.addHeader("redirect", loginPage);
			request.getSession().invalidate();
			return false;
		}
		
//		//更新在线列表
//		String onlineKey = "online-"+appLoginUserId;
//		Object object = redisService.get(onlineKey);
//		if(object==null){
//			redisService.set(onlineKey, appLoginUserId, 60);
//		}
		
		
		
		String reqURL = request.getRequestURI();
		String functionName = null;
		if (reqURL != null && !reqURL.isEmpty()) {
			int beginIndex = (reqURL.indexOf("/") == 0) ? 1 : 0; // 如果第一个字符是/则略过开头
			if (reqURL.indexOf("/", beginIndex) > -1) {
				beginIndex = reqURL.indexOf("/", beginIndex) + 1;
			}
			int endIndex = reqURL.length();
			if (reqURL.indexOf("/", beginIndex) > -1) {
				endIndex = reqURL.indexOf("/", beginIndex);
			}
			functionName = reqURL.substring(beginIndex, endIndex);
		}
		EmpUserVisitHistory visitHistory = new EmpUserVisitHistory();
		visitHistory.setClientSystemType(FoodConstant.CLIENT_SYSTEM_TYPE_WEBCOMPANY);
		visitHistory.setClientUserId(appLoginUserId);
		visitHistory.setClientUserName(SecurityUtils.getCurrentUserRealName());
		visitHistory.setClientUserLoginName(SecurityUtils.getCurrentUsername());
		visitHistory.setServerIpAddress(IPUtil.getIpAddress(request));
		visitHistory.setServerHostName(request.getRemoteHost());
		visitHistory.setFunctionName(functionName);
		visitHistory.setInitialRequest(request.getRequestURI());
		visitHistory.setCreateDate(new Date());
		accessHistoryService.createEmpUserVisitHistory(visitHistory);
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		// System.out.println("postHandle");
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		// System.out.println("afterCompletion");
	}

	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	}
}
