package com.wondersgroup.operation.input.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class DTOAutoReceiveCreate {
	private String id;
	private BigDecimal quantity;
	
	
	
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public BigDecimal getQuantity() {
		return quantity;
	}
	public void setQuantity(BigDecimal quantity) {
		this.quantity = quantity;
	}
	public static List<String> toIdList(List<DTOAutoReceiveCreate> outputBatchDetails) {
		List<String> result = new ArrayList<>();
		for (int i = 0; i < outputBatchDetails.size(); i++) {
			DTOAutoReceiveCreate batch = outputBatchDetails.get(i);
			result.add(batch.getId());
		}
		return result;
	}
	public static List<BigDecimal> toQuantityList(List<DTOAutoReceiveCreate> outputBatchDetails) {
		List<BigDecimal> result = new ArrayList<>();
		for (int i = 0; i < outputBatchDetails.size(); i++) {
			DTOAutoReceiveCreate batch = outputBatchDetails.get(i);
			result.add(batch.getQuantity());
		}
		return result;
	}
	

}
