package com.wondersgroup.operation.input.model;

import java.math.BigDecimal;
import java.util.Date;
import java.util.UUID;

import javax.validation.constraints.NotNull;

import com.wondersgroup.data.jpa.entity.InputBatchDetail;
import com.wondersgroup.data.jpa.entity.InputMaterial;
import com.wondersgroup.data.jpa.entity.IntCompany;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.service.company.InternalCompanyService;
import com.wondersgroup.service.input.InputMaterialService;
import com.wondersgroup.util.TimeOrDateUtils;

/**
 * 用户录入和更新台账明细信息
 *
 * @author wangei
 *
 */
public class DTOInputBatchCreate {
	// 进货日期
	@NotNull
	private Date inputDate;
	
	// 供应商id
	@NotNull
	private Integer supplierId;
	
	//采购品id
	@NotNull
	private Integer inputMatId;
	
	//生产单位
	@NotNull
	private String manufacture;
	
	//规格
	@NotNull
	private String spec;
	
	// 数量
	@NotNull
	private BigDecimal quantity;
	
	//生产日期
	private Date productionDate;
	
	//生产批号
	private String productionBatch;
	//追溯码
	private String traceCode;
	
	

	public DTOInputBatchCreate() {
	}

	public static InputBatchDetail toEntity(DTOInputBatchCreate dto, int companyId, InternalCompanyService intCompanyService, InputMaterialService inputMaterialService, Integer loginUserId, String loginUserName) {
		InputBatchDetail entity = null;
		try {
			entity = new InputBatchDetail();
			//基本信息
			entity.setId(UUID.randomUUID().toString().replaceAll("-", ""));
			entity.setCompanyId(companyId);
			entity.setCreateDate(new Date());
			entity.setLastModifiedDate(new Date());
			entity.setQuantity(dto.getQuantity());
			entity.setProductionDate(dto.getProductionDate());
			entity.setProductionBatch(dto.getProductionBatch());
			entity.setInputDate(dto.getInputDate());
			entity.setCreateUser(loginUserId);
			entity.setCreateUserName(loginUserName);
			//追溯码
			entity.setTraceCode(dto.getTraceCode());
			
			//供应商信息
			IntCompany supplier = intCompanyService.getInternalCompanyById(dto.getSupplierId());
			if (supplier  == null) {
				throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
			}
			entity.setSupplierId(supplier.getId());
			entity.setSupplierName(supplier.getName());
			
			//采购品信息
			InputMaterial inputMat = inputMaterialService.getInputMaterialById(dto.getInputMatId());
			if (inputMat == null) {
				throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
			}
			entity.setInputMatId(inputMat.getId());
			entity.setInputMatName(inputMat.getName());
			entity.setCode(inputMat.getCode());
			entity.setTypeGeneral(inputMat.getTypeGeneral());
			entity.setSpec(inputMat.getSpec());
			entity.setGuaranteeValue(inputMat.getGuaranteeValue());
			entity.setGuaranteeUnit(inputMat.getGuaranteeUnit());
			entity.setManufacture(inputMat.getManufacture());
			entity.setPlaceOfProduction(inputMat.getPlaceOfProduction());

			
			//批次信息
			//批次号  = 进货日期+单位id+供应商id
			String newBatchId = TimeOrDateUtils.formateDate(dto.getInputDate(), TimeOrDateUtils.YMD)+"_"+companyId+"_"+supplier.getId();
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

	public String getTraceCode() {
		return traceCode;
	}

	public void setTraceCode(String traceCode) {
		this.traceCode = traceCode;
	}
	
}
