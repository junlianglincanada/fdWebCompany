package com.wondersgroup.operation.recycle.model;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.wondersgroup.data.jpa.entity.Attachment;
import com.wondersgroup.data.jpa.entity.CleanOilRecycleCom;
import com.wondersgroup.data.jpa.entity.CleanOilRecycleRecord;
import com.wondersgroup.framework.common.AttachmentService;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.FoodConstant;

public class DTOCleanOilRecycleRecordDetail {

    private Integer id;
    private BigDecimal amount;
    private String unitValue;
    private Integer unit;
    private int companyId;
    private int companyOilRecycleId;
    private String type;
    private String typeValue;
    private String recyclePerson;
    private Date createDate;
    private Integer createUser;
    private String createUserName;
    private Date recycleDate;
    
    private String oilCleanCompanyName;
    private List<DTOAttachment> dtoAttachments;

    public static DTOCleanOilRecycleRecordDetail createByEntity(CleanOilRecycleRecord entity,AttachmentService attachmentService) {
        DTOCleanOilRecycleRecordDetail dto = new DTOCleanOilRecycleRecordDetail();
        dto.setAmount(entity.getAmount());
        dto.setCompanyId(entity.getCompany().getCompanyId());
        dto.setCompanyOilRecycleId(entity.getOilCompany().getId());
        dto.setId(entity.getId());
        dto.setRecyclePerson(entity.getRecyclePerson());
        dto.setCreateDate(entity.getCreateDate());
        dto.setCreateUser(entity.getCreateUser());
        dto.setCreateUserName(entity.getCreateUserName());
        dto.setRecycleDate(entity.getRecycleDate());
        Integer type = entity.getType();
        if (null != type && type > 0) {
            dto.setType(type.toString());
            String typeValue = DataDictService.getDataDicDetailNameById(type);
            dto.setTypeValue(typeValue);
        }
        dto.setUnit(entity.getUnit());
        CleanOilRecycleCom oilCleanCompany = entity.getOilCompany(); 
        if (null!=oilCleanCompany&&null!=oilCleanCompany.getCompany()) {
			dto.setOilCleanCompanyName(oilCleanCompany.getCompany().getCompanyName());
		}
        QueryResult<Attachment> queryResult = attachmentService.queryAttFile(FoodConstant.ATT_OIL_RECYCLE_RECORD, entity.getId(), null, null);
        if(null!=queryResult&&null!=queryResult.getResultList()){
        List<DTOAttachment> dtoAttachmentList = DTOAttachment.createListByEntities(queryResult.getResultList());
        dto.setDtoAttachments(dtoAttachmentList);
        }
        return dto;
    }

    public String getUnitValue() {
        return unitValue;
    }

    public void setUnitValue(String unitValue) {
        this.unitValue = unitValue;
    }

    public Integer getUnit() {
        return unit;
    }

    public void setUnit(Integer unit) {
        this.unit = unit;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Integer getCreateUser() {
        return createUser;
    }

    public void setCreateUser(Integer createUser) {
        this.createUser = createUser;
    }

    public String getCreateUserName() {
        return createUserName;
    }

    public void setCreateUserName(String createUserName) {
        this.createUserName = createUserName;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public int getCompanyId() {
        return companyId;
    }

    public void setCompanyId(int companyId) {
        this.companyId = companyId;
    }

    public int getCompanyOilRecycleId() {
        return companyOilRecycleId;
    }

    public void setCompanyOilRecycleId(int companyOilRecycleId) {
        this.companyOilRecycleId = companyOilRecycleId;
    }

    public String getTypeValue() {
        return typeValue;
    }

    public void setTypeValue(String typeValue) {
        this.typeValue = typeValue;
    }

    public String getRecyclePerson() {
        return recyclePerson;
    }

    public void setRecyclePerson(String recyclePerson) {
        this.recyclePerson = recyclePerson;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getRecycleDate() {
        return recycleDate;
    }

    public void setRecycleDate(Date recycleDate) {
        this.recycleDate = recycleDate;
    }

	public String getOilCleanCompanyName() {
		return oilCleanCompanyName;
	}

	public void setOilCleanCompanyName(String oilCleanCompanyName) {
		this.oilCleanCompanyName = oilCleanCompanyName;
	}

	public List<DTOAttachment> getDtoAttachments() {
		return dtoAttachments;
	}

	public void setDtoAttachments(List<DTOAttachment> dtoAttachments) {
		this.dtoAttachments = dtoAttachments;
	}
    
}
