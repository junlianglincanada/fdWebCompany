package com.wondersgroup.operation.input.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.InputMaterial;


/**
 * 产出品进货原料（input material）
 */
public class DTOOutputMatBomQueryData {

    private Integer id;
    private String name;
    private String spec;
    private String manufacture;
    private Integer typeGeneral;
    private String productionBarcode;
    private Integer guaranteeValue;
    private Integer guaranteeUnit;
    private String code;
    public DTOOutputMatBomQueryData() {
    }

    public static DTOOutputMatBomQueryData createByEntity(InputMaterial domainInstance) {
        DTOOutputMatBomQueryData dtoInstance = null;
        if (domainInstance != null) {
            dtoInstance = new DTOOutputMatBomQueryData();
            dtoInstance.setId(domainInstance.getId());
            dtoInstance.setName(domainInstance.getName());
            dtoInstance.setSpec(domainInstance.getSpec());
            dtoInstance.setManufacture(domainInstance.getManufacture());
            dtoInstance.setTypeGeneral(domainInstance.getTypeGeneral());
            dtoInstance.setProductionBarcode(domainInstance.getProductionBarcode());
            dtoInstance.setGuaranteeValue(domainInstance.getGuaranteeValue());
            dtoInstance.setGuaranteeUnit(domainInstance.getGuaranteeUnit());
            dtoInstance.setCode(domainInstance.getCode());
        }
        return dtoInstance;
    }

    public static List<DTOOutputMatBomQueryData> createListByEntities(Collection<InputMaterial> domainInstanceList) {
        List<DTOOutputMatBomQueryData> list = new ArrayList<DTOOutputMatBomQueryData>();
        if (domainInstanceList != null) {
            for (InputMaterial domainInstance : domainInstanceList) {
                DTOOutputMatBomQueryData data = createByEntity(domainInstance);
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

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}


}
