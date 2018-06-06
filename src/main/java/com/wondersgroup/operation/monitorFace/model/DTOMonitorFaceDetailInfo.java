package com.wondersgroup.operation.monitorFace.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOMonitorFaceDetailInfo {
	private String manufacture;
	private String inputName;
	private String inputDate;
	public static List<DTOMonitorFaceDetailInfo> toDtoList(QueryResult queryResult){
		List<DTOMonitorFaceDetailInfo> dtoList=new ArrayList<DTOMonitorFaceDetailInfo>();
		if (queryResult != null && queryResult.getResultList() != null&& queryResult.getTotalRecord() > 0) {
			List<Object[]> list = queryResult.getResultList();
			for (Object[] o : list) {
				DTOMonitorFaceDetailInfo dto = new DTOMonitorFaceDetailInfo();
				dto.setManufacture(o[0]==null?null:o[0].toString());
				dto.setInputName(o[1]==null?null:o[1].toString());
				dto.setInputDate(o[2]==null?null:TimeOrDateUtils.formateDate(TimeOrDateUtils.parseDate(o[2].toString()),TimeOrDateUtils.FULL_YMD));
				dtoList.add(dto);
			}
		}
		return dtoList;
	}
	public String getManufacture() {
		return manufacture;
	}
	public void setManufacture(String manufacture) {
		this.manufacture = manufacture;
	}
	public String getInputName() {
		return inputName;
	}
	public void setInputName(String inputName) {
		this.inputName = inputName;
	}
	public String getInputDate() {
		return inputDate;
	}
	public void setInputDate(String inputDate) {
		this.inputDate = inputDate;
	}
	
}
