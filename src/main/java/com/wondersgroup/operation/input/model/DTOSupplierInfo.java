package com.wondersgroup.operation.input.model;

import java.util.Date;

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
public class DTOSupplierInfo {
	
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
    //code
    private String code;
    //简称
    private String nameAbbrev;
    
    
    //内部企业关联的真实companyId
    private Integer linkedCompanyId;
    private String linkedCompanyName;
    

    public DTOSupplierInfo() {

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
	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}



	public static DTOSupplierInfo createByEntity(IntCompany entity) {
		DTOSupplierInfo dto = null;
		if(entity!=null){
			dto = new DTOSupplierInfo();
			dto.setId(entity.getId());
			dto.setName(entity.getName());
			dto.setBizCertNum(entity.getBizCertNum());
			dto.setBizCertExpDate(entity.getBizCertExpDate());
			dto.setCateringCert(entity.getCateringCert());
			dto.setCateringCertExpDate(entity.getCateringCertExpDate());
			dto.setContactAddress(entity.getContactAddress());
			dto.setContactPerson(entity.getContactPerson());
			dto.setContactPhone(entity.getContactPhone());
			dto.setFoodCircuCert(entity.getFoodCircuCert());
			dto.setFoodCircuCertExpDate(entity.getFoodCircuCertExpDate());
			dto.setFoodProdCert(entity.getFoodProdCert());
			dto.setFoodProdCertExpDate(entity.getFoodProdCertExpDate());
			dto.setFoodBusinessCert(entity.getFoodBusinessCert());
			dto.setFoodBusinessCertExpDate(entity.getFoodBusinessCertExpDate());
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

	public Date getFoodProdCertExpDate() {
		return foodProdCertExpDate;
	}

	public void setFoodProdCertExpDate(Date foodProdCertExpDate) {
		this.foodProdCertExpDate = foodProdCertExpDate;
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



	public Date getFoodBusinessCertExpDate() {
		return foodBusinessCertExpDate;
	}



	public void setFoodBusinessCertExpDate(Date foodBusinessCertExpDate) {
		this.foodBusinessCertExpDate = foodBusinessCertExpDate;
	}
    
}
