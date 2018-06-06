package com.wondersgroup.operation.input.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import com.wondersgroup.data.jpa.entity.OutputBatchDetail;
import com.wondersgroup.data.jpa.entity.Restaurant;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.service.company.RestaurantService;
import com.wondersgroup.util.TimeOrDateUtils;


/**
 *
 * @author wanglei
 */
public class DTOAutoReceiveQueryData {
    private String id;
    //配送日期
    private String outputDate;
    //产出品id
    private int outputMatId;
    //产出品名称
    private String outputMatName;
    //供应商单位ID
    private Integer supplierComId;
    //供应商单位名称
    private String supplierComName;
    //规格
    private String spec;
    //配送数量
    private BigDecimal quantity;
    //生产日期
    private Date productionDate;
    //生产批号
    private String productionBatch;
     //产品编号 5.4
    private String code;

    
    public static DTOAutoReceiveQueryData createByEntity(OutputBatchDetail entity,RestaurantService rs,DataDictService dds) {
        DTOAutoReceiveQueryData dto = null;
        if (entity != null) {
            dto = new DTOAutoReceiveQueryData();
            dto.setId(entity.getId());
            dto.setOutputMatName(entity.getOutputMatName());
            dto.setSpec(entity.getSpec());
            dto.setQuantity(entity.getQuantity());
            dto.setProductionDate(entity.getProductionDate());
            dto.setProductionBatch(entity.getProductionBatch());
            dto.setOutputMatId(entity.getOutputMatId());
            dto.setCode(entity.getCode());
            if(entity!=null){
                dto.setOutputDate(TimeOrDateUtils.formateDate(entity.getOutputDate(), TimeOrDateUtils.FULL_FROMAT));
                Integer companyId = entity.getCompanyId();
				dto.setSupplierComId(companyId);
				if(companyId!=null) {
					Restaurant restaurant = rs.getRestaurantById(companyId);
					dto.setSupplierComName(restaurant.getCompanyName());
				}
            }
            
            
        }
        return dto;
    }

    public static List<DTOAutoReceiveQueryData> createListByEntities(Collection<OutputBatchDetail> domainInstanceList,RestaurantService rs,DataDictService dds) {
        List<DTOAutoReceiveQueryData> list = new ArrayList<>();
        if (domainInstanceList != null) {
            for (OutputBatchDetail domainInstance : domainInstanceList) {
                DTOAutoReceiveQueryData data = createByEntity(domainInstance, rs, dds);
                if (data != null) {
                    list.add(data);
                }
            }
        }
        return list;
    }
    


    public String getSpec() {
        return spec;
    }

    public void setSpec(String spec) {
        this.spec = spec;
    }


    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    public Date getProductionDate() {
        return productionDate;
    }

    public void setProductionDate(Date productionDate) {
        this.productionDate = productionDate;
    }

    public String getProductionBatch() {
        return productionBatch;
    }

    public void setProductionBatch(String productionBatch) {
        this.productionBatch = productionBatch;
    }


    public String getOutputMatName() {
        return outputMatName;
    }

    public void setOutputMatName(String outputMatName) {
        this.outputMatName = outputMatName;
    }


    public String getOutputDate() {
        return outputDate;
    }

    public void setOutputDate(String outputDate) {
        this.outputDate = outputDate;
    }

    public Integer getSupplierComId() {
        return supplierComId;
    }

    public void setSupplierComId(Integer supplierComId) {
        this.supplierComId = supplierComId;
    }

    public String getSupplierComName() {
        return supplierComName;
    }

    public void setSupplierComName(String supplierComName) {
        this.supplierComName = supplierComName;
    }


	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getOutputMatId() {
		return outputMatId;
	}

	public void setOutputMatId(int outputMatId) {
		this.outputMatId = outputMatId;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

    
}
