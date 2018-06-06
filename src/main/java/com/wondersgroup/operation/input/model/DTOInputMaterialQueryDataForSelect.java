package com.wondersgroup.operation.input.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.InputMaterial;
import com.wondersgroup.framework.common.DataDictService;

/**
 *
 * @author wanglei
 */
public class DTOInputMaterialQueryDataForSelect {

    private Integer id;
    private String name;
    
    public DTOInputMaterialQueryDataForSelect() {
    }

    public static DTOInputMaterialQueryDataForSelect createByEntity(InputMaterial entity) {
        DTOInputMaterialQueryDataForSelect dto = null;
        if (entity != null) {
            dto = new DTOInputMaterialQueryDataForSelect();
            dto.setId(entity.getId());
            dto.setName(entity.getName());
        }
        return dto;
    }

    public static List<DTOInputMaterialQueryDataForSelect> createListByEntities(Collection<InputMaterial> entityies) {
        List<DTOInputMaterialQueryDataForSelect> list = new ArrayList<>();
        if (entityies != null) {
            for (InputMaterial entity : entityies) {
                DTOInputMaterialQueryDataForSelect data = createByEntity(entity);
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
