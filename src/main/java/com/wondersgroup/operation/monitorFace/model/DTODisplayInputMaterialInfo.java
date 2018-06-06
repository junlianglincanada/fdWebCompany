package com.wondersgroup.operation.monitorFace.model;

import java.util.ArrayList;
import java.util.List;

import com.wondersgroup.data.jpa.entity.DisplayInputMaterial;

public class DTODisplayInputMaterialInfo {

	private int id;
	private String inputMatName;
	
	public static List<DTODisplayInputMaterialInfo> createByEntities(List<DisplayInputMaterial> entities){
		List<DTODisplayInputMaterialInfo> list = new ArrayList<>();
		if(entities!=null && entities.size()>0){
			for(DisplayInputMaterial entity : entities){
				DTODisplayInputMaterialInfo dto = createByEntity(entity);
				list.add(dto);
			}
		}
		return list;
	}
	public static DTODisplayInputMaterialInfo createByEntity(DisplayInputMaterial entity){
		DTODisplayInputMaterialInfo dto = null;
		if(entity!=null){
			dto = new DTODisplayInputMaterialInfo();
			dto.setId(entity.getId());
			dto.setInputMatName(entity.getInputMatName());
		}
		return dto;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getInputMatName() {
		return inputMatName;
	}
	public void setInputMatName(String inputMatName) {
		this.inputMatName = inputMatName;
	}
}
