package com.wondersgroup.operation.output.model;

import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.validation.constraints.NotNull;

import org.apache.commons.lang.StringUtils;
import org.hibernate.validator.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.wondersgroup.data.jpa.entity.OutputMaterial;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.util.formatter.QJ2BJDeserializer;
import com.wondersgroup.util.PinYinUtil;

/**
 *
 * @author wanglei
 */
@JsonIgnoreProperties(ignoreUnknown=true)
public class DTOOutputMaterialCreate {
	// 名称
	@NotBlank
	@JsonDeserialize(using = QJ2BJDeserializer.class)
	private String name;
	// 商品条码
	private String productionBarcode;
	// 规格
	@NotBlank
	@JsonDeserialize(using = QJ2BJDeserializer.class)
	private String spec;
	// 生产企业
	@JsonDeserialize(using = QJ2BJDeserializer.class)
	private String manufacture;
	// 保质天数
	private Integer guaranteeValue;
	private Integer guaranteeUnit;
	// 采购品分类
	@NotNull
	private Integer typeGeneral;
    // 关联采购品
	private Set<Integer> inputMatIdList;
	@JsonDeserialize(using = QJ2BJDeserializer.class)
    private String code;
	// 是否设为菜肴
	private Integer isCuisine;
	public DTOOutputMaterialCreate() {
	}

	public static OutputMaterial toEntity(DTOOutputMaterialCreate dto, int companyId) {
		OutputMaterial entity = null;
		if (dto != null) {
			entity = new OutputMaterial();
			entity.setStatus(FoodConstant.FIELD_STATUS_VALID);
			entity.setCreateDate(new Date());
			entity.setName(dto.getName().trim());
			entity.setProductionBarcode(dto.getProductionBarcode().trim());
			entity.setSpec(dto.getSpec().trim());
			entity.setManufacture(dto.getManufacture().trim());
			entity.setTypeGeneral(dto.getTypeGeneral());
			if(null!=dto.getGuaranteeValue()&&dto.getGuaranteeValue()>0){
            	entity.setGuaranteeValue(dto.getGuaranteeValue());
                entity.setGuaranteeUnit(dto.getGuaranteeUnit());
            }
			// 置空菜肴相关信息
			entity.setSortNum(null);
			entity.setCuisineType(null);
			entity.setCuisineCustomType(null);
			
			//中文拼音
			String pinyin = null;
			if (StringUtils.isNotBlank(dto.getName())) {
				pinyin = PinYinUtil.getFirstSpell(dto.getName().trim());
			}
			entity.setNamePy((StringUtils.isNotBlank(pinyin)) ? pinyin.toUpperCase() : pinyin);
			entity.setCompanyId(companyId);
			entity.setCode(dto.getCode().trim());
			entity.setIsCuisine(dto.getIsCuisine());
		}
		return entity;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getProductionBarcode() {
		return productionBarcode;
	}

	public void setProductionBarcode(String productionBarcode) {
		this.productionBarcode = productionBarcode;
	}

	public Integer getTypeGeneral() {
		return typeGeneral;
	}

	public void setTypeGeneral(Integer typeGeneral) {
		this.typeGeneral = typeGeneral;
	}

	public Set<Integer> getInputMatIdList() {
		return inputMatIdList;
	}

	public void setInputMatIdList(Set<Integer> inputMatIdList) {
		this.inputMatIdList = inputMatIdList;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Integer getIsCuisine() {
		return isCuisine;
	}

	public void setIsCuisine(Integer isCuisine) {
		this.isCuisine = isCuisine;
	}



}
