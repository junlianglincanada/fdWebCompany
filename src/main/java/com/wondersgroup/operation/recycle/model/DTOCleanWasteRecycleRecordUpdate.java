package com.wondersgroup.operation.recycle.model;

import java.math.BigDecimal;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

import com.wondersgroup.data.jpa.entity.CleanWasteRecycleCom;
import com.wondersgroup.data.jpa.entity.CleanWasteRecycleRecord;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.service.clean.CleanService;
import com.wondersgroup.service.company.RestaurantService;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOCleanWasteRecycleRecordUpdate {
	private Integer id;
	private Date createDate;
	private BigDecimal amount;
	private Integer unit;
	private int companyWasteRecycleId;
	private String recyclePerson;
	private String recycleDate;
	
	public static CleanWasteRecycleRecord toEntity(	CleanWasteRecycleRecord entity,DTOCleanWasteRecycleRecordUpdate dto, Integer loginCompanyId,
			CleanService cleanService, RestaurantService restaurantService) {
		
		entity.setAmount(dto.getAmount());
		Company company = restaurantService.getRestaurantById(loginCompanyId);
		entity.setCompany(company);
		
		Integer wastedCompanyId = dto.getCompanyWasteRecycleId();
		CleanWasteRecycleCom wasteCompany = cleanService.getCleanWasteRecycleComById(wastedCompanyId);
		entity.setComRecycle(wasteCompany);
                entity.setComRecycleName(wasteCompany.getName());
		entity.setRecyclePerson(dto.getRecyclePerson());
		if(dto.getUnit()==null){
                    entity.setUnit(13004); //垃圾默认单位是桶
                }else{
                    entity.setUnit(dto.getUnit());
                }
		entity.setCreateDate(new Date());
		  if (StringUtils.isNotBlank(dto.getRecycleDate())) {
	            entity.setRecycleDate(TimeOrDateUtils.parseDate(dto.getRecycleDate()));
			}
		
		return entity;
	}
	

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}


	public int getCompanyWasteRecycleId() {
		return companyWasteRecycleId;
	}

	public void setCompanyWasteRecycleId(int companyWasteRecycleId) {
		this.companyWasteRecycleId = companyWasteRecycleId;
	}

	public String getRecyclePerson() {
		return recyclePerson;
	}


	public void setRecyclePerson(String recyclePerson) {
		this.recyclePerson = recyclePerson;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	public String getRecycleDate() {
		return recycleDate;
	}

	public void setRecycleDate(String recycleDate) {
		this.recycleDate = recycleDate;
	}

}
