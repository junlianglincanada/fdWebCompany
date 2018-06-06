package com.wondersgroup.operation.output.model;

import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.wondersgroup.data.jpa.entity.OutputMaterial;
import com.wondersgroup.operation.util.formatter.QJ2BJDeserializer;
import com.wondersgroup.service.output.OutputMaterialService;
import com.wondersgroup.util.PinYinUtil;
@JsonIgnoreProperties(ignoreUnknown=true)
public class DTOOutputMaterialUpdate {
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
    // 关联采购品
	private Set<Integer> inputMatIdList;
    private String productionBarcode;
    @JsonDeserialize(using = QJ2BJDeserializer.class)
    private String code;
    // 是否设为菜肴
 	private Integer isCuisine;
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


	public static OutputMaterial toEntity(DTOOutputMaterialUpdate dtoInstance, OutputMaterialService outputMaterialService) {
    	OutputMaterial entityInstance = outputMaterialService.getOutputMaterialById(dtoInstance.getId());
        if (dtoInstance != null) {
            if (entityInstance == null) {
                entityInstance = new OutputMaterial();
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
            entityInstance.setIsCuisine(dtoInstance.getIsCuisine());
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


	public Set<Integer> getInputMatIdList() {
		return inputMatIdList;
	}


	public void setInputMatIdList(Set<Integer> inputMatIdList) {
		this.inputMatIdList = inputMatIdList;
	}


	public Integer getIsCuisine() {
		return isCuisine;
	}


	public void setIsCuisine(Integer isCuisine) {
		this.isCuisine = isCuisine;
	}




	
}
