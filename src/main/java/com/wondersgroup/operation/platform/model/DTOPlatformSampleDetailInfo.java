package com.wondersgroup.operation.platform.model;

import java.util.Date;
import java.util.Map;

import com.wondersgroup.data.jpa.entity.RetentionSamples;
import com.wondersgroup.data.jpa.entity.RetentionSamplesDetail;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.DataDicConstant;
import com.wondersgroup.util.StringUtils;

public class DTOPlatformSampleDetailInfo {

	private String sampleName;
	private Integer sampleQty;
	private String sampleUnit;
	
	//样品数量单位分类表
	static Map<String, Integer> sampleUnitMap = DataDictService.getDataDicDetailName2IdMap(DataDicConstant.DIC_SAMPLE_UNIT);
	
	public static RetentionSamplesDetail createByDTO(DTOPlatformSampleDetailInfo dto,RetentionSamples sample) throws Exception{
		if(dto==null||StringUtils.isBlank(dto.getSampleName())||dto.getSampleQty() == null||dto.getSampleQty()<0||sampleUnitMap.get(dto.getSampleUnit())==null){
			throw FoodException.returnException("116026");
		}
		RetentionSamplesDetail entity = new RetentionSamplesDetail();
		entity.setRetentionSamples(sample);
		entity.setSampleName(dto.getSampleName());
		entity.setSampleQty(dto.getSampleQty());
		entity.setSampleUnit(sampleUnitMap.get(dto.getSampleUnit()));
		entity.setCreateDate(new Date());
		return entity;
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

	public String getSampleUnit() {
		return sampleUnit;
	}

	public void setSampleUnit(String sampleUnit) {
		this.sampleUnit = sampleUnit;
	}
}
