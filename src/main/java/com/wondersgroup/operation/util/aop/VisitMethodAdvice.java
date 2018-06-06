package com.wondersgroup.operation.util.aop;

import java.lang.reflect.Method;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.MethodBeforeAdvice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.wondersgroup.service.empuser.RestaurantEmployeeLoginService;
import com.wondersgroup.service.history.AccessHistoryService;

@Component
public class VisitMethodAdvice implements MethodBeforeAdvice {

	private static final Logger logger = LoggerFactory.getLogger(VisitMethodAdvice.class);

	@Autowired
	private RestaurantEmployeeLoginService employeeLoginService;
	@Autowired
	private AccessHistoryService accessHistoryService;

	@Override
	public void before(Method method, Object[] args, Object targetClassInstance) throws Throwable {
//		System.out.println("before");

//		logger.debug("~~~~~~~~ enter VisitMethodAdvice ~~~~~~~~");
//		long begin = System.currentTimeMillis();
//		try {
//			ServletRequestAttributes atts = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
//			if (atts != null) {
//				String functionName = null;
//				String methodName = method.getName();
//
//				HttpServletRequest req = atts.getRequest();
//				String reqURL = req.getRequestURI();
//
//				String serverHost = req.getLocalName();
//				String serverAddress = req.getLocalAddr();
//
//				if (reqURL != null && !reqURL.isEmpty()) {
//					int beginIndex = (reqURL.indexOf("/") == 0) ? 1 : 0; // 如果第一个字符是/则略过开头
//					if (reqURL.indexOf("/", beginIndex) > -1) {
//						beginIndex = reqURL.indexOf("/", beginIndex) + 1;
//					}
//					int endIndex = reqURL.length();
//					if (reqURL.indexOf("/", beginIndex) > -1) {
//						endIndex = reqURL.indexOf("/", beginIndex);
//					}
//					functionName = reqURL.substring(beginIndex, endIndex);
//				}
//				Integer loginUserId = null;
//				String loginUserName = null;
//				String userName = null;
//				LoginUser loginUser = SecurityUtils.getCurrentUser();
//				if (null != loginUser && null != loginUser.getAppLoginUser()) {
//					loginUserId = loginUser.getAppLoginUser().getId();
//					loginUserName = loginUser.getAppLoginUser().getUsername();
//					userName = loginUser.getAppLoginUser().getEmp().getPersonName();
//				}
//
//				EmpUserVisitHistory visitHistory = new EmpUserVisitHistory();
//				visitHistory.setClientSystemType(FoodConstant.CLIENT_SYSTEM_TYPE_WEBCOMPANY);
//				visitHistory.setClientUserId(SecurityUtils.getCurrentUserId());
//				visitHistory.setClientUserName(SecurityUtils.getCurrentUserRealName());
//				visitHistory.setClientUserLoginName(SecurityUtils.getCurrentUsername());
//				visitHistory.setServerIpAddress(IPUtil.getIpAddress(req));
//				visitHistory.setServerHostName(req.getRemoteHost());
//				visitHistory.setFunctionName("login.jsp");
//				visitHistory.setInitialRequest(req.getRequestURI());
//				visitHistory.setCreateDate(new Date());
//				visitHistory.setRequestName(methodName);
//				visitHistory.setFunctionName(functionName);
//
//				accessHistoryService.createEmpUserVisitHistory(visitHistory);
//			}
//		} catch (Exception e) {
//			logger.error(null, e);
//		} finally {
//			long useTime = System.currentTimeMillis() - begin;
//			logger.debug("~~~~~~~~ VisitMethodAdvice useTime:" + useTime + "~~~~~~~~");
//			logger.debug("~~~~~~~~ leave VisitMethodAdvice ~~~~~~~~");
//		}
	}
}
