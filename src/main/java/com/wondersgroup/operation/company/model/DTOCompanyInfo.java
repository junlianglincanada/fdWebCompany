package com.wondersgroup.operation.company.model;

import java.util.Date;

import org.apache.commons.lang.StringUtils;

import com.wondersgroup.data.jpa.entity.Restaurant;
import com.wondersgroup.framework.common.DataDictService;

public class DTOCompanyInfo {

	// 单位ID
	private Integer companyId;

	// 单位名称
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

	private String legalPerson;// 法人
	private String contactPerson;// 联系人
	private String contactPhone;// 联系电话
	private Integer foodSaftyRating;// 食品安全等级
	private String bizCertNumber; // 工商证号
    //工商执照到期时间
    private Date bizCertExpDate;

	private Integer seats;// 就餐座位数
	private String honorQualification;// 荣誉资质
	private String complaintPhone;// 店内投诉电话
	private Integer averageComsumption;// 人均消费
	private String restAtmosphere;// 餐厅氛围
	private String restFeature;// 餐厅特色
	private String restCuisineType;// 餐厅菜系
	private String postalCode;// 邮编
	private Integer commercialCenter;// 商圈
	private Integer isStuMeal;// 是否配送学生营养餐
	private Integer isMnt;// 是否纳入温湿度监控
	private Integer isCam;// 是否纳入视频监控
	private String type;// 单位类型
	private String transportation;// 交通方式
	private String gisLongitude;// 坐标经度
	private String gisLatitude;// 坐标纬度
	// 食品流通证
	private String foodCircuCert;
    //食品流通号到期时间
    private Date foodCircuCertExpDate;
	// 食品生产证
	private String foodProdCert;
    //食品生产号到期时间
    private Date foodProdCertExpDate;
    //食品经营证
    private String foodBusinessCert;
    //食品经营证到期时间
    private Date foodBusinessCertExpDate;

	private String restCuisineTypeValue;// 餐厅菜系
	private String restAtmosphereValue;// 餐厅氛围
	private String averageComsumptionValue;// 人均消费
	private String commercialCenterValue;// 商圈
	
	private Integer regByOfficialCert;//匹配证件库的证件类型

	public static DTOCompanyInfo toDTO(Restaurant entity) {
		DTOCompanyInfo dto = null;

		if (entity != null) {
			dto = new DTOCompanyInfo();
			dto.setCompanyId(entity.getCompanyId());
			dto.setCompanyName(entity.getCompanyName());
			dto.setCompanyNameAbbrev(entity.getNameAbbrev());
			dto.setCompanyBizAddress(entity.getBizAddress());
			dto.setCompanyRegAddress(entity.getCompanyAddress());
			dto.setRegionProvinceId(entity.getRegionProvince());
			dto.setRegionCityId(entity.getRegionCity());
			dto.setRegionCountyId(entity.getRegionCounty());
			dto.setRegionStreetId(entity.getRegionStreet());
			dto.setCateringCert(entity.getCateringCert());
			dto.setCateringCertExpDate(entity.getCateringCertExpDate());
			dto.setFoodCircuCert(entity.getFoodCircuCert());
			dto.setFoodCircuCertExpDate(entity.getFoodCircuCertExpDate());
			dto.setFoodProdCert(entity.getFoodProdCert());
			dto.setFoodProdCertExpDate(entity.getFoodProdCertExpDate());
			dto.setFoodBusinessCert(entity.getFoodBusinessCert());
			dto.setFoodBusinessCertExpDate(entity.getFoodBusinessCertExpDate());

			dto.setLegalPerson(entity.getLegalPerson());
			dto.setContactPerson(entity.getContactPerson());
			dto.setContactPhone(entity.getContactPhone());
			dto.setFoodSaftyRating(entity.getFoodSaftyRating());
			dto.setBizCertNumber(entity.getBizCertNumber());
			dto.setBizCertExpDate(entity.getBizCertExpDate());
			dto.setSeats(entity.getSeats());
			dto.setHonorQualification(entity.getHonorQualification());
			dto.setComplaintPhone(entity.getComplaintPhone());
			dto.setAverageComsumption(entity.getAverageComsumption());
			dto.setRestAtmosphere(entity.getRestAtmosphere());
			dto.setRestCuisineType(entity.getRestCuisineType());
			dto.setRestFeature(entity.getRestFeature());
			dto.setPostalCode(entity.getPostalCode());
			dto.setCommercialCenter(entity.getCommercialCenter());
			dto.setIsCam(entity.getIsCam());
			dto.setIsMnt(entity.getIsMnt());
			dto.setIsStuMeal(entity.getIsStuMeal());
			dto.setTransportation(entity.getTransportation());
			dto.setGisLatitude(entity.getGisLatitude());
			dto.setGisLongitude(entity.getGisLongitude());
			dto.setRegByOfficialCert(entity.getRegByOfficialCert());
			if (StringUtils.isNotEmpty(entity.getRestCuisineType())) {
				String [] cuisine=entity.getRestCuisineType().split(",");
				String _restCuisineTypeValue="";
				for (int i = 0; i < cuisine.length; i++) {
					_restCuisineTypeValue+=DataDictService
							.getDataDicDetailNameById(Integer.valueOf(cuisine[i]))+",";
				}
				dto.setRestCuisineTypeValue(_restCuisineTypeValue);
			}
			if (StringUtils.isNotEmpty(entity.getRestAtmosphere())) {
				String [] restAtmosphere=entity.getRestAtmosphere().split(",");
				String _restAtmosphereValue="";
				for (int i = 0; i < restAtmosphere.length; i++) {
					_restAtmosphereValue+=DataDictService
							.getDataDicDetailNameById(Integer.valueOf(restAtmosphere[i]))+",";
				}
				dto.setRestAtmosphereValue(_restAtmosphereValue);
			}
			if (null != entity.getAverageComsumption()) {
				dto.setAverageComsumptionValue(DataDictService
						.getDataDicDetailNameById(entity
								.getAverageComsumption()));
			}
			if (null != entity.getCommercialCenter()) {
				dto.setCommercialCenterValue(DataDictService
						.getDataDicDetailNameById(entity.getCommercialCenter()));
			}
		}
		return dto;
	}

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
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

	public Integer getFoodSaftyRating() {
		return foodSaftyRating;
	}

	public void setFoodSaftyRating(Integer foodSaftyRating) {
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
    
	public String getRestCuisineTypeValue() {
		return restCuisineTypeValue;
	}

	public void setRestCuisineTypeValue(String restCuisineTypeValue) {
		this.restCuisineTypeValue = restCuisineTypeValue;
	}

	public String getRestAtmosphereValue() {
		return restAtmosphereValue;
	}

	public void setRestAtmosphereValue(String restAtmosphereValue) {
		this.restAtmosphereValue = restAtmosphereValue;
	}

	public String getAverageComsumptionValue() {
		return averageComsumptionValue;
	}

	public void setAverageComsumptionValue(String averageComsumptionValue) {
		this.averageComsumptionValue = averageComsumptionValue;
	}

	public String getCommercialCenterValue() {
		return commercialCenterValue;
	}

	public void setCommercialCenterValue(String commercialCenterValue) {
		this.commercialCenterValue = commercialCenterValue;
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

	public Integer getRegByOfficialCert() {
		return regByOfficialCert;
	}

	public void setRegByOfficialCert(Integer regByOfficialCert) {
		this.regByOfficialCert = regByOfficialCert;
	}

}
