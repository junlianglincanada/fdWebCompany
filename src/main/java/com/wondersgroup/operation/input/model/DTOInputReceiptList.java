package com.wondersgroup.operation.input.model;

import java.util.List;
import java.util.Map;

import com.wondersgroup.data.jpa.entity.Attachment;

public class DTOInputReceiptList {
	private String name;
	private Integer inputReceiptId;
	private String inputDate;
	private Integer receiptCount;
	private List<Attachment> attachmentList;

	public static DTOInputReceiptList toDTO(Map map) {
		DTOInputReceiptList dto = new DTOInputReceiptList();
		dto.setName((map.get("name") == null ? "" : map.get("name")).toString());
		dto.setInputReceiptId(Integer.parseInt((map.get("inputReceiptId") == null ? -1 : map.get("inputReceiptId")).toString()));
		dto.setInputDate((map.get("inputDate") == null ? "" : map.get("inputDate")).toString());

		return dto;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getInputReceiptId() {
		return inputReceiptId;
	}

	public void setInputReceiptId(Integer inputReceiptId) {
		this.inputReceiptId = inputReceiptId;
	}

	public String getInputDate() {
		return inputDate;
	}

	public void setInputDate(String inputDate) {
		this.inputDate = inputDate;
	}

	public Integer getReceiptCount() {
		return receiptCount;
	}

	public void setReceiptCount(Integer receiptCount) {
		this.receiptCount = receiptCount;
	}

	public List<Attachment> getAttachmentList() {
		return attachmentList;
	}

	public void setAttachmentList(List<Attachment> attachmentList) {
		this.attachmentList = attachmentList;
	}

}
