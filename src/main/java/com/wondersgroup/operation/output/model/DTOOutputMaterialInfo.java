package com.wondersgroup.operation.output.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.InputMaterial;
import com.wondersgroup.data.jpa.entity.OutputMatBom;
import com.wondersgroup.data.jpa.entity.OutputMaterial;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.DataUtil;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.operation.input.model.DTOInputMaterialInfo;
import com.wondersgroup.service.input.InputMaterialService;
import com.wondersgroup.service.output.OutputMaterialService;

public class DTOOutputMaterialInfo {
	
	private Integer id;
    private String name;
    //规格
    private String spec;
    //生产企业
    private String manufacture;
    //保质天数
    private Integer guaranteeValue;
    //保质期单位
    private Integer guaranteeUnit;
    private String guaranteeUnitString;
    //商品条码
    private String productionBarcode;
    //产品分类
    private Integer typeGeneral;
    private String typeGeneralValue;
    //关联的采购品
    private List<DTOInputMaterialInfo> inputMaterialList;
    private String code;
    // 是否设为菜肴
 	private Integer isCuisine;
    

    public static DTOOutputMaterialInfo createByEntity(OutputMaterial entity,List<OutputMatBom> outputMatBomlist,InputMaterialService inputMaterialService) {
        DTOOutputMaterialInfo dto = null;
        if (entity != null) {
            dto = new DTOOutputMaterialInfo();
            dto.setId(entity.getId());
            dto.setName(entity.getName());
            dto.setSpec(entity.getSpec());
            dto.setManufacture(entity.getManufacture());
            dto.setGuaranteeValue(entity.getGuaranteeValue());
            dto.setProductionBarcode(entity.getProductionBarcode());
            
            Integer typeGeneral = entity.getTypeGeneral();
            dto.setTypeGeneral(typeGeneral);
            String typeGeneralValue = DataDictService.getDataDicDetailNameById(typeGeneral);
            dto.setTypeGeneralValue(typeGeneralValue);
            
            Integer _guaranteeUnit = entity.getGuaranteeUnit();
			dto.setGuaranteeUnit(_guaranteeUnit);
            if(_guaranteeUnit!=null){
            	String guaranteeUnitString = DataDictService.getDataDicDetailNameById(_guaranteeUnit);
            	dto.setGuaranteeUnitString(guaranteeUnitString);
            }
//   9.28
            List<DTOInputMaterialInfo> inputMaterialList=new ArrayList<>();
            if(null!=outputMatBomlist&&outputMatBomlist.size()>0){
            	for (OutputMatBom outputMatBom:outputMatBomlist) {
            		   InputMaterial material = inputMaterialService.getInputMaterialById(outputMatBom.getInputMatId());
            		   if(null==material|| DataUtil.isDeleted(material.getDelFlag())){
            			   continue;
            		   }else {
            				DTOInputMaterialInfo inputdto = DTOInputMaterialInfo.createByEntity(material);
            				inputMaterialList.add(inputdto);
					}
				}
            	dto.setInputMaterialList(inputMaterialList);
            }
            dto.setCode(entity.getCode());
            dto.setIsCuisine(entity.getIsCuisine());	
  
            
        }
        return dto;
    }

//    public static List<DTOOutputMaterialInfo> createListByEntities(Collection<OutputMaterial> entityList) {
//        List<DTOOutputMaterialInfo> list = new ArrayList<>();
//        if (entityList != null) {
//            for (OutputMaterial entity : entityList) {
//                DTOOutputMaterialInfo data = createByEntity(entity);
//                if (data != null) {
//                    list.add(data);
//                }
//            }
//        }
//        return list;
//    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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



	public String getTypeGeneralValue() {
		return typeGeneralValue;
	}

	public void setTypeGeneralValue(String typeGeneralValue) {
		this.typeGeneralValue = typeGeneralValue;
	}

	public String getGuaranteeUnitString() {
		return guaranteeUnitString;
	}

	public void setGuaranteeUnitString(String guaranteeUnitString) {
		this.guaranteeUnitString = guaranteeUnitString;
	}

	public List<DTOInputMaterialInfo> getInputMaterialList() {
		return inputMaterialList;
	}

	public void setInputMaterialList(List<DTOInputMaterialInfo> inputMaterialList) {
		this.inputMaterialList = inputMaterialList;
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
