package com.wondersgroup.operation.system.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.DataDictDetail;
import com.wondersgroup.framework.support.CommonDomainDTO;

public class DTODataDictDetail extends CommonDomainDTO {
	private int id;
	
	private String value;
	
	private int typeid;
	
	private int sortNum;
	
	private String typeName;
	
	private int parentId;
	
	private String parentName;

	public DTODataDictDetail() {
	}
	
	public static List<DTODataDictDetail> createListByEntities(Collection<DataDictDetail> domainInstanceList) {
		List<DTODataDictDetail> list = new ArrayList<DTODataDictDetail>();
		if (domainInstanceList != null) {
			for (DataDictDetail domainInstance : domainInstanceList) {
				DTODataDictDetail data = toDTO(domainInstance);
				if (data != null) {
					list.add(data);
				}
			}
		}
		return list;
	}
	
	public static DTODataDictDetail toDTO(DataDictDetail entity) {
		DTODataDictDetail dto = new DTODataDictDetail();
		dto.setId(entity.getId());
		dto.setValue(entity.getValue());
		dto.setSortNum(entity.getSortNum());
		dto.setTypeid(entity.getType().getId());
		dto.setTypeName(entity.getType().getName());
		if(entity.getParent()!=null){
			dto.setParentId(entity.getParent().getId());
			dto.setParentName(entity.getParent().getValue());
		}
		
		return dto;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public int getTypeid() {
		return typeid;
	}

	public void setTypeid(int typeid) {
		this.typeid = typeid;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}

	public int getSortNum() {
		return sortNum;
	}

	public void setSortNum(int sortNum) {
		this.sortNum = sortNum;
	}
	
}
