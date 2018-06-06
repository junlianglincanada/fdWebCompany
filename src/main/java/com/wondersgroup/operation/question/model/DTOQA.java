package com.wondersgroup.operation.question.model;

import java.io.Serializable;

import com.wondersgroup.data.jpa.entity.QA;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOQA implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer id;//
    private Integer companyId;//企业id
    private Integer questionFrom;//1：超级终端网页版 2：追溯平台
    private Integer questionType;//1：业务咨询 2：技术咨询 3：法规咨询
    private String questionContent;//咨询内容
    private Integer questionUserId;//咨询者id
    private String questionUserName;//咨询者
    private String questionUserContact;//联系方式
    private String questionUserEmail;//联系邮箱
    private String answerContent;//回答内容
    private Integer answerUserId;//回答者id
    private String answerUserName;//回答者
    private String lastAnswerDate;//回答时间
    private Integer isTop;//是否置顶 1 置顶 0非置顶
    private String createDate;//创建时间
    private String lastModifiedDate;//最后修改时间
    
	public static DTOQA toDTO(QA qa) {
		DTOQA dto=new DTOQA();
	        dto.setId(qa.getId());
	       dto.setCompanyId(qa.getCompanyId());
	       dto.setQuestionFrom(qa.getQuestionFrom());
	       dto.setQuestionType(qa.getQuestionType());
	       dto.setQuestionContent(qa.getQuestionContent());
	       dto.setQuestionUserId(qa.getQuestionUserId());
	       dto.setQuestionUserContact(qa.getQuestionUserContact());
	       dto.setQuestionUserName(qa.getQuestionUserName());
	       dto.setQuestionUserEmail(qa.getQuestionUserEmail());
	       dto.setAnswerContent(qa.getAnswerContent());
	       dto.setAnswerUserId(qa.getAnswerUserId());
	       dto.setAnswerUserName(qa.getAnswerUserName());
	       dto.setIsTop(qa.getIsTop());
	       
	       dto.setLastAnswerDate(TimeOrDateUtils.formateDate(qa.getLastAnswerDate(),TimeOrDateUtils.FULL_YMD));
	       dto.setCreateDate(TimeOrDateUtils.formateDate(qa.getCreateDate(),TimeOrDateUtils.FULL_YMD));
	       dto.setLastModifiedDate(TimeOrDateUtils.formateDate(qa.getLastModifiedDate(),TimeOrDateUtils.FULL_YMD));

	  return dto;
	}
    public DTOQA() {
    }

    public DTOQA(Integer id) {
        this.id = id;
    }


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public Integer getQuestionUserId() {
        return questionUserId;
    }

    public void setQuestionUserId(Integer questionUserId) {
        this.questionUserId = questionUserId;
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

    public String getAnswerContent() {
        return answerContent;
    }

    public void setAnswerContent(String answerContent) {
        this.answerContent = answerContent;
    }

    public Integer getAnswerUserId() {
        return answerUserId;
    }

    public void setAnswerUserId(Integer answerUserId) {
        this.answerUserId = answerUserId;
    }

    public String getAnswerUserName() {
        return answerUserName;
    }

    public void setAnswerUserName(String answerUserName) {
        this.answerUserName = answerUserName;
    }


    public Integer getIsTop() {
        return isTop;
    }

    public void setIsTop(Integer isTop) {
        this.isTop = isTop;
    }


	public String getLastAnswerDate() {
		return lastAnswerDate;
	}

	public void setLastAnswerDate(String lastAnswerDate) {
		this.lastAnswerDate = lastAnswerDate;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getLastModifiedDate() {
		return lastModifiedDate;
	}

	public void setLastModifiedDate(String lastModifiedDate) {
		this.lastModifiedDate = lastModifiedDate;
	}
    
}
