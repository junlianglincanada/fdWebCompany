package com.wondersgroup.operation.monitorFace.model;

import java.util.List;
import java.util.Map;

import org.springframework.util.LinkedMultiValueMap;

import com.wondersgroup.data.jpa.entity.Attachment;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOMonitorFaceComInfo {
	private Integer companyId;
	private String nameAbbrev;
	private String companyName;
	private String grade;
	private String gradeDate;
	private Attachment comImg;
	private List<DTOMonitorFaceEmpInfo> empDtoList;
	
	public static DTOMonitorFaceComInfo toDto(QueryResult queryResult,LinkedMultiValueMap<String, Attachment> resultMap,List<DTOMonitorFaceEmpInfo> dtoEmpInfo){
		DTOMonitorFaceComInfo dto = new DTOMonitorFaceComInfo();
		if (queryResult != null && queryResult.getResultList() != null&& queryResult.getTotalRecord()>0) {
			@SuppressWarnings("unchecked")
			List<Map> list = queryResult.getResultList();
			Map o=list.get(0);
			dto.setCompanyId( Integer.parseInt(o.get("COMPANY_ID")==null?"0":o.get("COMPANY_ID").toString()));
			dto.setNameAbbrev(o.get("NAME_ABBREV")==null?null:o.get("NAME_ABBREV").toString());
			dto.setCompanyName(o.get("COMPANY_NAME")==null?null:o.get("COMPANY_NAME").toString());
			dto.setGrade(o.get("GRADE")==null?null:o.get("GRADE").toString());
			dto.setGradeDate(o.get("GRADE_DATE")==null?null:TimeOrDateUtils.formateDate(TimeOrDateUtils.parseDate(o.get("GRADE_DATE").toString()),TimeOrDateUtils.FULL_YMD));
			if(resultMap.get("COM_SPJYXKZ")!=null&&resultMap.get("COM_SPJYXKZ").size()>0){
				dto.setComImg(resultMap.get("COM_SPJYXKZ").get(0));
			}else if(resultMap.get("COM_CYFWXKZ")!=null&&resultMap.get("COM_CYFWXKZ").size()>0){
				dto.setComImg(resultMap.get("COM_CYFWXKZ").get(0));
			}/*else if(resultMap.get("COM_SPLTXKZ")!=null&&resultMap.get("COM_SPLTXKZ").size()>0){
				dto.setComImg(resultMap.get("COM_SPLTXKZ").get(0));
			}*/
			dto.setEmpDtoList(dtoEmpInfo);
		}
		return dto;
	}
	public Integer getCompanyId() {
		return companyId;
	}
	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}
	public String getNameAbbrev() {
		return nameAbbrev;
	}
	public void setNameAbbrev(String nameAbbrev) {
		this.nameAbbrev = nameAbbrev;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getGradeDate() {
		return gradeDate;
	}
	public void setGradeDate(String gradeDate) {
		this.gradeDate = gradeDate;
	}
	public Attachment getComImg() {
		return comImg;
	}
	public void setComImg(Attachment comImg) {
		this.comImg = comImg;
	}
	public List<DTOMonitorFaceEmpInfo> getEmpDtoList() {
		return empDtoList;
	}
	public void setEmpDtoList(List<DTOMonitorFaceEmpInfo> empDtoList) {
		this.empDtoList = empDtoList;
	}
	
}
