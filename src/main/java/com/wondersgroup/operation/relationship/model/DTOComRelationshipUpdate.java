package com.wondersgroup.operation.relationship.model;

import java.util.Date;

import javax.validation.constraints.NotNull;

import com.wondersgroup.data.jpa.entity.ComRelationship;
import com.wondersgroup.service.company.ComRelationshipService;

public class DTOComRelationshipUpdate {

	@NotNull
	private int id;
	
	private Integer companyToType;
	
	public static ComRelationship toEntity(DTOComRelationshipUpdate dto,ComRelationshipService comRelationshipService){
		ComRelationship entity=comRelationshipService.getComRelationshipById(dto.getId());
		if(entity!=null){
			entity.setCompanyToType(dto.getCompanyToType());
			entity.setLastModifiedDate(new Date());
		}
		return entity;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Integer getCompanyToType() {
		return companyToType;
	}

	public void setCompanyToType(Integer companyToType) {
		this.companyToType = companyToType;
	}
}
