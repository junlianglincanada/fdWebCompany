package com.wondersgroup.operation.output.model;

import java.math.BigDecimal;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

public class DTOOutBatchDetailDate {

	/**
	 * @author zyk
	 */
	private String id;
	private String outputDate;
	private String outputMatName;
	private String spec;
	private String manufacture;
	private BigDecimal quantity;
	private String newBatchId;
	private String guarantee;
	private String receiverName;
	private String productionDate;
	private String productionBatch;
	private String traceCode;
	private Integer receiverId;
	private Integer outputMatId;
	private String code;
	public static DTOOutBatchDetailDate createByObj(Map obj){
		DTOOutBatchDetailDate dto=new DTOOutBatchDetailDate();
        dto.setId(replaceString(obj.get("id")));
//        dto.setGuarantee(replaceString(obj.get("guarantee")));
        dto.setManufacture(replaceString(obj.get("manufacture")));
        dto.setOutputDate(replaceString(obj.get("output_date")));
        dto.setOutputMatName(replaceString(obj.get("output_mat_name")));
        dto.setProductionBatch(replaceString(obj.get("batch_No")));
        dto.setProductionDate(replaceString(obj.get("production_date")));
        if(!obj.get("guarantee").equals("年")&&!obj.get("guarantee").equals("月")&&!obj.get("guarantee").equals("日")&&!obj.get("guarantee").equals("小时")){
			dto.setGuarantee(replaceString(obj.get("guarantee")));
		}
        dto.setQuantity(new BigDecimal(replaceString(obj.get("quantity"))));
        dto.setReceiverName(replaceString(obj.get("receiver_name")));
        dto.setSpec(replaceString(obj.get("spec")));
        dto.setCode(replaceString(obj.get("code")));
        dto.setTraceCode(replaceString(obj.get("trace_code")));
		return dto;
		
	}
	
	public static String  replaceString(Object object){
		if(object==null||object.equals("")||object.equals("null")){
			return "";
		}else{
			String str=object.toString();
			str=str.replace("\'", "");
			str=str.replace("null", "");
			if(!StringUtils.isEmpty(str)){
				str=str.trim();
			}
			if(str.equals("null")){
				return "";
			}
			return str;
		}

	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOutputDate() {
		return outputDate;
	}

	public void setOutputDate(String outputDate) {
		this.outputDate = outputDate;
	}

	public String getOutputMatName() {
		return outputMatName;
	}

	public void setOutputMatName(String outputMatName) {
		this.outputMatName = outputMatName;
	}

	public String getSpec() {
		return spec;
	}

	public void setSpec(String spec) {
		this.spec = spec;
	}

	public String getManufacture() {
		return manufacture;
	}

	public void setManufacture(String manufacture) {
		this.manufacture = manufacture;
	}

	public BigDecimal getQuantity() {
		return quantity;
	}

	public void setQuantity(BigDecimal quantity) {
		this.quantity = quantity;
	}

	public String getNewBatchId() {
		return newBatchId;
	}

	public void setNewBatchId(String newBatchId) {
		this.newBatchId = newBatchId;
	}

	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	public String getProductionDate() {
		return productionDate;
	}

	public void setProductionDate(String productionDate) {
		this.productionDate = productionDate;
	}

	public String getProductionBatch() {
		return productionBatch;
	}

	public void setProductionBatch(String productionBatch) {
		this.productionBatch = productionBatch;
	}

	public String getTraceCode() {
		return traceCode;
	}

	public void setTraceCode(String traceCode) {
		this.traceCode = traceCode;
	}

	public Integer getReceiverId() {
		return receiverId;
	}

	public void setReceiverId(Integer receiverId) {
		this.receiverId = receiverId;
	}

	public Integer getOutputMatId() {
		return outputMatId;
	}

	public void setOutputMatId(Integer outputMatId) {
		this.outputMatId = outputMatId;
	}

	public String getGuarantee() {
		return guarantee;
	}

	public void setGuarantee(String guarantee) {
		this.guarantee = guarantee;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	

}
