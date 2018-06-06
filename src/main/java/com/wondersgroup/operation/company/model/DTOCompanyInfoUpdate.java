package com.wondersgroup.operation.company.model;

import java.util.Date;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.wondersgroup.data.jpa.entity.GeoAdminRegion;
import com.wondersgroup.data.jpa.entity.Restaurant;
import com.wondersgroup.framework.common.GeoAdminRegionService;
import com.wondersgroup.operation.util.formatter.QJ2BJDeserializer;

public class DTOCompanyInfoUpdate {
	
	// 单位ID
	private Integer companyId;

	// 单位名称
	@JsonDeserialize(using = QJ2BJDeserializer.class)
	private String companyName;

	// 单位店招
	private String companyNameAbbrev;

	// 单位注册地址
	private String companyRegAddress;

	// 单位经营地址
	private String companyBizAddress;
	
	// 省ID
	private Integer regionProvinceId;
			
	// 市ID
	private Integer regionCityId;

	// 区县ID
	private Integer regionCountyId;

	// 区县ID
	private Integer regionStreetId;

	// 餐饮许可证号
	private String cateringCert;
    //餐饮证号到期时间
    private Date cateringCertExpDate;
	//10.9
	private String legalPerson;//法人
	private String contactPerson;//联系人
	private String contactPhone;//联系电话
	private int foodSaftyRating;//食品安全等级
	private String bizCertNumber;	//工商证号
    //工商执照到期时间
    private Date bizCertExpDate;

	private Integer seats;//就餐座位数
    private String honorQualification;//荣誉资质
    private String complaintPhone;//店内投诉电话
    private Integer averageComsumption;//人均消费
    private String restAtmosphere;//餐厅氛围
    private String restFeature;//餐厅特色
    private String restCuisineType;//餐厅菜系
    private String postalCode;//邮编
    private Integer commercialCenter;//商圈
    private Integer isStuMeal;//是否配送学生营养餐
    private Integer isMnt;//是否纳入温湿度监控
    private Integer isCam;//是否纳入视频监控
	private String type;//单位类型
	private String transportation;//交通方式
    private String gisLongitude;//坐标经度
    private String gisLatitude;//坐标纬度
	
    //食品流通
    private String foodCircuCert;
    //食品流通号到期时间
    private Date foodCircuCertExpDate;
	//食品生产
	private String foodProdCert;
    //食品生产号到期时间
    private Date foodProdCertExpDate;
    //食品经营证
    private String foodBusinessCert;
    //食品经营证到期时间
    private Date foodBusinessCertExpDate;
	
