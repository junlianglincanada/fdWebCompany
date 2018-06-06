package com.wondersgroup.operation.output.model;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.data.jpa.entity.IntCompany;
import com.wondersgroup.operation.util.formatter.QJ2BJDeserializer;
import com.wondersgroup.service.company.CompanyService;
import com.wondersgroup.service.company.InternalCompanyService;

/**
 * 用于新建或更新供应商信息时与客户端进行数据交换
 *
 * @author wanglei
 *
 */
public class DTOReceiverUpdate {
	
	@NotNull
	private Integer id;

    //供应商名称
	@NotBlank
	@JsonDeserialize(using = QJ2BJDeserializer.class)
    private String name;
	
    //地址
	@NotBlank
    private String contactAddress;
	
    //联系人姓名
    private String contactPerson;
    
    //联系手机
    private String contactPhone;
    
    //工商执照号
    private String bizCertNum;
    //餐饮服务证号
    private String cateringCert;
    //食品流通证号
    private String foodCircuCert;
    //食品生产证号
    private String foodProdCert;
    //食品经营证
    private String foodBusinessCert;
    //code
    @JsonDeserialize(using = QJ2BJDeserializer.class)
    private String code;
    //简称
    private String nameAbbrev;
    
    private Integer LinkedCompanyId;

    public DTOReceiverUpdate() {

    }

    
    public static IntCompany toEntity(DTOReceiverUpdate dto, InternalCompanyService intCompanyService,CompanyService companyService) {
        IntCompany entity = null;
		if (dto != null) {
            entity = intCompanyService.getInternalCompanyById(dto.getId());
            entity.setName(dto.getName());
            entity.setBizCertNum(dto.getBizCertNum());
            entity.setCateringCert(dto.getCateringCert());
            entity.setFoodCircuCert(dto.getFoodCircuCert());
            entity.setContactAddress(dto.getContactAddress());
            entity.setContactPerson(dto.getContactPerson());
            entity.setContactPhone(dto.getContactPhone());
            entity.setFoodProdCert(dto.getFoodProdCert());
            entity.setFoodBusinessCert(dto.getFoodBusinessCert());
            entity.setCode(dto.getCode());
            entity.setNameAbbrev(dto.getNameAbbrev());
            
            if(dto.getLinkedCompanyId()!=null){
            	Company newLinkCom = companyService.getCompanyById(dto.getLinkedCompanyId());
        		entity.setLinkedCompany(newLinkCom);
        		entity.setLinkedCompanyId(newLinkCom.getCompanyId());
            }
        }
        return entity;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    public String getBizCertNum() {
        return bizCertNum;
    }

    public void setBizCertNum(String bizCertNum) {
        this.bizCertNum = bizCertNum;
    }

    public String getCateringCert() {
        return cateringCert;
    }

    public void setCateringCert(String cateringCert) {
        this.cateringCert = cateringCert;
    }

    public String getContactAddress() {
        return contactAddress;
    }

    public void setContactAddress(String contactAddress) {
        this.contactAddress = contactAddress;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getFoodCircuCert() {
        return foodCircuCert;
    }

    public void setFoodCircuCert(String foodCircuCert) {
        this.foodCircuCert = foodCircuCert;
    }


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public String getFoodProdCert() {
		return foodProdCert;
	}


	public void setFoodProdCert(String foodProdCert) {
		this.foodProdCert = foodProdCert;
	}


	public String getCode() {
		return code;
	}


	public void setCode(String code) {
		this.code = code;
	}


	public String getNameAbbrev() {
		return nameAbbrev;
	}


	public void setNameAbbrev(String nameAbbrev) {
		this.nameAbbrev = nameAbbrev;
	}


	public Integer getLinkedCompanyId() {
		return LinkedCompanyId;
	}


	public void setLinkedCompanyId(Integer linkedCompanyId) {
		LinkedCompanyId = linkedCompanyId;
	}


	public String getFoodBusinessCert() {
		return foodBusinessCert;
	}


	public void setFoodBusinessCert(String foodBusinessCert) {
		this.foodBusinessCert = foodBusinessCert;
	}
    
}
