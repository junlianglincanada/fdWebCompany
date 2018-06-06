package com.wondersgroup.operation.employee.model;

import java.util.Date;

import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.service.company.CompanyService;

public class DTOComEmployeeCreate {
    private String personName;//姓名
    private String jobNum;//工号
    private String jobRole;//岗位
    private String jobDescription;//具体分工
    private Integer sex;//性别
    private Integer idType;//证件类型
    private String idNumber;//证件号码
    private Date onboardDate;//入职时间
    private Date resignDate;//离职时间
    private Integer pubVisible;//是否公示  1-公示 0-不公示
    private Integer pubSortNum;//公示排序号
    private String memo;//备注
    private String jobTitle;//职务
    private String phone;//电话
    private String email;//邮箱
    private String mobilePhone;//手机
//    

    public static ComEmployee toEntity(DTOComEmployeeCreate dto, CompanyService companyService,int companyId) {
    	ComEmployee entity = null;
		if(dto!=null) {
			entity = new ComEmployee();
		
				Company company = companyService.getCompanyById(companyId);
				if (company!=null) {
				entity.setCompany(company);
			}
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
			entity.setPersonType(ComEmployee.TYPE_EMP);
			entity.setJobTitle(dto.getJobTitle());
			entity.setPhone(dto.getPhone());
			entity.setMobilePhone(dto.getMobilePhone());
			entity.setEmail(dto.getEmail());
			entity.setCreateDate(new Date());
			entity.setStatus(FoodConstant.FIELD_STATUS_VALID);
		}
		return entity;
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
