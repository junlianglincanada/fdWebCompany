package com.wondersgroup.operation.input.model;


import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.wondersgroup.data.jpa.entity.InputMaterial;
import com.wondersgroup.operation.util.formatter.QJ2BJDeserializer;
import com.wondersgroup.service.input.InputMaterialService;
import com.wondersgroup.util.PinYinUtil;

/**
 *
 * @author wanglei
 *
 */
public class DTOInputMaterialUpdate {
	
	@NotNull
	private Integer id;
    //名称
    @NotBlank
    @JsonDeserialize(using = QJ2BJDeserializer.class)
    private String name;
    //规格
    @NotBlank
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
    private String productionBarcode;
    @JsonDeserialize(using = QJ2BJDeserializer.class)
    private String code;

//    //自定义类别(使用新类别时为null)
//    private Integer pTypeCustomId;
//    //自定义类别名称(自动添加新自定义类别使用)
//    private String pCustomTypeName;
 
    public static InputMaterial toEntity(DTOInputMaterialUpdate dtoInstance, InputMaterialService inputMaterialService) {
    	InputMaterial entityInstance = inputMaterialService.getInputMaterialById(dtoInstance.getId());
        if (dtoInstance != null) {
            if (entityInstance == null) {
                entityInstance = new InputMaterial();
                entityInstance.setCreateDate(new Date());
            }
            entityInstance.setName(dtoInstance.getName().trim());
            entityInstance.setSpec(dtoInstance.getSpec().trim());
            entityInstance.setManufacture(dtoInstance.getManufacture().trim());
            if(null!=dtoInstance.getGuaranteeValue()&&dtoInstance.getGuaranteeValue()>0){
            	entityInstance.setGuaranteeValue(dtoInstance.getGuaranteeValue());
            	entityInstance.setGuaranteeUnit(dtoInstance.getGuaranteeUnit());
            }else{
            	entityInstance.setGuaranteeValue(null);
            	entityInstance.setGuaranteeUnit(null);
            }
            entityInstance.setTypeGeneral(dtoInstance.getTypeGeneral());
            
            String pinyin = null;
            if(dtoInstance.getName()!=null && !dtoInstance.getName().isEmpty()){
                pinyin = PinYinUtil.getFirstSpell(dtoInstance.getName().trim());
            }
            entityInstance.setNamePy((pinyin!=null)?pinyin.toUpperCase():pinyin);
            entityInstance.setProductionBarcode(dtoInstance.getProductionBarcode().trim());
            entityInstance.setCode(dtoInstance.getCode().trim());
        }
        return entityInstance;
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



    public Integer getTypeGeneral() {
        return typeGeneral;
    }

    public void setTypeGeneral(Integer typeGeneral) {
        this.typeGeneral = typeGeneral;
    }


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getProductionBarcode() {
		return productionBarcode;
	}


	public void setProductionBarcode(String productionBarcode) {
		this.productionBarcode = productionBarcode;
	}


	public String getCode() {
		return code;
	}


	public void setCode(String code) {
		this.code = code;
	}


}
