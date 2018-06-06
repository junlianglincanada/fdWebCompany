package com.wondersgroup.operation.system.model;

import java.util.Date;

import org.apache.commons.lang.StringUtils;

import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.service.empuser.RestaurantEmployeeLoginService;
import com.wondersgroup.service.empuser.RestaurantEmployeeService;
import com.wondersgroup.util.EncodeUtils;

public class DTOLoginUserUpdate {
	private Integer id;
	private String username;
	private String password;
	private String personName;//姓名
	private String mobilePhone;//手机
	private String phone;//电话
	private String email;//邮箱
	private String jobRole; //岗位
	private Integer enabled;  //不修改这个值 ，就传null
	private Integer hasAppMgrPermission;//是否开通APP权限
	private Integer personId; //从业人员id

	private static void toComEmployee(DTOLoginUserUpdate dto,ComEmployee emp, String personType) {
		if (dto != null && emp!=null) {
			emp.setPersonType(personType);
			Date now = new Date();
//			emp.setCreateDate(now);
			emp.setLastModifiedDate(now);
			emp.setEmail(dto.getEmail());
			emp.setPhone(dto.getPhone());
			emp.setMobilePhone(dto.getMobilePhone());
			emp.setJobRole(dto.getJobRole());
			emp.setPersonName(dto.getPersonName());
		}
	}

	public static AppLoginUser toEntity(DTOLoginUserUpdate dto,RestaurantEmployeeLoginService empLoginService,RestaurantEmployeeService restaurantEmployeeService) {
		AppLoginUser entity = null;
		if (dto != null) {
			entity = empLoginService.getAppLoginUserById(dto.getId());
			if (null==entity) {
				throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
			}
			ComEmployee emp =restaurantEmployeeService.getRestaurantEmployeeById(dto.getPersonId());
			if(emp==null){
				throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
			}
			entity.setEmp(emp);
			//用户名不为空
			String _username = dto.getUsername();
			if (StringUtils.isEmpty(_username)) {
				throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
			}
			entity.setUsername(_username);
			//密码不为空,更新密码
			String _password = dto.getPassword();
			if (StringUtils.isNotEmpty(_password)&&!_password.equals(entity.getPassword())) {
				entity.setPassword(EncodeUtils.encodePassword(_password));
			}
			if(dto.getEnabled()!=null){
				entity.setEnabled(dto.getEnabled());
			}
			entity.setCreateDate(new Date());
			if(dto.getEnabled()!=null){
				entity.setEnabled(dto.getEnabled());
			}
			entity.setHasAppMgrPermission(dto.getHasAppMgrPermission());
			entity.setUserType(AppLoginUser.TYPE_EMP);
//			ComEmployee emp = entity.getEmp();
//			toComEmployee(dto, emp, ComEmployee.TYPE_EMP);
			
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

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public Integer getEnabled() {
		return enabled;
	}

	public void setEnabled(Integer enabled) {
		this.enabled = enabled;
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
