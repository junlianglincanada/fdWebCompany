package com.wondersgroup.operation.exception.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import com.wondersgroup.data.jpa.entity.ComEmpLicence;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.service.empuser.RestaurantEmployeeService;
import com.wondersgroup.util.CollectionUtils;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOComEmployeeListValue {
	private Integer personId;
	private String personName;
	private String jobTitle;
	private String jobRole;
	private String jobNum;
	private String idNumber;
	private String onboardDate;
	private String resignDate;
	private String createDate;
	private String mobilePhone;
	private String pubVisibleValue;
	private String statusValue;
	private String sex;
	private String explire;
	private String notExplire;
	private String date;
	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getExplire() {
		return explire;
	}

	public void setExplire(String explire) {
		this.explire = explire;
	}

	public String getNotExplire() {
		return notExplire;
	}

	public void setNotExplire(String notExplire) {
		this.notExplire = notExplire;
	}

	private String licenceNum;
	private Date licenceNumExpireDate;
    private String email;
	public static List<DTOComEmployeeListValue> createListByEntities(
			Collection<ComEmployee> domainInstanceList,
			RestaurantEmployeeService restaurantEmployeeService,Integer type) {
		List<DTOComEmployeeListValue> list = null;
		if (domainInstanceList != null) {
			list = new ArrayList<DTOComEmployeeListValue>();
			for (ComEmployee entity : domainInstanceList) {
				DTOComEmployeeListValue data = createByEntity(entity,
						restaurantEmployeeService,type);
				if (data != null) {
					list.add(data);
				}
			}	
		}
		return list;
	}

	private static DTOComEmployeeListValue createByEntity(ComEmployee entity,
			RestaurantEmployeeService restaurantEmployeeService,Integer Type) {
		DTOComEmployeeListValue dto = null;
		  
		if (entity != null) {
			dto = new DTOComEmployeeListValue();
			dto.setPersonId(entity.getPersonId());
			dto.setPersonName(entity.getPersonName());
			dto.setJobTitle(entity.getJobTitle());
			dto.setJobRole(entity.getJobRole());
			dto.setJobNum(entity.getJobNum());
			dto.setIdNumber(entity.getIdNumber());
			dto.setMobilePhone(entity.getMobilePhone());
			dto.setEmail(entity.getEmail());
			if (entity.getPubVisible() != null) {
				if (entity.getPubVisible() == 1) {
					dto.setPubVisibleValue("是");
				} else {
					dto.setPubVisibleValue("否");
				}
			}
			if (entity.getStatus() != null) {
				if (entity.getStatus() == 1) {
					dto.setStatusValue("是");
				} else {
					dto.setStatusValue("否");
				}
			}
			if (entity.getSex() != null) {
				if (entity.getSex() == 1) {
					dto.setSex("男");
				} else {
					dto.setSex("女");
				}

			}
			dto.setResignDate(TimeOrDateUtils.formateDate(
					entity.getResignDate(), "yyyy-MM-dd"));
			dto.setOnboardDate(TimeOrDateUtils.formateDate(
					entity.getOnboardDate(), "yyyy-MM-dd"));
			dto.setCreateDate(TimeOrDateUtils.formateDate(
					entity.getCreateDate(), "yyyy-MM-dd"));
			int Type1=Type;
			Date statusDate=new Date();
			String newDate=TimeOrDateUtils.formateDate(statusDate,TimeOrDateUtils.FULL_YMD);
			 statusDate=TimeOrDateUtils.parseDate(newDate);
			if(CollectionUtils.isNotEmpty(entity.getComEmpLicenceList())){
				ComEmpLicence comEmpLicence=null;
				for (ComEmpLicence come : entity.getComEmpLicenceList()) {

					if (come.getLicenceType()==Type1&&come.getDelFlag()!=FoodConstant.DELETE_FLAG) {

						comEmpLicence=come;
						break;
					}
				}
				if (null!=comEmpLicence) {
					dto.setLicenceNum(comEmpLicence.getLicenceNum());
					dto.setLicenceNumExpireDate(comEmpLicence.getExpireDate());
					if(comEmpLicence.getExpireDate()!=null){
						if((comEmpLicence.getExpireDate().getTime())>=statusDate.getTime()){
							dto.setDate("快过期");
						}else{
							dto.setDate("已过期");
						}
					}
				}
			}
			
			
		}
		return dto;
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

	public String getJobTitle() {
		return jobTitle;
	}

	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}

	public String getJobNum() {
		return jobNum;
	}

	public void setJobNum(String jobNum) {
		this.jobNum = jobNum;
	}

	public String getIdNumber() {
		return idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}

	public String getOnboardDate() {
		return onboardDate;
	}

	public void setOnboardDate(String onboardDate) {
		this.onboardDate = onboardDate;
	}

	public String getResignDate() {
		return resignDate;
	}

	public void setResignDate(String resignDate) {
		this.resignDate = resignDate;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getJobRole() {
		return jobRole;
	}

	public void setJobRole(String jobRole) {
		this.jobRole = jobRole;
	}

	public String getMobilePhone() {
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	public String getPubVisibleValue() {
		return pubVisibleValue;
	}

	public void setPubVisibleValue(String pubVisibleValue) {
		this.pubVisibleValue = pubVisibleValue;
	}

	public String getStatusValue() {
		return statusValue;
	}

	public void setStatusValue(String statusValue) {
		this.statusValue = statusValue;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getLicenceNum() {
		return licenceNum;
	}

	public void setLicenceNum(String licenceNum) {
		this.licenceNum = licenceNum;
	}

	public Date getLicenceNumExpireDate() {
		return licenceNumExpireDate;
	}

	public void setLicenceNumExpireDate(Date licenceNumExpireDate) {
		this.licenceNumExpireDate = licenceNumExpireDate;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
