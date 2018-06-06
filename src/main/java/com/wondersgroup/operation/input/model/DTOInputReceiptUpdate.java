package com.wondersgroup.operation.input.model;

import java.util.Date;
import java.util.List;

import com.wondersgroup.data.jpa.entity.InputReceipt;
import com.wondersgroup.service.input.InputReceiptService;
import com.wondersgroup.util.CollectionUtils;
import com.wondersgroup.util.TimeOrDateUtils;


public class DTOInputReceiptUpdate {
	private Integer id; //单据id
    private Integer suppilerId; //供应商id
    private String inputDate; // 进货日期
    
	public Integer getSuppilerId() {
		return suppilerId;
	}
	public void setSuppilerId(Integer suppilerId) {
		this.suppilerId = suppilerId;
	}
	

	public static InputReceipt toEntitie(DTOInputReceiptUpdate dto, Integer companyId,InputReceiptService inputReceiptService) {
		InputReceipt inputReceipt=null;
		//读取数据库已经存在的票据，并且放入内存
		List<InputReceipt> inputReceiptList = inputReceiptService.queryInputReceiptsBySupplier(companyId, dto.getSuppilerId(), TimeOrDateUtils.parseDate(dto.getInputDate()));
		if(CollectionUtils.isNotEmpty(inputReceiptList)){
			 inputReceipt=inputReceiptList.get(0);
		}else {
			inputReceipt=new InputReceipt();
			inputReceipt.setCompanyId(companyId);
			inputReceipt.setSuppilerId(dto.getSuppilerId());
			inputReceipt.setInputDate(TimeOrDateUtils.parseDate(dto.getInputDate()));
			inputReceipt.setCreateDate(new Date());
			inputReceipt.setLastModifiedDate(new Date());
		}


		return inputReceipt;
	}
	public String getInputDate() {
		return inputDate;
	}
	public void setInputDate(String inputDate) {
		this.inputDate = inputDate;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	
	

	
	



}
