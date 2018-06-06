package com.wondersgroup.operation.employee.model;

import java.util.Date;

import com.wondersgroup.data.jpa.entity.Attachment;
import com.wondersgroup.data.jpa.entity.ComEmpLicence;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.framework.common.DataDictService;

/**
 * @author hwj
 */
public class DTOComEmpLicence {
	private Integer id;
	private Integer licenceType; // 类型Dict表里的 26号类型： 26001：健康证 26002：培训证
									// 26003：荣誉证书
	private String licenceTypeValue;
	private String licenceNum; // 证件编号
	private String licenceName; // 荣誉证书名称
	private Integer licenceLevel; // 培训证等级Dict表里的 27号类型
	private String licenceLevelValue; // 培训证等级Dict表里的 27号类型
	private Date issueDate; // 发证日期
	private Date expireDate; // 过期日期
	
	private String memo; // 备注

	private Integer comEmployeeId;
	private ComEmployee emp;
	
	
	private String[] fileNames; // file
	private Integer fileId;  //图片附件编号
    private String filePath;  //图片路径
	
	public DTOComEmpLicence() {
	}

	public static ComEmpLicence toEntity(ComEmpLicence entityInstance,
			DTOComEmpLicence dtoInstance, ComEmployee emp) {
		if (dtoInstance != null) {
			if (entityInstance == null) {
				entityInstance = new ComEmpLicence();
			}
			entityInstance.setLicenceType(dtoInstance.getLicenceType());
			entityInstance.setLicenceNum(dtoInstance.getLicenceNum());
			entityInstance.setLicenceName(dtoInstance.getLicenceName());
			entityInstance.setIssueDate(dtoInstance.getIssueDate());
			entityInstance.setExpireDate(dtoInstance.getExpireDate());
			entityInstance.setLicenceLevel(dtoInstance.getLicenceLevel());
			entityInstance.setMemo(dtoInstance.getMemo());
			entityInstance.setEmp(emp);
		}
		return entityInstance;
	}

	public static DTOComEmpLicence toDTO(ComEmpLicence entityInstance, Attachment file) {
		DTOComEmpLicence dtoComEmpLicence = new DTOComEmpLicence();
		dtoComEmpLicence.setId(entityInstance.getId());
		Integer licenceType = entityInstance.getLicenceType();
		if (licenceType != null) {
			dtoComEmpLicence.setLicenceType(licenceType);
			String licenceTypeValue = DataDictService.getDataDicDetailNameById(licenceType);
			dtoComEmpLicence.setLicenceTypeValue(licenceTypeValue);
		}

		dtoComEmpLicence.setLicenceNum(entityInstance.getLicenceNum());
		dtoComEmpLicence.setLicenceName(entityInstance.getLicenceName());

		Integer licenceLevel = entityInstance.getLicenceLevel();
		if (licenceLevel != null) {
			dtoComEmpLicence.setLicenceLevel(licenceLevel);
			String licenceLevelValue = DataDictService.getDataDicDetailNameById(licenceLevel);
			dtoComEmpLicence.setLicenceLevelValue(licenceLevelValue);
		}
		dtoComEmpLicence.setIssueDate(entityInstance.getIssueDate());
		dtoComEmpLicence.setExpireDate(entityInstance.getExpireDate());
		
		ComEmployee comEmployee = entityInstance.getEmp();
		dtoComEmpLicence.setComEmployeeId(comEmployee.getPersonId());
		dtoComEmpLicence.setEmp(comEmployee);
		
		if(file!=null && file.getFilePath()!=null){
			dtoComEmpLicence.setFilePath(file.getFilePath());
			dtoComEmpLicence.setFileId(file.getId());
        }else{
        	dtoComEmpLicence.setFilePath("");
        }
		dtoComEmpLicence.setMemo(entityInstance.getMemo());
		return dtoComEmpLicence;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getLicenceType() {
		return licenceType;
	}

	public void setLicenceType(Integer licenceType) {
		this.licenceType = licenceType;
	}

	public String getLicenceTypeValue() {
		return licenceTypeValue;
	}

	public void setLicenceTypeValue(String licenceTypeValue) {
		this.licenceTypeValue = licenceTypeValue;
	}

	public String getLicenceNum() {
		return licenceNum;
	}

	public void setLicenceNum(String licenceNum) {
		this.licenceNum = licenceNum;
	}

	public String getLicenceName() {
		return licenceName;
	}

	public void setLicenceName(String licenceName) {
		this.licenceName = licenceName;
	}

	public Integer getLicenceLevel() {
		return licenceLevel;
	}

	public void setLicenceLevel(Integer licenceLevel) {
		this.licenceLevel = licenceLevel;
	}

	public String getLicenceLevelValue() {
		return licenceLevelValue;
	}

	public void setLicenceLevelValue(String licenceLevelValue) {
		this.licenceLevelValue = licenceLevelValue;
	}

	public Date getIssueDate() {
		return issueDate;
	}

	public void setIssueDate(Date issueDate) {
		this.issueDate = issueDate;
	}

	public Date getExpireDate() {
		return expireDate;
	}

	public void setExpireDate(Date expireDate) {
		this.expireDate = expireDate;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String[] getFileNames() {
		return fileNames;
	}

	public void setFileNames(String[] fileNames) {
		this.fileNames = fileNames;
	}

	public ComEmployee getEmp() {
		return emp;
	}

	public void setEmp(ComEmployee emp) {
		this.emp = emp;
	}

	public Integer getComEmployeeId() {
		return comEmployeeId;
	}

	public void setComEmployeeId(Integer comEmployeeId) {
		this.comEmployeeId = comEmployeeId;
	}

	public Integer getFileId() {
		return fileId;
	}

	public void setFileId(Integer fileId) {
		this.fileId = fileId;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
}
