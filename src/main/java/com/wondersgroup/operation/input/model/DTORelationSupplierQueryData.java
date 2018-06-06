package com.wondersgroup.operation.input.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.IntCompany;

/**
 *
 *
 *
 */
public class DTORelationSupplierQueryData {

	private Integer id;
	private String name;
	// 地址
	private String contactAddress;
	// 店招名
	private String nameAbbrev;
	// 内部企业关联的真实companyId
	private Integer linkedCompanyId;
	// 是否自动售货 0:不自动收货，1:自动收货
	private int isAutoRecv;

	public DTORelationSupplierQueryData() {

	}

	public static DTORelationSupplierQueryData createByEntity(IntCompany entity) {
		DTORelationSupplierQueryData dto = null;
		if (entity != null) {
			dto = new DTORelationSupplierQueryData();
			dto.setId(entity.getId());
			dto.setName(entity.getName());
			dto.setContactAddress(entity.getContactAddress());
			dto.setNameAbbrev(entity.getNameAbbrev());
			dto.setLinkedCompanyId(entity.getLinkedCompanyId());
			dto.setIsAutoRecv(entity.getIsAutoRecv()==null?0:entity.getIsAutoRecv());
		}
		return dto;
	}

	public static List<DTORelationSupplierQueryData> createListByEntities(
			Collection<IntCompany> domainInstanceList) {
		List<DTORelationSupplierQueryData> list = new ArrayList<DTORelationSupplierQueryData>();
		if (domainInstanceList != null) {
			for (IntCompany domainInstance : domainInstanceList) {
				DTORelationSupplierQueryData data = createByEntity(domainInstance);
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

	public String getContactAddress() {
		return contactAddress;
	}

	public void setContactAddress(String contactAddress) {
		this.contactAddress = contactAddress;
	}

	public String getNameAbbrev() {
		return nameAbbrev;
	}

	public void setNameAbbrev(String nameAbbrev) {
		this.nameAbbrev = nameAbbrev;
	}

	public Integer getLinkedCompanyId() {
		return linkedCompanyId;
	}

	public void setLinkedCompanyId(Integer linkedCompanyId) {
		this.linkedCompanyId = linkedCompanyId;
	}

	public int getIsAutoRecv() {
		return isAutoRecv;
	}

	public void setIsAutoRecv(int isAutoRecv) {
		this.isAutoRecv = isAutoRecv;
	}

}
