package com.wondersgroup.operation.util.security;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.commons.lang.StringUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.AppPermission;

public class SecurityUtils {

	public static LoginUser getCurrentUser() {
		SecurityContext ctx = SecurityContextHolder.getContext();
		if (ctx != null) {
			Authentication authentication = ctx.getAuthentication();
			if (authentication != null) {
				Object principal = authentication.getPrincipal();
				if (principal != null) {
					return (LoginUser) principal;
				}
			}
		}
		return null;
	}

	public static String getCurrentUserPwd() {
		LoginUser loginUser = getCurrentUser();
		if (loginUser != null) {
			AppLoginUser appLoginUser = loginUser.getAppLoginUser();
			if (appLoginUser != null) {
				return appLoginUser.getPassword();
			}
		}
		return "";
	}

	public static Integer getCurrentUserId() {
		LoginUser user = getCurrentUser();
		if (user != null) {
			return user.getAppLoginUser().getId();
		}
		return null;
	}

	public static String getCurrentUsername() {
		LoginUser user = getCurrentUser();
		if (user != null) {
			return user.getUsername();
		}
		return "";
	}

	public static String getCurrentUserRealName() {
		LoginUser user = getCurrentUser();
		if (user != null) {
			return user.getAppLoginUser().getEmp().getPersonName();
		}
		return "";
	}

	public static String getCurrentUserDepartment() {
		LoginUser user = getCurrentUser();
		if (user != null) {
			return user.getAppLoginUser().getEmp().getJobDescription();
		}
		return "";
	}

	public static boolean hasResCode(String code) {
		return isCurrentUserHasResCode(code);
	}

	public static boolean isCurrentUserHasResCode(String code) {
		List<AppPermission> resList = getCurrentUserPrivList();
		if (resList != null) {
			for (AppPermission r : resList) {
				if (StringUtils.equals(r.getDescription(), code)) {
					return true;
				}
			}
		}
		return false;
	}

	public static String getCurrentUserCompanyName() {
		LoginUser user = getCurrentUser();
		if (user != null) {
			System.out.println(user.getAppLoginUser().getEmp().getCompany());
			// System.out.println(user.getAppLoginUser().getEmp().getPersonName());
			return user.getAppLoginUser().getEmp().getCompany().getCompanyName();
		}
		return "";
	}
	
	public static Integer getCurrentUserCompanyId() {
		LoginUser user = getCurrentUser();
		if (user != null) {
			System.out.println(user.getAppLoginUser().getEmp().getCompany());
			return user.getAppLoginUser().getEmp().getCompany().getCompanyId();
		}
		return null;
	}

	public static List<AppPermission> getCurrentUserPrivList() {
		LoginUser user = getCurrentUser();
		if (user == null)
			return null;
		return user.getAppPermissionsList();
	}

	public static boolean getHasBranch() {
		LoginUser user = getCurrentUser();
		boolean hasBranch = false;
		if (user != null && user.getHasBranch() > 0) {
			hasBranch = true;
		}
		System.out.println(hasBranch);
		return hasBranch;
	}
	
	public static boolean getHasTrunk() {
		LoginUser user = getCurrentUser();
		boolean hasTrunk = false;
		if (user != null && user.getHasTrunk() > 0) {
			hasTrunk = true;
		}
		System.out.println(hasTrunk);
		return hasTrunk;
	}

	public static String getPath(String fileName) {
		String contextPath = "";
		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
		ServletContext servletContext = webApplicationContext.getServletContext();
		contextPath = servletContext.getRealPath("/");
		contextPath += fileName;
		File attachFile = new File(contextPath);
		if (!attachFile.exists()) {
			attachFile.mkdirs();
		}
		return contextPath;
	}
	
	public static boolean getHasMonitor() {
		LoginUser user = getCurrentUser();
		boolean hasMonitor = false;
		if (user != null && user.getHasMonitor() > 0) {
			hasMonitor = true;
		}
		System.out.println(hasMonitor);
		return hasMonitor;
	}
	
	public static String getCurrentUserNameAbbrev() {
		LoginUser user = getCurrentUser();
		if (user != null) {
			System.out.println(user.getAppLoginUser().getEmp().getCompany());
			// System.out.println(user.getAppLoginUser().getEmp().getPersonName());
			return user.getAppLoginUser().getEmp().getCompany().getRestaurant().getNameAbbrev();
		}
		return "";
	}
}
