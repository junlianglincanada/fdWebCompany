package com.wondersgroup.operation.output.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.IntCompany;

/**
 *
 * @author wanglei
 *
 */
public class DTOReceiverQueryDataForSelect {

    private Integer id;
    private String name;

    public DTOReceiverQueryDataForSelect() {

    }

    public static DTOReceiverQueryDataForSelect createByEntity(IntCompany entity) {
        DTOReceiverQueryDataForSelect dto = null;
        if (entity != null) {
            dto = new DTOReceiverQueryDataForSelect();
            dto.setId(entity.getId());
            dto.setName(entity.getName());
        }
        return dto;
    }

    public static List<DTOReceiverQueryDataForSelect> createListByEntities(Collection<IntCompany> domainInstanceList) {
        List<DTOReceiverQueryDataForSelect> list = new ArrayList<DTOReceiverQueryDataForSelect>();
        if (domainInstanceList != null) {
            for (IntCompany domainInstance : domainInstanceList) {
                DTOReceiverQueryDataForSelect data = createByEntity(domainInstance);
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
