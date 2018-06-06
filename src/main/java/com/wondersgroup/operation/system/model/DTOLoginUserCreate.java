package com.wondersgroup.operation.system.model;

import java.util.Date;

import org.apache.commons.lang.StringUtils;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.service.empuser.RestaurantEmployeeService;
import com.wondersgroup.util.EncodeUtils;
@JsonIgnoreProperties(ignoreUnknown=true)
public class DTOLoginUserCreate {
	private String username;
	private String password;
	private Integer personId;//从业人员 id
	private String personName;//姓名
	private String mobilePhone;//手机
	private String phone;//电话
	private String email;//邮箱
	private String jobRole; //岗位
	private Integer hasAppMgrPermission;

	public static ComEmployee toComEmployee(DTOLoginUserCreate dto, String personType, Company company) {
		ComEmployee emp = null;
		if (dto != null) {
			emp = new ComEmployee();
			emp.setPersonType(personType);
			Date now = new Date();
			emp.setCreateDate(now);
			emp.setLastModifiedDate(now);
			emp.setEmail(dto.getEmail());
			emp.setPhone(dto.getPhone());
			emp.setMobilePhone(dto.getMobilePhone());
			emp.setJobRole(dto.getJobRole());
			emp.setPersonName(dto.getPersonName());
			emp.setCompany(company);
		}
		return emp;
	}

	public static AppLoginUser toEntity(DTOLoginUserCreate dto,Company company, RestaurantEmployeeService restaurantEmployeeService) {
		AppLoginUser entity = null;
		if (dto != null) {
//			ComEmployee emp = toComEmployee(dto, ComEmployee.TYPE_EMP, company);
			ComEmployee emp =restaurantEmployeeService.getRestaurantEmployeeById(dto.getPersonId());
			if(emp==null){
				throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
			}
			entity = new AppLoginUser();
			entity.setHasAppMgrPermission(dto.getHasAppMgrPermission());
			entity.setEmp(emp);
			entity.setEnabled(1);
			entity.setUserType(AppLoginUser.TYPE_EMP);
			String _username = dto.getUsername();
			if (StringUtils.isEmpty(_username)) {
				throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
			}
			entity.setUsername(_username);
			String _password = dto.getPassword();
			if (StringUtils.isEmpty(_password)) {
				throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
			}
			entity.setPassword(EncodeUtils.encodePassword(_password));
			entity.setEnabled(1);
			entity.setCreateDate(new Date());
			
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

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public Integer getPersonId() {
		return personId;
	}

	public void setPersonId(Integer personId) {
		this.personId = personId;
	}

	public Integer getHasAppMgrPermission() {
		return hasAppMgrPermission;
	}

	public void setHasAppMgrPermission(Integer hasAppMgrPermission) {
		this.hasAppMgrPermission = hasAppMgrPermission;
	}

}
