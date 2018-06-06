package com.wondersgroup.operation.input.model;

import java.util.Map;



public class DTOInputReceiptView {
   private String filePath;//票据路径
   private Integer id;//票据id
   private String inputDate;//进货日期
   private Integer supplierId;//供应商id
   private String name;//供应商名称
   
   public static DTOInputReceiptView toDTO(Map map ){
	   DTOInputReceiptView dto=new DTOInputReceiptView();
	   dto.setFilePath((map.get("filePath")==null?"":map.get("filePath")).toString());
	   dto.setId(Integer.parseInt((map.get("id")==null?-1:map.get("id")).toString()));
	   dto.setInputDate((map.get("inputDate")==null?"":map.get("inputDate")).toString());
	   dto.setName((map.get("name")==null?"":map.get("name")).toString());
	   dto.setSupplierId(Integer.parseInt((map.get("supplierId")==null?-1:map.get("supplierId")).toString()));
	   
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

public Integer getSupplierId() {
	return supplierId;
}

public void setSupplierId(Integer supplierId) {
	this.supplierId = supplierId;
}

public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}





}
