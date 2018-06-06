package com.wondersgroup.operation.recycle.model;


import java.math.BigDecimal;
import java.util.Date;

import com.wondersgroup.data.jpa.entity.Attachment;
import com.wondersgroup.data.jpa.entity.CleanOilRecycleCom;
import com.wondersgroup.data.jpa.entity.CleanOilRecycleRecord;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.framework.common.AttachmentService;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.util.security.SecurityUtils;
import com.wondersgroup.service.clean.CleanService;
import com.wondersgroup.service.company.CompanyService;
import com.wondersgroup.util.TimeOrDateUtils;

/**
 *
 * @author duanjianguo
 */
public class DTOCleanOilRecycleRecord {
    private Integer id;
    private String oilCompanyName;
    private Integer type;
    private String typeValue;
    private BigDecimal amount;
    private Integer unit;
    private String unitValue;
    private String recyclePerson;
    private Date recycleDate;
    private String createDate;
    private Integer createUser;
    private String createUserName;
    private Company company;
    private Integer companyId;
    private Integer oilCompanyId;
    private int attachListSize;
    
	public static DTOCleanOilRecycleRecord toDTO(CleanOilRecycleRecord entity,AttachmentService attachmentService) {
		DTOCleanOilRecycleRecord dto = null;
		if(entity!=null){
			dto = new DTOCleanOilRecycleRecord();
			dto.setId(entity.getId());
			dto.setOilCompanyName(entity.getOilCompanyName());
			dto.setAmount(entity.getAmount());
			dto.setUnit(entity.getUnit());
			dto.setRecyclePerson(entity.getRecyclePerson());
			dto.setRecycleDate(entity.getRecycleDate());
			dto.setCreateDate(TimeOrDateUtils.formateDate(entity.getCreateDate(), "yyyy-MM-dd"));
			dto.setCreateUser(entity.getCreateUser());
			dto.setCreateUserName(entity.getCreateUserName());
			//dto.setCompany(entity.getCompany());
			Integer idType = entity.getType();
			if( idType!=null  && idType>0){
				String typleValue = DataDictService.getDataDicDetailNameById(idType);
				dto.setType(idType);
				dto.setTypeValue(typleValue);
			}
			Integer unit = entity.getUnit();
			if( unit!=null  && unit>0){
				String unitValue = DataDictService.getDataDicDetailNameById(unit);
				dto.setUnit(unit);
				dto.setUnitValue(unitValue);
			}
			
		       // 获取附件
	        QueryResult<Attachment> queryResult = attachmentService.queryAttFile(FoodConstant.ATT_OIL_RECYCLE_RECORD, entity.getId(), null, null);
	        if (queryResult != null && queryResult.getResultList() != null) {
	            dto.setAttachListSize(queryResult.getResultList().size());
	        } else {
	            dto.setAttachListSize(0);
	        }
		}
		return dto;
	}
	
	
public static CleanOilRecycleRecord toEntity(CleanOilRecycleRecord entity, DTOCleanOilRecycleRecord dto,CleanService cleanService,CompanyService companyService){
		
		if (dto!=null) {
			if (entity == null) {
				entity = new CleanOilRecycleRecord();
            }
			Integer company_id = dto.getCompanyId();
			Company company = companyService.getCompanyById(company_id);
			entity.setCompany(company);
			entity.setAmount(dto.getAmount());
			entity.setCreateDate(new Date());
			entity.setCreateUser(SecurityUtils.getCurrentUserId());
			entity.setCreateUserName(SecurityUtils.getCurrentUserRealName());
			CleanOilRecycleCom oilCompany = cleanService.getCleanOilRecycleComById(dto.getId());
			entity.setOilCompany(oilCompany);
			entity.setOilCompanyName(oilCompany.getOilCleanCompany().getCompanyName());
			entity.setRecycleDate(dto.getRecycleDate()); 
			entity.setRecyclePerson(dto.getRecyclePerson());
			entity.setType(dto.getType());
		    entity.setUnit(dto.getUnit());

		}
		return entity;
	}
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getOilCompanyName() {
		return oilCompanyName;
	}

	public void setOilCompanyName(String oilCompanyName) {
		this.oilCompanyName = oilCompanyName;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getTypeValue() {
		return typeValue;
	}

	public void setTypeValue(String typeValue) {
		this.typeValue = typeValue;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public Integer getUnit() {
		return unit;
	}

	public void setUnit(Integer unit) {
		this.unit = unit;
	}
  
	public String getUnitValue() {
		return unitValue;
	}
	public void setUnitValue(String unitValue) {
		this.unitValue = unitValue;
	}
	public String getRecyclePerson() {
		return recyclePerson;
	}

	public void setRecyclePerson(String recyclePerson) {
		this.recyclePerson = recyclePerson;
	}

	public Date getRecycleDate() {
		return recycleDate;
	}
	public void setRecycleDate(Date recycleDate) {
		this.recycleDate = recycleDate;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
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

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	
	


	public int getAttachListSize() {
		return attachListSize;
	}


	public void setAttachListSize(int attachListSize) {
		this.attachListSize = attachListSize;
	}


	public Integer getOilCompanyId() {
		return oilCompanyId;
	}
	public void setOilCompanyId(Integer oilCompanyId) {
		this.oilCompanyId = oilCompanyId;
	}


	public Integer getCompanyId() {
		return companyId;
	}


	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

}
