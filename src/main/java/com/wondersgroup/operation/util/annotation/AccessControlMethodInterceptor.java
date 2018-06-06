package com.wondersgroup.operation.util.annotation;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.wondersgroup.data.jpa.entity.AppPermission;
import com.wondersgroup.data.jpa.entity.SysUserOperationHistory;
import com.wondersgroup.data.jpa.entity.SysUserVisitHistory;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.operation.util.security.LoginUser;
import com.wondersgroup.operation.util.security.SecurityUtils;
import com.wondersgroup.service.empuser.RestaurantEmployeeLoginService;
import com.wondersgroup.service.history.AccessHistoryService;
/**
 * 登录和权限控制相关方法拦截器
 * @author mengke
 */
public class AccessControlMethodInterceptor implements MethodInterceptor {
	private static final Logger logger = LoggerFactory.getLogger(AccessControlMethodInterceptor.class);
	
	@Autowired 
	private HttpSession session;
	
	@Autowired
	private RestaurantEmployeeLoginService restaurantEmployeeLoginService;
	
	@Autowired
	private AccessHistoryService accessHistoryService;
	
	private String actionType;
	
	@Override
	public Object invoke(MethodInvocation invocation) throws Throwable {
		logger.debug("~~~~~~~~ enter AccessControlMethodInterceptor ~~~~~~~~");
		ServletRequestAttributes sra =(ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
    	HttpServletRequest request = sra.getRequest();
    	boolean isSuccess = true;
        try {
        	boolean isValid = false;
        	
        	if (invocation.getMethod().isAnnotationPresent(RequestMapping.class)) {
        		
        		
        		if(invocation.getMethod().isAnnotationPresent(LoginRequired.class)){
            		isValid = loginRequiredHandler(); 
            	}else if(invocation.getMethod().isAnnotationPresent(HasPermission.class)){
            		HasPermission p = invocation.getMethod().getAnnotation(HasPermission.class);
            		isValid = hasPermissionHandler(p.value());
            	}else{
            		isValid = true;
            	}
        		
        		if (invocation.getMethod().isAnnotationPresent(ActionType.class)) {
        			ActionType type = invocation.getMethod().getAnnotation(ActionType.class);
        			this.setActionType(type.value());
				}else if(invocation.getClass().isAnnotationPresent(ActionType.class)){
					ActionType type = invocation.getMethod().getAnnotation(ActionType.class);
        			this.setActionType(type.value());
				}else{
					this.setActionType(invocation.getMethod().getName());
				}
            	//如果没有通过权限控制，则返回access denied
            	if(!isValid){
            		throw FoodException.returnException("012010");
            	}
			}
        	return invocation.proceed();
        }catch(FoodException fe){
        	isSuccess=false;
        	throw FoodException.returnException(fe.getMessage());
        }catch(Exception e){
        	isSuccess=false;
        	String msg="000000";
        	if (!StringUtils.isEmpty(e.getMessage())) {
        		throw new FoodException(e.getMessage());
			}else{
				StackTraceElement[] stackTrace = e.getStackTrace();
				StringBuilder sb = new StringBuilder();
				for (int i = 0; i < stackTrace.length; i++) {
					StackTraceElement st = stackTrace[i];
					sb.append(st.getFileName()+"  | "+st.getClassName()+"  | "+st.getMethodName()+"  | "+st.getLineNumber()+" \n\r");
				}
				logger.error(e.getClass()+" ," +e.getCause()+" \n\r "+sb.toString());
				throw FoodException.returnException(msg);
			}
        	
        }finally {
//        	addOperationHistory(request, isSuccess);
        	logger.debug("~~~~~~~~ leave AccessControlMethodInterceptor ~~~~~~~~");
        }
	}
	
	
	private boolean loginRequiredHandler(){
		LoginUser loginUser = SecurityUtils.getCurrentUser();
		if (null != loginUser && null != loginUser.getAppLoginUser()) {
			return true;
		}
		return false;
	}
	
	private boolean hasPermissionHandler(String[] permissionArray){
		//如果没有permission，则等同于loginRequired
		if(null == permissionArray || permissionArray.length < 1){
			return this.loginRequiredHandler();
		}
		
		LoginUser loginUser = SecurityUtils.getCurrentUser();
        if (null != loginUser && null != loginUser.getAppLoginUser()) {
        	//获取登录用户所有的permission
//        	List<SysPermission> sysPermissionList = SecurityUtils.getCurrentUserPrivList();
//        	List<AppPermission> sysPermissionList = SecurityUtils.getCurrentUserPrivList();
        	
        	List<AppPermission> sysPermissionList;
			try {
				sysPermissionList = restaurantEmployeeLoginService.getAllPermissionsByLoginUserId(loginUser.getAppLoginUser().getId());
			} catch (Exception e) {
				return false;
			}
        	
        	//如果用户没有permission,返回false
        	if(null == sysPermissionList || sysPermissionList.size() < 1){
        		return false;
        	}
            Set<String> pSet = new HashSet<>();
//            for(SysPermission sp : sysPermissionList){
                for(AppPermission sp : sysPermissionList){
                pSet.add(sp.getPermissionId());
            }
        	for(String permission : permissionArray){
        		//只要有一个permission用户没有，返回false
        		if(!pSet.contains(permission)){
        			return false;
        		}
        	}
        	return true;
        }
		return false;
	}

	public String getActionType() {
		return actionType;
	}

	public void setActionType(String actionType) {
		this.actionType = actionType;
	}
	
}
