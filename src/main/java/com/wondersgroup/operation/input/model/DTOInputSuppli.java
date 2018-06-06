package com.wondersgroup.operation.input.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.IntCompany;

public class DTOInputSuppli {
	 private Integer id;
	 private String name;
	 private Integer total;
		public DTOInputSuppli() {

	    }

public static DTOInputSuppli createByEntity(IntCompany entity) {
	DTOInputSuppli dto = null;
    if (entity != null) {
        dto = new DTOInputSuppli();
        dto.setId(entity.getId());
        dto.setName(entity.getName());
    }
    return dto;
}
public static List<DTOInputSuppli> createListByEntities(Collection<IntCompany> domainInstanceList) {
    List<DTOInputSuppli> list = new ArrayList<DTOInputSuppli>();
    if (domainInstanceList != null) {
        for (IntCompany domainInstance : domainInstanceList) {
        	DTOInputSuppli data = createByEntity(domainInstance);
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
public Integer getTotal() {
    return total;
}

public void setTotal(Integer total) {
    this.total = total;
}
}