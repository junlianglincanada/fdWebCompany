package com.wondersgroup.operation.output.model;

import java.util.Date;

import org.hibernate.validator.constraints.NotBlank;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.data.jpa.entity.IntCompany;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.util.formatter.QJ2BJDeserializer;

/**
 * 用于新建或更新供应商信息时与客户端进行数据交换
 *
 * @author wanglei
 *
 */
public class DTOReceiverCreate {

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
    //关联的company
    private Integer linkedCompanyId;
    //code
    @JsonDeserialize(using = QJ2BJDeserializer.class)
    private String code;
    //简称
    private String nameAbbrev;

    public DTOReceiverCreate() {

    }

    
    public static IntCompany toEntity(DTOReceiverCreate dto, Company company,Company linkedCompany) {
        IntCompany entity = null;
		if (dto != null) {
            entity = new IntCompany();
            entity.setStatus(FoodConstant.FIELD_STATUS_VALID);
            entity.setCreateDate(new Date());
            entity.setType(IntCompany.COMPANY_TYPE_RECEIVER);
            entity.setCompanyId(company.getCompanyId());
            entity.setName(dto.getName());
            entity.setBizCertNum(dto.getBizCertNum());
            entity.setCateringCert(dto.getCateringCert());
            entity.setFoodCircuCert(dto.getFoodCircuCert());
            entity.setContactAddress(dto.getContactAddress());
            entity.setContactPerson(dto.getContactPerson());
            entity.setContactPhone(dto.getContactPhone());
            entity.setStatus(FoodConstant.FIELD_STATUS_VALID);
            entity.setFoodProdCert(dto.getFoodProdCert());
            entity.setFoodBusinessCert(dto.getFoodBusinessCert());
            if(linkedCompany!=null){
            	entity.setLinkedCompany(linkedCompany);
            	entity.setLinkedCompanyId(linkedCompany.getCompanyId());
            }
            entity.setCode(dto.getCode());
            entity.setNameAbbrev(dto.getNameAbbrev());
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


	public String getFoodProdCert() {
		return foodProdCert;
	}


	public void setFoodProdCert(String foodProdCert) {
		this.foodProdCert = foodProdCert;
	}


	public Integer getLinkedCompanyId() {
		return linkedCompanyId;
	}


	public void setLinkedCompanyId(Integer linkedCompanyId) {
		this.linkedCompanyId = linkedCompanyId;
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


	public String getFoodBusinessCert() {
		return foodBusinessCert;
	}


	public void setFoodBusinessCert(String foodBusinessCert) {
		this.foodBusinessCert = foodBusinessCert;
	}
    
}
