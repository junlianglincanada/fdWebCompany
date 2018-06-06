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

public class DTOCleanWasteRecycleRecordCreate {
	private Integer id;
	private String createDate;
	private BigDecimal amount;
	private Integer unit;
	private int companyId;
	private int companyWasteRecycleId;
	private String recyclePerson;
	private String recycleDate;

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

	public static CleanWasteRecycleRecord toEntity(DTOCleanWasteRecycleRecordCreate dto,
			Integer loginCompanyId, CleanService cleanService, RestaurantService restaurantService,
			Integer createUserId, String createUserName) {
		CleanWasteRecycleRecord entity = new CleanWasteRecycleRecord();
		entity.setAmount(dto.getAmount());
		Company company = restaurantService.getRestaurantById(loginCompanyId);
		entity.setCompany(company);
		Integer wastedCompanyId = dto.getCompanyWasteRecycleId();
		CleanWasteRecycleCom wasteCompany = cleanService
				.getCleanWasteRecycleComById(wastedCompanyId);
		entity.setComRecycle(wasteCompany);
                entity.setComRecycleName(wasteCompany.getName());
		entity.setRecyclePerson(dto.getRecyclePerson());
		if(dto.getUnit()==null){
                    entity.setUnit(13004); //垃圾默认单位是桶
                }else{
                    entity.setUnit(dto.getUnit());
                }
		entity.setCreateDate(new Date());
		entity.setCreateUser(createUserId);
		entity.setCreateUserName(createUserName);
		  if (StringUtils.isNotBlank(dto.getRecycleDate())) {
	            entity.setRecycleDate(TimeOrDateUtils.parseDate(dto.getRecycleDate()));
			}
		return entity;
	}

	public Integer getUnit() {
		return unit;
	}

	public void setUnit(Integer unit) {
		this.unit = unit;
	}



	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getRecycleDate() {
		return recycleDate;
	}

	public void setRecycleDate(String recycleDate) {
		this.recycleDate = recycleDate;
	}


}
