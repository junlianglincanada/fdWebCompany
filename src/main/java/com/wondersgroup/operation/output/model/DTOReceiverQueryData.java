package com.wondersgroup.operation.output.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.data.jpa.entity.IntCompany;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.service.company.InternalCompanyService;

/**
 *
 * @author wanglei
 *
 */
public class DTOReceiverQueryData {

    private Integer id;
    private String name;
    private String contactAddress;
    private String contactPerson;
    private String contactPhone;
    //code
    private String code;
    //简称
    private String nameAbbrev;
  //内部企业关联的真实companyId
    private Integer linkedCompanyId;
    private String linkedCompanyName;
    private Integer contractFlag;

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

	public DTOReceiverQueryData() {

    }

    public static DTOReceiverQueryData createByEntity(IntCompany entity,InternalCompanyService intCompanyService,int companyId) {
        DTOReceiverQueryData dto = null;
        if (entity != null) {
            dto = new DTOReceiverQueryData();
            dto.setId(entity.getId());
            dto.setName(entity.getName());
            dto.setContactAddress(entity.getContactAddress());
            dto.setContactPerson(entity.getContactPerson());
            dto.setContactPhone(entity.getContactPhone());
            dto.setCode(entity.getCode());
            dto.setNameAbbrev(entity.getNameAbbrev());
            dto.setLinkedCompanyId(entity.getLinkedCompanyId());
            if(null!=entity.getLinkedCompanyId()&&entity.getLinkedCompanyId()>0){
            	if(intCompanyService.queryContractCompany(companyId,entity.getLinkedCompanyId(),"SUPPLIER")>0){
                	dto.setContractFlag(FoodConstant.CONTRACT_COMPANY_FLAG);
                }
            }
        }
        return dto;
    }

    public static List<DTOReceiverQueryData> createListByEntities(Collection<IntCompany> domainInstanceList,InternalCompanyService intCompanyService,int companyId) {
        List<DTOReceiverQueryData> list = new ArrayList<DTOReceiverQueryData>();
        if (domainInstanceList != null) {
            for (IntCompany domainInstance : domainInstanceList) {
                DTOReceiverQueryData data = createByEntity(domainInstance,intCompanyService,companyId);
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

	public Integer getContractFlag() {
		return contractFlag;
	}

	public void setContractFlag(Integer contractFlag) {
		this.contractFlag = contractFlag;
	}

}
