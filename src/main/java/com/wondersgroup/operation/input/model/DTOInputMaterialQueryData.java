package com.wondersgroup.operation.input.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.InputMaterial;
import com.wondersgroup.framework.common.DataDictService;

/**
 *
 * @author wanglei
 */
public class DTOInputMaterialQueryData {

    private Integer id;
    private String name;
    private String productionBarcode;
    private String spec;
    private String manufacture;
    private String placeOfProduction;
    private Integer typeGeneral;
    private String typeGeneralValue;
    private String code;
    
    public DTOInputMaterialQueryData() {
    }

    public static DTOInputMaterialQueryData createByEntity(InputMaterial entity) {
        DTOInputMaterialQueryData dto = null;
        if (entity != null) {
            dto = new DTOInputMaterialQueryData();

            dto.setId(entity.getId());
            dto.setName(entity.getName());
            dto.setProductionBarcode(entity.getProductionBarcode());
            dto.setSpec(entity.getSpec());
            dto.setManufacture(entity.getManufacture());
            dto.setPlaceOfProduction(entity.getPlaceOfProduction());
            
            Integer typeGeneral = entity.getTypeGeneral();
            dto.setTypeGeneral(typeGeneral);
            String typeGeneralValue = DataDictService.getDataDicDetailNameById(typeGeneral);
            dto.setTypeGeneralValue(typeGeneralValue);
            dto.setCode(entity.getCode());
        }
        return dto;
    }

    public static List<DTOInputMaterialQueryData> createListByEntities(Collection<InputMaterial> entityies) {
        List<DTOInputMaterialQueryData> list = new ArrayList<>();
        if (entityies != null) {
            for (InputMaterial entity : entityies) {
                DTOInputMaterialQueryData data = createByEntity(entity);
                if (data != null) {
                    list.add(data);
                }
            }
        }
        return list;
    }

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

    public String getPlaceOfProduction() {
        return placeOfProduction;
    }

    public void setPlaceOfProduction(String placeOfProduction) {
        this.placeOfProduction = placeOfProduction;
    }

    public Integer getTypeGeneral() {
        return typeGeneral;
    }

    public void setTypeGeneral(Integer typeGeneral) {
        this.typeGeneral = typeGeneral;
    }


	public String getProductionBarcode() {
		return productionBarcode;
	}

	public void setProductionBarcode(String productionBarcode) {
		this.productionBarcode = productionBarcode;
	}

	public String getTypeGeneralValue() {
		return typeGeneralValue;
	}

	public void setTypeGeneralValue(String typeGeneralValue) {
		this.typeGeneralValue = typeGeneralValue;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
}
