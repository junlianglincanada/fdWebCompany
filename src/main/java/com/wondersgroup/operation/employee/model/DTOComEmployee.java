package com.wondersgroup.operation.employee.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.service.company.CompanyService;

public class DTOComEmployee  {
	private Integer personId;
    private String personName;
    private String personType;
    private String jobRole;
    //private String jobRoleValue;
    private String jobDescription;
    private String jobNum;
    private Integer sex;
    private String sexValue;
    private Integer idType;
    private String idTypeValue;
    private String idNumber;
    private String memo;
    private Date onboardDate;
    private Date resignDate;
    
    private Integer pubVisible;
    private String pubVisibleValue;
    private Integer pubSortNum;
    
    private Integer companyId;
    private String companyName;
    private String workLoc;
    private String phone;
    private String jobTitle;
    private String email;
    private String mobilePhone;
    

	public static List<DTOComEmployee> createListByEntities(
			Collection<ComEmployee> resultList) {
		List<DTOComEmployee> list = null;
    	if(resultList!=null){
    		list = new ArrayList<DTOComEmployee>();
    		for(ComEmployee entity : resultList){
    			DTOComEmployee data = toDTO(entity);
    			if(data!=null){
    				list.add(data);
    			}
    		}
    	}
    	return list;
	}
    
    
	public static DTOComEmployee toDTO(ComEmployee comEmployee) {
		DTOComEmployee otdObject = new DTOComEmployee();
		otdObject.setPersonId(comEmployee.getPersonId());
		otdObject.setPersonName(comEmployee.getPersonName());
		String jobRole = comEmployee.getJobRole();
		if(!StringUtils.isEmpty(jobRole)){
			//String jobRoleValue = DataDicConstant.getDataDicDetailNameById(Integer.parseInt(jobRole));
			otdObject.setJobRole(comEmployee.getJobRole());
			//otdObject.setJobRoleValue(jobRoleValue);
		}
		
		otdObject.setJobDescription(comEmployee.getJobDescription());
		otdObject.setJobNum(comEmployee.getJobNum());
		Integer sex = comEmployee.getSex();
		if(sex!=null){
			otdObject.setSex(sex);
			otdObject.setSexValue(sex==1?"男":"女");
		}
		
		otdObject.setSex(comEmployee.getSex());
		
		Integer idType = comEmployee.getIdType();
		if( idType!=null  && idType>0){
			String typleValue = DataDictService.getDataDicDetailNameById(idType);
			otdObject.setIdType(idType);
			otdObject.setIdTypeValue(typleValue);
		}
		otdObject.setIdNumber(comEmployee.getIdNumber());
		
		otdObject.setOnboardDate(comEmployee.getOnboardDate());
		otdObject.setResignDate(comEmployee.getResignDate());
		
		Integer visible = comEmployee.getPubVisible();
		if(visible!=null){
			otdObject.setPubVisible(visible);
			otdObject.setPubVisibleValue(visible==1?"是":"否");
		}
		
		otdObject.setPubSortNum(comEmployee.getPubSortNum());
		
		Company company = comEmployee.getCompany();
		if (company!=null) {
			otdObject.setCompanyId(company.getCompanyId());
			otdObject.setCompanyName(company.getCompanyName());
		}
		otdObject.setWorkLoc(comEmployee.getWorkLoc());
		otdObject.setPhone(comEmployee.getPhone());
		otdObject.setJobTitle(comEmployee.getJobTitle());
		otdObject.setEmail(comEmployee.getEmail());
		otdObject.setMobilePhone(comEmployee.getMobilePhone());
		return otdObject;
	}
	
	public static ComEmployee toEntity(ComEmployee comEmployeeEntity, DTOComEmployee dtoComEmployee, CompanyService companyService){
		if (dtoComEmployee!=null) {
			
			if (comEmployeeEntity == null) {
				comEmployeeEntity = new ComEmployee();
				comEmployeeEntity.setPersonType(ComEmployee.TYPE_EMP);
				comEmployeeEntity.setCreateDate(new Date());
            }
			comEmployeeEntity.setPersonId(dtoComEmployee.getPersonId());
			String personName = dtoComEmployee.getPersonName();
			if (!StringUtils.isEmpty(personName)) {
				comEmployeeEntity.setPersonName(personName);
			}
			comEmployeeEntity.setJobRole(dtoComEmployee.getJobRole());
			comEmployeeEntity.setJobDescription(dtoComEmployee.getJobDescription());
			comEmployeeEntity.setJobNum(dtoComEmployee.getJobNum());
			comEmployeeEntity.setSex(dtoComEmployee.getSex());
			
			comEmployeeEntity.setIdType(dtoComEmployee.getIdType());
			comEmployeeEntity.setIdNumber(dtoComEmployee.getIdNumber());
			comEmployeeEntity.setMemo(dtoComEmployee.getMemo());
			comEmployeeEntity.setOnboardDate(dtoComEmployee.getOnboardDate());
			comEmployeeEntity.setResignDate(dtoComEmployee.getResignDate());
			comEmployeeEntity.setPubVisible(dtoComEmployee.getPubVisible());
			comEmployeeEntity.setPubSortNum(dtoComEmployee.getPubSortNum());
			
			Integer companyId = dtoComEmployee.getCompanyId();
			if(null!=companyId){
				Company company = companyService.getCompanyById(companyId);
				comEmployeeEntity.setCompany(company);
			}
			comEmployeeEntity.setWorkLoc(dtoComEmployee.getWorkLoc()!=null?dtoComEmployee.getWorkLoc():"");
			comEmployeeEntity.setPhone(dtoComEmployee.getPhone()!=null?dtoComEmployee.getPhone():"");
			comEmployeeEntity.setJobTitle(dtoComEmployee.getJobTitle()!=null?dtoComEmployee.getJobTitle():"");
			comEmployeeEntity.setEmail(dtoComEmployee.getEmail()!=null?dtoComEmployee.getEmail():"");
			comEmployeeEntity.setMobilePhone(dtoComEmployee.getMobilePhone()!=null?dtoComEmployee.getMobilePhone():"");
		}
		return comEmployeeEntity;
		
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

	public String getIdTypeValue() {
		return idTypeValue;
	}

	public void setIdTypeValue(String idTypeValue) {
		this.idTypeValue = idTypeValue;
	}

	public String getIdNumber() {
		return idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}

	public String getJobRole() {
		return jobRole;
	}

	public void setJobRole(String jobRole) {
		this.jobRole = jobRole;
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

	public String getJobDescription() {
		return jobDescription;
	}

	public void setJobDescription(String jobDescription) {
		this.jobDescription = jobDescription;
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

	public String getPubVisibleValue() {
		return pubVisibleValue;
	}

	public void setPubVisibleValue(String pubVisibleValue) {
		this.pubVisibleValue = pubVisibleValue;
	}

	public String getSexValue() {
		return sexValue;
	}

	public void setSexValue(String sexValue) {
		this.sexValue = sexValue;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getPersonType() {
		return personType;
	}

	public void setPersonType(String personType) {
		this.personType = personType;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	public String getWorkLoc() {
		return workLoc;
	}

	public void setWorkLoc(String workLoc) {
		this.workLoc = workLoc;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getJobTitle() {
		return jobTitle;
	}

	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
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
