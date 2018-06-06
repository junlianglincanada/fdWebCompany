package com.wondersgroup.operation.relationship.model;

import java.util.Map;

import com.wondersgroup.framework.common.GeoAdminRegionService;

public class DTOComRelationshipForSearch {

	Integer companyId;
	String companyName;
	String companyAddress;
	String regionProvince;
	String regionCity;
	String regionCounty;
	String regionStreet;
	Integer status;
	
	public static DTOComRelationshipForSearch createByMap(Map map,GeoAdminRegionService geoAdminRegionService){
		DTOComRelationshipForSearch dto = new DTOComRelationshipForSearch();
		if(map.get("COMPANY_ID")!=null){
			dto.setCompanyId(Integer.parseInt(map.get("COMPANY_ID").toString()));
		}
		if(map.get("COMPANY_NAME")!=null){
			dto.setCompanyName(map.get("COMPANY_NAME").toString());
		}
		if(map.get("COMPANY_ADDRESS")!=null){
			dto.setCompanyAddress(map.get("COMPANY_ADDRESS").toString());
		}
		if(map.get("REGION_PROVINCE")!=null){
			dto.setRegionProvince(geoAdminRegionService.getGeoAdminRegionById(Integer.parseInt(map.get("REGION_PROVINCE").toString())).getName());
		}
		if(map.get("REGION_CITY")!=null){
			dto.setRegionCity(geoAdminRegionService.getGeoAdminRegionById(Integer.parseInt(map.get("REGION_CITY").toString())).getName());
		}
		if(map.get("REGION_COUNTY")!=null){
			dto.setRegionCounty(geoAdminRegionService.getGeoAdminRegionById(Integer.parseInt(map.get("REGION_COUNTY").toString())).getName());
		}
		if(map.get("REGION_STREET")!=null){
			dto.setRegionStreet(geoAdminRegionService.getGeoAdminRegionById(Integer.parseInt(map.get("REGION_STREET").toString())).getName());
		}
		return dto;
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
	public String getCompanyAddress() {
		return companyAddress;
	}
	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}
	public String getRegionProvince() {
		return regionProvince;
	}
	public void setRegionProvince(String regionProvince) {
		this.regionProvince = regionProvince;
	}
	public String getRegionCity() {
		return regionCity;
	}
	public void setRegionCity(String regionCity) {
		this.regionCity = regionCity;
	}
	public String getRegionCounty() {
		return regionCounty;
	}
	public void setRegionCounty(String regionCounty) {
		this.regionCounty = regionCounty;
	}
	public String getRegionStreet() {
		return regionStreet;
	}
	public void setRegionStreet(String regionStreet) {
		this.regionStreet = regionStreet;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
}
