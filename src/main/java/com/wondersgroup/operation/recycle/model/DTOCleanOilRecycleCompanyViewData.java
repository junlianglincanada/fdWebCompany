package com.wondersgroup.operation.recycle.model;

import com.wondersgroup.data.jpa.entity.CleanOilRecycleCom;
import com.wondersgroup.framework.common.DataDictService;

public class DTOCleanOilRecycleCompanyViewData {

    private Integer id;
    private String name;
    private String address;
    private String contactPerson;
    private String phoneNum;
    private int unit;
    private String unitName;
    private Integer status;
   
    private Integer oilCleanCompanyId; //关联的油脂回收单位ID
    
    
    public static DTOCleanOilRecycleCompanyViewData createByEntity(CleanOilRecycleCom entity) {
        DTOCleanOilRecycleCompanyViewData dto = null;
        if (entity != null && entity.getCompany() != null) {
            dto = new DTOCleanOilRecycleCompanyViewData();
            dto.setId(entity.getId());
            dto.setAddress(entity.getAddress());
            dto.setContactPerson(entity.getContactPerson());
            if(entity.getOilCleanCompany()!=null){
                dto.setName(entity.getOilCleanCompany().getCompanyName());
                dto.setOilCleanCompanyId(entity.getOilCleanCompany().getCompanyId());
            }else{
                dto.setName("");
            }
            dto.setPhoneNum(entity.getPhoneNum());
            dto.setStatus(entity.getStatus());
            dto.setUnit(entity.getUnit());
            
            if(entity.getUnit() > 0){
                dto.setUnitName(DataDictService.getDataDicDetailNameById(entity.getUnit()));
            }else{
                dto.setUnitName("");
            }
        }
        return dto;
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



    public int getUnit() {
        return unit;
    }

    public void setUnit(int unit) {
        this.unit = unit;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }



    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getOilCleanCompanyId() {
        return oilCleanCompanyId;
    }

    public void setOilCleanCompanyId(Integer oilCleanCompanyId) {
        this.oilCleanCompanyId = oilCleanCompanyId;
    }

}
