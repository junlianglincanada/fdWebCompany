
package com.wondersgroup.operation.exception.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import com.wondersgroup.data.jpa.entity.Restaurant;


public class DTORestaurant implements Serializable {
    private Integer	companyId;
    private String companyName;
    private String nameAbbev;
    private String companyAddress;
	private Date bizCertExpDate;
    private Date cateringCertExpDate;
    private Date foodCircuCertExpDate;
    private Date foodProdCertExpDate;
    private Date foodBusinessCertExpDate;
    private int cun;
    private int cunTo;
    public static List<DTORestaurant> createListByEntities(
			Collection<Restaurant> domainInstanceList) {
		List<DTORestaurant> list = new ArrayList<DTORestaurant>();
		if (domainInstanceList != null) {
			for (Restaurant domainInstance : domainInstanceList) {
				DTORestaurant data = toDTO(domainInstance);
				if (data != null) {
					list.add(data);
				}
			}
		}
		return list;
	}
    
	public static DTORestaurant toDTO(Restaurant entity) {
		DTORestaurant otdObject = new DTORestaurant();
		otdObject.setCompanyId(entity.getCompanyId());
		otdObject.setBizCertExpDate(entity.getBizCertExpDate());
		otdObject.setCateringCertExpDate(entity.getCateringCertExpDate());
		otdObject.setFoodCircuCertExpDate(entity.getFoodCircuCertExpDate());
		otdObject.setFoodProdCertExpDate(entity.getFoodProdCertExpDate());
		otdObject.setCompanyName(entity.getCompanyName());
		otdObject.setNameAbbev(entity.getNameAbbrev());
		otdObject.setCompanyAddress(entity.getCompanyAddress());
		return otdObject;
	 }
    public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getNameAbbev() {
		return nameAbbev;
	}

	public void setNameAbbev(String nameAbbev) {
		this.nameAbbev = nameAbbev;
	}

	public String getCompanyAddress() {
		return companyAddress;
	}

	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}

	public int getCun() {
		return cun;
	}

	public void setCun(int cun) {
		this.cun = cun;
	}

	public int getCunTo() {
		return cunTo;
	}

	public void setCunTo(int cunTo) {
		this.cunTo = cunTo;
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
	
    
}
