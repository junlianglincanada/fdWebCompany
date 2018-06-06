package com.wondersgroup.operation.platform.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.data.jpa.entity.RetentionSamples;
import com.wondersgroup.data.jpa.entity.RetentionSamplesDetail;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.DataDicConstant;
import com.wondersgroup.service.company.CompanyService;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOPlatformSampleInfo {

	private String sampleDate;
	private String sampleMeal;
	private String sampleType;
	private Integer diningCount;
	private String cateringWay;
	private String sampleDescription;
	private List sampleDetails;
	//留样餐次分类表
	static Map<String, Integer> sampleMealMap = DataDictService.getDataDicDetailName2IdMap(DataDicConstant.DIC_SAMPLE_MEAL);
	//留样类型分类表
	static Map<String, Integer> sampleTypeMap = DataDictService.getDataDicDetailName2IdMap(DataDicConstant.DIC_SAMPLE_TYPE);
	
	public static RetentionSamples createRetentionSamplesByJSON(JSONObject sample,Company company) throws Exception{
		RetentionSamples entity = null;
		if(sample != null && company != null){
			entity = new RetentionSamples();
			List<RetentionSamplesDetail> retentionSamplesDetails = new ArrayList<RetentionSamplesDetail>();
			DTOPlatformSampleInfo dto = (DTOPlatformSampleInfo)JSONObject.toBean(sample,DTOPlatformSampleInfo.class);
			entity.setSampleDate(TimeOrDateUtils.parseDate(dto.getSampleDate()));
			Integer sampleMealVal = sampleMealMap.get(dto.getSampleMeal());
			if(sampleMealVal == null || sampleMealVal <0){
				throw FoodException.returnException("116026");
			}
			entity.setSampleMeal(sampleMealVal);
			Integer sampleTypeVal = sampleTypeMap.get(dto.getSampleType());
			if(sampleTypeVal == null || sampleTypeVal <0){
				throw FoodException.returnException("116026");
			}
			entity.setCompany(company);
			entity.setSampleType(sampleTypeVal);
			entity.setDiningCount(dto.getDiningCount());
			entity.setCateringWay(dto.getCateringWay());
			entity.setSampleDescription(dto.getSampleDescription());
			JSONArray jsonArray = JSONArray.fromObject(dto.getSampleDetails());
			List<DTOPlatformSampleDetailInfo> list = (List<DTOPlatformSampleDetailInfo>)JSONArray.toCollection(jsonArray, DTOPlatformSampleDetailInfo.class);
			if(list!=null&&list.size()>0){
				for(DTOPlatformSampleDetailInfo sampleDetail:list){
					RetentionSamplesDetail rsd = DTOPlatformSampleDetailInfo.createByDTO(sampleDetail,entity);
					retentionSamplesDetails.add(rsd);
				}
			}else{
				throw FoodException.returnException("116026");
			}
			entity.setRetentionSamplesDetailList(retentionSamplesDetails);
			entity.setCreateDate(new Date());
			entity.setLastModifiedDate(new Date());
		}
		return entity;
	}

	public String getSampleDate() {
		return sampleDate;
	}

	public void setSampleDate(String sampleDate) {
		this.sampleDate = sampleDate;
	}

	public String getSampleMeal() {
		return sampleMeal;
	}

	public void setSampleMeal(String sampleMeal) {
		this.sampleMeal = sampleMeal;
	}

	public String getSampleType() {
		return sampleType;
	}

	public void setSampleType(String sampleType) {
		this.sampleType = sampleType;
	}

	public Integer getDiningCount() {
		return diningCount;
	}

	public void setDiningCount(Integer diningCount) {
		this.diningCount = diningCount;
	}

	public String getCateringWay() {
		return cateringWay;
	}

	public void setCateringWay(String cateringWay) {
		this.cateringWay = cateringWay;
	}

	public String getSampleDescription() {
		return sampleDescription;
	}

	public void setSampleDescription(String sampleDescription) {
		this.sampleDescription = sampleDescription;
	}

	public List getSampleDetails() {
		return sampleDetails;
	}

	public void setSampleDetails(List sampleDetails) {
		this.sampleDetails = sampleDetails;
	}
}
