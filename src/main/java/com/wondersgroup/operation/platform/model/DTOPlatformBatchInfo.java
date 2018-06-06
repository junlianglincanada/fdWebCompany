package com.wondersgroup.operation.platform.model;

import java.math.BigDecimal;
import java.util.Date;
import java.util.UUID;

import com.wondersgroup.data.jpa.entity.InputBatchDetail;
import com.wondersgroup.data.jpa.entity.IntCompany;
import com.wondersgroup.data.jpa.entity.OutputBatchDetail;
import com.wondersgroup.util.StringUtils;
import com.wondersgroup.util.TimeOrDateUtils;

import net.sf.json.JSONObject;

public class DTOPlatformBatchInfo {

	private String recordDate;
	private String materialName;
	private String manufacture;
	private String spec;
	private String quantity;
	private String productionDate;
	private String productionBatch;
	private String traceCode;
	public static InputBatchDetail createInputBatchByJson(JSONObject batch,Integer companyId,IntCompany supplier,Integer appId) throws Exception{
		InputBatchDetail entity = null;
		if(batch != null && supplier != null && companyId != null && companyId >0){
			entity = new InputBatchDetail();
			UUID uuid = UUID.randomUUID();
			String id = uuid.toString().replaceAll("-", "");
			entity.setId(id);
			entity.setCompanyId(companyId);
			if(supplier.getId()!=null){
				entity.setSupplierId(supplier.getId());
			}
			entity.setSupplierCode(supplier.getCode());
			entity.setSupplierName(supplier.getName());
			entity.setSupplierNameAbbrev(supplier.getNameAbbrev());
			DTOPlatformBatchInfo dto=(DTOPlatformBatchInfo)JSONObject.toBean(batch,DTOPlatformBatchInfo.class);
			entity.setInputDate(TimeOrDateUtils.parseDate(dto.getRecordDate()));
			entity.setInputMatName(dto.getMaterialName());
			entity.setManufacture(dto.getManufacture());
			entity.setSpec(dto.getSpec());
			entity.setQuantity(new BigDecimal(dto.getQuantity()));
			if(StringUtils.isNotBlank(dto.getProductionDate())){
				entity.setProductionDate(TimeOrDateUtils.parseDate(dto.getProductionDate()));
			}
			entity.setProductionBatch(dto.getProductionBatch());
			entity.setTraceCode(dto.getTraceCode());
			entity.setCreateDate(new Date());
			entity.setLastModifiedDate(new Date());
			entity.setCreateUser(-1);
			entity.setCreateUserName("AppID:"+appId);
		}
		return entity;
	}
	public static OutputBatchDetail createOutputBatchByJson(JSONObject batch,Integer companyId,IntCompany receiver,Integer appId) throws Exception{
		OutputBatchDetail entity = null;
		if(batch != null && receiver != null && companyId != null && companyId >0){
			entity = new OutputBatchDetail();
			UUID uuid = UUID.randomUUID();
			String id = uuid.toString().replaceAll("-", "");
			entity.setId(id);
			entity.setCompanyId(companyId);
			if(receiver.getId()!=null){
				entity.setReceiverId(receiver.getId());
			}
			entity.setReceiverCode(receiver.getCode());
			entity.setReceiverName(receiver.getName());
			entity.setReceiverNameAbbrev(receiver.getNameAbbrev());
			DTOPlatformBatchInfo dto=(DTOPlatformBatchInfo)JSONObject.toBean(batch,DTOPlatformBatchInfo.class);
			entity.setOutputDate(TimeOrDateUtils.parseDate(dto.getRecordDate()));
			entity.setOutputMatName(dto.getMaterialName());
			entity.setManufacture(dto.getManufacture());
			entity.setSpec(dto.getSpec());
			entity.setQuantity(new BigDecimal(dto.getQuantity()));
			if(StringUtils.isNotBlank(dto.getProductionDate())){
				entity.setProductionDate(TimeOrDateUtils.parseDate(dto.getProductionDate()));
			}
			entity.setProductionBatch(dto.getProductionBatch());
			entity.setCreateDate(new Date());
			entity.setLastModifiedDate(new Date());
			entity.setCreateUser(-1);
			entity.setCreateUserName("AppID:"+appId);
		}
		return entity;
	}
	public String getRecordDate() {
		return recordDate;
	}
	public void setRecordDate(String recordDate) {
		this.recordDate = recordDate;
	}
	public String getMaterialName() {
		return materialName;
	}
	public void setMaterialName(String materialName) {
		this.materialName = materialName;
	}
	public String getManufacture() {
		return manufacture;
	}
	public void setManufacture(String manufacture) {
		this.manufacture = manufacture;
	}
	public String getSpec() {
		return spec;
	}
	public void setSpec(String spec) {
		this.spec = spec;
	}
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	public String getProductionDate() {
		return productionDate;
	}
	public void setProductionDate(String productionDate) {
		this.productionDate = productionDate;
	}
	public String getProductionBatch() {
		return productionBatch;
	}
	public void setProductionBatch(String productionBatch) {
		this.productionBatch = productionBatch;
	}
	public String getTraceCode() {
		return traceCode;
	}
	public void setTraceCode(String traceCode) {
		this.traceCode = traceCode;
	}
}
