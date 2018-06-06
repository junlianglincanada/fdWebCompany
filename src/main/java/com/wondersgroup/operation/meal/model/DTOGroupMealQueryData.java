package com.wondersgroup.operation.meal.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.GroupMeal;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOGroupMealQueryData {

	private Integer id;
	private String groupMealDate;
	private Integer groupMealSeq;
	private String diningCompanyName;
	private String diningCompanyAddress;
	private Integer diningCount;
	private Integer groupMealType;
	private String groupMealTypeDesc;
	public DTOGroupMealQueryData(){
		
	}
	public static DTOGroupMealQueryData createByEntity(GroupMeal entity){
		DTOGroupMealQueryData dto= null;
		if(entity != null){
			dto = new DTOGroupMealQueryData();
			dto.setId(entity.getId());
			dto.setGroupMealDate(TimeOrDateUtils.formateDate(entity.getGroupMealDate(),TimeOrDateUtils.FULL_YMDHM));
			dto.setGroupMealSeq(entity.getGroupMealSeq());
			dto.setDiningCompanyName(entity.getDiningCompanyName());
			dto.setDiningCompanyAddress(entity.getDiningCompanyAddress());
			dto.setDiningCount(entity.getDiningCount());
			dto.setGroupMealType(entity.getGroupMealType());
			dto.setGroupMealTypeDesc(entity.getGroupMealTypeDesc());
		}
		return dto;
	}
	public static List<DTOGroupMealQueryData> createListByEntities(Collection<GroupMeal> domainInstanceList){
		List<DTOGroupMealQueryData> list =new ArrayList<DTOGroupMealQueryData>();
		if(domainInstanceList != null){
			for(GroupMeal gm:domainInstanceList){
				DTOGroupMealQueryData data=createByEntity(gm);
				if(data != null){
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
	public Integer getDiningCount() {
		return diningCount;
	}
	public void setDiningCount(Integer diningCount) {
		this.diningCount = diningCount;
	}
	public Integer getGroupMealType() {
		return groupMealType;
	}
	public void setGroupMealType(Integer groupMealType) {
		this.groupMealType = groupMealType;
	}
	public String getGroupMealTypeDesc() {
		return groupMealTypeDesc;
	}
	public void setGroupMealTypeDesc(String groupMealTypeDesc) {
		this.groupMealTypeDesc = groupMealTypeDesc;
	}
}
