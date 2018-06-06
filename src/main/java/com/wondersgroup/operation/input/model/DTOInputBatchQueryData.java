package com.wondersgroup.operation.input.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;

import com.wondersgroup.data.jpa.entity.InputBatchDetail;
import com.wondersgroup.data.jpa.entity.InputBatchDetailHistory;
import com.wondersgroup.framework.common.DataDictService;

public class DTOInputBatchQueryData {

	private String id;
	private Date inputDate;
	private String inputMatName;
	private String spec;
	private String manufacture;
	private BigDecimal quantity;
	private String newBatchId;
	private Integer guaranteeValue;
	private Integer guaranteeUnit;
	private String guaranteeUnitString;
	private String supplierName;
	private Date productionDate;
	private String productionBatch;
	private String traceCode;
	private Integer supplierId;
	private Integer inputMatId;

	public DTOInputBatchQueryData() {

	}

	public static DTOInputBatchQueryData createByEntity(InputBatchDetail entity) {
		DTOInputBatchQueryData dto = null;
		if (entity != null) {
			dto = new DTOInputBatchQueryData();
			dto.setId(entity.getId());
			dto.setInputDate(entity.getInputDate());
			dto.setInputMatName(entity.getInputMatName());
			dto.setSpec(entity.getSpec());
			dto.setManufacture(entity.getManufacture());
			dto.setQuantity(entity.getQuantity());

			dto.setSupplierName(entity.getSupplierName());
			dto.setProductionDate(entity.getProductionDate());
			dto.setProductionBatch(entity.getProductionBatch());
			dto.setTraceCode(entity.getTraceCode());
			dto.setSupplierId(entity.getSupplierId());
			dto.setInputMatId(entity.getInputMatId());
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
	
	public static DTOInputBatchQueryData createByHistoryEntity(InputBatchDetailHistory entity) {
		DTOInputBatchQueryData dto = null;
		if (entity != null) {
			dto = new DTOInputBatchQueryData();
			dto.setId(entity.getId());
			dto.setInputDate(entity.getInputDate());
			dto.setInputMatName(entity.getInputMatName());
			dto.setSpec(entity.getSpec());
			dto.setManufacture(entity.getManufacture());
			dto.setQuantity(entity.getQuantity());

			dto.setSupplierName(entity.getSupplierName());
			dto.setProductionDate(entity.getProductionDate());
			dto.setProductionBatch(entity.getProductionBatch());
			dto.setTraceCode(entity.getTraceCode());
			dto.setSupplierId(entity.getSupplierId());
			dto.setInputMatId(entity.getInputMatId());
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

	public static List<DTOInputBatchQueryData> createListByEntities(Collection<InputBatchDetail> domainInstanceList) {
		List<DTOInputBatchQueryData> list = new ArrayList<>();
		if (domainInstanceList != null) {
			for (InputBatchDetail domainInstance : domainInstanceList) {
				DTOInputBatchQueryData data = createByEntity(domainInstance);
				if (data != null) {
					list.add(data);
				}
			}
		}
		return list;
	}
	
	public static List<DTOInputBatchQueryData> createListByHistoryEntities(Collection<InputBatchDetailHistory> domainInstanceList) {
		List<DTOInputBatchQueryData> list = new ArrayList<>();
		if (domainInstanceList != null) {
			for (InputBatchDetailHistory domainInstance : domainInstanceList) {
				DTOInputBatchQueryData data = createByHistoryEntity(domainInstance);
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

	public Date getInputDate() {
		return inputDate;
	}

	public void setInputDate(Date inputDate) {
		this.inputDate = inputDate;
	}

	public String getInputMatName() {
		return inputMatName;
	}

	public void setInputMatName(String inputMatName) {
		this.inputMatName = inputMatName;
	}

	public String getSupplierName() {
		return supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
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

	public Date getProductionDate() {
		return productionDate;
	}

	public void setProductionDate(Date productionDate) {
		this.productionDate = productionDate;
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

	public String getTraceCode() {
		return traceCode;
	}

	public void setTraceCode(String traceCode) {
		this.traceCode = traceCode;
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

}
