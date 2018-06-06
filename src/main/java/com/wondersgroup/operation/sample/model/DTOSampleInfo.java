package com.wondersgroup.operation.sample.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wondersgroup.data.jpa.entity.RetentionSamples;
import com.wondersgroup.data.jpa.entity.RetentionSamplesDetail;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOSampleInfo {
	private Integer id;
	private String sampleDate;
	private Integer sampleMeal;
	private Integer sampleType;
	private Integer diningCount;
	private String sampleDescription;
	private String cateringWay;
	private List<DTOSampleDetailInfo> sampleDetailList;
	
	public DTOSampleInfo(){
		
	}
	public static DTOSampleInfo createByEntity(RetentionSamples entity){
		DTOSampleInfo dto=null;
		if(entity!=null){
			dto=new DTOSampleInfo();
			dto.setId(entity.getId());
			dto.setSampleDate(TimeOrDateUtils.formateDate(entity.getSampleDate(),TimeOrDateUtils.FULL_YMDHM));
			dto.setSampleMeal(entity.getSampleMeal());
			dto.setSampleType(entity.getSampleType());
			dto.setDiningCount(entity.getDiningCount());
			dto.setCateringWay(entity.getCateringWay());
			dto.setSampleDescription(entity.getSampleDescription());
			List<RetentionSamplesDetail> retentionSamplesDetailList=entity.getRetentionSamplesDetailList();
			List<DTOSampleDetailInfo> list=new ArrayList<DTOSampleDetailInfo>();
			for(RetentionSamplesDetail rsd:retentionSamplesDetailList){
				DTOSampleDetailInfo data=DTOSampleDetailInfo.createByEntity(rsd);
				if(data != null){
					list.add(data);
				}
			}
			dto.setSampleDetailList(list);
		}
		return dto;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getSampleDate() {
		return sampleDate;
	}
	public void setSampleDate(String sampleDate) {
		this.sampleDate = sampleDate;
	}
	public Integer getSampleMeal() {
		return sampleMeal;
	}
	public void setSampleMeal(Integer sampleMeal) {
		this.sampleMeal = sampleMeal;
	}
	public Integer getSampleType() {
		return sampleType;
	}
	public void setSampleType(Integer sampleType) {
		this.sampleType = sampleType;
	}
	public Integer getDiningCount() {
		return diningCount;
	}
	public void setDiningCount(Integer diningCount) {
		this.diningCount = diningCount;
	}
	public String getSampleDescription() {
		return sampleDescription;
	}
	public void setSampleDescription(String sampleDescription) {
		this.sampleDescription = sampleDescription;
	}
	public List<DTOSampleDetailInfo> getSampleDetailList() {
		return sampleDetailList;
	}
	public void setSampleDetailList(List<DTOSampleDetailInfo> sampleDetailList) {
		this.sampleDetailList = sampleDetailList;
	}
	public String getCateringWay() {
		return cateringWay;
	}
	public void setCateringWay(String cateringWay) {
		this.cateringWay = cateringWay;
	}
}
