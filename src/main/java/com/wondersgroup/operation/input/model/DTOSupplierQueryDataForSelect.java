package com.wondersgroup.operation.input.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.IntCompany;

/**
 *
 * @author wanglei
 *
 */
public class DTOSupplierQueryDataForSelect {

    private Integer id;
    private String name;
    

    public DTOSupplierQueryDataForSelect() {

    }

    public static DTOSupplierQueryDataForSelect createByEntity(IntCompany entity) {
        DTOSupplierQueryDataForSelect dto = null;
        if (entity != null) {
            dto = new DTOSupplierQueryDataForSelect();
            dto.setId(entity.getId());
            dto.setName(entity.getName());
        }
        return dto;
    }

    public static List<DTOSupplierQueryDataForSelect> createListByEntities(Collection<IntCompany> domainInstanceList) {
        List<DTOSupplierQueryDataForSelect> list = new ArrayList<DTOSupplierQueryDataForSelect>();
        if (domainInstanceList != null) {
            for (IntCompany domainInstance : domainInstanceList) {
                DTOSupplierQueryDataForSelect data = createByEntity(domainInstance);
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




}
