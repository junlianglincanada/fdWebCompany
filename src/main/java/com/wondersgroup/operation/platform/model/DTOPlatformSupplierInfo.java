package com.wondersgroup.operation.platform.model;

import net.sf.json.JSONObject;
import com.wondersgroup.data.jpa.entity.IntCompany;
import com.wondersgroup.framework.util.FoodConstant;

public class DTOPlatformSupplierInfo {

	private String supName;
	private String supAddress;
	private String supCateringCert;
	private String supFoodBusinessCert;
	private String supFoodCircuCert;
	private String supFoodProdCert;
	private String supBizCertNum;
	private String supCode;
	private String supNameAbbrev;
	private String supContactPerson;
	private String supContactPhone;
	public static IntCompany createEntityByJson(JSONObject supplier,Integer companyId) throws Exception{
		IntCompany entity=null;
		if(supplier!=null){
			entity=new IntCompany();
			DTOPlatformSupplierInfo dto=(DTOPlatformSupplierInfo)JSONObject.toBean(supplier, DTOPlatformSupplierInfo.class);
			entity.setName(dto.getSupName());
			entity.setType(IntCompany.COMPANY_TYPE_SUPPLIER);
			entity.setStatus(FoodConstant.FIELD_STATUS_VALID);
			entity.setCompanyId(companyId);
			entity.setContactAddress(dto.getSupAddress());
			entity.setCateringCert(dto.getSupCateringCert());
			entity.setFoodBusinessCert(dto.getSupFoodBusinessCert());
			entity.setFoodCircuCert(dto.getSupFoodCircuCert());
			entity.setFoodProdCert(dto.getSupFoodProdCert());
			entity.setBizCertNum(dto.getSupBizCertNum());
			entity.setCode(dto.getSupCode());
			entity.setNameAbbrev(dto.getSupNameAbbrev());
			entity.setContactPerson(dto.getSupContactPerson());
			entity.setContactPhone(dto.getSupContactPhone());
		}
		return entity;
	}
	public String getSupName() {
		return supName;
	}
	public void setSupName(String supName) {
		this.supName = supName;
	}
	public String getSupAddress() {
		return supAddress;
	}
	public void setSupAddress(String supAddress) {
		this.supAddress = supAddress;
	}
	public String getSupCateringCert() {
		return supCateringCert;
	}
	public void setSupCateringCert(String supCateringCert) {
		this.supCateringCert = supCateringCert;
	}
	public String getSupFoodBusinessCert() {
		return supFoodBusinessCert;
	}
	public void setSupFoodBusinessCert(String supFoodBusinessCert) {
		this.supFoodBusinessCert = supFoodBusinessCert;
	}
	public String getSupFoodCircuCert() {
		return supFoodCircuCert;
	}
	public void setSupFoodCircuCert(String supFoodCircuCert) {
		this.supFoodCircuCert = supFoodCircuCert;
	}
	public String getSupFoodProdCert() {
		return supFoodProdCert;
	}
	public void setSupFoodProdCert(String supFoodProdCert) {
		this.supFoodProdCert = supFoodProdCert;
	}
	public String getSupBizCertNum() {
		return supBizCertNum;
	}
	public void setSupBizCertNum(String supBizCertNum) {
		this.supBizCertNum = supBizCertNum;
	}
	public String getSupCode() {
		return supCode;
	}
	public void setSupCode(String supCode) {
		this.supCode = supCode;
	}
	public String getSupNameAbbrev() {
		return supNameAbbrev;
	}
	public void setSupNameAbbrev(String supNameAbbrev) {
		this.supNameAbbrev = supNameAbbrev;
	}
	public String getSupContactPerson() {
		return supContactPerson;
	}
	public void setSupContactPerson(String supContactPerson) {
		this.supContactPerson = supContactPerson;
	}
	public String getSupContactPhone() {
		return supContactPhone;
	}
	public void setSupContactPhone(String supContactPhone) {
		this.supContactPhone = supContactPhone;
	}
}
