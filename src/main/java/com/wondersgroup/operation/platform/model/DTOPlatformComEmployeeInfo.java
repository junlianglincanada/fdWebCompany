package com.wondersgroup.operation.platform.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.wondersgroup.data.jpa.entity.ComEmpLicence;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.DataDicConstant;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.service.empuser.RestaurantEmployeeService;
import com.wondersgroup.util.StringUtils;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOPlatformComEmployeeInfo {

	private String personName;
	private String sex;
	private String idType;
	private String idNumber;
	private String mobilePhone;
	private String jobRole;
	private String jobNum;
	private String healthLicenceNum;
	private String healthLicenceNumExpireDate;
	private String trainLicenceNum;
	private String trainLicenceLevel;
	private String trainLicenceNumExpireDate;
	static Map<String, Integer> idTypeMap = DataDictService.getDataDicDetailName2IdMap(DataDicConstant.DIC_COMPANY_EMPLOYEE_IDCARD_TYPE);
	static Map<String, Integer> trainLicenceLevelMap = DataDictService.getDataDicDetailName2IdMap(DataDicConstant.DIC_COMPANY_EMPLOYEE_CREDENTIALS_GRADE);
	static Map<String, Integer> jobRoleMap = DataDictService.getDataDicDetailName2IdMap(DataDicConstant.DIC_COMPANY_EMPLOYEE_ROLE_TYPE);
	static Map<String, Integer> sexlMap=new HashMap<String, Integer>(){{
		put("男", 1);
		put("女", 0);
	}};
	public static ComEmployee createComEmployeeByJSON(JSONObject employee,Company company,RestaurantEmployeeService restaurantEmployeeService) throws Exception{
		ComEmployee entity = null;
		if(employee != null && company != null){
			DTOPlatformComEmployeeInfo dto = (DTOPlatformComEmployeeInfo)JSONObject.toBean(employee, DTOPlatformComEmployeeInfo.class);
			Integer sexVal = sexlMap.get(dto.getSex());
			Integer idTypeVal = idTypeMap.get(dto.getIdType());
			if(sexVal == null || sexVal <0 || idTypeVal == null || idTypeVal <0){
				throw FoodException.returnException("116029");
			}
			ComEmployee comEmployee = restaurantEmployeeService.getComEmployee(company.getCompanyId(), idTypeVal, dto.getIdNumber(), true, null);
			if(comEmployee != null){
				entity = comEmployee;
			}else{
				entity = new ComEmployee();
				entity.setCreateDate(new Date());
			}
			entity.setCompany(company);
			entity.setPersonName(dto.getPersonName());
			entity.setSex(sexVal);
			entity.setIdType(idTypeVal);
			entity.setIdNumber(dto.getIdNumber());
			entity.setMobilePhone(dto.getMobilePhone());
			if(StringUtils.isNotBlank(dto.getJobRole())){
				Integer jobRoleVal = jobRoleMap.get(dto.getJobRole());
				if(jobRoleVal == null || jobRoleVal <0){
					throw FoodException.returnException("116029");
				}
				entity.setJobRole(dto.getJobRole());
			}
			entity.setJobNum(dto.getJobNum());
			entity.setStatus(FoodConstant.FIELD_STATUS_VALID);
			entity.setPersonType(ComEmployee.TYPE_EMP);
			List<ComEmpLicence> list = new ArrayList<ComEmpLicence>();
			if(StringUtils.isNotBlank(dto.getHealthLicenceNum())){
				ComEmpLicence cel = null;
				if(comEmployee != null){
					for(ComEmpLicence instance:entity.getComEmpLicenceList()){
						if(instance.getLicenceType()==DataDicConstant.DIC_LICENCE_TYPE_HEALTHY){
							cel=instance;
						}
					}
				}else{
					cel = new ComEmpLicence();
					cel.setEmp(entity);
					cel.setCreateDate(new Date());
				}
				cel.setLicenceName(DataDictService.getDataDicDetailNameById(DataDicConstant.DIC_LICENCE_TYPE_HEALTHY));
				cel.setLicenceNum(dto.getHealthLicenceNum());
				cel.setLicenceType(DataDicConstant.DIC_LICENCE_TYPE_HEALTHY);
				cel.setLastModifiedDate(new Date());
				if(StringUtils.isNotBlank(dto.getHealthLicenceNumExpireDate())){
					Date expireDate = TimeOrDateUtils.parseDate(dto.getHealthLicenceNumExpireDate());
					if(expireDate == null){
						throw FoodException.returnException("116029");
					}
					cel.setExpireDate(expireDate);
				}
				list.add(cel);
			}
			if(StringUtils.isNotBlank(dto.getTrainLicenceNum())){
				ComEmpLicence cel = null;
				if(comEmployee != null){
					for(ComEmpLicence instance:entity.getComEmpLicenceList()){
						if(instance.getLicenceType()==DataDicConstant.DIC_LICENCE_TYPE_TRIAN){
							cel=instance;
						}
					}
				}else{
					cel = new ComEmpLicence();
					cel.setEmp(entity);
					cel.setCreateDate(new Date());
				}
				cel.setLicenceName(DataDictService.getDataDicDetailNameById(DataDicConstant.DIC_LICENCE_TYPE_TRIAN));
				cel.setLicenceNum(dto.getHealthLicenceNum());
				cel.setLicenceType(DataDicConstant.DIC_LICENCE_TYPE_TRIAN);
				cel.setLastModifiedDate(new Date());
				if(StringUtils.isNotBlank(dto.getTrainLicenceLevel())){
					Integer trainLevel = trainLicenceLevelMap.get(dto.getTrainLicenceLevel());
					if(trainLevel == null || trainLevel<0){
						throw FoodException.returnException("116029");
					}
					cel.setLicenceLevel(trainLevel);
				}
				if(StringUtils.isNotBlank(dto.getTrainLicenceNumExpireDate())){
					Date expireDate = TimeOrDateUtils.parseDate(dto.getTrainLicenceNumExpireDate());
					if(expireDate == null){
						throw FoodException.returnException("116029");
					}
					cel.setExpireDate(expireDate);
				}
				cel.setEmp(entity);
				list.add(cel);
			}
			entity.setComEmpLicenceList(list);
		}
		return entity;
	}
	public String getPersonName() {
		return personName;
	}
	public void setPersonName(String personName) {
		this.personName = personName;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getIdType() {
		return idType;
	}
	public void setIdType(String idType) {
		this.idType = idType;
	}
	public String getIdNumber() {
		return idNumber;
	}
	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}
	public String getMobilePhone() {
		return mobilePhone;
	}
	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}
	public String getJobRole() {
		return jobRole;
	}
	public void setJobRole(String jobRole) {
		this.jobRole = jobRole;
	}
	public String getJobNum() {
		return jobNum;
	}
	public void setJobNum(String jobNum) {
		this.jobNum = jobNum;
	}
	public String getHealthLicenceNum() {
		return healthLicenceNum;
	}
	public void setHealthLicenceNum(String healthLicenceNum) {
		this.healthLicenceNum = healthLicenceNum;
	}
	public String getHealthLicenceNumExpireDate() {
		return healthLicenceNumExpireDate;
	}
	public void setHealthLicenceNumExpireDate(String healthLicenceNumExpireDate) {
		this.healthLicenceNumExpireDate = healthLicenceNumExpireDate;
	}
	public String getTrainLicenceNum() {
		return trainLicenceNum;
	}
	public void setTrainLicenceNum(String trainLicenceNum) {
		this.trainLicenceNum = trainLicenceNum;
	}
	public String getTrainLicenceLevel() {
		return trainLicenceLevel;
	}
	public void setTrainLicenceLevel(String trainLicenceLevel) {
		this.trainLicenceLevel = trainLicenceLevel;
	}
	public String getTrainLicenceNumExpireDate() {
		return trainLicenceNumExpireDate;
	}
	public void setTrainLicenceNumExpireDate(String trainLicenceNumExpireDate) {
		this.trainLicenceNumExpireDate = trainLicenceNumExpireDate;
	}
}