	public static Restaurant toEntity(DTOCompanyInfoUpdate dto, GeoAdminRegionService geoAdminRegionService) {
		Restaurant entity = null;
		
		if (dto != null) {
			if (entity == null) {
				entity = new Restaurant();
				entity.setCompanyType(Restaurant.COMPANY_TYPE);
				//entity.setCreateDate(new Date());
				//TYPE 先写死
				entity.setType("00000001");
			}
			entity.setCompanyId(dto.getCompanyId());
			entity.setCompanyName(dto.getCompanyName());
			entity.setNameAbbrev(dto.getCompanyNameAbbrev());
			entity.setCompanyAddress(dto.getCompanyRegAddress());
			
			entity.setBizAddress(dto.getCompanyBizAddress());
			
			entity.setRegionProvince(dto.getRegionProvinceId());
			entity.setRegionCity(dto.getRegionCityId());
			entity.setRegionCounty(dto.getRegionCountyId());
			entity.setRegionStreet(dto.getRegionStreetId());
			entity.setLastModifiedDate(new Date());
			entity.setCateringCert(dto.getCateringCert());
			entity.setCateringCertExpDate(dto.getCateringCertExpDate());
			entity.setFoodCircuCert(dto.getFoodCircuCert());
			entity.setFoodCircuCertExpDate(dto.getFoodCircuCertExpDate());
			entity.setFoodProdCert(dto.getFoodProdCert());
			entity.setFoodProdCertExpDate(dto.getFoodProdCertExpDate());
			entity.setFoodBusinessCert(dto.getFoodBusinessCert());
			entity.setFoodBusinessCertExpDate(dto.getFoodBusinessCertExpDate());

			Integer regionId = dto.getRegionStreetId();
			if (null != regionId) {
				GeoAdminRegion region = geoAdminRegionService.getGeoAdminRegionById(regionId);
				entity.setCompanyRegion(region);
			}
			entity.setLegalPerson(dto.getLegalPerson());
			entity.setContactPerson(dto.getContactPerson());
			entity.setContactPhone(dto.getContactPhone());
			entity.setFoodSaftyRating(dto.getFoodSaftyRating());
			entity.setBizCertNumber(dto.getBizCertNumber());
			entity.setBizCertExpDate(dto.getBizCertExpDate());
			entity.setSeats(dto.getSeats());
			entity.setHonorQualification(dto.getHonorQualification());
			entity.setComplaintPhone(dto.getComplaintPhone());
			entity.setAverageComsumption(dto.getAverageComsumption());
			entity.setRestAtmosphere(dto.getRestAtmosphere());
			entity.setRestCuisineType(dto.getRestCuisineType());
			entity.setRestFeature(dto.getRestFeature());
			entity.setPostalCode(dto.getPostalCode());
			entity.setCommercialCenter(dto.getCommercialCenter());
			entity.setIsCam(dto.getIsCam());
			entity.setIsMnt(dto.getIsMnt());
			entity.setIsStuMeal(dto.getIsStuMeal());
			entity.setTransportation(dto.getTransportation());
			entity.setGisLatitude(dto.getGisLatitude());
			entity.setGisLongitude(dto.getGisLongitude());
		}
		return entity;
	}
	
	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getCompanyNameAbbrev() {
		return companyNameAbbrev;
	}

	public void setCompanyNameAbbrev(String companyNameAbbrev) {
		this.companyNameAbbrev = companyNameAbbrev;
	}

	public String getCompanyRegAddress() {
		return companyRegAddress;
	}

	public void setCompanyRegAddress(String companyRegAddress) {
		this.companyRegAddress = companyRegAddress;
	}

	public String getCompanyBizAddress() {
		return companyBizAddress;
	}

	public void setCompanyBizAddress(String companyBizAddress) {
		this.companyBizAddress = companyBizAddress;
	}

	public Integer getRegionProvinceId() {
		return regionProvinceId;
	}

	public void setRegionProvinceId(Integer regionProvinceId) {
		this.regionProvinceId = regionProvinceId;
	}

	public Integer getRegionCityId() {
		return regionCityId;
	}

	public void setRegionCityId(Integer regionCityId) {
		this.regionCityId = regionCityId;
	}

	public Integer getRegionCountyId() {
		return regionCountyId;
	}

	public void setRegionCountyId(Integer regionCountyId) {
		this.regionCountyId = regionCountyId;
	}

	public Integer getRegionStreetId() {
		return regionStreetId;
	}

	public void setRegionStreetId(Integer regionStreetId) {
		this.regionStreetId = regionStreetId;
	}

	public String getCateringCert() {
		return cateringCert;
	}

	public void setCateringCert(String cateringCert) {
		this.cateringCert = cateringCert;
	}

    public Date getCateringCertExpDate() {
        return cateringCertExpDate;
    }

    public void setCateringCertExpDate(Date cateringCertExpDate) {
        this.cateringCertExpDate = cateringCertExpDate;
    }
    
	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	public String getLegalPerson() {
		return legalPerson;
	}

	public void setLegalPerson(String legalPerson) {
		this.legalPerson = legalPerson;
	}

