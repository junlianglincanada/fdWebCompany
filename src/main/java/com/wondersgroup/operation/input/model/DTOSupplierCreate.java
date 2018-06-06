package com.wondersgroup.operation.input.model;

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
public class DTOSupplierCreate {

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
    //工商执照到期时间
    private Date bizCertExpDate;
    //餐饮服务证号
    private String cateringCert;
    //餐饮证号到期时间
    private Date cateringCertExpDate;
    //食品流通证号
    private String foodCircuCert;
    //食品流通号到期时间
    private Date foodCircuCertExpDate;
    //食品生产证号
    private String foodProdCert;
    //食品生产号到期时间
    private Date foodProdCertExpDate;
    //食品经营证
    private String foodBusinessCert;
    //食品经营证到期时间
    private Date foodBusinessCertExpDate;
    //关联的company
    private Integer linkedCompanyId;
    //code
    @JsonDeserialize(using = QJ2BJDeserializer.class)
    private String code;
    //简称
    private String nameAbbrev;

    public DTOSupplierCreate() {

    }

    
    public static IntCompany toEntity(DTOSupplierCreate dto, Company company,Integer linkedCompanyId) {
        IntCompany entity = null;
		if (dto != null) {
            entity = new IntCompany();
            entity.setStatus(FoodConstant.FIELD_STATUS_VALID);
            entity.setCreateDate(new Date());
            entity.setType(IntCompany.COMPANY_TYPE_SUPPLIER);
            entity.setCompanyId(company.getCompanyId());
            entity.setName(dto.getName());
            entity.setBizCertNum(dto.getBizCertNum());
            entity.setBizCertExpDate(dto.getBizCertExpDate());
            entity.setCateringCert(dto.getCateringCert());
            entity.setCateringCertExpDate(dto.getCateringCertExpDate());
            entity.setFoodCircuCert(dto.getFoodCircuCert());
            entity.setFoodCircuCertExpDate(dto.getFoodCircuCertExpDate());
            entity.setContactAddress(dto.getContactAddress());
            entity.setContactPerson(dto.getContactPerson());
            entity.setContactPhone(dto.getContactPhone());
            entity.setStatus(FoodConstant.FIELD_STATUS_VALID);
            entity.setFoodProdCert(dto.getFoodProdCert());
            entity.setFoodProdCertExpDate(dto.getFoodProdCertExpDate());
            entity.setFoodBusinessCert(dto.getFoodBusinessCert());
            entity.setFoodBusinessCertExpDate(dto.getFoodBusinessCertExpDate());
            entity.setCode(dto.getCode());
            entity.setNameAbbrev(dto.getNameAbbrev());
            entity.setLinkedCompanyId(linkedCompanyId);
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

    public Date getBizCertExpDate() {
        return bizCertExpDate;
    }

    public void setBizCertExpDate(Date bizCertExpDate) {
        this.bizCertExpDate = bizCertExpDate;
    }
    
    public String getCateringCert() {
        return cateringCert;
    }

    public void setCateringCert(String cateringCert) {
        this.cateringCert = cateringCert;
    }

	public Date getCateringCertExpDate() {
		return cateringCertExpDate;
	}

	public void setCateringCertExpDate(Date cateringCertExpDate) {
		this.cateringCertExpDate = cateringCertExpDate;
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
    
	public Date getFoodCircuCertExpDate() {
		return foodCircuCertExpDate;
	}

	public void setFoodCircuCertExpDate(Date foodCircuCertExpDate) {
		this.foodCircuCertExpDate = foodCircuCertExpDate;
	}


	public String getFoodProdCert() {
		return foodProdCert;
	}


	public void setFoodProdCert(String foodProdCert) {
		this.foodProdCert = foodProdCert;
	}
	public Date getFoodProdCertExpDate() {
		return foodProdCertExpDate;
	}

	public void setFoodProdCertExpDate(Date foodProdCertExpDate) {
		this.foodProdCertExpDate = foodProdCertExpDate;
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


	public Date getFoodBusinessCertExpDate() {
		return foodBusinessCertExpDate;
	}


	public void setFoodBusinessCertExpDate(Date foodBusinessCertExpDate) {
		this.foodBusinessCertExpDate = foodBusinessCertExpDate;
	}
    
}