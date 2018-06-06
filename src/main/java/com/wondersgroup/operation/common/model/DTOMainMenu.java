package com.wondersgroup.operation.common.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.wondersgroup.data.jpa.entity.MainMenu;


public class DTOMainMenu implements Serializable{

	private String menuId;
	private String menuName;
	private String parentId;
	private String description;
	private String menuIcon;
	private String valid;
	private String linkPath;
	
	public static DTOMainMenu toDTO(MainMenu entity) {
		DTOMainMenu dto = null;
		if (entity != null) {
			dto = new DTOMainMenu();
			dto.setMenuId(entity.getMenuId());
			dto.setMenuName(entity.getMenuName());
			dto.setParentId(entity.getParentId());
			dto.setDescription(entity.getDescription());
			dto.setMenuIcon(entity.getMenuIcon());
			dto.setValid(entity.getValid());
			dto.setLinkPath(entity.getLinkPath());
		}
		return dto;
	}
	
	public static List<DTOMainMenu> createListByEntities(List<MainMenu> resultList) {
		// TODO Auto-generated method stub
		List<DTOMainMenu> list = new ArrayList<DTOMainMenu>();
		if(resultList != null){
			list = new ArrayList<DTOMainMenu>();
			for(MainMenu entity : resultList){
				DTOMainMenu data = toDTO(entity);
				if(data!=null){
    				list.add(data);
    			}
			}
		}
		return list;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getMenuIcon() {
		return menuIcon;
	}

	public void setMenuIcon(String menuIcon) {
		this.menuIcon = menuIcon;
	}

	public String getLinkPath() {
		return linkPath;
	}

	public void setLinkPath(String linkPath) {
		this.linkPath = linkPath;
	}

	public String getValid() {
		return valid;
	}
	public void setValid(String valid) {
		this.valid = valid;
	}


	
}

