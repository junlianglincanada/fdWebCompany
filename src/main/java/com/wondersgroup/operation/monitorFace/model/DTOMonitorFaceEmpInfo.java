package com.wondersgroup.operation.monitorFace.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.wondersgroup.data.jpa.entity.Attachment;
import com.wondersgroup.data.jpa.entity.DisplayJobRole;
import com.wondersgroup.framework.support.QueryResult;


public class DTOMonitorFaceEmpInfo {
	private Integer personId;
	private String personName;
	private String jobRole;
	private Attachment img;
	public static DisplayJobRole toEntity(Integer companyId,DTOMonitorFaceEmpInfo dto){
		DisplayJobRole entity = null;
		if(dto != null){
			entity = new DisplayJobRole();
			entity.setCompanyId(companyId);
			entity.setEmpId(dto.getPersonId());
			entity.setJobRole(dto.getJobRole());
		}
		return entity;
	}
	@SuppressWarnings("rawtypes")
	public static List<DTOMonitorFaceEmpInfo> toDtoList(QueryResult queryResult){
		List<DTOMonitorFaceEmpInfo> dtoList=new ArrayList<DTOMonitorFaceEmpInfo>();
		if (queryResult != null && queryResult.getResultList() != null&& queryResult.getTotalRecord() > 0) {
			@SuppressWarnings("unchecked")
			List<Map> list = queryResult.getResultList();
			for (Map o : list) {
				DTOMonitorFaceEmpInfo dto = new DTOMonitorFaceEmpInfo();
				dto = DTOMonitorFaceEmpInfo.toDto(o);
				dtoList.add(dto);
				}
			for (int i=0;i<dtoList.size()-1;i++){
				for(int j=dtoList.size()-1;j>i;j--){
					if(dtoList.get(j).getJobRole().equals(dtoList.get(i).getJobRole())){
						dtoList.remove(j);
					}
				}
			}
			boolean n=false;
			//判断门店经理大堂经理 若都有则只保留门店经理
			for(DTOMonitorFaceEmpInfo emp:dtoList){
				if(emp.getJobRole().equals("门店经理")){
					n=true;
				}
			}
			boolean m=false;
			//判断门店经理大堂经理 若都有则只保留门店经理
			for(DTOMonitorFaceEmpInfo emp:dtoList){
				if(emp.getJobRole().equals("食品安全管理人员(专职)")){
					m=true;
				}
			}
			for (int i=0;i<dtoList.size()-1;i++){
				if((n==true&&dtoList.get(i).getJobRole().equals("大堂经理"))||(m==true&&dtoList.get(i).getJobRole().equals("食品安全管理人员(兼职)"))){
					dtoList.remove(i);
				}
			}
    		for(int x=0;x<dtoList.size();x++){
    			if(dtoList.get(x).getJobRole().equals("大堂经理")||dtoList.get(x).getJobRole().equals("门店经理")){
    				dtoList.get(x).setJobRole("经理");
    			}else if(dtoList.get(x).getJobRole().equals("食品安全管理人员(专职)")||dtoList.get(x).getJobRole().equals("食品安全管理人员(兼职)")){
    				dtoList.get(x).setJobRole("食品安全负责人");
    			}else if(dtoList.get(x).getJobRole().equals("厨师长")){
    				dtoList.get(x).setJobRole("厨师长");
    			}else if(dtoList.get(x).getJobRole().equals("原料采购人员")){
    				dtoList.get(x).setJobRole("采购负责人");
    			}
    		}
		}
		return dtoList;
	}
	public static List<DTOMonitorFaceEmpInfo> displayList(QueryResult queryResult){
		List<DTOMonitorFaceEmpInfo> dtoList=new ArrayList<DTOMonitorFaceEmpInfo>();
		if (queryResult != null && queryResult.getResultList() != null&& queryResult.getTotalRecord() > 0) {
			@SuppressWarnings("unchecked")
			List<Map> list = queryResult.getResultList();
			for (Map o : list) {
				DTOMonitorFaceEmpInfo dto = new DTOMonitorFaceEmpInfo();
				dto = DTOMonitorFaceEmpInfo.toDto(o);
				dtoList.add(dto);
				}
		}
		return dtoList;
	}
	public static DTOMonitorFaceEmpInfo toDto(Map obj){
		DTOMonitorFaceEmpInfo dto=new DTOMonitorFaceEmpInfo();
		dto.setPersonId( Integer.parseInt(obj.get("PERSON_ID")==null?"0":obj.get("PERSON_ID").toString()));
		dto.setPersonName(obj.get("PERSON_NAME")==null?null:obj.get("PERSON_NAME").toString());
		dto.setJobRole(obj.get("JOB_ROLE")==null?null:obj.get("JOB_ROLE").toString());
		return dto;
	}
	public static DisplayJobRole toEntity(DTOMonitorFaceEmpInfo dto,Integer companyId){
		DisplayJobRole entity=new DisplayJobRole();
		entity.setCreateDate(new Date());
		entity.setCompanyId(companyId);
		entity.setDelFlag(1);
		entity.setEmpId(dto.getPersonId());
		entity.setJobRole(dto.getJobRole());
		return entity;
	}
	public Integer getPersonId() {
		return personId;
	}
	public void setPersonId(Integer personId) {
		this.personId = personId;
	}
	public String getPersonName() {
		return personName;
	}
	public void setPersonName(String personName) {
		this.personName = personName;
	}
	public String getJobRole() {
		return jobRole;
	}
	public void setJobRole(String jobRole) {
		this.jobRole = jobRole;
	}
	public Attachment getImg() {
		return img;
	}
	public void setImg(Attachment img) {
		this.img = img;
	}

	
}
