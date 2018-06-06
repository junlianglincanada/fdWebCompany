package com.wondersgroup.operation.common.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.wondersgroup.data.jpa.entity.CompanyImport;

public class DTOCompanyImportInfo {

	// 单位ID
	private Integer companyId;

	// 单位名称
	private String companyName;

	// 单位店招
	private String companyNameAbbrev;

	// 单位注册地址
	private String companyRegAddress;

	// 单位经营地址
	private String companyBizAddress;
	
	// 省ID
	private Integer regionProvinceId;
	
	// 市ID
	private Integer regionCityId;

	// 区县ID
	private Integer regionCountyId;

	// 街道ID
	private Integer regionStreetId;

	// 餐饮许可证号
	private String cateringCert;
	
	//食品流通
    private String foodCircuCert;
	 //食品生产
	private String foodProdCert;
	//食品经营许可证证件失效日期
	private Date endDate;
	//工商执照号
    private String bizCertNum;

	public static DTOCompanyImportInfo toDTO(CompanyImport entity) {
		DTOCompanyImportInfo dto = null;
		if (entity != null) {
			dto = new DTOCompanyImportInfo();
			dto.setCompanyId(entity.getId());
			dto.setCompanyName(entity.getCompanyName());
			dto.setCompanyNameAbbrev(entity.getCompanyNameAbbrev());
			dto.setCompanyBizAddress(entity.getCompanyBizAddress());
			dto.setCompanyRegAddress(entity.getCompanyRegAddress());
			dto.setRegionProvinceId(entity.getRegionProvince());
			dto.setRegionCityId(entity.getRegionCity());
			dto.setRegionCountyId(entity.getRegionCounty());
			dto.setRegionStreetId(entity.getRegionStreet());
			dto.setCateringCert(entity.getCateringCert());
			dto.setFoodCircuCert(entity.getFoodCircuCert());
			dto.setFoodProdCert(entity.getFoodProdCert());
			dto.setBizCertNum(entity.getBizCertNumber());
		}
		return dto;
	}
	
	public static DTOCompanyImportInfo createByMap(Map map){
		DTOCompanyImportInfo dto = null;
		if(map != null){
			dto = new DTOCompanyImportInfo();
			if(map.get("companyName") != null){
				dto.setCompanyName(map.get("companyName").toString());
			}
			if(map.get("companyAddress") != null){
				dto.setCompanyBizAddress(map.get("companyAddress").toString());
				dto.setCompanyRegAddress(map.get("companyAddress").toString());
			}
			if(map.get("regionProvinceId") != null){
				dto.setRegionProvinceId((int)map.get("regionProvinceId"));
			}
			if(map.get("regionCityId") != null){
				dto.setRegionCityId((int)map.get("regionCityId"));
			}
			if(map.get("regionCountyId") != null){
				dto.setRegionCountyId((int)map.get("regionCountyId"));
			}
			if(map.get("regionStreetId") != null){
				dto.setRegionStreetId((int)map.get("regionStreetId"));
			}
			if(map.get("endDate") != null){
				dto.setEndDate((Date)map.get("endDate"));
			}
		}
		return dto;
	}

	public static List<DTOCompanyImportInfo> createListByEntities(Collection<CompanyImport> entityList) {
		List<DTOCompanyImportInfo> list = new ArrayList<>();
		if (entityList != null) {
			for (CompanyImport companyImport : entityList) {
				DTOCompanyImportInfo data = toDTO(companyImport);
				if (data != null) {
					list.add(data);
				}
			}
		}
		return list;
	}

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getCompanyNameAbbrev() {
		return companyNameAbbrev;
	}

	public void setCompanyNameAbbrev(String companyNameAbbrev) {
		this.companyNameAbbrev = companyNameAbbrev;
	}

	public String getCompanyRegAddress() {
		return companyRegAddress;
	}

	public void setCompanyRegAddress(String companyRegAddress) {
		this.companyRegAddress = companyRegAddress;
	}

	public String getCompanyBizAddress() {
		return companyBizAddress;
	}

	public void setCompanyBizAddress(String companyBizAddress) {
		this.companyBizAddress = companyBizAddress;
	}

	public String getCateringCert() {
		return cateringCert;
	}

	public void setCateringCert(String cateringCert) {
		this.cateringCert = cateringCert;
	}

	public Integer getRegionCountyId() {
		return regionCountyId;
	}

	public void setRegionCountyId(Integer regionCountyId) {
		this.regionCountyId = regionCountyId;
	}

	public Integer getRegionStreetId() {
		return regionStreetId;
	}

	public void setRegionStreetId(Integer regionStreetId) {
		this.regionStreetId = regionStreetId;
	}

	public String getFoodCircuCert() {
		return foodCircuCert;
	}

	public void setFoodCircuCert(String foodCircuCert) {
		this.foodCircuCert = foodCircuCert;
	}

	public String getFoodProdCert() {
		return foodProdCert;
	}

	public void setFoodProdCert(String foodProdCert) {
		this.foodProdCert = foodProdCert;
	}

	public String getBizCertNum() {
		return bizCertNum;
	}

	public void setBizCertNum(String bizCertNum) {
		this.bizCertNum = bizCertNum;
	}

	public Integer getRegionProvinceId() {
		return regionProvinceId;
	}

	public void setRegionProvinceId(Integer regionProvinceId) {
		this.regionProvinceId = regionProvinceId;
	}

	public Integer getRegionCityId() {
		return regionCityId;
	}

	public void setRegionCityId(Integer regionCityId) {
		this.regionCityId = regionCityId;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
}
