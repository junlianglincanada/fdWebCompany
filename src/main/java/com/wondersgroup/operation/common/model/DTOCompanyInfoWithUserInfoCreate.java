package com.wondersgroup.operation.common.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.AppRole;
import com.wondersgroup.data.jpa.entity.AppUserRole;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.data.jpa.entity.GeoAdminRegion;
import com.wondersgroup.data.jpa.entity.Restaurant;
import com.wondersgroup.framework.common.GeoAdminRegionService;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.util.formatter.QJ2BJDeserializer;
import com.wondersgroup.service.empuser.RestaurantEmployeeLoginService;
import com.wondersgroup.util.EncodeUtils;

public class DTOCompanyInfoWithUserInfoCreate {

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
	
	// 登录用户名
	private String loginUserName;
	
	// 登录用户密码
	private String loginUserPsw;
	
	// 登录用户姓名
	private String loginUserPersonName;
	
	// 登录用户手机号
	private String loginUserMobile;
	//食品流通
    private String foodCircuCert;
	 //食品生产
	private String foodProdCert;
	//工商执照号
    private String bizCertNum;
    //食品经营
    private String foodBusinessCert;
    //食品经营许可证到期日期
    private Date endDate;
    //匹配证件库的证件类型
    private Integer regByOfficialCert;
	
	public static Restaurant toEntityRestaurant(DTOCompanyInfoWithUserInfoCreate dto, GeoAdminRegionService geoAdminRegionService) {
		Restaurant entity = null;
		
		if (dto != null) {
			if (entity == null) {
				entity = new Restaurant();
				entity.setCompanyType(Restaurant.COMPANY_TYPE);
				entity.setAccountStatus(1);
				entity.setCreateDate(new Date());
				//9.25
				entity.setType("00000000");
				entity.setAccountStatus(1);
			}
			entity.setCompanyName(dto.getCompanyName());
			entity.setNameAbbrev(dto.getCompanyNameAbbrev());
			entity.setCompanyAddress(dto.getCompanyRegAddress());

			Integer regionId = dto.getRegionStreetId();
			if (null != regionId) {
				GeoAdminRegion region = geoAdminRegionService.getGeoAdminRegionById(regionId);
				entity.setCompanyRegion(region);
			}

			entity.setRegionProvince(dto.getRegionProvinceId());
			entity.setRegionCity(dto.getRegionCityId());
			entity.setRegionCounty(dto.getRegionCountyId());
			entity.setRegionStreet(dto.getRegionStreetId());
			entity.setLastModifiedDate(new Date());
			entity.setBizAddress(dto.getCompanyBizAddress());
			entity.setCateringCert(dto.getCateringCert());
			entity.setContactPerson(dto.getLoginUserPersonName());
			entity.setContactPhone(dto.getLoginUserMobile());
			entity.setFoodCircuCert(dto.getFoodCircuCert());
			entity.setFoodProdCert(dto.getFoodProdCert());
			entity.setBizCertNumber(dto.getBizCertNum());
			entity.setFoodBusinessCert(dto.getFoodBusinessCert());
			entity.setFoodBusinessCertExpDate(dto.getEndDate());
			entity.setRegByOfficialCert(dto.getRegByOfficialCert());
		}
		return entity;
	}
	
	public static ComEmployee toEntityComEmployee(DTOCompanyInfoWithUserInfoCreate dto) {
		ComEmployee entity = null;
		
		if(dto != null) {
			entity = new ComEmployee();
			entity.setPersonName(dto.getLoginUserPersonName());
			entity.setPersonType(ComEmployee.TYPE_EMP);
			entity.setStatus(FoodConstant.FIELD_STATUS_VALID);
			entity.setMobilePhone(dto.getLoginUserMobile());
			entity.setCreateDate(new Date());
			entity.setLastModifiedDate(new Date());
		}
		
		return entity;
	}

	public static AppLoginUser toEntityAppLoginUser(DTOCompanyInfoWithUserInfoCreate dto,RestaurantEmployeeLoginService restaurantEmployeeLoginService) {
		AppLoginUser entity = null;
		
		if (dto != null) {
			entity = new AppLoginUser();
			entity.setUserType(AppLoginUser.TYPE_EMP);
			entity.setEnabled(FoodConstant.FIELD_STATUS_VALID);
			entity.setHasAppMgrPermission(FoodConstant.FIELD_STATUS_VALID);
			entity.setCreateDate(new Date());
			entity.setUsername(dto.getLoginUserName());
			entity.setPassword(EncodeUtils.encodePassword(dto.getLoginUserPsw()));
			 List<AppUserRole> comSecRoleUserList = new ArrayList<>();
	        AppRole role = restaurantEmployeeLoginService.getAppRoleById(FoodConstant.EMP_ADMIN);
            if (role != null) {
                AppUserRole roleUser = new AppUserRole();
                roleUser.setRole(role);
                roleUser.setUser(entity);
                comSecRoleUserList.add(roleUser);
                entity.setAppUserRoleList(comSecRoleUserList);
            }
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

	public String getLoginUserName() {
		return loginUserName;
	}

	public void setLoginUserName(String loginUserName) {
		this.loginUserName = loginUserName;
	}

	public String getLoginUserPsw() {
		return loginUserPsw;
	}

	public void setLoginUserPsw(String loginUserPsw) {
		this.loginUserPsw = loginUserPsw;
	}

	public String getLoginUserPersonName() {
		return loginUserPersonName;
	}

	public void setLoginUserPersonName(String loginUserPersonName) {
		this.loginUserPersonName = loginUserPersonName;
	}

	public String getLoginUserMobile() {
		return loginUserMobile;
	}

	public void setLoginUserMobile(String loginUserMobile) {
		this.loginUserMobile = loginUserMobile;
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

	public String getBizCertNum() {
		return bizCertNum;
	}

	public void setBizCertNum(String bizCertNum) {
		this.bizCertNum = bizCertNum;
	}

	public String getFoodBusinessCert() {
		return foodBusinessCert;
	}

	public void setFoodBusinessCert(String foodBusinessCert) {
		this.foodBusinessCert = foodBusinessCert;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public Integer getRegByOfficialCert() {
		return regByOfficialCert;
	}

	public void setRegByOfficialCert(Integer regByOfficialCert) {
		this.regByOfficialCert = regByOfficialCert;
	}
	
}
