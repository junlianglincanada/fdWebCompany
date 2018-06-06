package com.wondersgroup.operation.employee.model;

import java.util.Date;

import javax.validation.constraints.NotNull;

import org.apache.commons.lang.StringUtils;

import com.wondersgroup.data.jpa.entity.ComEmpLicence;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.DataDicConstant;
import com.wondersgroup.service.empuser.RestaurantEmployeeService;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOComEmpLicenceUpdate {
	@NotNull
	private Integer personId;
	//健康证号
	private String licenceNum;
	//到期日期
	private String licenceNumExpireDate;
	//培训证
	private String trainLicenceNum;
	//到期日期
	private String trainLicenceNumExpireDate;
	//培训证等级
	private Integer licenceLevel;


	public static ComEmpLicence toLicenceEntity(DTOComEmpLicenceUpdate dto,RestaurantEmployeeService restaurantEmployeeService) {
		QueryResult<ComEmpLicence> licenceQr = restaurantEmployeeService.queryComEmpLicenceByCompanyEmpId(dto.getPersonId(), DataDicConstant.DIC_LICENCE_TYPE_HEALTHY, null, null, -1, -1);
		ComEmpLicence entityInstance =null;
		if (null!=licenceQr&&licenceQr.getResultList().size()>0) {
			entityInstance=licenceQr.getResultList().get(0);
			entityInstance.setLastModifiedDate(new Date());
			entityInstance.setLicenceType(DataDicConstant.DIC_LICENCE_TYPE_HEALTHY);
			entityInstance.setLicenceName(DataDictService.getDataDicDetailNameById(DataDicConstant.DIC_LICENCE_TYPE_HEALTHY));
			entityInstance.setLicenceNum(dto.getLicenceNum());
			if (StringUtils.isNotBlank(dto.getLicenceNumExpireDate())) {
				entityInstance.setExpireDate(TimeOrDateUtils.parseDate(dto.getLicenceNumExpireDate()));
			}else{
				entityInstance.setExpireDate(null);
			}
			return entityInstance;
		}else {
			entityInstance=new ComEmpLicence();
			entityInstance.setLastModifiedDate(new Date());
			entityInstance.setCreateDate(new Date());
			entityInstance.setLicenceType(DataDicConstant.DIC_LICENCE_TYPE_HEALTHY);
			entityInstance.setLicenceName(DataDictService.getDataDicDetailNameById(DataDicConstant.DIC_LICENCE_TYPE_HEALTHY));
			entityInstance.setLicenceNum(dto.getLicenceNum());
			if (StringUtils.isNotBlank(dto.getLicenceNumExpireDate())) {
				entityInstance.setExpireDate(TimeOrDateUtils.parseDate(dto.getLicenceNumExpireDate()));
			}else{
				entityInstance.setExpireDate(null);
			}
			return entityInstance;
	}

}

public static ComEmpLicence toTrainLicenceEntity(DTOComEmpLicenceUpdate dto,RestaurantEmployeeService restaurantEmployeeService) {
		QueryResult<ComEmpLicence> licenceQr = restaurantEmployeeService.queryComEmpLicenceByCompanyEmpId(dto.getPersonId(), DataDicConstant.DIC_LICENCE_TYPE_TRIAN, null, null, -1, -1);
		ComEmpLicence entityInstance =null;
		if (null!=licenceQr&&licenceQr.getResultList().size()>0) {
			entityInstance=licenceQr.getResultList().get(0);
			entityInstance.setLastModifiedDate(new Date());
			entityInstance.setLicenceType(DataDicConstant.DIC_LICENCE_TYPE_TRIAN);
			entityInstance.setLicenceName(DataDictService.getDataDicDetailNameById(DataDicConstant.DIC_LICENCE_TYPE_TRIAN));
			entityInstance.setLicenceNum(dto.getTrainLicenceNum());
			if(!StringUtils.isEmpty(dto.getTrainLicenceNum())){
				entityInstance.setLicenceLevel(dto.getLicenceLevel());
			}else{
				entityInstance.setLicenceLevel(null);
			}
			if (StringUtils.isNotBlank(dto.getTrainLicenceNumExpireDate())) {
				entityInstance.setExpireDate(TimeOrDateUtils.parseDate(dto.getTrainLicenceNumExpireDate()));
			}else{
				entityInstance.setExpireDate(null);
			}
			return entityInstance;
		}else {
			entityInstance=new ComEmpLicence();
			entityInstance.setLastModifiedDate(new Date());
			entityInstance.setCreateDate(new Date());
			entityInstance.setLicenceType(DataDicConstant.DIC_LICENCE_TYPE_TRIAN);
			entityInstance.setLicenceName(DataDictService.getDataDicDetailNameById(DataDicConstant.DIC_LICENCE_TYPE_TRIAN));
			entityInstance.setLicenceNum(dto.getTrainLicenceNum());
			if(!StringUtils.isEmpty(dto.getTrainLicenceNum())){
				entityInstance.setLicenceLevel(dto.getLicenceLevel());
			}else{
				entityInstance.setLicenceLevel(null);
			}
			
			if (StringUtils.isNotBlank(dto.getTrainLicenceNumExpireDate())) {
				entityInstance.setExpireDate(TimeOrDateUtils.parseDate(dto.getTrainLicenceNumExpireDate()));
			}else{
				entityInstance.setExpireDate(null);
			}
			return entityInstance;
	}

}
public Integer getPersonId() {
	return personId;
}
public void setPersonId(Integer personId) {
	this.personId = personId;
}
public String getLicenceNum() {
	return licenceNum;
}
public void setLicenceNum(String licenceNum) {
	this.licenceNum = licenceNum;
}

public String getTrainLicenceNum() {
	return trainLicenceNum;
}
public void setTrainLicenceNum(String trainLicenceNum) {
	this.trainLicenceNum = trainLicenceNum;
}

public Integer getLicenceLevel() {
	return licenceLevel;
}
public void setLicenceLevel(Integer licenceLevel) {
	this.licenceLevel = licenceLevel;
}

public String getLicenceNumExpireDate() {
	return licenceNumExpireDate;
}

public void setLicenceNumExpireDate(String licenceNumExpireDate) {
	this.licenceNumExpireDate = licenceNumExpireDate;
}

public String getTrainLicenceNumExpireDate() {
	return trainLicenceNumExpireDate;
}

public void setTrainLicenceNumExpireDate(String trainLicenceNumExpireDate) {
	this.trainLicenceNumExpireDate = trainLicenceNumExpireDate;
}


}
