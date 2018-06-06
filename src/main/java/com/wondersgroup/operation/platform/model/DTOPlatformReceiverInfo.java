package com.wondersgroup.operation.platform.model;

import net.sf.json.JSONObject;

import com.wondersgroup.data.jpa.entity.IntCompany;
import com.wondersgroup.framework.util.FoodConstant;

public class DTOPlatformReceiverInfo {

	private String recName;
	private String recAddress;
	private String recCateringCert;
	private String recFoodBusinessCert;
	private String recFoodCircuCert;
	private String recFoodProdCert;
	private String recBizCertNum;
	private String recCode;
	private String recNameAbbrev;
	private String recContactPerson;
	private String recContactPhone;
	public static IntCompany createEntityByJson(JSONObject receiver,Integer companyId) throws Exception{
		IntCompany entity=null;
		if(receiver!=null){
			entity=new IntCompany();
			DTOPlatformReceiverInfo dto=(DTOPlatformReceiverInfo)JSONObject.toBean(receiver, DTOPlatformReceiverInfo.class);
			entity.setName(dto.getRecName());
			entity.setType(IntCompany.COMPANY_TYPE_RECEIVER);
			entity.setStatus(FoodConstant.FIELD_STATUS_VALID);
			entity.setCompanyId(companyId);
			entity.setContactAddress(dto.getRecAddress());
			entity.setCateringCert(dto.getRecCateringCert());
			entity.setFoodBusinessCert(dto.getRecFoodBusinessCert());
			entity.setFoodCircuCert(dto.getRecFoodCircuCert());
			entity.setFoodProdCert(dto.getRecFoodProdCert());
			entity.setBizCertNum(dto.getRecBizCertNum());
			entity.setCode(dto.getRecCode());
			entity.setNameAbbrev(dto.getRecNameAbbrev());
			entity.setContactPerson(dto.getRecContactPerson());
			entity.setContactPhone(dto.getRecContactPhone());
		}
		return entity;
	}
	public String getRecName() {
		return recName;
	}
	public void setRecName(String recName) {
		this.recName = recName;
	}
	public String getRecAddress() {
		return recAddress;
	}
	public void setRecAddress(String recAddress) {
		this.recAddress = recAddress;
	}
	public String getRecCateringCert() {
		return recCateringCert;
	}
	public void setRecCateringCert(String recCateringCert) {
		this.recCateringCert = recCateringCert;
	}
	public String getRecFoodBusinessCert() {
		return recFoodBusinessCert;
	}
	public void setRecFoodBusinessCert(String recFoodBusinessCert) {
		this.recFoodBusinessCert = recFoodBusinessCert;
	}
	public String getRecFoodCircuCert() {
		return recFoodCircuCert;
	}
	public void setRecFoodCircuCert(String recFoodCircuCert) {
		this.recFoodCircuCert = recFoodCircuCert;
	}
	public String getRecFoodProdCert() {
		return recFoodProdCert;
	}
	public void setRecFoodProdCert(String recFoodProdCert) {
		this.recFoodProdCert = recFoodProdCert;
	}
	public String getRecBizCertNum() {
		return recBizCertNum;
	}
	public void setRecBizCertNum(String recBizCertNum) {
		this.recBizCertNum = recBizCertNum;
	}
	public String getRecCode() {
		return recCode;
	}
	public void setRecCode(String recCode) {
		this.recCode = recCode;
	}
	public String getRecNameAbbrev() {
		return recNameAbbrev;
	}
	public void setRecNameAbbrev(String recNameAbbrev) {
		this.recNameAbbrev = recNameAbbrev;
	}
	public String getRecContactPerson() {
		return recContactPerson;
	}
	public void setRecContactPerson(String recContactPerson) {
		this.recContactPerson = recContactPerson;
	}
	public String getRecContactPhone() {
		return recContactPhone;
	}
	public void setRecContactPhone(String recContactPhone) {
		this.recContactPhone = recContactPhone;
	}
}
