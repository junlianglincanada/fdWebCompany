package com.wondersgroup.operation.recycle.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.CleanOilRecycleCom;
import com.wondersgroup.data.jpa.entity.CleanWasteRecycleCom;

public class DTORecycleCompany {
	
	private Integer id;
	private String name;
    private String address;
    private String contactPerson;
    private String phoneNum;

    
    private Integer oilCleanCompanyId; //关联的油脂回收单位ID
	
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
	
	
	public static List<DTORecycleCompany> createListByEntities(Collection<CleanWasteRecycleCom> domainInstanceList){
    	List<DTORecycleCompany> list = null;
    	if(domainInstanceList!=null){
    		list = new ArrayList<DTORecycleCompany>();
    		for(CleanWasteRecycleCom domainInstance : domainInstanceList){
    			DTORecycleCompany data = createByEntity(domainInstance);
    			if(data!=null){
    				list.add(data);
    			}
    		}
    	}
    	return list;
    }
	
	public static DTORecycleCompany createByEntity(CleanWasteRecycleCom entity) {
		DTORecycleCompany dto = null;
		if(entity != null) {
			dto = new DTORecycleCompany();
			dto.setId(entity.getId());
			dto.setName(entity.getName());
			dto.setAddress(entity.getAddress());
			dto.setContactPerson(entity.getContactPerson());
			dto.setPhoneNum(entity.getPhoneNum());
		}
		
		return dto;
	}
	public static DTORecycleCompany createByEntity(CleanOilRecycleCom entity) {
		DTORecycleCompany dto = null;
		if(entity != null) {
			dto = new DTORecycleCompany();
			dto.setId(entity.getId());
	        if(entity.getOilCleanCompany()!=null){
                dto.setName(entity.getOilCleanCompany().getCompanyName());
                dto.setOilCleanCompanyId(entity.getOilCleanCompany().getCompanyId());
            }else{
                dto.setName("");
            }
	    	dto.setAddress(entity.getAddress());
			dto.setContactPerson(entity.getContactPerson());
			dto.setPhoneNum(entity.getPhoneNum());
		}
		
		return dto;
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
	public Integer getOilCleanCompanyId() {
		return oilCleanCompanyId;
	}
	public void setOilCleanCompanyId(Integer oilCleanCompanyId) {
		this.oilCleanCompanyId = oilCleanCompanyId;
	}
	
	
}
