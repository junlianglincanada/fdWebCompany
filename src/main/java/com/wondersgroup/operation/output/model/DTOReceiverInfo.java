package com.wondersgroup.operation.output.model;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.data.jpa.entity.IntCompany;

/**
 * 用于新建或更新供应商信息时与客户端进行数据交换
 *
 * @author wanglei
 *
 */
public class DTOReceiverInfo {
	
	@NotNull
	private Integer id;

    //供应商名称
	@NotBlank
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
    private String code;
    //简称
    private String nameAbbrev;
    
    
    //内部企业关联的真实companyId
    private Integer linkedCompanyId;
    private String linkedCompanyName;
    
    
    public DTOReceiverInfo() {

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



	public static DTOReceiverInfo createByEntity(IntCompany entity) {
		DTOReceiverInfo dto = null;
		if(entity!=null){
			dto = new DTOReceiverInfo();
			dto.setId(entity.getId());
			dto.setName(entity.getName());
			dto.setBizCertNum(entity.getBizCertNum());
			dto.setCateringCert(entity.getCateringCert());
			dto.setContactAddress(entity.getContactAddress());
			dto.setContactPerson(entity.getContactPerson());
			dto.setContactPhone(entity.getContactPhone());
			dto.setFoodCircuCert(entity.getFoodCircuCert());
			dto.setFoodProdCert(entity.getFoodProdCert());
			dto.setFoodBusinessCert(entity.getFoodBusinessCert());
			dto.setCode(entity.getCode());
			dto.setNameAbbrev(entity.getNameAbbrev());
			
			
			Company linkedCompany = entity.getLinkedCompany();
			if(linkedCompany!=null){
				dto.setLinkedCompanyId(linkedCompany.getCompanyId());
				dto.setLinkedCompanyName(linkedCompany.getCompanyName());
			}
		}
		return dto;
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
		return linkedCompanyId;
	}



	public void setLinkedCompanyId(Integer linkedCompanyId) {
		this.linkedCompanyId = linkedCompanyId;
	}



	public String getLinkedCompanyName() {
		return linkedCompanyName;
	}



	public void setLinkedCompanyName(String linkedCompanyName) {
		this.linkedCompanyName = linkedCompanyName;
	}



	public String getFoodBusinessCert() {
		return foodBusinessCert;
	}



	public void setFoodBusinessCert(String foodBusinessCert) {
		this.foodBusinessCert = foodBusinessCert;
	}
    
}
