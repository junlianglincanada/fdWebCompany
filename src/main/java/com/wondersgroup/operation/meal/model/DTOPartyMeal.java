package com.wondersgroup.operation.meal.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;
import com.wondersgroup.data.jpa.entity.PartyMeal;

public class DTOPartyMeal implements Serializable {

	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	
		private int id;
	@JsonFormat(shape=Shape.STRING,pattern="yyyy-MM-dd",timezone="GMT+8")

		private Date partyMealDate;
	    private int  partyMealSeq;
	    private String partyMealName;
	    private int  diningCount;
	    private int  partyMealType;
	    private String remark;
	    @JsonFormat(shape=Shape.STRING,pattern="yyyy-MM-dd",timezone="GMT+8")
		private Date createDate;

	    
	    
	    public Date getPartyMealDate() {
			return partyMealDate;
		}
		public void setPartyMealDate(Date partyMealDate) {
			this.partyMealDate = partyMealDate;
		}
		public int getPartyMealSeq() {
			return partyMealSeq;
		}
		public void setPartyMealSeq(int partyMealSeq) {
			this.partyMealSeq = partyMealSeq;
		}
		public String getPartyMealName() {
			return partyMealName;
		}
		public void setPartyMealName(String partyMealName) {
			this.partyMealName = partyMealName;
		}
		public int getDiningCount() {
			return diningCount;
		}
		public void setDiningCount(int diningCount) {
			this.diningCount = diningCount;
		}
		public int getPartyMealType() {
			return partyMealType;
		}
		public void setPartyMealType(int partyMealType) {
			this.partyMealType = partyMealType;
		}
		public String getRemark() {
			return remark;
		}
		public void setRemark(String remark) {
			this.remark = remark;
		}
	    public static List<DTOPartyMeal> createListByEntities(List resultList) {
			List<DTOPartyMeal> list = resultList;

			
			return list;
	    }
	
		public static DTOPartyMeal getPartyMealById(PartyMeal entity) {
			DTOPartyMeal dto = null;
			if(entity != null){
				dto = new DTOPartyMeal();
				dto.setId(entity.getId());
				dto.setPartyMealDate(entity.getPartyMealDate());
				dto.setPartyMealSeq(entity.getPartyMealSeq());
				dto.setPartyMealName(entity.getPartyMealName());
				dto.setDiningCount(entity.getDiningCount());
				dto.setPartyMealType(entity.getPartyMealType());
				dto.setRemark(entity.getRemark());
				dto.setCreateDate(entity.getCreateDate());
			}
			return dto;
		}
}