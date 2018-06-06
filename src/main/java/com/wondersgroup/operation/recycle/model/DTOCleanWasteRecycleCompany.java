package com.wondersgroup.operation.recycle.model;

import com.wondersgroup.data.jpa.entity.CleanWasteRecycleCom;
import com.wondersgroup.data.jpa.entity.Company;

public class DTOCleanWasteRecycleCompany {

    private Integer id;
    private String name;
    private String address;
    private String contactPerson;
    private String phoneNum;

    
    public static DTOCleanWasteRecycleCompany createByEntity(CleanWasteRecycleCom entity) {
        DTOCleanWasteRecycleCompany dto = null;
        if (entity != null && entity.getCompany() != null) {
            dto = new DTOCleanWasteRecycleCompany();
            dto.setId(entity.getId());
            dto.setAddress(entity.getAddress());
            dto.setContactPerson(entity.getContactPerson());
            dto.setName(entity.getName());
            dto.setPhoneNum(entity.getPhoneNum());
  
        }
        return dto;
    }

    public static CleanWasteRecycleCom toEntity(CleanWasteRecycleCom entityInstance, DTOCleanWasteRecycleCompany dtoInstance, Company company) {
        if (dtoInstance != null) {
            if (entityInstance == null) {
                entityInstance = new CleanWasteRecycleCom();
            }
            entityInstance.setCompany(company);

            entityInstance.setName(dtoInstance.getName());
            entityInstance.setAddress(dtoInstance.getAddress());
            entityInstance.setContactPerson(dtoInstance.getContactPerson());
            entityInstance.setPhoneNum(dtoInstance.getPhoneNum());
         
                entityInstance.setUnit(13004); //垃圾默认单位是桶
            
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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
