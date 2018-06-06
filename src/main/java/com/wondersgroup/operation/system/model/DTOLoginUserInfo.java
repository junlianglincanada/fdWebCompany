package com.wondersgroup.operation.system.model;

import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.ComEmployee;

public class DTOLoginUserInfo {
	private Integer id;
	private String username;
	private String personName;//姓名
	private String mobilePhone;//手机
	private String phone;//电话
	private String email;//邮箱
	private String jobRole; //岗位
	private String password;//密码
	private Integer hasAppMgrPermission;
	private Integer personId;
	
	
	public static DTOLoginUserInfo toDTO(AppLoginUser entity) {
		DTOLoginUserInfo dto = null;
		
		if(entity!=null){
			dto = new DTOLoginUserInfo();
			ComEmployee emp = entity.getEmp();
			dto.setEmail(emp.getEmail());
			dto.setId(entity.getId());
			dto.setJobRole(emp.getJobRole());
			dto.setMobilePhone(emp.getMobilePhone());
			dto.setPhone(emp.getPhone());
			dto.setPersonName(emp.getPersonName());
			dto.setUsername(entity.getUsername());
			dto.setPassword(entity.getPassword());
			dto.setHasAppMgrPermission(entity.getHasAppMgrPermission());
			dto.setPersonId(emp.getPersonId());
		}
		return dto;
	}
	
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPersonName() {
		return personName;
	}
	public void setPersonName(String personName) {
		this.personName = personName;
	}
	public String getMobilePhone() {
		return mobilePhone;
	}
	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getJobRole() {
		return jobRole;
	}
	public void setJobRole(String jobRole) {
		this.jobRole = jobRole;
	}


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public Integer getHasAppMgrPermission() {
		return hasAppMgrPermission;
	}


	public void setHasAppMgrPermission(Integer hasAppMgrPermission) {
		this.hasAppMgrPermission = hasAppMgrPermission;
	}


	public Integer getPersonId() {
		return personId;
	}


	public void setPersonId(Integer personId) {
		this.personId = personId;
	}
	
}
