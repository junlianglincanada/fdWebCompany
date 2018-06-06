package com.wondersgroup.operation.system.model;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.wondersgroup.data.jpa.entity.SysLoginUser;
import com.wondersgroup.data.jpa.entity.SysOperator;
import com.wondersgroup.data.jpa.entity.SysRole;
import com.wondersgroup.service.sys.SystemUserLoginService;

public class DTOSysLoginUser {
    private String username;
    private String password;
    private int status;
    private String statusValue;
    private Date createDate;
    private Date disableDate;
    private DTOSysOperator sysOperator;
    
    private String roleIds;
    private String roleDescs;
    
    public static DTOSysLoginUser toDTO(SysLoginUser entity, List<SysRole> sysRoles) {
    	DTOSysLoginUser dto = new DTOSysLoginUser();
    	dto.setUsername(entity.getUsername());
    	dto.setPassword(entity.getPassword());
    	dto.setStatus(entity.getStatus());
    	int status = entity.getStatus();
    	if (status==0) {
    		dto.setStatusValue("注销");
		}else if(status==1){
			dto.setStatusValue("正常");
		}else if(status==2){
			dto.setStatusValue("暂停");
		}
    	dto.setCreateDate(entity.getCreateDate());
    	dto.setDisableDate(entity.getDisableDate());
    	
    	SysOperator operator = entity.getSysUser();
    	dto.setSysOperator(DTOSysOperator.toDTO(operator));
    	if (sysRoles!=null && sysRoles.size()>0) {
    		String roleIds = "";
    		String roleDescs = "";
    		for (SysRole sysRole : sysRoles) {
    			roleIds +=sysRole.getRoleId()+",";
    			roleDescs += sysRole.getDescription()+",";
    		}
    		dto.setRoleIds(roleIds.substring(0, roleIds.length()-1));
    		dto.setRoleDescs(roleDescs.substring(0, roleDescs.length()-1));
		}
		return dto;
	}
    
    public static SysLoginUser toEntity(SystemUserLoginService systemUserLoginService, DTOSysLoginUser dtoSysLoginUser) {
    	SysLoginUser sysLoginUser = systemUserLoginService.getUserById(dtoSysLoginUser.getUsername());
    	if (dtoSysLoginUser!=null) {
			if (sysLoginUser == null) {
				sysLoginUser = new SysLoginUser();
				sysLoginUser.setCreateDate(new Date());
				sysLoginUser.setStatus(1);
            }
			sysLoginUser.setUsername(dtoSysLoginUser.getUsername());
			String password = dtoSysLoginUser.getPassword();
			if (!StringUtils.isEmpty(password)) {
				sysLoginUser.setPassword(password);
			}
			int status = dtoSysLoginUser.getStatus();
			if(status>0){
				sysLoginUser.setStatus(status);
			}
			sysLoginUser.setDisableDate(dtoSysLoginUser.getDisableDate());
			SysOperator operator = DTOSysOperator.toEntity(sysLoginUser.getSysUser(), dtoSysLoginUser.getSysOperator());
			sysLoginUser.setSysUser(operator);
			sysLoginUser.setLastModifiedDate(new Date());
		}
		return sysLoginUser;
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
