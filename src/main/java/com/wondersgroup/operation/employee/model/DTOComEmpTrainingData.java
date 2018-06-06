package com.wondersgroup.operation.employee.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.ComEmpTraining;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.util.TimeOrDateUtils;

/**
 *
 * @author wanglei
 */
public class DTOComEmpTrainingData {
    private Integer id;
    private String trainingOrg;
    private int trainingOrgType;
    private String trainingOrgTypeVal;
    private String startDate;
    private String endDate;
    private BigDecimal trainingHours;
    private String memo;

    public DTOComEmpTrainingData() {
    }
    
    public static DTOComEmpTrainingData createByEntity(ComEmpTraining entity) {
        DTOComEmpTrainingData dto = null;
        if (entity != null) {
            dto = new DTOComEmpTrainingData();
            dto.setId(entity.getId());
            dto.setTrainingOrg(entity.getTrainingOrg());
            int type = entity.getTrainingOrgType();
            if (type>0) {
            	dto.setTrainingOrgType(type);
                String typeValue = DataDictService.getDataDicDetailNameById(type);
                dto.setTrainingOrgTypeVal(typeValue);
			}
            
            dto.setStartDate(TimeOrDateUtils.formateDate(entity.getStartDate(), "yyyy-MM-dd"));
            dto.setEndDate(TimeOrDateUtils.formateDate(entity.getEndDate(), "yyyy-MM-dd"));
            dto.setTrainingHours(entity.getTrainingHours());
            dto.setMemo(entity.getMemo());
        }
        return dto;
    }

    public static List<DTOComEmpTrainingData> createListByEntities(Collection<ComEmpTraining> domainInstanceList) {
        List<DTOComEmpTrainingData> list = new ArrayList<>();
        if (domainInstanceList != null) {
            for (ComEmpTraining domainInstance : domainInstanceList) {
                DTOComEmpTrainingData data = createByEntity(domainInstance);
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

    public String getTrainingOrg() {
        return trainingOrg;
    }

    public void setTrainingOrg(String trainingOrg) {
        this.trainingOrg = trainingOrg;
    }

    public int getTrainingOrgType() {
        return trainingOrgType;
    }

    public void setTrainingOrgType(int trainingOrgType) {
        this.trainingOrgType = trainingOrgType;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public BigDecimal getTrainingHours() {
        return trainingHours;
    }

    public void setTrainingHours(BigDecimal trainingHours) {
        this.trainingHours = trainingHours;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

	public String getTrainingOrgTypeVal() {
		return trainingOrgTypeVal;
	}

	public void setTrainingOrgTypeVal(String trainingOrgTypeVal) {
		this.trainingOrgTypeVal = trainingOrgTypeVal;
	}
    
    
}
