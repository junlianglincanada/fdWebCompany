package com.wondersgroup.operation.output.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;
import com.wondersgroup.data.jpa.entity.OutputBatchDetail;
import com.wondersgroup.data.jpa.entity.OutputBatchDetailHistory;
import com.wondersgroup.framework.common.DataDictService;

public class DTOOutputBatchQueryData {
	private String id;
	@JsonFormat(shape = Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
	private Date outputDate;
	private String outputMatName;
	private String spec;
	private String manufacture;
	private BigDecimal quantity;
	private String newBatchId;
	private Integer guaranteeValue;
	private Integer guaranteeUnit;
	private String guaranteeUnitString;
	private String receiverName;
	private String traceCode;
	private Date productionDate;
	private String productionBatch;

	public DTOOutputBatchQueryData() {
	}

	public static DTOOutputBatchQueryData createByEntity(OutputBatchDetail entity) {
		DTOOutputBatchQueryData dto = null;
		if (entity != null) {
			dto = new DTOOutputBatchQueryData();
			dto.setId(entity.getId());
			dto.setOutputDate(entity.getOutputDate());
			dto.setOutputMatName(entity.getOutputMatName());
			dto.setSpec(entity.getSpec());
			dto.setManufacture(entity.getManufacture());
			dto.setQuantity(entity.getQuantity());
			dto.setTraceCode(entity.getTraceCode());
			dto.setReceiverName(entity.getReceiverName());
			dto.setProductionDate(entity.getProductionDate());
			dto.setProductionBatch(entity.getProductionBatch());
			if (null!=entity.getGuaranteeValue()&&entity.getGuaranteeValue() > 0) {
				dto.setGuaranteeValue(entity.getGuaranteeValue());
				Integer _guaranteeUnit = entity.getGuaranteeUnit();
				dto.setGuaranteeUnit(_guaranteeUnit);
				if (_guaranteeUnit != null) {
					String guaranteeUnitString = DataDictService.getDataDicDetailNameById(_guaranteeUnit);
					dto.setGuaranteeUnitString(guaranteeUnitString);
				}
			}
		}
		return dto;
	}
	
	public static DTOOutputBatchQueryData createByHistoryEntity(OutputBatchDetailHistory entity) {
		DTOOutputBatchQueryData dto = null;
		if (entity != null) {
			dto = new DTOOutputBatchQueryData();
			dto.setId(entity.getId());
			dto.setOutputDate(entity.getOutputDate());
			dto.setOutputMatName(entity.getOutputMatName());
			dto.setSpec(entity.getSpec());
			dto.setManufacture(entity.getManufacture());
			dto.setQuantity(entity.getQuantity());
			dto.setTraceCode(entity.getTraceCode());
			dto.setReceiverName(entity.getReceiverName());
			dto.setProductionDate(entity.getProductionDate());
			dto.setProductionBatch(entity.getProductionBatch());
			if (null!=entity.getGuaranteeValue()&&entity.getGuaranteeValue() > 0) {
				dto.setGuaranteeValue(entity.getGuaranteeValue());
				Integer _guaranteeUnit = entity.getGuaranteeUnit();
				dto.setGuaranteeUnit(_guaranteeUnit);
				if (_guaranteeUnit != null) {
					String guaranteeUnitString = DataDictService.getDataDicDetailNameById(_guaranteeUnit);
					dto.setGuaranteeUnitString(guaranteeUnitString);
				}
			}
		}
		return dto;
	}

	public static List<DTOOutputBatchQueryData> createListByEntities(Collection<OutputBatchDetail> domainInstanceList) {
		List<DTOOutputBatchQueryData> list = new ArrayList<>();
		if (domainInstanceList != null) {
			for (OutputBatchDetail domainInstance : domainInstanceList) {
				DTOOutputBatchQueryData data = createByEntity(domainInstance);
				if (data != null) {
					list.add(data);
				}
			}
		}
		return list;
	}
	
	public static List<DTOOutputBatchQueryData> createListByHistoryEntities(Collection<OutputBatchDetailHistory> domainInstanceList) {
		List<DTOOutputBatchQueryData> list = new ArrayList<>();
		if (domainInstanceList != null) {
			for (OutputBatchDetailHistory domainInstance : domainInstanceList) {
				DTOOutputBatchQueryData data = createByHistoryEntity(domainInstance);
				if (data != null) {
					list.add(data);
				}
			}
		}
		return list;
	}

	public BigDecimal getQuantity() {
		return quantity;
	}

	public void setQuantity(BigDecimal quantity) {
		this.quantity = quantity;
	}

	public Date getOutputDate() {
		return outputDate;
	}

	public void setOutputDate(Date outputDate) {
		this.outputDate = outputDate;
	}

	public String getOutputMatName() {
		return outputMatName;
	}

	public void setOutputMatName(String outputMatName) {
		this.outputMatName = outputMatName;
	}

	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	public Date getProductionDate() {
		return productionDate;
	}

	public void setProductionDate(Date productionDate) {
		this.productionDate = productionDate;
	}

	public String getSpec() {
		return spec;
	}

	public void setSpec(String spec) {
		this.spec = spec;
	}

	public String getManufacture() {
		return manufacture;
	}

	public void setManufacture(String manufacture) {
		this.manufacture = manufacture;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getNewBatchId() {
		return newBatchId;
	}

	public void setNewBatchId(String newBatchId) {
		this.newBatchId = newBatchId;
	}

	public Integer getGuaranteeValue() {
		return guaranteeValue;
	}

	public void setGuaranteeValue(Integer guaranteeValue) {
		this.guaranteeValue = guaranteeValue;
	}

	public Integer getGuaranteeUnit() {
		return guaranteeUnit;
	}

	public void setGuaranteeUnit(Integer guaranteeUnit) {
		this.guaranteeUnit = guaranteeUnit;
	}

	public String getTraceCode() {
		return traceCode;
	}

	public void setTraceCode(String traceCode) {
		this.traceCode = traceCode;
	}

	public String getGuaranteeUnitString() {
		return guaranteeUnitString;
	}

	public void setGuaranteeUnitString(String guaranteeUnitString) {
		this.guaranteeUnitString = guaranteeUnitString;
	}

	public String getProductionBatch() {
		return productionBatch;
	}

	public void setProductionBatch(String productionBatch) {
		this.productionBatch = productionBatch;
	}

}
