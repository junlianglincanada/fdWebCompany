package com.wondersgroup.operation.monitorFace.model;

import com.wondersgroup.data.jpa.entity.DisplayJobRole;

public class DTODisplayJobRoleCreate {

	private Integer empId;
	private String jobRole;
	
	public static DisplayJobRole toEntity(Integer companyId,DTODisplayJobRoleCreate dto){
		DisplayJobRole entity = null;
		if(dto != null){
			entity = new DisplayJobRole();
			entity.setCompanyId(companyId);
			entity.setEmpId(dto.getEmpId());
			entity.setJobRole(dto.getJobRole());
		}
		return entity;
	}
	public Integer getEmpId() {
		return empId;
	}
	public void setEmpId(Integer empId) {
		this.empId = empId;
	}
	public String getJobRole() {
		return jobRole;
	}
	public void setJobRole(String jobRole) {
		this.jobRole = jobRole;
	}
}
