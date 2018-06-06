package com.wondersgroup.operation.platform.model;

import java.util.Map;

import net.sf.json.JSONObject;

import com.wondersgroup.data.jpa.entity.InputMaterial;
import com.wondersgroup.data.jpa.entity.OutputMaterial;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.DataDicConstant;
import com.wondersgroup.util.StringUtils;

public class DTOPlatformMaterialInfo {

	private String name;
	private String spec;
	private String manufacture;
	private Integer guaranteeValue;
	private String guaranteeUnit;
	private Integer typeGeneral;
	private String code;
	private String nameEn;
	private String placeOfProduction;
	
	//static Map<String, Integer> typeGeneralMap = DataDictService.getDataDicDetailName2IdMap(DataDicConstant.DIC_INPUT_MAT_GENERAL_TYPE);
	static Map<Integer, String> typeGeneralMap = DataDictService.getDataDicDetailByType(DataDicConstant.DIC_INPUT_MAT_GENERAL_TYPE);
	static Map<String, Integer> unitMap = DataDictService.getDataDicDetailName2IdMap(DataDicConstant.DIC_DATE_UNIT);
	public static InputMaterial createInputMaterialByJson(JSONObject material,Integer companyId) throws Exception{
		InputMaterial entity=null;
		if(material!=null){
			entity = new InputMaterial();
			entity.setCompanyId(companyId);
			DTOPlatformMaterialInfo dto = (DTOPlatformMaterialInfo)JSONObject.toBean(material, DTOPlatformMaterialInfo.class);
			entity.setName(dto.getName());
			entity.setSpec(dto.getSpec());
			entity.setManufacture(dto.getManufacture());
			entity.setGuaranteeValue(dto.getGuaranteeValue());
			if(dto.getGuaranteeValue()!=null){
				if(StringUtils.isNotBlank(dto.getGuaranteeUnit())){
					Integer guaranteeUnit = unitMap.get(dto.getGuaranteeUnit());
					if (guaranteeUnit == null || guaranteeUnit < 1) {
						throw new FoodException("116016");
					}else{
						entity.setGuaranteeUnit(guaranteeUnit);
					}
				}else{
					throw new FoodException("116016");
				}
			}
//			if(StringUtils.isNotBlank(dto.getTypeGeneral())){
//				Integer typeGeneral = typeGeneralMap.get(dto.getTypeGeneral());
//				if (typeGeneral == null || typeGeneral < 1) {
//					throw new FoodException("116016");
//				}else{
//					entity.setTypeGeneral(typeGeneral);
//				}
//			}else{
//				throw new FoodException("116016");
//			}
			if(dto.getTypeGeneral() != null && dto.getTypeGeneral()>0){
				String typeValue = typeGeneralMap.get(dto.getTypeGeneral());
				if (typeValue == null) {
					throw new FoodException("116016");
				}else{
					entity.setTypeGeneral(dto.getTypeGeneral());
				}
			}else{
				throw new FoodException("116016");
			}
			entity.setCode(dto.getCode());
			entity.setNameEN(dto.getNameEn());
			entity.setPlaceOfProduction(dto.getPlaceOfProduction());
		}
		return entity;
	}
	public static OutputMaterial createOutputMaterialByJson(JSONObject material,Integer companyId) throws Exception{
		OutputMaterial entity=null;
		if(material!=null){
			entity = new OutputMaterial();
			entity.setCompanyId(companyId);
			DTOPlatformMaterialInfo dto = (DTOPlatformMaterialInfo)JSONObject.toBean(material, DTOPlatformMaterialInfo.class);
			entity.setName(dto.getName());
			entity.setSpec(dto.getSpec());
			entity.setManufacture(dto.getManufacture());
			entity.setGuaranteeValue(dto.getGuaranteeValue());
			if(dto.getGuaranteeValue()!=null){
				if(StringUtils.isNotBlank(dto.getGuaranteeUnit())){
					Integer guaranteeUnit = unitMap.get(dto.getGuaranteeUnit());
					if (guaranteeUnit == null || guaranteeUnit < 1) {
						throw new FoodException("116016");
					}else{
						entity.setGuaranteeUnit(guaranteeUnit);
					}
				}else{
					throw new FoodException("116016");
				}
			}
//			if(StringUtils.isNotBlank(dto.getTypeGeneral())){
//				Integer typeGeneral = typeGeneralMap.get(dto.getTypeGeneral());
//				if (typeGeneral == null || typeGeneral < 1) {
//					throw new FoodException("116016");
//				}else{
//					entity.setTypeGeneral(typeGeneral);
//				}
//			}else{
//				throw new FoodException("116016");
//			}
			if(dto.getTypeGeneral() != null && dto.getTypeGeneral()>0){
				String typeValue = typeGeneralMap.get(dto.getTypeGeneral());
				if (typeValue == null) {
					throw new FoodException("116016");
				}else{
					entity.setTypeGeneral(dto.getTypeGeneral());
				}
			}else{
				throw new FoodException("116016");
			}
			entity.setCode(dto.getCode());
			entity.setNameEN(dto.getNameEn());
			entity.setPlaceOfProduction(dto.getPlaceOfProduction());
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
	public String getGuaranteeUnit() {
		return guaranteeUnit;
	}
	public void setGuaranteeUnit(String guaranteeUnit) {
		this.guaranteeUnit = guaranteeUnit;
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
	public String getNameEn() {
		return nameEn;
	}
	public void setNameEn(String nameEn) {
		this.nameEn = nameEn;
	}
	public String getPlaceOfProduction() {
		return placeOfProduction;
	}
	public void setPlaceOfProduction(String placeOfProduction) {
		this.placeOfProduction = placeOfProduction;
	}
}
