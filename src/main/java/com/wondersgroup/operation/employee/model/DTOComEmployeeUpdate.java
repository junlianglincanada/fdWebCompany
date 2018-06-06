package com.wondersgroup.operation.employee.model;

import java.util.Date;

import com.wondersgroup.data.jpa.entity.ComEmpLicence;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.DataDicConstant;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.service.empuser.RestaurantEmployeeService;

public class DTOComEmployeeUpdate {
	private Integer personId;
    private String personName;
    private String jobNum;
    private String jobRole;
    private String jobDescription;
    private Integer sex;
    private Integer idType;
    private String idNumber;
    private Date onboardDate;
    private Date resignDate;
    private Integer pubVisible;
    private Integer pubSortNum;
    private String memo;
    private String jobTitle;
    private String phone;
    private String email;
    private String mobilePhone;
    
    
    public static ComEmployee toEntity(DTOComEmployeeUpdate dto, RestaurantEmployeeService restEmployeeService) {
    	ComEmployee entity = null;
		if(dto!=null) {
			entity = restEmployeeService.getRestaurantEmployeeById(dto.getPersonId());
			if (null!=entity) {
				entity.setPersonName(dto.getPersonName());
				entity.setJobNum(dto.getJobNum());
				entity.setJobRole(dto.getJobRole());
				entity.setJobDescription(dto.getJobDescription());
				entity.setSex(dto.getSex());
				entity.setIdType(dto.getIdType());
				entity.setIdNumber(dto.getIdNumber());
				entity.setOnboardDate(dto.getOnboardDate());
				entity.setResignDate(dto.getResignDate());
				entity.setPubVisible(dto.getPubVisible());
				entity.setPubSortNum(dto.getPubSortNum());
				entity.setMemo(dto.getMemo());
				entity.setJobTitle(dto.getJobTitle());
				entity.setPhone(dto.getPhone());
				entity.setEmail(dto.getEmail());
				entity.setMobilePhone(dto.getMobilePhone());
				entity.setStatus(FoodConstant.FIELD_STATUS_VALID);
			}

		}
		return entity;
	}

	public Integer getPersonId() {
		return personId;
	}

	public void setPersonId(Integer personId) {
		this.personId = personId;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getJobNum() {
		return jobNum;
	}

	public void setJobNum(String jobNum) {
		this.jobNum = jobNum;
	}

	public String getJobRole() {
		return jobRole;
	}

	public void setJobRole(String jobRole) {
		this.jobRole = jobRole;
	}

	public String getJobDescription() {
		return jobDescription;
	}

	public void setJobDescription(String jobDescription) {
		this.jobDescription = jobDescription;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public Integer getIdType() {
		return idType;
	}

	public void setIdType(Integer idType) {
		this.idType = idType;
	}

	public String getIdNumber() {
		return idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}

	public Date getOnboardDate() {
		return onboardDate;
	}

	public void setOnboardDate(Date onboardDate) {
		this.onboardDate = onboardDate;
	}

	public Date getResignDate() {
		return resignDate;
	}

	public void setResignDate(Date resignDate) {
		this.resignDate = resignDate;
	}

	public Integer getPubVisible() {
		return pubVisible;
	}

	public void setPubVisible(Integer pubVisible) {
		this.pubVisible = pubVisible;
	}

	public Integer getPubSortNum() {
		return pubSortNum;
	}

	public void setPubSortNum(Integer pubSortNum) {
		this.pubSortNum = pubSortNum;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getJobTitle() {
		return jobTitle;
	}

	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
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
	public String getMobilePhone() {
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}
}
