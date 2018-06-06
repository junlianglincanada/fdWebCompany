package com.wondersgroup.operation.input.model;


import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.data.jpa.entity.InputMaterial;
import com.wondersgroup.operation.util.formatter.QJ2BJDeserializer;
import com.wondersgroup.util.PinYinUtil;

/**
 *
 * @author wanglei
 *
 */
@JsonIgnoreProperties(ignoreUnknown=true)
public class DTOInputMaterialCreate {
	
	

    //名称
    @NotBlank
    @JsonDeserialize(using = QJ2BJDeserializer.class)
    private String name;
    //规格
    @NotBlank(message="spec.notblank")
    @JsonDeserialize(using = QJ2BJDeserializer.class)
    private String spec;
    //生产企业
    @JsonDeserialize(using = QJ2BJDeserializer.class)
    private String manufacture;
    //保质天数
    private Integer guaranteeValue;
    private Integer guaranteeUnit;
    //采购品分类
    @NotNull
    private Integer typeGeneral;
	//商品条码
    @JsonDeserialize(using = QJ2BJDeserializer.class)
    private String productionBarcode;
    @JsonDeserialize(using = QJ2BJDeserializer.class)
    private String code;

    public static InputMaterial toEntity(DTOInputMaterialCreate dto, Company company) {
    	InputMaterial entity = null;
        if (dto != null) {
            if (entity == null) {
                entity = new InputMaterial();
                entity.setCreateDate(new Date());
            }
            entity.setCompanyId(company.getCompanyId());
            entity.setName(dto.getName().trim());
            entity.setSpec(dto.getSpec().trim());
            entity.setManufacture(dto.getManufacture().trim());
            if(null!=dto.getGuaranteeValue()&&dto.getGuaranteeValue()>0){
            	entity.setGuaranteeValue(dto.getGuaranteeValue());
                entity.setGuaranteeUnit(dto.getGuaranteeUnit());
            }
            entity.setProductionBarcode(dto.getProductionBarcode().trim());
            entity.setTypeGeneral(dto.getTypeGeneral());
            entity.setCode(dto.getCode().trim());
            //中文拼音
            String pinyin = null;
            if(dto.getName()!=null && !dto.getName().isEmpty()){
                pinyin = PinYinUtil.getFirstSpell(dto.getName().trim());
            }
            entity.setNamePy((pinyin!=null)?pinyin.toUpperCase():pinyin);
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


	public String getCode() {
		return code;
	}


	public void setCode(String code) {
		this.code = code;
	}


}
