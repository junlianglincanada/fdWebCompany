package com.wondersgroup.operation.output.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.OutputMaterial;
import com.wondersgroup.framework.common.DataDictService;

public class DTOOutputMaterialQueryData {
	
	private Integer id;
    private String name;
    private String productionBarcode;
    private String spec;
    private String manufacture;
    private Integer typeGeneral;
    private String typeGeneralValue;
    private String code;
    public DTOOutputMaterialQueryData() {
    }

    public static DTOOutputMaterialQueryData createByEntity(OutputMaterial entity) {
        DTOOutputMaterialQueryData dto = null;
        if (entity != null) {
            dto = new DTOOutputMaterialQueryData();

            dto.setId(entity.getId());
            dto.setName(entity.getName());
            dto.setProductionBarcode(entity.getProductionBarcode());
            dto.setSpec(entity.getSpec());
            dto.setManufacture(entity.getManufacture());
            
            Integer typeGeneral = entity.getTypeGeneral();
            dto.setTypeGeneral(typeGeneral);
            String typeGeneralValue = DataDictService.getDataDicDetailNameById(typeGeneral);
            dto.setTypeGeneralValue(typeGeneralValue);
            dto.setCode(entity.getCode());
        }
        return dto;
    }

    public static List<DTOOutputMaterialQueryData> createListByEntities(Collection<OutputMaterial> entityies) {
        List<DTOOutputMaterialQueryData> list = new ArrayList<>();
        if (entityies != null) {
            for (OutputMaterial entity : entityies) {
                DTOOutputMaterialQueryData data = createByEntity(entity);
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
