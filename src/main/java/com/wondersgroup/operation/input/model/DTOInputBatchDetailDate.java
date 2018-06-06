package com.wondersgroup.operation.input.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

public class DTOInputBatchDetailDate {

	private String id;
	private String inputDate;
	private String inputMatName;
	private String spec;
	private String manufacture;
	private BigDecimal quantity;
	private String newBatchId;
	private Integer guaranteeValue;
	private Integer guaranteeUnit;
	private String guaranteeUnitString;
	private String supplierName;
	private String productionDate;
	private String productionBatch;
	private String traceCode;
	private Integer supplierId;
	private Integer inputMatId;
	private String guarantee;
	private String code;
	
	
	public static DTOInputBatchDetailDate createByObj(Map obj){
		DTOInputBatchDetailDate dto=new DTOInputBatchDetailDate();		
			dto.setSpec(replaceString(obj.get("spec")));
			dto.setId(replaceString(obj.get("id")));
			dto.setManufacture(replaceString(obj.get("manufacture")));
			dto.setSupplierName(replaceString(obj.get("supplier_name")));
			if(!obj.get("guarantee").equals("年")&&!obj.get("guarantee").equals("月")&&!obj.get("guarantee").equals("日")&&!obj.get("guarantee").equals("小时")){
				dto.setGuarantee(replaceString(obj.get("guarantee")));
			}		
			dto.setInputDate(replaceString(obj.get("input_date")));
			dto.setQuantity(new BigDecimal (replaceString((obj.get("quantity")))));
			dto.setCode(replaceString(obj.get("code")));
			dto.setProductionDate(replaceString(obj.get("production_date")));
			dto.setProductionBatch(replaceString(obj.get("batch_no")));
			dto.setInputMatName(replaceString(obj.get("input_mat_name")));
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
	
	
	
	public static List<DTOInputBatchDetailDate> TODto(List<Object[]> objs){
		List<DTOInputBatchDetailDate> list=new ArrayList<>();
		for(Object[] o : objs){
			DTOInputBatchDetailDate dto=new DTOInputBatchDetailDate();
			
			 dto.setSpec(String.valueOf(0)); 
			dto.setId(o[1].toString());
			dto.setManufacture(String.valueOf(2));
			dto.setSupplierName(String.valueOf(3));
			dto.setGuarantee(String.valueOf(4));
			dto.setInputDate(String.valueOf(5));
			dto.setQuantity(new BigDecimal(String.valueOf(6)));
			dto.setCode(String.valueOf(7));
			dto.setProductionDate(String.valueOf(8));
			dto.setProductionBatch(String.valueOf(9));
			dto.setInputMatName(String.valueOf(10));
			dto.setTraceCode(String.valueOf(11));
			
			list.add(dto);
		}
		return list;
		
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getInputDate() {
		return inputDate;
	}

	public void setInputDate(String inputDate) {
		this.inputDate = inputDate;
	}

	public String getInputMatName() {
		return inputMatName;
	}

	public void setInputMatName(String inputMatName) {
		this.inputMatName = inputMatName;
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

	public Integer getGuaranteeValue() {
		return guaranteeValue;
	}

	public void setGuaranteeValue(Integer guaranteeValue) {
		this.guaranteeValue = guaranteeValue;
	}

	public Integer getGuaranteeUnit() {
		return guaranteeUnit;
	}

	public void setGuaranteeUnit(Integer guaranteeUnit) {
		this.guaranteeUnit = guaranteeUnit;
	}

	public String getGuaranteeUnitString() {
		return guaranteeUnitString;
	}

	public void setGuaranteeUnitString(String guaranteeUnitString) {
		this.guaranteeUnitString = guaranteeUnitString;
	}

	public String getSupplierName() {
		return supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
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

	public Integer getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(Integer supplierId) {
		this.supplierId = supplierId;
	}

	public Integer getInputMatId() {
		return inputMatId;
	}

	public void setInputMatId(Integer inputMatId) {
		this.inputMatId = inputMatId;
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
