package com.wondersgroup.operation.sample.model;

import com.wondersgroup.data.jpa.entity.RetentionSamplesDetail;

public class DTOSampleDetailInfo {

	private String sampleName;
	private Integer sampleQty;
	private Integer sampleUnit;
	
	public DTOSampleDetailInfo(){
		
	}
	public static DTOSampleDetailInfo createByEntity(RetentionSamplesDetail entity){
		DTOSampleDetailInfo dto=null;
		if(entity != null){
			dto=new DTOSampleDetailInfo();
			dto.setSampleName(entity.getSampleName());
			dto.setSampleQty(entity.getSampleQty());
			dto.setSampleUnit(entity.getSampleUnit());
		}
		return dto;
	}
	public String getSampleName() {
		return sampleName;
	}
	public void setSampleName(String sampleName) {
		this.sampleName = sampleName;
	}
	public Integer getSampleQty() {
		return sampleQty;
	}
	public void setSampleQty(Integer sampleQty) {
		this.sampleQty = sampleQty;
	}
	public Integer getSampleUnit() {
		return sampleUnit;
	}
	public void setSampleUnit(Integer sampleUnit) {
		this.sampleUnit = sampleUnit;
	}
	
}
