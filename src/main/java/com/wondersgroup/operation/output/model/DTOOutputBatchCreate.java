package com.wondersgroup.operation.output.model;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.validation.constraints.NotNull;

import com.wondersgroup.data.jpa.entity.IntCompany;
import com.wondersgroup.data.jpa.entity.OutputBatchDetail;
import com.wondersgroup.data.jpa.entity.OutputMaterial;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.service.company.InternalCompanyService;
import com.wondersgroup.service.company.RestaurantService;
import com.wondersgroup.service.output.OutputMaterialService;

/**
 * 用户录入和更新台账明细信息
 *
 * @author wangei
 *
 */
public class DTOOutputBatchCreate {
	// 进货日期
	@NotNull
	private Date outputDate;
	
	// 供应商id
	@NotNull
	private List<Integer> receiverId;
	
	//采购品id
	@NotNull
	private Integer outputMatId;
	
	//生产单位
	@NotNull
	private String manufacture;
	
	//规格
	@NotNull
	private String spec;
	
	// 数量
	@NotNull
	private BigDecimal quantity;
	
	//生产日期
	private Date productionDate;
	
	//生产批号
	private String productionBatch;
	
	//追溯码
	private String traceCode;
	

	public DTOOutputBatchCreate() {
	}

	public static OutputBatchDetail toEntity(DTOOutputBatchCreate dto,int receiverId, int companyId, InternalCompanyService intCompanyService, OutputMaterialService outputMaterialService, Integer loginUserId, String loginUserName,RestaurantService restaurantService) {
		OutputBatchDetail entity = null;
		try {
			entity = new OutputBatchDetail();
			//基本信息
			entity.setId(UUID.randomUUID().toString().replaceAll("-", ""));
			entity.setCompanyId(companyId);
			entity.setCreateDate(new Date());
			entity.setLastModifiedDate(new Date());
			entity.setQuantity(dto.getQuantity());
			entity.setProductionDate(dto.getProductionDate());
			entity.setProductionBatch(dto.getProductionBatch());
			entity.setOutputDate(dto.getOutputDate());
			entity.setCreateUser(loginUserId);
			entity.setCreateUserName(loginUserName);
			//追溯码
			entity.setTraceCode(dto.getTraceCode());
			//供应商信息
			IntCompany receiver = intCompanyService.getInternalCompanyById(receiverId);
			if (receiver  == null) {
				throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
			}
			entity.setReceiverId(receiver.getId());
			entity.setReceiverName(receiver.getName());
			//采购品信息
			OutputMaterial outputMat = outputMaterialService.getOutputMaterialById(dto.getOutputMatId());
			if (outputMat == null) {
				throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
			}
			entity.setOutputMatId(outputMat.getId());
			entity.setOutputMatName(outputMat.getName());
			entity.setCode(outputMat.getCode());
			entity.setTypeGeneral(outputMat.getTypeGeneral());
			entity.setSpec(outputMat.getSpec());
			entity.setGuaranteeValue(outputMat.getGuaranteeValue());
			entity.setGuaranteeUnit(outputMat.getGuaranteeUnit());
			entity.setManufacture(outputMat.getManufacture());
			entity.setPlaceOfProduction(outputMat.getPlaceOfProduction());
			//批次信息
			//批次号  = 进货日期+单位id+供应商id
//			String newBatchId = TimeOrDateUtils.formateDate(dto.getOutputDate(), TimeOrDateUtils.YMD)+"_"+companyId+"_"+receiver.getId();
			
//			//4.19重新定义IS_SYNC   未关联0，关联不自动收货 2，关联要自动收货3，已收1，拒收-1
//			//判断是否关联关系
//			if(receiver.getLinkedCompany()!=null){
//				Restaurant rs=restaurantService.getRestaurantById(companyId);
//				IntCompany supplier = intCompanyService.getInternalCompany(receiver.getLinkedCompany().getCompanyId(), IntCompany.COMPANY_TYPE_SUPPLIER, rs.getCompanyName(), true, null, null);
//				if(supplier!=null){
//				Restaurant restaurant= restaurantService.getRestaurantById(receiver.getLinkedCompany().getCompanyId());
//				if(restaurant.getIsAutoRecv()!=null&&restaurant.getIsAutoRecv()==1){
//					entity.setIsSync(3);
//				}else{
//					entity.setIsSync(2);
//				}
//				  }else{
//					entity.setIsSync(0);
//				}
//			}else{
//				entity.setIsSync(0);
//			}
//			
			//----5.4
			Map<String,Object> receiverMap=null;
			int isSync=0;
			QueryResult<Map> result=intCompanyService.getOutputIntCompanyByCompanyId(companyId,receiver.getId());
			if (null!=result&&null!=result.getResultList()) {
				receiverMap=result.getResultList().get(0);
				if(receiverMap!=null){
					if(receiverMap.get("linkedCompanyId")!=null){
						if(receiverMap.get("companyId")!=null){
							if(receiverMap.get("isAutoRecv")!=null&&receiverMap.get("isAutoRecv").toString().equals("1")){
								isSync=3;
							}else{
								isSync=2;
							}
						}
					}
				}
			}
			entity.setIsSync(isSync);
		} catch (Exception e) {
			throw new FoodException(e);
		}
		return entity;
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



	public List<Integer> getReceiverId() {
		return receiverId;
	}

	public void setReceiverId(List<Integer> receiverId) {
		this.receiverId = receiverId;
	}

	public Date getOutputDate() {
		return outputDate;
	}

	public void setOutputDate(Date outputDate) {
		this.outputDate = outputDate;
	}

	public Integer getOutputMatId() {
		return outputMatId;
	}

	public void setOutputMatId(Integer outputMatId) {
		this.outputMatId = outputMatId;
	}

	public String getManufacture() {
		return manufacture;
	}

	public void setManufacture(String manufacture) {
		this.manufacture = manufacture;
	}

	public String getSpec() {
		return spec;
	}

	public void setSpec(String spec) {
		this.spec = spec;
	}
	public String getTraceCode() {
		return traceCode;
	}

	public void setTraceCode(String traceCode) {
		this.traceCode = traceCode;
	}
}
