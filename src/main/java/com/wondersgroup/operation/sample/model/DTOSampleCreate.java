package com.wondersgroup.operation.sample.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.data.jpa.entity.RetentionSamples;
import com.wondersgroup.data.jpa.entity.RetentionSamplesDetail;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOSampleCreate {

	private String sampleDate;
	private Integer sampleMeal;
	private Integer sampleType;
	private Integer diningCount;
	private String sampleDescription;
	private String cateringWay;
	private String listInfo;
	
	public DTOSampleCreate(){
		
	}
	public static RetentionSamples toEntity(DTOSampleCreate dto,Company company){
		RetentionSamples entity=null;
		if(dto != null){
			entity=new RetentionSamples();
			entity.setCompany(company);
			if(StringUtils.isNotBlank(dto.getSampleDate())){
				Date date = TimeOrDateUtils.parseDate(dto.getSampleDate(), TimeOrDateUtils.FULL_YMDHM);
				entity.setSampleDate(date);
		    }
			entity.setSampleMeal(dto.getSampleMeal());
			entity.setSampleType(dto.getSampleType());
			entity.setDiningCount(dto.getDiningCount());
			entity.setSampleDescription(dto.getSampleDescription());
			entity.setCateringWay(dto.getCateringWay());
			entity.setCreateDate(new Date());
			entity.setLastModifiedDate(new Date());
			String listInfos=dto.getListInfo();
			List<RetentionSamplesDetail> list=null;
			if(StringUtils.isNotBlank(listInfos)){
				list=new ArrayList<RetentionSamplesDetail>();
				String[] datas=listInfos.split(",");
				RetentionSamplesDetail rsd = null;
				for(int i=0;i<datas.length;i++){
					if(i%3==0){
						rsd=new RetentionSamplesDetail();
						rsd.setSampleName(datas[i]);
					}else if(i%3==1){
						rsd.setSampleQty(Integer.parseInt(datas[i]));
					}else if(i%3==2){
						rsd.setSampleUnit(Integer.parseInt(datas[i]));
						rsd.setRetentionSamples(entity);
						rsd.setCreateDate(new Date());
						list.add(rsd);
					}
				}
			}
			entity.setRetentionSamplesDetailList(list);
		}
		return entity;
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
	public String getListInfo() {
		return listInfo;
	}
	public void setListInfo(String listInfo) {
		this.listInfo = listInfo;
	}
	public String getCateringWay() {
		return cateringWay;
	}
	public void setCateringWay(String cateringWay) {
		this.cateringWay = cateringWay;
	}
}
