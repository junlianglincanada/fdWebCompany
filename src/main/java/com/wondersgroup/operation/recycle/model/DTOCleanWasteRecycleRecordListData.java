package com.wondersgroup.operation.recycle.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import com.wondersgroup.data.jpa.entity.Attachment;
import com.wondersgroup.data.jpa.entity.CleanWasteRecycleRecord;
import com.wondersgroup.framework.common.AttachmentService;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.FoodConstant;

public class DTOCleanWasteRecycleRecordListData {

    private Integer id;
    private Date createDate;
    private BigDecimal amount;
    private String unitValue;
    private Integer unit;
    private String recyclePerson;
    private String recycleCompanyName;
    private Integer createUser;
    private String createUserName;
    private Date recycleDate;

    private int attachListSize;
    
    private Integer isConfirm;

    public static List<DTOCleanWasteRecycleRecordListData> createListByEntities(
            Collection<CleanWasteRecycleRecord> domainInstanceList, AttachmentService attachmentService) {
        List<DTOCleanWasteRecycleRecordListData> list = new ArrayList<DTOCleanWasteRecycleRecordListData>();
        for (CleanWasteRecycleRecord wasteRecycleRecord : domainInstanceList) {
            DTOCleanWasteRecycleRecordListData obj = createByEntity(wasteRecycleRecord, attachmentService);
            if (obj != null) {
                list.add(obj);
            }
        }
        return list;
    }

    public static DTOCleanWasteRecycleRecordListData createByEntity(CleanWasteRecycleRecord entity, AttachmentService attachmentService) {
        DTOCleanWasteRecycleRecordListData dto = null;
        if (entity != null && entity.getComRecycle() != null && entity.getCompany() != null) {
            dto = new DTOCleanWasteRecycleRecordListData();
            dto.setAmount(entity.getAmount());
            dto.setId(entity.getId());
            dto.setRecyclePerson(entity.getRecyclePerson());
            dto.setUnit(entity.getUnit());
            dto.setCreateDate(entity.getCreateDate());
            dto.setCreateUser(entity.getCreateUser());
            dto.setCreateUserName(entity.getCreateUserName());
            dto.setRecycleDate(entity.getRecycleDate());
            dto.setIsConfirm(entity.getIsConfirm());
            
            String unitValue = DataDictService.getDataDicDetailNameById(entity.getUnit());
            dto.setUnitValue(unitValue);
                dto.setRecycleCompanyName(entity.getComRecycleName());
          

            // 获取附件
            QueryResult<Attachment> queryResult = attachmentService.queryAttFile(FoodConstant.ATT_WASTE_RECYCLE_RECORD, entity.getId(), null, null);
            if (queryResult != null && queryResult.getResultList() != null) {
                dto.setAttachListSize(queryResult.getResultList().size());
            } else {
                dto.setAttachListSize(0);
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

    public int getAttachListSize() {
        return attachListSize;
    }

    public void setAttachListSize(int attachListSize) {
        this.attachListSize = attachListSize;
    }


    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getRecyclePerson() {
        return recyclePerson;
    }

    public void setRecyclePerson(String recyclePerson) {
        this.recyclePerson = recyclePerson;
    }

    public String getRecycleCompanyName() {
        return recycleCompanyName;
    }

    public void setRecycleCompanyName(String recycleCompanyName) {
        this.recycleCompanyName = recycleCompanyName;
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

    public Date getRecycleDate() {
        return recycleDate;
    }

    public void setRecycleDate(Date recycleDate) {
        this.recycleDate = recycleDate;
    }

	public Integer getIsConfirm() {
		return isConfirm;
	}

	public void setIsConfirm(Integer isConfirm) {
		this.isConfirm = isConfirm;
	}
}
