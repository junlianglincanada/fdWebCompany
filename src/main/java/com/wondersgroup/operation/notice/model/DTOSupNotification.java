package com.wondersgroup.operation.notice.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.SupComNotification;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOSupNotification {

	private Integer id;
	private String issueDate;
	private String content;
	private String orgName;
	private String issuerName;
	private Integer status;
	
	public static DTOSupNotification toDTO(SupComNotification entity){
		DTOSupNotification dto = null;
		if(entity != null){
			dto = new DTOSupNotification();
			dto.setId(entity.getId());
			dto.setIssueDate(TimeOrDateUtils.formateDate(entity.getIssueDate(), TimeOrDateUtils.FULL_FROMAT));
			dto.setContent(entity.getContent());
			dto.setOrgName(entity.getOrgName());
			dto.setIssuerName(entity.getIssuerName());
			dto.setStatus(entity.getStatus());
		}
		return dto;
	}
	public static List<DTOSupNotification> toDTOList(Collection<SupComNotification> entities){
		List<DTOSupNotification> list = new ArrayList<DTOSupNotification>();
		if(entities != null){
			for(SupComNotification entity:entities){
				DTOSupNotification dto = toDTO(entity);
				if(dto != null){
					list.add(dto);
				}
			}
		}
		return list;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getIssueDate() {
		return issueDate;
	}
	public void setIssueDate(String issueDate) {
		this.issueDate = issueDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getIssuerName() {
		return issuerName;
	}
	public void setIssuerName(String issuerName) {
		this.issuerName = issuerName;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
}
