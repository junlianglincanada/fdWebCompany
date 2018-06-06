package com.wondersgroup.operation.exception.model;

import java.util.Date;


public class DTOException {
	//**************   台账预警     *****************
	private String lastRecordDate; 	//最近记录时间
	private String  recordDay;   		//无台账记录天数
	private String accountName;  //台帐名称
	public  DTOException() {
		
	}
	public String getLastRecordDate() {
		return lastRecordDate;
	}
	public void setLastRecordDate(String lastRecordDate) {
		this.lastRecordDate = lastRecordDate;
	}
	public String getRecordDay() {
		return recordDay;
	}
	public void setRecordDay(String recordDay) {
		this.recordDay = recordDay;
	}
	public String getAccountName() {
		return accountName;
	}
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}


	
	
}
