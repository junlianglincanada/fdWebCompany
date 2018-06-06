package com.wondersgroup.operation.recycle.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.wondersgroup.data.jpa.entity.Attachment;

public class DTOAttachment  {
	private Integer id;
	private String objType;
	private String objId;
	private String name;
	private String filePath;
	private Date uploadTime;
	private String description;
	
	
	 public static List<DTOAttachment> createListByEntities(Collection<Attachment> domainInstanceList){
	    	List<DTOAttachment> list = null;
	    	if(domainInstanceList!=null){
	    		list = new ArrayList<DTOAttachment>();
	    		for(Attachment domainInstance : domainInstanceList){
	    			DTOAttachment data = toDTO(domainInstance);
	    			if(data!=null){
	    				list.add(data);
	    			}
	    		}
	    	}
	    	return list;
	    }
	
	
	public static DTOAttachment toDTO(Attachment entity) {
		DTOAttachment dto = new DTOAttachment();
		dto.setDescription(entity.getDescription());
		dto.setFilePath(entity.getFilePath());
		dto.setId(entity.getId());
		String name = entity.getName();
		if(!StringUtils.isEmpty(name) && name.length()>=18){
		    dto.setName(name.substring(0, 18)+"...");
		}else{
			dto.setName(name);
		}
		dto.setObjId(entity.getObjId());
		dto.setObjType(entity.getObjType());
		dto.setUploadTime(entity.getUploadTime());
		return dto;
	}


	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getObjType() {
		return objType;
	}
	public void setObjType(String objType) {
		this.objType = objType;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public Date getUploadTime() {
		return uploadTime;
	}
	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}


	public String getObjId() {
		return objId;
	}


	public void setObjId(String objId) {
		this.objId = objId;
	}
	
}
