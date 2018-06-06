package com.wondersgroup.operation.input.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;
import com.wondersgroup.data.jpa.entity.ImportFileList;

public class DTOImportFileListQueryData {
    private Integer id;
    //文件类型
    private String fileType;
    //文件名称
    private String fileName;
    //上传时间
    @JsonFormat(shape=Shape.STRING,pattern="yyyy-MM-dd")
    private Date uploadDate;
    //上传用户登录ID
    private Integer uploadUser;
    //上传用户名称
    private String uploadUserName;
    
    public static DTOImportFileListQueryData createByEntity(ImportFileList entity) {
        DTOImportFileListQueryData dto = null;
        if (entity != null) {
            dto = new DTOImportFileListQueryData();
            dto.setId(entity.getId());
            dto.setFileType(entity.getFileType());
            dto.setFileName(entity.getFileName());
            dto.setUploadDate(entity.getUploadDate());
            dto.setUploadUser(entity.getUploadUser());
            dto.setUploadUserName(entity.getUploadUserName());
        }
        return dto;
    }

    public static List<DTOImportFileListQueryData> createListByEntities(Collection<ImportFileList> domainInstanceList) {
        List<DTOImportFileListQueryData> list = new ArrayList<>();
        if (domainInstanceList != null) {
            for (ImportFileList domainInstance : domainInstanceList) {
                DTOImportFileListQueryData data = createByEntity(domainInstance);
                if (data != null) {
                    list.add(data);
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

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Date getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

	public Integer getUploadUser() {
		return uploadUser;
	}

	public void setUploadUser(Integer uploadUser) {
		this.uploadUser = uploadUser;
	}

	public String getUploadUserName() {
		return uploadUserName;
	}

	public void setUploadUserName(String uploadUserName) {
		this.uploadUserName = uploadUserName;
	}
    
}
