package com.wondersgroup.operation.monitorFace.model;

import com.wondersgroup.data.jpa.entity.DisplayInputMaterial;

public class DTODisplayInputMaterialCreate {

	private String inputMatName;
	
	public static DisplayInputMaterial createByDto(int companyId,DTODisplayInputMaterialCreate dto){
		DisplayInputMaterial entity = null;
		if(dto!=null){
			entity = new DisplayInputMaterial();
			entity.setInputMatName(dto.getInputMatName());
			entity.setCompanyId(companyId);
		}
		return entity;
	}

	public String getInputMatName() {
		return inputMatName;
	}

	public void setInputMatName(String inputMatName) {
		this.inputMatName = inputMatName;
	}
}
