package com.wondersgroup.operation.system.model;

import java.util.Date;

import com.wondersgroup.data.jpa.entity.SysOperator;

public class DTOSysOperator {
	
	private Integer personId;
	private String personName;
    private String jobNum;
    private int sex;
    private String sexValue;
    private String department;
    private String jobTitle;
    private String phone;
    private String email;
    private String mobilePhone;
    private Integer orderNum;
    private Integer status;
    private Date createDate;
	
	public static DTOSysOperator toDTO(SysOperator operator) {
		DTOSysOperator dto = new DTOSysOperator();
		if (operator!=null) {
			dto.setPersonId(operator.getPersonId());
			dto.setPersonName(operator.getPersonName());
			dto.setJobNum(operator.getJobNum());
	    	dto.setSex(operator.getSex());
	    	dto.setSexValue(operator.getSex()==1?"男":"女");
	    	dto.setDepartment(operator.getDepartment());
	    	dto.setJobTitle(operator.getJobTitle());
	    	dto.setPhone(operator.getPhone());
	    	dto.setEmail(operator.getEmail());
	    	dto.setMobilePhone(operator.getMobilePhone());
	    	dto.setOrderNum(operator.getOrderNum());
	    	dto.setStatus(operator.getStatus());
	    	dto.setCreateDate(operator.getCreateDate());
		}
		return dto;
	}

	public static SysOperator toEntity(SysOperator operator, DTOSysOperator dtoSysOperator) {
		if (dtoSysOperator!=null) {
			if (operator == null) {
				operator = new SysOperator();
				operator.setCreateDate(new Date());
				operator.setStatus(1);
            }
			operator.setPersonId(dtoSysOperator.getPersonId());
			operator.setPersonName(dtoSysOperator.getPersonName());
			operator.setJobNum(dtoSysOperator.getJobNum());
			operator.setSex(dtoSysOperator.getSex());
			operator.setDepartment(dtoSysOperator.getDepartment());
			operator.setJobTitle(dtoSysOperator.getJobTitle());
			operator.setPhone(dtoSysOperator.getPhone());
			operator.setEmail(dtoSysOperator.getEmail());
			operator.setMobilePhone(dtoSysOperator.getMobilePhone());
			operator.setOrderNum(dtoSysOperator.getOrderNum());
			operator.setStatus(dtoSysOperator.getStatus());
		}
		return operator;
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

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
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

	public Integer getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getSexValue() {
		return sexValue;
	}

	public void setSexValue(String sexValue) {
		this.sexValue = sexValue;
	}
	
}
