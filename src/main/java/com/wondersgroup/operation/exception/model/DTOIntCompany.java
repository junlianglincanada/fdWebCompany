package com.wondersgroup.operation.exception.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.springframework.util.StringUtils;

import com.wondersgroup.data.jpa.entity.IntCompany;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.util.TimeOrDateUtils;

public class DTOIntCompany implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer id;
	private Integer companyId;
	private Date bizCertExpDate;
	private String bizCert;
	private Date cateringCertExpDate;
	private String cateringCert;
	private Date foodCircuCertExpDate;
	private String foodCircuCert;
	private Date foodProdCertExpDate;
	private String foodProdCert;
	private String companyName;
	private String bizStatus;
	private String cateringStatus;
	private String foodCircuCertStatus;
	private String foodProdStatus;
	private Date foodBusinessCertExpDate;
	private String foodBusinessCert;
	private String foodBusinessStatus;
	private Date date;

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getBizStatus() {
		return bizStatus;
	}

	public void setBizStatus(String bizStatus) {
		this.bizStatus = bizStatus;
	}

	public String getCateringStatus() {
		return cateringStatus;
	}

	public void setCateringStatus(String cateringStatus) {
		this.cateringStatus = cateringStatus;
	}

	public String getFoodCircuCertStatus() {
		return foodCircuCertStatus;
	}

	public void setFoodCircuCertStatus(String foodCircuCertStatus) {
		this.foodCircuCertStatus = foodCircuCertStatus;
	}

	public String getFoodProdStatus() {
		return foodProdStatus;
	}

	public void setFoodProdStatus(String foodProdStatus) {
		this.foodProdStatus = foodProdStatus;
	}

	public String getBizCert() {
		return bizCert;
	}
	public void setBizCert(String bizCert) {
		this.bizCert = bizCert;
	}
	public String getCateringCert() {
		return cateringCert;
	}

	public void setCateringCert(String cateringCert) {
		this.cateringCert = cateringCert;
	}

	public String getFoodCircuCert() {
		return foodCircuCert;
	}

	public void setFoodCircuCert(String foodCircuCert) {
		this.foodCircuCert = foodCircuCert;
	}

	public String getFoodProdCert() {
		return foodProdCert;
	}

	public void setFoodProdCert(String foodProdCert) {
		this.foodProdCert = foodProdCert;
	}

	public Date getCateringCertExpDate() {
		return cateringCertExpDate;
	}

	public void setCateringCertExpDate(Date cateringCertExpDate) {
		this.cateringCertExpDate = cateringCertExpDate;
	}

	public Date getFoodCircuCertExpDate() {
		return foodCircuCertExpDate;
	}

	public void setFoodCircuCertExpDate(Date foodCircuCertExpDate) {
		this.foodCircuCertExpDate = foodCircuCertExpDate;
	}

	public Date getFoodProdCertExpDate() {
		return foodProdCertExpDate;
	}

	public void setFoodProdCertExpDate(Date foodProdCertExpDate) {
		this.foodProdCertExpDate = foodProdCertExpDate;
	}

	public static List<DTOIntCompany> createListByEntities(
			Collection<IntCompany> domainInstanceList, String zjType,
			String zjStatus) {
		List<DTOIntCompany> list = new ArrayList<DTOIntCompany>();
		if (domainInstanceList != null) {
			for (IntCompany domainInstance : domainInstanceList) {
				DTOIntCompany data = toDTO(domainInstance, zjType, zjStatus);
				if (data != null) {
					list.add(data);
				}
			}
		}
		return list;
	}

	// status: 0已经过期 1快过期
	public static DTOIntCompany toDTO(IntCompany entity, String type,
			String status) {
		DTOIntCompany otdObject = new DTOIntCompany();
		Date date1 = new Date();
		otdObject.setId(entity.getId());
		otdObject.setCompanyId(entity.getCompanyId());
		otdObject.setCompanyName(entity.getName());
		otdObject.setDate(date1);
		Date statusDate = new Date();
		String newDate = TimeOrDateUtils.formateDate(statusDate,
				TimeOrDateUtils.FULL_YMD);
		statusDate = TimeOrDateUtils.parseDate(newDate);
		Calendar cal = Calendar.getInstance();
		cal.add(cal.MONTH, 1);
		Date date = cal.getTime();
		if (StringUtils.isEmpty(type) && StringUtils.isEmpty(status)) {
			Date bizCertExpDate = entity.getBizCertExpDate();
			if (bizCertExpDate != null) {
				if (bizCertExpDate.getTime() < statusDate.getTime()) {
					otdObject.setBizCert(entity.getBizCertNum());
					otdObject.setBizStatus("已过期");
					otdObject.setBizCertExpDate(entity.getBizCertExpDate());
				} else if (bizCertExpDate.getTime() >= statusDate.getTime()&& bizCertExpDate.getTime() < date.getTime()) {
					otdObject.setBizCert(entity.getBizCertNum());
					otdObject.setBizStatus("快过期");
					otdObject.setBizCertExpDate(entity.getBizCertExpDate());
				}
			}

			Date cateringCertExpDate = entity.getCateringCertExpDate();
			if (cateringCertExpDate != null) {
				if (cateringCertExpDate.getTime() < statusDate.getTime()) {
					otdObject.setCateringCert(entity.getCateringCert());
					otdObject.setCateringStatus("已过期");
					otdObject.setCateringCertExpDate(entity.getCateringCertExpDate());
				} else if (cateringCertExpDate.getTime() >= statusDate.getTime()&& cateringCertExpDate.getTime() < date.getTime()) {
					otdObject.setCateringCert(entity.getCateringCert());
					otdObject.setCateringStatus("快过期");
					otdObject.setCateringCertExpDate(entity.getCateringCertExpDate());
				}
			}

			Date foodProdCertExpDate = entity.getFoodProdCertExpDate();
			if (foodProdCertExpDate != null) {
				if (foodProdCertExpDate.getTime() < statusDate.getTime()) {
					otdObject.setFoodProdCert(entity.getFoodProdCert());
					otdObject.setFoodProdStatus("已过期");
					otdObject.setFoodProdCertExpDate(entity.getFoodProdCertExpDate());
				} else if (foodProdCertExpDate.getTime() >= statusDate.getTime()&& foodProdCertExpDate.getTime() < date.getTime()) {
					otdObject.setFoodProdCert(entity.getFoodProdCert());
					otdObject.setFoodProdStatus("快过期");
					otdObject.setFoodProdCertExpDate(entity.getFoodProdCertExpDate());
				}
			}

			Date foodCircuCertExpDate = entity.getFoodCircuCertExpDate();
			if (foodCircuCertExpDate != null) {
				if (foodCircuCertExpDate.getTime() < statusDate.getTime()) {
					otdObject.setFoodCircuCert(entity.getFoodCircuCert());
					otdObject.setFoodCircuCertStatus("已过期");
					otdObject.setFoodCircuCertExpDate(entity.getFoodCircuCertExpDate());
				} else if (foodCircuCertExpDate.getTime() >= statusDate.getTime()&& foodCircuCertExpDate.getTime() < date.getTime()) {
					otdObject.setFoodCircuCert(entity.getFoodCircuCert());
					otdObject.setFoodCircuCertStatus("快过期");
					otdObject.setFoodCircuCertExpDate(entity.getFoodCircuCertExpDate());
				}
			}
			Date foodBusinessCertExpDate = entity.getFoodBusinessCertExpDate();
			if (foodBusinessCertExpDate != null) {
				if (foodBusinessCertExpDate.getTime() < statusDate.getTime()) {
					otdObject.setFoodBusinessCert(entity.getFoodBusinessCert());
					otdObject.setFoodBusinessStatus("已过期");
					otdObject.setFoodBusinessCertExpDate(entity.getFoodBusinessCertExpDate());
				} else if (foodBusinessCertExpDate.getTime() >= statusDate.getTime()&& foodBusinessCertExpDate.getTime() < date.getTime()) {
					otdObject.setFoodBusinessCert(entity.getFoodBusinessCert());
					otdObject.setFoodBusinessStatus("快过期");
					otdObject.setFoodBusinessCertExpDate(entity.getFoodBusinessCertExpDate());
				}
			}
		} else if (!StringUtils.isEmpty(type)) {
			if (type.equals(FoodConstant.ATT_COM_GSYYZZ)) {
				Date bizCertExpDate = entity.getBizCertExpDate();
				if (bizCertExpDate != null) {
					if (bizCertExpDate.getTime() < statusDate.getTime()) {
						otdObject.setBizCert(entity.getBizCertNum());
						otdObject.setBizStatus("已过期");
						otdObject.setBizCertExpDate(entity.getBizCertExpDate());
					} else if (bizCertExpDate.getTime() >= statusDate.getTime()&& bizCertExpDate.getTime() < date.getTime()) {
						otdObject.setBizCert(entity.getBizCertNum());
						otdObject.setBizStatus("快过期");
						otdObject.setBizCertExpDate(entity.getBizCertExpDate());
					}
				}
			} else if (type.equals(FoodConstant.ATT_COM_CYFWXKZ)) {
				Date cateringCertExpDate = entity.getCateringCertExpDate();
				if (cateringCertExpDate != null) {
					if (cateringCertExpDate.getTime() < statusDate.getTime()) {
						otdObject.setCateringCert(entity.getCateringCert());
						otdObject.setCateringStatus("已过期");
						otdObject.setCateringCertExpDate(entity.getCateringCertExpDate());
					} else if (cateringCertExpDate.getTime() >= statusDate.getTime()&& cateringCertExpDate.getTime() < date.getTime()) {
						otdObject.setCateringCert(entity.getCateringCert());
						otdObject.setCateringStatus("快过期");
						otdObject.setCateringCertExpDate(entity.getCateringCertExpDate());
					}
				}
			} else if (type.equals(FoodConstant.ATT_COM_SPSCXKZ)) {
				Date foodProdCertExpDate = entity.getFoodProdCertExpDate();
				if (foodProdCertExpDate != null) {
					if (foodProdCertExpDate.getTime() < statusDate.getTime()) {
						otdObject.setFoodProdCert(entity.getFoodProdCert());
						otdObject.setFoodProdStatus("已过期");
						otdObject.setFoodProdCertExpDate(entity.getFoodProdCertExpDate());
					} else if (foodProdCertExpDate.getTime() >= statusDate.getTime()&& foodProdCertExpDate.getTime() < date.getTime()) {
						otdObject.setFoodProdCert(entity.getFoodProdCert());
						otdObject.setFoodProdStatus("快过期");
						otdObject.setFoodProdCertExpDate(entity.getFoodProdCertExpDate());
					}
				}
			} else if (type.equals(FoodConstant.ATT_COM_SPLTXKZ)) {
				Date foodCircuCertExpDate = entity.getFoodCircuCertExpDate();
				if (foodCircuCertExpDate != null) {
					if (foodCircuCertExpDate.getTime() < statusDate.getTime()) {
						otdObject.setFoodCircuCert(entity.getFoodCircuCert());
						otdObject.setFoodCircuCertStatus("已过期");
						otdObject.setFoodCircuCertExpDate(entity.getFoodCircuCertExpDate());
					} else if (foodCircuCertExpDate.getTime() >= statusDate.getTime()&& foodCircuCertExpDate.getTime() < date.getTime()) {
						otdObject.setFoodCircuCert(entity.getFoodCircuCert());
						otdObject.setFoodCircuCertStatus("快过期");
						otdObject.setFoodCircuCertExpDate(entity.getFoodCircuCertExpDate());
					}
				}
			}else if(type.equals(FoodConstant.ATT_COM_SPJYXKZ)){
				Date foodBusinessCertExpDate = entity.getFoodBusinessCertExpDate();
				if (foodBusinessCertExpDate != null) {
					if (foodBusinessCertExpDate.getTime() < statusDate.getTime()) {
						otdObject.setFoodBusinessCert(entity.getFoodBusinessCert());
						otdObject.setFoodBusinessStatus("已过期");
						otdObject.setFoodBusinessCertExpDate(entity.getFoodBusinessCertExpDate());
					} else if (foodBusinessCertExpDate.getTime() >= statusDate.getTime()&& foodBusinessCertExpDate.getTime() < date.getTime()) {
						otdObject.setFoodBusinessCert(entity.getFoodBusinessCert());
						otdObject.setFoodBusinessStatus("快过期");
						otdObject.setFoodBusinessCertExpDate(entity.getFoodBusinessCertExpDate());
					}
				}
			}
		} else if (StringUtils.isEmpty(type) && status.equals("0")) {
			Date bizCertExpDate = entity.getBizCertExpDate();
			if (bizCertExpDate != null) {
				if (bizCertExpDate.getTime() < statusDate.getTime()) {
					otdObject.setBizCert(entity.getBizCertNum());
					otdObject.setBizStatus("已过期");
					otdObject.setBizCertExpDate(entity.getBizCertExpDate());
				}
			}
			Date cateringCertExpDate = entity.getCateringCertExpDate();
			if (cateringCertExpDate != null) {
				if (cateringCertExpDate.getTime() < statusDate.getTime()) {
					otdObject.setCateringCert(entity.getCateringCert());
					otdObject.setCateringStatus("已过期");
					otdObject.setCateringCertExpDate(entity.getCateringCertExpDate());
				}
			}
			Date foodProdCertExpDate = entity.getFoodProdCertExpDate();
			if (foodProdCertExpDate != null) {
				if (foodProdCertExpDate.getTime() < statusDate.getTime()) {
					otdObject.setFoodProdCert(entity.getFoodProdCert());
					otdObject.setFoodProdStatus("已过期");
					otdObject.setFoodProdCertExpDate(entity.getFoodProdCertExpDate());
				}
			}
			Date foodCircuCertExpDate = entity.getFoodCircuCertExpDate();
			if (foodCircuCertExpDate != null) {
				if (foodCircuCertExpDate.getTime() < statusDate.getTime()) {
					otdObject.setFoodCircuCert(entity.getFoodCircuCert());
					otdObject.setFoodCircuCertStatus("已过期");
					otdObject.setFoodCircuCertExpDate(entity.getFoodCircuCertExpDate());
				}
			}
				Date foodBusinessCertExpDate = entity.getFoodBusinessCertExpDate();
				if (foodBusinessCertExpDate != null) {
					otdObject.setFoodBusinessCert(entity.getFoodBusinessCert());
					if (foodBusinessCertExpDate.getTime() < statusDate.getTime()) {
						otdObject.setFoodBusinessStatus("已过期");
						otdObject.setFoodBusinessCertExpDate(entity.getFoodBusinessCertExpDate());
					}
				}

		} else if (StringUtils.isEmpty(type) && status.equals("1")) {
			Date bizCertExpDate = entity.getBizCertExpDate();
			if (bizCertExpDate != null) {
				if (bizCertExpDate.getTime() >= statusDate.getTime()&& bizCertExpDate.getTime() < date.getTime()) {
					otdObject.setBizCert(entity.getBizCertNum());
					otdObject.setBizStatus("快过期");
					otdObject.setBizCertExpDate(entity.getBizCertExpDate());
				}
			}
			Date cateringCertExpDate = entity.getCateringCertExpDate();
			if (cateringCertExpDate != null) {
				if (cateringCertExpDate.getTime() >= statusDate.getTime()&& cateringCertExpDate.getTime() < date.getTime()) {
					otdObject.setCateringCert(entity.getCateringCert());
					otdObject.setCateringStatus("快过期");
					otdObject.setCateringCertExpDate(entity.getCateringCertExpDate());
				}
			}
			Date foodProdCertExpDate = entity.getFoodProdCertExpDate();
			if (foodProdCertExpDate != null) {
				if (foodProdCertExpDate.getTime() >= statusDate.getTime()&& foodProdCertExpDate.getTime() < date.getTime()) {
					otdObject.setFoodProdCert(entity.getFoodProdCert());
					otdObject.setFoodProdStatus("快过期");
					otdObject.setFoodProdCertExpDate(entity.getFoodProdCertExpDate());
				}
			}
			Date foodCircuCertExpDate = entity.getFoodCircuCertExpDate();
			if (foodCircuCertExpDate != null) {
				if (foodCircuCertExpDate.getTime() >= statusDate.getTime()&& foodCircuCertExpDate.getTime() < date.getTime()) {
					otdObject.setFoodCircuCert(entity.getFoodCircuCert());
					otdObject.setFoodCircuCertStatus("快过期");
					otdObject.setFoodCircuCertExpDate(entity.getFoodCircuCertExpDate());

				}
			}
			Date foodBusinessCertExpDate = entity.getFoodBusinessCertExpDate();
			if (foodBusinessCertExpDate != null) {
				if (foodBusinessCertExpDate.getTime() >= statusDate.getTime()&& foodBusinessCertExpDate.getTime() < date.getTime()) {
			    	otdObject.setFoodBusinessCert(entity.getFoodBusinessCert());
			    	otdObject.setFoodBusinessStatus("快过期");
			    	otdObject.setFoodBusinessCertExpDate(entity.getFoodBusinessCertExpDate());
				}
			}
		}
		return otdObject;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getBizCertExpDate() {
		return bizCertExpDate;
	}

	public void setBizCertExpDate(Date bizCertExpDate) {
		this.bizCertExpDate = bizCertExpDate;
	}

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	public Date getFoodBusinessCertExpDate() {
		return foodBusinessCertExpDate;
	}

	public void setFoodBusinessCertExpDate(Date foodBusinessCertExpDate) {
		this.foodBusinessCertExpDate = foodBusinessCertExpDate;
	}

	public String getFoodBusinessCert() {
		return foodBusinessCert;
	}

	public void setFoodBusinessCert(String foodBusinessCert) {
		this.foodBusinessCert = foodBusinessCert;
	}

	public String getFoodBusinessStatus() {
		return foodBusinessStatus;
	}

	public void setFoodBusinessStatus(String foodBusinessStatus) {
		this.foodBusinessStatus = foodBusinessStatus;
	}


}
