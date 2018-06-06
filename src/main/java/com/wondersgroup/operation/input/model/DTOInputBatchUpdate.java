package com.wondersgroup.operation.input.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.validation.constraints.NotNull;

import com.wondersgroup.data.jpa.entity.InputBatchDetail;
import com.wondersgroup.data.jpa.entity.InputMaterial;
import com.wondersgroup.data.jpa.entity.IntCompany;
import com.wondersgroup.data.jpa.entity.OutputMaterial;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.DataUtil;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.service.company.InternalCompanyService;
import com.wondersgroup.service.input.InputBatchService;
import com.wondersgroup.service.input.InputMaterialService;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOInputBatchUpdate {
	@NotNull
	private String id;
	// 进货日期
	private Date inputDate;
	// 供应商id
	private Integer supplierId;
	// 数量
	private BigDecimal quantity;
	// 生产日期
	private Date productionDate;
	// 生产批号
	private String productionBatch;
	// 删除标示
	private Integer delFlag;
	//追溯码
	private String traceCode;
	//采购品id
    private int inputMatId;

	public DTOInputBatchUpdate() {
	}

	public static InputBatchDetail toEntity(DTOInputBatchUpdate dto, int companyId, InternalCompanyService intCompanyService, InputMaterialService inputMaterialService,
			InputBatchService inputBatchService, Integer loginUserId, String loginUserName) {
		InputBatchDetail entity = null;
		try {
			entity = inputBatchService.getInputBatchDetailById(dto.getId());
			if (entity == null || DataUtil.isDeleted(entity.getDelFlag())) {
				throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
			}
			
			//判断基础数据 供应商，如果没有需要创建
			IntCompany supplier = intCompanyService.createIntCompanyIfNotExists(dto.getSupplierId(),companyId,IntCompany.COMPANY_TYPE_SUPPLIER,entity.getSupplierName(),entity.getSupplierNameAbbrev(),entity.getSupplierCode());
			entity.setSupplierId(supplier.getId());
			entity.setSupplierName(supplier.getName());
			entity.setSupplierNameAbbrev(supplier.getNameAbbrev());
			
			//判断基础数据 采购品，如果没有需要创建
			InputMaterial inputMaterial = inputMaterialService.createInputMaterialIfNotExists(dto.getInputMatId(),companyId,entity.getInputMatName(),entity.getSpec(),entity.getTypeGeneral(),entity.getManufacture(),entity.getCode(),entity.getGuaranteeUnit(),entity.getGuaranteeValue());
			entity.setInputMatId(inputMaterial.getId());
			entity.setInputMatName(inputMaterial.getName());
			entity.setSpec(inputMaterial.getSpec());
			entity.setManufacture(inputMaterial.getManufacture());
			entity.setTypeGeneral(inputMaterial.getTypeGeneral());
			
			// 首先 判断是否标示为删除
			Integer newDelFlag = dto.getDelFlag();
			if (DataUtil.isDeleted(newDelFlag)) {
				entity.setDelFlag(newDelFlag);
				return entity;
			}
			
			
			// 基本信息
			if(dto.getInputDate()==null){
				throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
			}
			if(dto.getQuantity()==null){
				throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
			}
			entity.setId(dto.getId());
			entity.setCompanyId(companyId);
			//entity.setCreateDate(new Date());
			entity.setLastModifiedDate(new Date());
			entity.setQuantity(dto.getQuantity());
			entity.setProductionDate(dto.getProductionDate());
			entity.setProductionBatch(dto.getProductionBatch());
			entity.setInputDate(dto.getInputDate());
			
			// 批次信息
			// 批次号 = 进货日期+单位id+供应商id
			String newBatchId = TimeOrDateUtils.formateDate(dto.getInputDate(), TimeOrDateUtils.YMD) + "_" + companyId + "_" + supplier.getId();
			//追溯码
			entity.setTraceCode(dto.getTraceCode());
			
			
			
		
		} catch (Exception e) {
			throw new FoodException(e);
		}
		return entity;
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

	public Integer getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(Integer supplierId) {
		this.supplierId = supplierId;
	}

	public Date getInputDate() {
		return inputDate;
	}

	public void setInputDate(Date inputDate) {
		this.inputDate = inputDate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Integer getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(Integer delFlag) {
		this.delFlag = delFlag;
	}

	public String getTraceCode() {
		return traceCode;
	}

	public void setTraceCode(String traceCode) {
		this.traceCode = traceCode;
	}

	public int getInputMatId() {
		return inputMatId;
	}

	public void setInputMatId(int inputMatId) {
		this.inputMatId = inputMatId;
	}
	
}
