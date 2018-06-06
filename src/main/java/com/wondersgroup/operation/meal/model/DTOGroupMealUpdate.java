package com.wondersgroup.operation.meal.model;

import java.util.Date;

import org.apache.commons.lang.StringUtils;

import com.wondersgroup.data.jpa.entity.GroupMeal;
import com.wondersgroup.service.meal.GroupMealService;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOGroupMealUpdate {

	private Integer id;
	private Integer diningCompanyId;
	private String diningCompanyName;
	private String diningCompanyAddress;
	private String diningCompanyContactPerson;
	private String diningCompanyContactPhone;
	private String groupMealDate;
	private Integer groupMealSeq;
	private Integer groupMealType;
	private Integer diningCount;
	private String outputCategory;
	private String foodSafeStaff;
	private String foodSafeStaffPhone;
	private String groupMealTypeDesc;
	private String outputCategoryDesc;
	
	public DTOGroupMealUpdate(){
		
	}
	public static GroupMeal toEntity(DTOGroupMealUpdate dto, GroupMealService groupMealService){
		GroupMeal entity=null;
		if(dto!=null){
			entity=groupMealService.getGroupMealById(dto.getId());
			entity.setDiningCompanyId(dto.getDiningCompanyId());
			entity.setDiningCompanyName(dto.getDiningCompanyName());
			entity.setDiningCompanyAddress(dto.getDiningCompanyAddress());
			entity.setDiningCompanyContactPerson(dto.getDiningCompanyContactPerson());
			entity.setDiningCompanyContactPhone(dto.getDiningCompanyContactPhone());
			if(StringUtils.isNotBlank(dto.getGroupMealDate())){
				Date date = TimeOrDateUtils.parseDate(dto.getGroupMealDate(), TimeOrDateUtils.FULL_YMDHM);
				entity.setGroupMealDate(date);
		    }
			entity.setGroupMealSeq(dto.getGroupMealSeq());
			entity.setGroupMealType(dto.getGroupMealType());
			entity.setDiningCount(dto.getDiningCount());
			entity.setOutputCategory(dto.getOutputCategory());
			entity.setFoodSafeStaff(dto.getFoodSafeStaff());
			entity.setFoodSafeStaffPhone(dto.getFoodSafeStaffPhone());
			entity.setGroupMealTypeDesc(dto.getGroupMealTypeDesc());
			entity.setOutputCategoryDesc(dto.getOutputCategoryDesc());
			entity.setLastModifiedDate(new Date());
		}
		return entity;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getDiningCompanyId() {
		return diningCompanyId;
	}
	public void setDiningCompanyId(Integer diningCompanyId) {
		this.diningCompanyId = diningCompanyId;
	}
	public String getDiningCompanyName() {
		return diningCompanyName;
	}
	public void setDiningCompanyName(String diningCompanyName) {
		this.diningCompanyName = diningCompanyName;
	}
	public String getDiningCompanyAddress() {
		return diningCompanyAddress;
	}
	public void setDiningCompanyAddress(String diningCompanyAddress) {
		this.diningCompanyAddress = diningCompanyAddress;
	}
	public String getDiningCompanyContactPerson() {
		return diningCompanyContactPerson;
	}
	public void setDiningCompanyContactPerson(String diningCompanyContactPerson) {
		this.diningCompanyContactPerson = diningCompanyContactPerson;
	}
	public String getDiningCompanyContactPhone() {
		return diningCompanyContactPhone;
	}
	public void setDiningCompanyContactPhone(String diningCompanyContactPhone) {
		this.diningCompanyContactPhone = diningCompanyContactPhone;
	}
	public String getGroupMealDate() {
		return groupMealDate;
	}
	public void setGroupMealDate(String groupMealDate) {
		this.groupMealDate = groupMealDate;
	}
	public Integer getGroupMealSeq() {
		return groupMealSeq;
	}
	public void setGroupMealSeq(Integer groupMealSeq) {
		this.groupMealSeq = groupMealSeq;
	}
	public Integer getGroupMealType() {
		return groupMealType;
	}
	public void setGroupMealType(Integer groupMealType) {
		this.groupMealType = groupMealType;
	}
	public Integer getDiningCount() {
		return diningCount;
	}
	public void setDiningCount(Integer diningCount) {
		this.diningCount = diningCount;
	}
	public String getOutputCategory() {
		return outputCategory;
	}
	public void setOutputCategory(String outputCategory) {
		this.outputCategory = outputCategory;
	}
	public String getFoodSafeStaff() {
		return foodSafeStaff;
	}
	public void setFoodSafeStaff(String foodSafeStaff) {
		this.foodSafeStaff = foodSafeStaff;
	}
	public String getFoodSafeStaffPhone() {
		return foodSafeStaffPhone;
	}
	public void setFoodSafeStaffPhone(String foodSafeStaffPhone) {
		this.foodSafeStaffPhone = foodSafeStaffPhone;
	}
	public String getGroupMealTypeDesc() {
		return groupMealTypeDesc;
	}
	public void setGroupMealTypeDesc(String groupMealTypeDesc) {
		this.groupMealTypeDesc = groupMealTypeDesc;
	}
	public String getOutputCategoryDesc() {
		return outputCategoryDesc;
	}
	public void setOutputCategoryDesc(String outputCategoryDesc) {
		this.outputCategoryDesc = outputCategoryDesc;
	}
}
