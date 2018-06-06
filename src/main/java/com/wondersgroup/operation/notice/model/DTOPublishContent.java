
package com.wondersgroup.operation.notice.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;


public class DTOPublishContent implements Serializable {
	private int id;
    private String title;//标题
    private String companyName;//发布单位
    private String publishDate;//发布日期
    private String keyWord;
    private String  draftPersonName;
    private String  content;
    private Integer status;//状态
    private Integer isRead;
    
    public static DTOPublishContent createListByMap(Map map) {
    	DTOPublishContent dto = null;
    	if(map!=null){
    		dto = new DTOPublishContent();
    		if(map.get("ID")!=null){
    			dto.setId((int)map.get("ID"));
    		}
    		if(map.get("PUBLISH_DATE")!=null){
    			dto.setPublishDate(map.get("PUBLISH_DATE").toString());
    		}
    		if(map.get("CONTENT")!=null){
    			dto.setContent(map.get("CONTENT").toString());
    		}
    		if(map.get("KEYWORDS")!=null){
    			dto.setKeyWord(map.get("KEYWORDS").toString());
    		}
    		if(map.get("DRAFT_PERSON_NAME")!=null){
    			dto.setDraftPersonName(map.get("DRAFT_PERSON_NAME").toString());
    		}
    		if(map.get("ORGAN_NAME")!=null){
    			dto.setCompanyName(map.get("ORGAN_NAME").toString());
    		}
    		if(map.get("TITLE")!=null){
    			dto.setTitle(map.get("TITLE").toString());
    		}
    		dto.setStatus((Integer)map.get("STATUS"));
    		if(map.get("IS_READ")!=null){
    			dto.setIsRead((Integer)map.get("IS_READ"));
    		}
    	}
		return dto;
	}
    
    public static List<DTOPublishContent> createListByEntities(List<Map> resultList) {
		List<DTOPublishContent> list = new ArrayList<DTOPublishContent>();
		if(resultList!=null){
			for(Map map:resultList){
				DTOPublishContent dto = createListByMap(map);
				if(dto != null){
					list.add(dto);
				}
			}
		}
		return list;
	}
    
    public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }


	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getPublishDate() {
		return publishDate;
	}

	public void setPublishDate(String publishDate) {
		this.publishDate = publishDate;
	}
	public String getKeyWord() {
		return keyWord;
	}

	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDraftPersonName() {
		return draftPersonName;
	}

	public void setDraftPersonName(String draftPersonName) {
		this.draftPersonName = draftPersonName;
	}
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Integer getIsRead() {
		return isRead;
	}

	public void setIsRead(Integer isRead) {
		this.isRead = isRead;
	}
}