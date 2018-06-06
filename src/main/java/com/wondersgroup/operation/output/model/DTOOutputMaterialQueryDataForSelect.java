package com.wondersgroup.operation.output.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.OutputMaterial;
import com.wondersgroup.framework.common.DataDictService;

public class DTOOutputMaterialQueryDataForSelect {
	
	private Integer id;
    private String name;
    
    public DTOOutputMaterialQueryDataForSelect() {
    }

    public static DTOOutputMaterialQueryDataForSelect createByEntity(OutputMaterial entity) {
        DTOOutputMaterialQueryDataForSelect dto = null;
        if (entity != null) {
            dto = new DTOOutputMaterialQueryDataForSelect();

            dto.setId(entity.getId());
            dto.setName(entity.getName());
            
        }
        return dto;
    }

    public static List<DTOOutputMaterialQueryDataForSelect> createListByEntities(Collection<OutputMaterial> entityies) {
        List<DTOOutputMaterialQueryDataForSelect> list = new ArrayList<>();
        if (entityies != null) {
            for (OutputMaterial entity : entityies) {
                DTOOutputMaterialQueryDataForSelect data = createByEntity(entity);
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
