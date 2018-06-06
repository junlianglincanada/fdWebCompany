package com.wondersgroup.operation.recycle.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.OilCleanCompany;

/**
 *
 * @author wanglei
 */
public class DTOOilCleanCompanyListData {
    private Integer id;
    private String companyName;
    private String companyAddress;
    private String contactPerson;
    private String phoneNum;

    public static DTOOilCleanCompanyListData createByEntity(OilCleanCompany domainInstance) {
        DTOOilCleanCompanyListData dtoInstance = null;
        if (domainInstance != null) {
            dtoInstance = new DTOOilCleanCompanyListData();
            dtoInstance.setId(domainInstance.getCompanyId());
            dtoInstance.setCompanyName(domainInstance.getCompanyName());
            dtoInstance.setCompanyAddress(domainInstance.getCompanyAddress());
            dtoInstance.setContactPerson(domainInstance.getContactPerson());
            dtoInstance.setPhoneNum(domainInstance.getPhoneNum());
        }
        return dtoInstance;
    }
    
	public static List<DTOOilCleanCompanyListData> createListByEntities(Collection<OilCleanCompany> domainInstanceList) {
        List<DTOOilCleanCompanyListData> list = null;
        if (domainInstanceList != null) {
            list = new ArrayList<>();
            for (OilCleanCompany domainInstance : domainInstanceList) {
                DTOOilCleanCompanyListData data = createByEntity(domainInstance);
                if (data != null) {
                    list.add(data);
                }
            }
        }
        return list;
    }
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getCompanyAddress() {
        return companyAddress;
    }

    public void setCompanyAddress(String companyAddress) {
        this.companyAddress = companyAddress;
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
