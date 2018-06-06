package com.wondersgroup.operation.output.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.wondersgroup.data.jpa.entity.OutputBatchDetail;
import com.wondersgroup.data.jpa.entity.OutputMaterial;
import com.wondersgroup.data.jpa.entity.InputMaterial;
import com.wondersgroup.data.jpa.entity.IntCompany;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.DataUtil;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.operation.output.model.DTOOutputBatchUpdate;
import com.wondersgroup.operation.util.formatter.QJ2BJDeserializer;
import com.wondersgroup.service.company.InternalCompanyService;
import com.wondersgroup.service.output.OutputBatchService;
import com.wondersgroup.service.output.OutputMaterialService;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOOutputBatchUpdate {
	
	@NotNull
	private String id;
	// 进货日期
	private Date outputDate;
	// 供应商id
	private Integer receiverId;
	// 数量
	private BigDecimal quantity;
	// 生产日期
	private Date productionDate;
	// 生产批号
	private String productionBatch;
	//产品id
    private int outputMatId;
	// 删除标示
	private Integer delFlag;
	//追溯码
	private String traceCode;

	public DTOOutputBatchUpdate() {
	}

	public static OutputBatchDetail toEntity(DTOOutputBatchUpdate dto, int companyId, InternalCompanyService intCompanyService, OutputMaterialService outputMaterialService,
			OutputBatchService outputBatchService, Integer loginUserId, String loginUserName) {
		OutputBatchDetail entity = null;
		try {
			entity = outputBatchService.getOutputBatchDetailById(dto.getId());
			if (entity == null || DataUtil.isDeleted(entity.getDelFlag())) {
				throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
			}
			// 判断是否标示为删除
			Integer newDelFlag = dto.getDelFlag();
			if (DataUtil.isDeleted(newDelFlag)) {
				entity.setDelFlag(newDelFlag);
				return entity;
			}
			
			//判断基础数据 收货商，如果没有需要创建
			IntCompany receiver = intCompanyService.createIntCompanyIfNotExists(dto.getReceiverId(),companyId,IntCompany.COMPANY_TYPE_RECEIVER,entity.getReceiverName(),entity.getReceiverNameAbbrev(),entity.getReceiverCode());
			entity.setReceiverId(receiver.getId());
			entity.setReceiverName(receiver.getName());
			entity.setReceiverNameAbbrev(receiver.getNameAbbrev());
			//追溯码
			entity.setTraceCode(dto.getTraceCode());
			//判断基础数据 采购品，如果没有需要创建
			OutputMaterial outputMaterial = outputMaterialService.createOutputMaterialIfNotExists(dto.getOutputMatId(),companyId,entity.getOutputMatName(),entity.getSpec(),entity.getTypeGeneral(),entity.getManufacture(),entity.getCode(),entity.getGuaranteeUnit(),entity.getGuaranteeValue());
			entity.setOutputMatId(outputMaterial.getId());
			entity.setOutputMatName(outputMaterial.getName());
			entity.setSpec(outputMaterial.getSpec());
			entity.setManufacture(outputMaterial.getManufacture());
			entity.setTypeGeneral(outputMaterial.getTypeGeneral());
			
			// 基本信息
			if(dto.getOutputDate()==null){
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
			entity.setOutputDate(dto.getOutputDate());
			
			// 批次信息
			// 批次号 = 进货日期+单位id+供应商id
			String newBatchId = TimeOrDateUtils.formateDate(dto.getOutputDate(), TimeOrDateUtils.YMD) + "_" + companyId + "_" + entity.getReceiverId();
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

	public Integer getReceiverId() {
		return receiverId;
	}

	public void setReceiverId(Integer receiverId) {
		this.receiverId = receiverId;
	}

	public Date getOutputDate() {
		return outputDate;
	}

	public void setOutputDate(Date outputDate) {
		this.outputDate = outputDate;
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

	public int getOutputMatId() {
		return outputMatId;
	}

	public void setOutputMatId(int outputMatId) {
		this.outputMatId = outputMatId;
	}
	public String getTraceCode() {
		return traceCode;
	}

	public void setTraceCode(String traceCode) {
		this.traceCode = traceCode;
	}
	
}
