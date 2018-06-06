package com.wondersgroup.operation.system.model;

import java.util.Date;

import com.wondersgroup.data.jpa.entity.SysLoginUser;
import com.wondersgroup.data.jpa.entity.SysOperator;

public class DTOSysLoginUserCreate {
    private String username;
    private String password;
    private int status;
    private String statusValue;
    private Date createDate;
    private Date disableDate;
    private DTOSysOperator sysOperator;
    
    private String roleIds;
    private String roleDescs;
    
    public static SysLoginUser toEntity(DTOSysLoginUserCreate dto) {
    	SysLoginUser entity = null;
    	if (dto!=null) {
			entity = new SysLoginUser();
			entity.setCreateDate(new Date());
			entity.setStatus(1);
			entity.setUsername(dto.getUsername());
			entity.setPassword(dto.getPassword());
			SysOperator operator = DTOSysOperator.toEntity(entity.getSysUser(), dto.getSysOperator());
			entity.setSysUser(operator);
			entity.setLastModifiedDate(new Date());
		}
		return entity;
	}
    
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getDisableDate() {
		return disableDate;
	}

	public void setDisableDate(Date disableDate) {
		this.disableDate = disableDate;
	}

	public DTOSysOperator getSysOperator() {
		return sysOperator;
	}

	public void setSysOperator(DTOSysOperator sysOperator) {
		this.sysOperator = sysOperator;
	}

	public String getRoleIds() {
		return roleIds;
	}

	public void setRoleIds(String roleIds) {
		this.roleIds = roleIds;
	}

	public String getRoleDescs() {
		return roleDescs;
	}

	public void setRoleDescs(String roleDescs) {
		this.roleDescs = roleDescs;
	}

	public String getStatusValue() {
		return statusValue;
	}

	public void setStatusValue(String statusValue) {
		this.statusValue = statusValue;
	}
    
    
}
