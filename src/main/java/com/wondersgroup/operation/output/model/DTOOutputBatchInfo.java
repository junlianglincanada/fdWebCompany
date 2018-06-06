package com.wondersgroup.operation.output.model;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;
import com.wondersgroup.data.jpa.entity.OutputBatchDetail;

public class DTOOutputBatchInfo {
	
	private String id;
	// 发货日期
	@JsonFormat(shape=Shape.STRING,pattern="yyyy-MM-dd",timezone="GMT+8")
	private Date outputDate;
	
	// 收货商id
	private Integer receiverId;
	
	// 收货商
	private String receiverName;
	
	//采购品id
	private Integer outputMatId;
	
	//采购品
	private String outputMatName;
	
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

	public Date getOutputDate() {
		return outputDate;
	}

	public void setOutputDate(Date outputDate) {
		this.outputDate = outputDate;
	}

	public Integer getReceiverId() {
		return receiverId;
	}

	public void setReceiverId(Integer receiverId) {
		this.receiverId = receiverId;
	}

	public Integer getOutputMatId() {
		return outputMatId;
	}
	
	public String getOutputMatName() {
		return outputMatName;
	}

	public void setOutputMatName(String outputMatName) {
		this.outputMatName = outputMatName;
	}

	public void setOutputMatId(Integer outputMatId) {
		this.outputMatId = outputMatId;
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

	public String getTraceCode() {
		return traceCode;
	}

	public void setTraceCode(String traceCode) {
		this.traceCode = traceCode;
	}

	public static DTOOutputBatchInfo toDTO(OutputBatchDetail entity) {
		DTOOutputBatchInfo dto = null;
		if(entity!=null){
			dto = new DTOOutputBatchInfo();
			dto.setId(entity.getId());
			dto.setOutputDate(entity.getOutputDate());
			dto.setOutputMatId(entity.getOutputMatId());
			dto.setOutputMatName(entity.getOutputMatName());
			dto.setManufacture(entity.getManufacture());
			dto.setProductionBatch(entity.getProductionBatch());
			dto.setProductionDate(entity.getProductionDate());
			dto.setQuantity(entity.getQuantity());
			dto.setSpec(entity.getSpec());
			dto.setReceiverId(entity.getReceiverId());
			dto.setReceiverName(entity.getReceiverName());
			dto.setTraceCode(entity.getTraceCode());
		}
		return dto;
	}

	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}
	
}
