package com.wondersgroup.operation.sample.model;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.apache.commons.lang.StringUtils;
import com.wondersgroup.data.jpa.entity.RetentionSamples;
import com.wondersgroup.data.jpa.entity.RetentionSamplesDetail;
import com.wondersgroup.service.sample.SampleService;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOSampleUpdate {

	@NotNull
	private Integer id;
	private String sampleDate;
	private Integer sampleMeal;
	private Integer sampleType;
	private Integer diningCount;
	private String sampleDescription;
	private String cateringWay;
	private String listInfo;
	
	public DTOSampleUpdate(){
		
	}
	public static RetentionSamples toEntity(DTOSampleUpdate dto,SampleService sampleService){
		RetentionSamples entity=null;
		if(dto != null){
			entity=sampleService.getRetentionSamplesById(dto.getId());
			if(StringUtils.isNotBlank(dto.getSampleDate())){
				Date date = TimeOrDateUtils.parseDate(dto.getSampleDate(), TimeOrDateUtils.FULL_YMDHM);
				entity.setSampleDate(date);
		    }
			entity.setSampleMeal(dto.getSampleMeal());
			entity.setSampleType(dto.getSampleType());
			entity.setDiningCount(dto.getDiningCount());
			entity.setSampleDescription(dto.getSampleDescription());
			entity.setCateringWay(dto.getCateringWay());
			entity.setLastModifiedDate(new Date());
			String listInfos=dto.getListInfo();
			List<RetentionSamplesDetail> list=entity.getRetentionSamplesDetailList();
			if(StringUtils.isNotBlank(listInfos)){
				list.clear();
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
