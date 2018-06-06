package com.wondersgroup.operation.input.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.InputMaterial;
import com.wondersgroup.framework.common.DataDictService;

public class DTOInputMaterialInfo {

	  private Integer id;
	    private String name;
	    private String nameEn;
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
	    private String code;


	    public static DTOInputMaterialInfo createByEntity(InputMaterial entity) {
	        DTOInputMaterialInfo dto = null;
	        if (entity != null) {
	            dto = new DTOInputMaterialInfo();
	            dto.setId(entity.getId());
	            dto.setName(entity.getName());
	            dto.setNameEn(entity.getNameEN());
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
	            dto.setCode(entity.getCode());
	            
	        }
	        return dto;
	    }

	    public static List<DTOInputMaterialInfo> createListByEntities(Collection<InputMaterial> entityList) {
	        List<DTOInputMaterialInfo> list = new ArrayList<>();
	        if (entityList != null) {
	            for (InputMaterial entity : entityList) {
	                DTOInputMaterialInfo data = createByEntity(entity);
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

		public String getNameEn() {
			return nameEn;
		}

		public void setNameEn(String nameEn) {
			this.nameEn = nameEn;
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

		public String getCode() {
			return code;
		}

		public void setCode(String code) {
			this.code = code;
		}

}
