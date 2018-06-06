package com.wondersgroup.operation.input.model;

import java.math.BigDecimal;
import java.util.Date;

import com.wondersgroup.data.jpa.entity.InputBatchDetail;

public class DTOInputBatchInfo {
	
	private String id;
	// 进货日期
	private Date inputDate;
	
	// 供应商id
	private Integer supplierId;
	
	private String supplierName;
	
	//采购品id
	private Integer inputMatId;
	
	private String inputMatName;
	
	//生产单位
	private String manufacture;
	
	//规格
	private String spec;
	
	// 数量
	private BigDecimal quantity;
	
	
	//生产日期
	private Date productionDate;
	
	//生产批号
	private String productionBatch;
	//追溯码
	private String traceCode;
	
	
	
	
	

	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getInputDate() {
		return inputDate;
	}

	public void setInputDate(Date inputDate) {
		this.inputDate = inputDate;
	}

	public Integer getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(Integer supplierId) {
		this.supplierId = supplierId;
	}

	public Integer getInputMatId() {
		return inputMatId;
	}

	public void setInputMatId(Integer inputMatId) {
		this.inputMatId = inputMatId;
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

	public BigDecimal getQuantity() {
		return quantity;
	}

	public void setQuantity(BigDecimal quantity) {
		this.quantity = quantity;
	}

	public Date getProductionDate() {
		return productionDate;
	}

	public void setProductionDate(Date productionDate) {
		this.productionDate = productionDate;
	}

	public String getProductionBatch() {
		return productionBatch;
	}

	public void setProductionBatch(String productionBatch) {
		this.productionBatch = productionBatch;
	}

	public static DTOInputBatchInfo toDTO(InputBatchDetail entity) {
		DTOInputBatchInfo dto = null;
		if(entity!=null){
			dto = new DTOInputBatchInfo();
			dto.setId(entity.getId());
			dto.setInputDate(entity.getInputDate());
			dto.setInputMatId(entity.getInputMatId());
			dto.setInputMatName(entity.getInputMatName());
			dto.setManufacture(entity.getManufacture());
			dto.setProductionBatch(entity.getProductionBatch());
			dto.setProductionDate(entity.getProductionDate());
			dto.setQuantity(entity.getQuantity());
			dto.setSpec(entity.getSpec());
			dto.setSupplierId(entity.getSupplierId());
			dto.setSupplierName(entity.getSupplierName());
			dto.setTraceCode(entity.getTraceCode());
			
		}
		return dto;
	}

	public String getSupplierName() {
		return supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}

	public String getInputMatName() {
		return inputMatName;
	}

	public void setInputMatName(String inputMatName) {
		this.inputMatName = inputMatName;
	}

	public String getTraceCode() {
		return traceCode;
	}

	public void setTraceCode(String traceCode) {
		this.traceCode = traceCode;
	}
	
	
	
	
}
