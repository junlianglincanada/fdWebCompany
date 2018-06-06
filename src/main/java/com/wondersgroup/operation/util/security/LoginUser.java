package com.wondersgroup.operation.util.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.AppPermission;
import com.wondersgroup.data.jpa.entity.AppRole;

public class LoginUser extends User {
	private static final long serialVersionUID = -5939048787260505766L;

	private AppLoginUser appLoginUser;
	private List<AppPermission> appPermissionsList = new ArrayList<AppPermission>();
	private List<AppRole> appRolesList = new ArrayList<>();
	private int hasBranch;//分店数量
	private int hasTrunk;//是否有总店
	private int hasMonitor;//是否有监控屏

	public LoginUser(String username, String password, boolean enabled, boolean accountNonExpired, boolean credentialsNonExpired, boolean accountNonLocked,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
	}

	public AppLoginUser getAppLoginUser() {
		return appLoginUser;
	}

	public void setAppLoginUser(AppLoginUser appLoginUser) {
		this.appLoginUser = appLoginUser;
	}

	public List<AppPermission> getAppPermissionsList() {
		return appPermissionsList;
	}

	public void setAppPermissionsList(List<AppPermission> appPermissionsList) {
		this.appPermissionsList = appPermissionsList;
	}

	public List<AppRole> getAppRolesList() {
		return appRolesList;
	}

	public void setAppRolesList(List<AppRole> appRolesList) {
		this.appRolesList = appRolesList;
	}

	public int getHasBranch() {
		return hasBranch;
	}

	public void setHasBranch(int hasBranch) {
		this.hasBranch = hasBranch;
	}

	public int getHasTrunk() {
		return hasTrunk;
	}

	public void setHasTrunk(int hasTrunk) {
		this.hasTrunk = hasTrunk;
	}

	public int getHasMonitor() {
		return hasMonitor;
	}

	public void setHasMonitor(int hasMonitor) {
		this.hasMonitor = hasMonitor;
	}
	
}
