package com.wondersgroup.operation.recycle.model;

import com.wondersgroup.data.jpa.entity.CleanOilRecycleCom;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.data.jpa.entity.OilCleanCompany;

public class DTOCleanOilRecycleCompany {

    private Integer id;
    private String address;
    private String contactPerson;
    private String phoneNum;
    private Integer oilCleanCompanyId; //关联的油脂回收单位ID

    public static CleanOilRecycleCom toEntity(CleanOilRecycleCom entityInstance, DTOCleanOilRecycleCompany dtoInstance, 
            Company company, OilCleanCompany oilCleanCompany) {
        if (dtoInstance != null) {
            if (entityInstance == null) {
                entityInstance = new CleanOilRecycleCom();
            }
            entityInstance.setCompany(company);
            if(oilCleanCompany!=null){
                entityInstance.setOilCleanCompany(oilCleanCompany);
            }

            entityInstance.setAddress(dtoInstance.getAddress());
            entityInstance.setContactPerson(dtoInstance.getContactPerson());
            entityInstance.setPhoneNum(dtoInstance.getPhoneNum());
   
                entityInstance.setUnit(13001); //油脂单位默认为L
       
            entityInstance.setStatus(1);
        }
        return entityInstance;
    }
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getOilCleanCompanyId() {
        return oilCleanCompanyId;
    }

    public void setOilCleanCompanyId(Integer oilCleanCompanyId) {
        this.oilCleanCompanyId = oilCleanCompanyId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }


    
}
