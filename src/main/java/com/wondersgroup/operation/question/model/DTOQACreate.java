package com.wondersgroup.operation.question.model;

import java.util.Date;

import com.wondersgroup.data.jpa.entity.QA;


public class DTOQACreate {

    private Integer questionFrom;//1：超级终端网页版 2：追溯平台
    private Integer questionType;//问题类型 1：业务咨询 2：技术咨询 3：法规咨询
    private String questionContent;//内容
    private String questionUserName;//提问者
    private String questionUserContact;//联系电话
    private String questionUserEmail;//邮箱
    private Integer companyId;//企业id
    
	public static QA toEntity(DTOQACreate dto) {
		QA qa=null;
		if(dto.getQuestionContent()!=null){
		qa= new QA();
		    qa.setQuestionFrom(dto.getQuestionFrom());
		 	qa.setCreateDate(new Date());
			qa.setQuestionFrom(dto.getQuestionFrom());
			qa.setQuestionType(dto.getQuestionType());
			qa.setQuestionContent(dto.getQuestionContent());
			qa.setQuestionUserName(dto.getQuestionUserName());
			qa.setQuestionUserContact(dto.getQuestionUserContact());
			qa.setQuestionUserEmail(dto.getQuestionUserEmail());
			qa.setLastModifiedDate(new Date());
			qa.setCompanyId(dto.getCompanyId());
	}
	
		return qa;
	}
	public Integer getQuestionType() {
		return questionType;
	}
	public void setQuestionType(Integer questionType) {
		this.questionType = questionType;
	}
	public String getQuestionContent() {
		return questionContent;
	}
	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}
	public String getQuestionUserName() {
		return questionUserName;
	}
	public void setQuestionUserName(String questionUserName) {
		this.questionUserName = questionUserName;
	}
	public String getQuestionUserContact() {
		return questionUserContact;
	}
	public void setQuestionUserContact(String questionUserContact) {
		this.questionUserContact = questionUserContact;
	}
	public String getQuestionUserEmail() {
		return questionUserEmail;
	}
	public void setQuestionUserEmail(String questionUserEmail) {
		this.questionUserEmail = questionUserEmail;
	}
	public Integer getCompanyId() {
		return companyId;
	}
	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}
	public Integer getQuestionFrom() {
		return questionFrom;
	}
	public void setQuestionFrom(Integer questionFrom) {
		this.questionFrom = questionFrom;
	}

 

    
}