	public String getContactPerson() {
		return contactPerson;
	}

	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}

	public String getContactPhone() {
		return contactPhone;
	}

	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}



	public int getFoodSaftyRating() {
		return foodSaftyRating;
	}

	public void setFoodSaftyRating(int foodSaftyRating) {
		this.foodSaftyRating = foodSaftyRating;
	}

	public String getBizCertNumber() {
		return bizCertNumber;
	}

	public void setBizCertNumber(String bizCertNumber) {
		this.bizCertNumber = bizCertNumber;
	}

    public Date getBizCertExpDate() {
        return bizCertExpDate;
    }

    public void setBizCertExpDate(Date bizCertExpDate) {
        this.bizCertExpDate = bizCertExpDate;
    }

	public Integer getSeats() {
		return seats;
	}

	public void setSeats(Integer seats) {
		this.seats = seats;
	}

	public String getHonorQualification() {
		return honorQualification;
	}

	public void setHonorQualification(String honorQualification) {
		this.honorQualification = honorQualification;
	}

	public String getComplaintPhone() {
		return complaintPhone;
	}

	public void setComplaintPhone(String complaintPhone) {
		this.complaintPhone = complaintPhone;
	}

	public Integer getAverageComsumption() {
		return averageComsumption;
	}

	public void setAverageComsumption(Integer averageComsumption) {
		this.averageComsumption = averageComsumption;
	}

	public String getRestAtmosphere() {
		return restAtmosphere;
	}

	public void setRestAtmosphere(String restAtmosphere) {
		this.restAtmosphere = restAtmosphere;
	}

	public String getRestFeature() {
		return restFeature;
	}

	public void setRestFeature(String restFeature) {
		this.restFeature = restFeature;
	}

	public String getRestCuisineType() {
		return restCuisineType;
	}

	public void setRestCuisineType(String restCuisineType) {
		this.restCuisineType = restCuisineType;
	}

	public String getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}

	public Integer getCommercialCenter() {
		return commercialCenter;
	}

	public void setCommercialCenter(Integer commercialCenter) {
		this.commercialCenter = commercialCenter;
	}

	public Integer getIsStuMeal() {
		return isStuMeal;
	}

	public void setIsStuMeal(Integer isStuMeal) {
		this.isStuMeal = isStuMeal;
	}

	public Integer getIsMnt() {
		return isMnt;
	}

	public void setIsMnt(Integer isMnt) {
		this.isMnt = isMnt;
	}

	public Integer getIsCam() {
		return isCam;
	}

	public void setIsCam(Integer isCam) {
		this.isCam = isCam;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTransportation() {
		return transportation;
	}

	public void setTransportation(String transportation) {
		this.transportation = transportation;
	}

	public String getGisLongitude() {
		return gisLongitude;
	}

	public void setGisLongitude(String gisLongitude) {
		this.gisLongitude = gisLongitude;
	}

	public String getGisLatitude() {
		return gisLatitude;
	}

	public void setGisLatitude(String gisLatitude) {
		this.gisLatitude = gisLatitude;
	}
	
	public String getFoodCircuCert() {
		return foodCircuCert;
	}

	public void setFoodCircuCert(String foodCircuCert) {
		this.foodCircuCert = foodCircuCert;
	}

    public Date getFoodCircuCertExpDate() {
        return foodCircuCertExpDate;
    }

    public void setFoodCircuCertExpDate(Date foodCircuCertExpDate) {
        this.foodCircuCertExpDate = foodCircuCertExpDate;
    }
    
	public String getFoodProdCert() {
		return foodProdCert;
	}

	public void setFoodProdCert(String foodProdCert) {
		this.foodProdCert = foodProdCert;
	}
    public Date getFoodProdCertExpDate() {
        return foodProdCertExpDate;
    }

    public void setFoodProdCertExpDate(Date foodProdCertExpDate) {
        this.foodProdCertExpDate = foodProdCertExpDate;
    }

	public String getFoodBusinessCert() {
		return foodBusinessCert;
	}

	public void setFoodBusinessCert(String foodBusinessCert) {
		this.foodBusinessCert = foodBusinessCert;
	}

	public Date getFoodBusinessCertExpDate() {
		return foodBusinessCertExpDate;
	}

	public void setFoodBusinessCertExpDate(Date foodBusinessCertExpDate) {
		this.foodBusinessCertExpDate = foodBusinessCertExpDate;
	}
    
}
