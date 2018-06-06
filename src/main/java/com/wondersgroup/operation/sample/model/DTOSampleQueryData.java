package com.wondersgroup.operation.sample.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import com.wondersgroup.data.jpa.entity.RetentionSamples;
import com.wondersgroup.data.jpa.entity.RetentionSamplesDetail;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOSampleQueryData {
	
	private Integer id;
	private String sampleDate;
	private Integer sampleMeal;
	private Integer sampleType;
	private String sampleDescription;
	private List<String> sampleNameList;
	
	public DTOSampleQueryData(){
		
	}
	public static DTOSampleQueryData createByEntity(RetentionSamples entity){
		DTOSampleQueryData dto=null;
		if(entity!=null){
			dto=new DTOSampleQueryData();
			dto.setId(entity.getId());
			dto.setSampleDate(TimeOrDateUtils.formateDate(entity.getSampleDate(),TimeOrDateUtils.FULL_YMDHM));
			dto.setSampleMeal(entity.getSampleMeal());
			dto.setSampleType(entity.getSampleType());
			dto.setSampleDescription(entity.getSampleDescription());
			List<RetentionSamplesDetail> retentionSamplesDetailList=entity.getRetentionSamplesDetailList();
			List<String> nameList=new ArrayList<String>();
			for(RetentionSamplesDetail rsd:retentionSamplesDetailList){
				nameList.add(rsd.getSampleName());
			}
			dto.setSampleNameList(nameList);
		}
		return dto;
	}
	public static List<DTOSampleQueryData> createListByEntities(Collection<RetentionSamples> domainInstanceList){
		List<DTOSampleQueryData> list= new ArrayList<DTOSampleQueryData>();
		if(domainInstanceList != null){
			for(RetentionSamples rs:domainInstanceList){
				DTOSampleQueryData data=createByEntity(rs);
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
	public String getSampleDescription() {
		return sampleDescription;
	}
	public void setSampleDescription(String sampleDescription) {
		this.sampleDescription = sampleDescription;
	}
	public List<String> getSampleNameList() {
		return sampleNameList;
	}
	public void setSampleNameList(List<String> sampleNameList) {
		this.sampleNameList = sampleNameList;
	}
	
}
