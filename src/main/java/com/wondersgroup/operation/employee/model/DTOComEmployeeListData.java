package com.wondersgroup.operation.employee.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import com.wondersgroup.data.jpa.entity.ComEmpLicence;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.framework.util.DataDicConstant;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.service.empuser.RestaurantEmployeeService;
import com.wondersgroup.service.input.excel.FoodCircuCert;
import com.wondersgroup.util.CollectionUtils;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOComEmployeeListData {
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
	// 健康证号
	private String licenceNum;
	// 到期日期
	private Date licenceNumExpireDate;
    private String email;
	public static List<DTOComEmployeeListData> createListByEntities(
			Collection<ComEmployee> domainInstanceList,
			RestaurantEmployeeService restaurantEmployeeService) {
		List<DTOComEmployeeListData> list = null;
		if (domainInstanceList != null) {
			list = new ArrayList<DTOComEmployeeListData>();
			for (ComEmployee entity : domainInstanceList) {
				DTOComEmployeeListData data = createByEntity(entity,
						restaurantEmployeeService);
				if (data != null) {
					list.add(data);
				}
			}
		}
		return list;
	}

	private static DTOComEmployeeListData createByEntity(ComEmployee entity,
			RestaurantEmployeeService restaurantEmployeeService) {
		DTOComEmployeeListData dto = null;
		if (entity != null) {
			dto = new DTOComEmployeeListData();
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
             
//			QueryResult<ComEmpLicence> licenceQr = restaurantEmployeeService
//					.queryComEmpLicenceByCompanyEmpId(dto.getPersonId(),
//							DataDicConstant.DIC_LICENCE_TYPE_HEALTHY, null,
//							null, -1, -1);
//			if (null != licenceQr && licenceQr.getResultList().size() > 0) {
//				ComEmpLicence entityInstance = licenceQr.getResultList().get(0);
//				dto.setLicenceNum(entityInstance.getLicenceNum());
//				dto.setLicenceNumExpireDate(entityInstance.getExpireDate());
//			}
			if(CollectionUtils.isNotEmpty(entity.getComEmpLicenceList())){
				ComEmpLicence comEmpLicence=null;
				for (ComEmpLicence come : entity.getComEmpLicenceList()) {
					if (come.getLicenceType()==DataDicConstant.DIC_LICENCE_TYPE_HEALTHY&&come.getDelFlag()!=FoodConstant.DELETE_FLAG) {
						comEmpLicence=come;
						break;
					}
				}
				if (null!=comEmpLicence) {
					dto.setLicenceNum(comEmpLicence.getLicenceNum());
					dto.setLicenceNumExpireDate(comEmpLicence.getExpireDate());
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
