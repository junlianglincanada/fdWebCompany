package com.wondersgroup.operation.recycle.model;

import java.math.BigDecimal;

import org.apache.commons.lang.StringUtils;

import com.wondersgroup.data.jpa.entity.CleanOilRecycleCom;
import com.wondersgroup.data.jpa.entity.CleanOilRecycleRecord;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.service.clean.CleanService;
import com.wondersgroup.service.company.RestaurantService;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOCleanOilRecycleRecordUpdate {

    private Integer id;
    private BigDecimal amount;
    private String unitValue;
    private Integer unit;
    private int companyOilRecycleId;
    private String type;
    private String typeValue;
    private String recyclePerson;
    private String recycleDate;

    public static CleanOilRecycleRecord toEntity(DTOCleanOilRecycleRecordUpdate dto, Integer loginCompanyId, CleanService cleanService,
            RestaurantService restaurantService) {
        CleanOilRecycleRecord entity = cleanService.getCleanOilRecycleRecordById(dto.getId());
        if (entity != null) {
            entity.setAmount(dto.getAmount());
            Company company = restaurantService.getRestaurantById(loginCompanyId);
            entity.setCompany(company);
            Integer oildCompanyId = dto.getCompanyOilRecycleId();
            CleanOilRecycleCom oilCompany = cleanService.getCleanOilRecycleComById(oildCompanyId);
            entity.setOilCompany(oilCompany);
            entity.setOilCompanyName(oilCompany.getOilCleanCompany().getCompanyName());
            entity.setRecyclePerson(dto.getRecyclePerson());
            entity.setType(Integer.parseInt(dto.getType()));
            if (dto.getUnit() == null) {
                entity.setUnit(13001); //油脂单位默认为L
            } else {
                entity.setUnit(dto.getUnit());
            }
      	  if (StringUtils.isNotBlank(dto.getRecycleDate())) {
	            entity.setRecycleDate(TimeOrDateUtils.parseDate(dto.getRecycleDate()));
			}
        }
        return entity;
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

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
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

	public String getRecycleDate() {
		return recycleDate;
	}

	public void setRecycleDate(String recycleDate) {
		this.recycleDate = recycleDate;
	}


}
