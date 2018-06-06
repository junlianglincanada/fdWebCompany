package com.wondersgroup.operation.employee.model;

import java.util.Date;

import javax.validation.constraints.NotNull;

import org.apache.commons.lang.StringUtils;

import com.wondersgroup.data.jpa.entity.ComEmpLicence;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.util.DataDicConstant;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOComEmpLicenceCreate {
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

//    public static ComEmployee toEntity(DTOComEmpLicenceCreate dto, CompanyService companyService,int companyId) {
//    	ComEmployee entity = null;
//		if(dto!=null) {
//			entity = new ComEmployee();
//		
//				Company company = companyService.getCompanyById(companyId);
//				if (company!=null) {
//				entity.setCompany(company);
//			}
//			entity.setPersonName(dto.getPersonName());
//			entity.setJobNum(dto.getJobNum());
//			entity.setJobRole(dto.getJobRole());
//			entity.setJobDescription(dto.getJobDescription());
//			entity.setSex(dto.getSex());
//			entity.setIdType(dto.getIdType());
//			entity.setIdNumber(dto.getIdNumber());
//			entity.setOnboardDate(dto.getOnboardDate());
//			entity.setResignDate(dto.getResignDate());
//			entity.setPubVisible(dto.getPubVisible());
//			entity.setPubSortNum(dto.getPubSortNum());
//			entity.setMemo(dto.getMemo());
//			entity.setPersonType(ComEmployee.TYPE_EMP);
//			entity.setJobTitle(dto.getJobTitle());
//			entity.setPhone(dto.getPhone());
//			entity.setMobilePhone(dto.getMobilePhone());
//			entity.setEmail(dto.getEmail());
//			entity.setCreateDate(new Date());
//			entity.setStatus(FoodConstant.FIELD_STATUS_VALID);
//		}
//		return entity;
//	}
    public static ComEmpLicence toLicenceEntity(DTOComEmpLicenceCreate dto,ComEmployee entity) {
    	ComEmpLicence entityInstance=null;
        if (dto.getLicenceNum() != null) {
        	entityInstance = new ComEmpLicence();
            
            entityInstance.setLicenceType(DataDicConstant.DIC_LICENCE_TYPE_HEALTHY);
            entityInstance.setLicenceNum(dto.getLicenceNum());
            entityInstance.setLicenceName(DataDictService.getDataDicDetailNameById(DataDicConstant.DIC_LICENCE_TYPE_HEALTHY));
            if (StringUtils.isNotBlank(dto.getLicenceNumExpireDate())) {
                entityInstance.setExpireDate(TimeOrDateUtils.parseDate(dto.getLicenceNumExpireDate()));
			}
            entityInstance.setCreateDate(new Date());
            entityInstance.setLastModifiedDate(new Date());
            entityInstance.setEmp(entity);
          
        }
    	  return entityInstance;
    }
    
    public static ComEmpLicence toTrainLicenceEntity(DTOComEmpLicenceCreate dto,ComEmployee entity) {
        if (dto.getTrainLicenceNum() != null) {
            	ComEmpLicence entityInstance = new ComEmpLicence();
            
            entityInstance.setLicenceType(DataDicConstant.DIC_LICENCE_TYPE_TRIAN);
            entityInstance.setLicenceNum(dto.getTrainLicenceNum());
            entityInstance.setLicenceName(DataDictService.getDataDicDetailNameById(DataDicConstant.DIC_LICENCE_TYPE_TRIAN));
            if (StringUtils.isNotBlank(dto.getTrainLicenceNumExpireDate())) {
                entityInstance.setExpireDate(TimeOrDateUtils.parseDate(dto.getTrainLicenceNumExpireDate()));
			}
            entityInstance.setLicenceLevel(dto.getLicenceLevel());
            entityInstance.setCreateDate(new Date());
            entityInstance.setLastModifiedDate(new Date());
            entityInstance.setEmp(entity);
            return entityInstance;
        }else {
			return null;
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
