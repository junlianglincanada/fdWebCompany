package com.wondersgroup.operation.input.model;

import java.util.Map;



public class DTOInputReceipt {
   private String filePath;
   private Integer id;
   private String inputDate;
   
   public static DTOInputReceipt toDTO(Map map){
	   DTOInputReceipt dto=new DTOInputReceipt();
	  dto.setFilePath((map.get("filePath")==null?"":map.get("filePath")).toString());
	   dto.setId(Integer.parseInt((map.get("id")==null?-1:map.get("id")).toString()));
	   dto.setInputDate((map.get("inputDate")==null?"":map.get("inputDate")).toString());
	   return dto;
   }

public String getInputDate() {
	return inputDate;
}
public void setInputDate(String inputDate) {
	this.inputDate = inputDate;
}

public String getFilePath() {
	return filePath;
}

public void setFilePath(String filePath) {
	this.filePath = filePath;
}

public Integer getId() {
	return id;
}

public void setId(Integer id) {
	this.id = id;
}




}
