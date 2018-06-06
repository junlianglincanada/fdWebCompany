
package com.wondersgroup.operation.input.model;

import java.util.ArrayList;
import java.util.List;

import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.data.jpa.entity.Restaurant;
import com.wondersgroup.data.jpa.entity.School;

/**
 *
 * @author wanglei
 */
public class DTOLinkCompanyQueryData {
    private Integer companyId;
    private String companyName = "";
    private String nameAbbrev = "";
    private String contactPerson = "";
    private String contactAddress = "";
    private String contactPhone = "";
    private String bizCertNumber = "";
    private String foodCircuCert;
    private String foodProdCert;
    private String cateringCert = "";
    private String foodBusinessCert;
    private Integer companyStatus;
	public DTOLinkCompanyQueryData() {
    }
    
    public static DTOLinkCompanyQueryData createByEntity(Company domainInstance){
    	DTOLinkCompanyQueryData dtoInstance = null;
    	if(domainInstance!=null){
            dtoInstance = new DTOLinkCompanyQueryData();
            dtoInstance.setCompanyId(domainInstance.getCompanyId());
            dtoInstance.setCompanyName(domainInstance.getCompanyName());
            if(domainInstance instanceof Restaurant){
                Restaurant restaurant = (Restaurant) domainInstance;
                dtoInstance.setNameAbbrev(restaurant.getNameAbbrev());
                dtoInstance.setContactPerson(restaurant.getContactPerson());
                dtoInstance.setContactAddress(restaurant.getCompanyAddress());
                dtoInstance.setContactPhone(restaurant.getContactPhone());
                dtoInstance.setBizCertNumber(restaurant.getBizCertNumber());
                dtoInstance.setCateringCert(restaurant.getCateringCert());
                dtoInstance.setFoodCircuCert(restaurant.getFoodCircuCert());
                dtoInstance.setFoodProdCert(restaurant.getFoodProdCert());
                dtoInstance.setFoodBusinessCert(restaurant.getFoodBusinessCert());
            }else if(domainInstance instanceof School){
                School school = (School) domainInstance;
                dtoInstance.setContactPerson(school.getContactPerson());
                dtoInstance.setContactAddress(school.getContactAddress());
                dtoInstance.setContactPhone(school.getContactPhone());
            }
            
            dtoInstance.setCompanyStatus(domainInstance.getCompanyStatus());
    	}
    	return dtoInstance;
    } 
    
    public static List<DTOLinkCompanyQueryData> createListByEntities(List<Company> domainInstanceList){
    	List<DTOLinkCompanyQueryData> list = new ArrayList<>();
    	if(domainInstanceList!=null){
            for(Company domainInstance : domainInstanceList){
                DTOLinkCompanyQueryData data = createByEntity(domainInstance);
                if(data!=null){
                    list.add(data);
                }
            }
    	}
    	return list;
    }
    
    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getBizCertNumber() {
        return bizCertNumber;
    }

    public void setBizCertNumber(String bizCertNumber) {
        this.bizCertNumber = bizCertNumber;
    }

    public String getCateringCert() {
        return cateringCert;
    }

    public void setCateringCert(String cateringCert) {
        this.cateringCert = cateringCert;
    }

    public Integer getCompanyStatus() {
        return companyStatus;
    }

    public void setCompanyStatus(Integer companyStatus) {
        this.companyStatus = companyStatus;
    }

    public String getNameAbbrev() {
        return nameAbbrev;
    }

    public void setNameAbbrev(String nameAbbrev) {
        this.nameAbbrev = nameAbbrev;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public String getContactAddress() {
        return contactAddress;
    }

    public void setContactAddress(String contactAddress) {
        this.contactAddress = contactAddress;
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

	public String getFoodBusinessCert() {
		return foodBusinessCert;
	}

	public void setFoodBusinessCert(String foodBusinessCert) {
		this.foodBusinessCert = foodBusinessCert;
	}
}
