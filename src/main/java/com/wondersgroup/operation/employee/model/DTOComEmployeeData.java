package com.wondersgroup.operation.employee.model;

import java.util.List;

import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.Attachment;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.framework.common.AttachmentService;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOComEmployeeData {
	private Integer personId;
    private String personName;
    private String jobNum;
    private String jobRole;
    private String jobDescription;
    private Integer sex;
    private String sexValue;
    private Integer idType;
    private String idTypeValue;
    private String idNumber;
    private String onboardDate;
    private String resignDate;
    private Integer pubVisible;
    private String pubVisibleValue;
    private Integer pubSortNum;
    private String memo;
    private String createDate;
    private String jobTitle;
    private String phone;
    private String mobilePhone;
    private String email;
    private Integer isPhoneReg;
    
    private Integer photoId;
    private String photoPath;
    private List<AppLoginUser> appLoginUserList;
    
    public static DTOComEmployeeData createByEntity(ComEmployee entity,AttachmentService attachmentService) {
    	DTOComEmployeeData dto =null;
		if(entity!=null) {
			dto = new DTOComEmployeeData();
			dto.setPersonId(entity.getPersonId());
			dto.setPersonName(entity.getPersonName());
			dto.setJobNum(entity.getJobNum());
			dto.setJobRole(entity.getJobRole());
			dto.setJobDescription(entity.getJobDescription());
			
			Integer sex = entity.getSex();
			if (sex!=null) {
				dto.setSex(sex);
				dto.setSexValue(sex==FoodConstant.FIELD_STATUS_VALID?"男":"女");
			}
			Integer idType = entity.getIdType();
			String idTypeValue = DataDictService.getDataDicDetailNameById(idType);
			dto.setIdType(idType);
			dto.setIdTypeValue(idTypeValue);
			dto.setIdNumber(entity.getIdNumber());
			dto.setOnboardDate(TimeOrDateUtils.formateDate(entity.getOnboardDate(), "yyyy-MM-dd"));
			dto.setResignDate(TimeOrDateUtils.formateDate(entity.getResignDate(), "yyyy-MM-dd"));
			Integer pubVisible = entity.getPubVisible();
			
			if (pubVisible!=null) {
				dto.setPubVisible(pubVisible);
				dto.setPubVisibleValue(pubVisible==FoodConstant.FIELD_STATUS_VALID?"公示":"不公示");
			}
			dto.setPubSortNum(entity.getPubSortNum());
			dto.setMemo(entity.getMemo());
			dto.setCreateDate(TimeOrDateUtils.formateDate(entity.getCreateDate(), "yyyy-MM-dd HH:mm:ss"));
			dto.setJobTitle(entity.getJobTitle());
			dto.setPhone(entity.getPhone());
			dto.setMobilePhone(entity.getMobilePhone());
			dto.setEmail(entity.getEmail());
			dto.setIsPhoneReg(entity.getIsPhoneReg());
			
		     //照片
	        QueryResult<Attachment> atts = attachmentService.queryAttFile(FoodConstant.ATT_EMPLOYEE, entity.getPersonId(), null, null);
	        Attachment att = null;
	        if(atts!=null && atts.getResultList()!=null && !atts.getResultList().isEmpty()){
	            att = atts.getResultList().get(0);
	        }
	          
            if(att!=null && att.getFilePath()!=null){
            	dto.setPhotoPath(att.getFilePath());
            	dto.setPhotoId(att.getId());
            }else{
            	dto.setPhotoPath("");
            }
            dto.setAppLoginUserList(entity.getAppLoginUserList());
		}
		return dto;
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

	public String getJobNum() {
		return jobNum;
	}

	public void setJobNum(String jobNum) {
		this.jobNum = jobNum;
	}

	public String getJobRole() {
		return jobRole;
	}

	public void setJobRole(String jobRole) {
		this.jobRole = jobRole;
	}

	public String getJobDescription() {
		return jobDescription;
	}

	public void setJobDescription(String jobDescription) {
		this.jobDescription = jobDescription;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public Integer getIdType() {
		return idType;
	}

	public void setIdType(Integer idType) {
		this.idType = idType;
	}

	public String getIdNumber() {
		return idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}

	public String getOnboardDate() {
		return onboardDate;
	}

	public void setOnboardDate(String onboardDate) {
		this.onboardDate = onboardDate;
	}

	public String getResignDate() {
		return resignDate;
	}

	public void setResignDate(String resignDate) {
		this.resignDate = resignDate;
	}

	public Integer getPubVisible() {
		return pubVisible;
	}

	public void setPubVisible(Integer pubVisible) {
		this.pubVisible = pubVisible;
	}

	public Integer getPubSortNum() {
		return pubSortNum;
	}

	public void setPubSortNum(Integer pubSortNum) {
		this.pubSortNum = pubSortNum;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getSexValue() {
		return sexValue;
	}

	public void setSexValue(String sexValue) {
		this.sexValue = sexValue;
	}

	public String getIdTypeValue() {
		return idTypeValue;
	}

	public void setIdTypeValue(String idTypeValue) {
		this.idTypeValue = idTypeValue;
	}

	public String getPubVisibleValue() {
		return pubVisibleValue;
	}

	public void setPubVisibleValue(String pubVisibleValue) {
		this.pubVisibleValue = pubVisibleValue;
	}

	public String getJobTitle() {
		return jobTitle;
	}

	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobilePhone() {
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}


	public Integer getIsPhoneReg() {
		return isPhoneReg;
	}


	public void setIsPhoneReg(Integer isPhoneReg) {
		this.isPhoneReg = isPhoneReg;
	}


	public Integer getPhotoId() {
		return photoId;
	}


	public void setPhotoId(Integer photoId) {
		this.photoId = photoId;
	}


	public String getPhotoPath() {
		return photoPath;
	}


	public void setPhotoPath(String photoPath) {
		this.photoPath = photoPath;
	}


	public List<AppLoginUser> getAppLoginUserList() {
		return appLoginUserList;
	}


	public void setAppLoginUserList(List<AppLoginUser> appLoginUserList) {
		this.appLoginUserList = appLoginUserList;
	}
	
	
}
