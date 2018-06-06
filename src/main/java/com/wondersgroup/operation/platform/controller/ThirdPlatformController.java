package com.wondersgroup.operation.platform.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.Attachment;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.data.jpa.entity.InputBatchDetail;
import com.wondersgroup.data.jpa.entity.InputMaterial;
import com.wondersgroup.data.jpa.entity.IntCompany;
import com.wondersgroup.data.jpa.entity.OutputBatchDetail;
import com.wondersgroup.data.jpa.entity.OutputMaterial;
import com.wondersgroup.data.jpa.entity.Platform;
import com.wondersgroup.data.jpa.entity.PlatformCompany;
import com.wondersgroup.data.jpa.entity.PlatformData;
import com.wondersgroup.data.jpa.entity.Restaurant;
import com.wondersgroup.data.jpa.entity.RetentionSamples;
import com.wondersgroup.framework.cache.RedisService;
import com.wondersgroup.framework.common.AttachmentService;
import com.wondersgroup.framework.dao.JdbcAbstractDao;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.platform.model.DTOPlatformBatchInfo;
import com.wondersgroup.operation.platform.model.DTOPlatformComEmployeeInfo;
import com.wondersgroup.operation.platform.model.DTOPlatformMaterialInfo;
import com.wondersgroup.operation.platform.model.DTOPlatformReceiverInfo;
import com.wondersgroup.operation.platform.model.DTOPlatformSampleInfo;
import com.wondersgroup.operation.platform.model.DTOPlatformSupplierInfo;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.service.company.InternalCompanyService;
import com.wondersgroup.service.company.RestaurantService;
import com.wondersgroup.service.empuser.RestaurantEmployeeLoginService;
import com.wondersgroup.service.empuser.RestaurantEmployeeService;
import com.wondersgroup.service.input.InputBatchService;
import com.wondersgroup.service.input.InputMaterialService;
import com.wondersgroup.service.output.OutputBatchService;
import com.wondersgroup.service.output.OutputMaterialService;
import com.wondersgroup.service.platform.PlatformService;
import com.wondersgroup.util.Base64;
import com.wondersgroup.util.StringUtils;
import com.wondersgroup.util.TimeOrDateUtils;

@Controller
@RequestMapping("webservice")
public class ThirdPlatformController extends AbstractBaseController {
	private static final Logger LOGGER = LoggerFactory.getLogger(ThirdPlatformController.class);
	@Autowired
	private RestaurantService restaurantService;
	@Autowired
	private InternalCompanyService internalCompanyService;
	@Autowired
	private InputMaterialService inputMaterialService;
	@Autowired
	private OutputMaterialService outputMaterialService;
	@Autowired
	private InputBatchService inputBatchService;
	@Autowired
	private RestaurantEmployeeLoginService restaurantEmployeeLoginService;
	@Autowired
	private RedisService redisService;
	@Autowired
	private PlatformService platformService;
	@Autowired
	private AttachmentService attachmentService;
	@Autowired
	private RestaurantEmployeeService restaurantEmployeeService;
	
	public static final String UPLOAD_TYPE_COM_GSYYZZ = "COM_GSYYZZ"; //注册企业 -- 工商营业执照
    public static final String UPLOAD_TYPE_COM_ZZJGDM = "COM_ZZJGDM"; //注册企业 -- 组织机构代码
    public static final String UPLOAD_TYPE_COM_SWDJZ = "COM_SWDJZ"; //注册企业 -- 税务登记证
    public static final String UPLOAD_TYPE_COM_FRSFZ = "COM_FRSFZ"; //注册企业 -- 法人身份证
    public static final String UPLOAD_TYPE_COM_GAJMLWNDTXZ = "COM_GAJMLWNDTXZ"; //注册企业 -- 港澳居民来往内地通行证
    public static final String UPLOAD_TYPE_COM_TWJMLWNDTXZ = "COM_TWJMLWNDTXZ"; //注册企业 -- 台湾居民来往内地通行证
    public static final String UPLOAD_TYPE_COM_SPLTXKZ = "COM_SPLTXKZ"; //注册企业 -- 食品流通许可证
    public static final String UPLOAD_TYPE_COM_SPSCXKZ = "COM_SPSCXKZ"; //注册企业 -- 食品生产许可证
    public static final String UPLOAD_TYPE_COM_CYFWXKZ = "COM_CYFWXKZ"; //注册企业 -- 餐饮服务许可证
    public static final String UPLOAD_TYPE_COM_SPJYXKZ = "COM_SPJYXKZ"; //注册企业 -- 食品经营许可证
    public static final String UPLOAD_TYPE_COM_OTHER = "COM_OTHER"; //供应商 -- 其他证照
	
    public static final Map<String, String> uploadTypeToAttachTypeMap = new HashMap<String, String>() {
		private static final long serialVersionUID = 1948879947792327281L;
		{
			put(UPLOAD_TYPE_COM_GSYYZZ, FoodConstant.ATT_COM_GSYYZZ);
			put(UPLOAD_TYPE_COM_ZZJGDM, FoodConstant.ATT_COM_ZZJGDM);
			put(UPLOAD_TYPE_COM_SWDJZ, FoodConstant.ATT_COM_SWDJZ);
			put(UPLOAD_TYPE_COM_FRSFZ, FoodConstant.ATT_COM_FRSFZ);
			put(UPLOAD_TYPE_COM_GAJMLWNDTXZ, FoodConstant.ATT_COM_GAJMLWNDTXZ);
			put(UPLOAD_TYPE_COM_TWJMLWNDTXZ, FoodConstant.ATT_COM_TWJMLWNDTXZ);
			put(UPLOAD_TYPE_COM_SPLTXKZ, FoodConstant.ATT_COM_SPLTXKZ);
			put(UPLOAD_TYPE_COM_SPSCXKZ, FoodConstant.ATT_COM_SPSCXKZ);
			put(UPLOAD_TYPE_COM_CYFWXKZ, FoodConstant.ATT_COM_CYFWXKZ);
			put(UPLOAD_TYPE_COM_SPJYXKZ, FoodConstant.ATT_COM_SPJYXKZ);
			put(UPLOAD_TYPE_COM_OTHER, FoodConstant.ATT_COM_OTHER);
	}};
	
	private static final List<String> singleImageTypes = new ArrayList<String>() {
		private static final long serialVersionUID = 6694506005823947192L;
		{
			add(UPLOAD_TYPE_COM_GSYYZZ);
			add(UPLOAD_TYPE_COM_ZZJGDM);
			add(UPLOAD_TYPE_COM_SWDJZ);
			add(UPLOAD_TYPE_COM_FRSFZ);
			add(UPLOAD_TYPE_COM_GAJMLWNDTXZ);
			add(UPLOAD_TYPE_COM_TWJMLWNDTXZ);
			add(UPLOAD_TYPE_COM_SPLTXKZ);
			add(UPLOAD_TYPE_COM_SPSCXKZ);
			add(UPLOAD_TYPE_COM_CYFWXKZ);
			add(UPLOAD_TYPE_COM_SPJYXKZ);
			add(UPLOAD_TYPE_COM_OTHER);
		}
	};
	
	private static final String KEY_LOGIN = JdbcAbstractDao.getLocation()+"ThirdParty_Login_Key_";

	/**
	 * 重定向授权页面
	 * @param request
	 * @param response
	 * @param appID
	 * @param key
	 * @param PFMCompanyID
	 * @param callbackURL
	 * @return
	 */
	@RequestMapping(value = "/companyAuthority")
	public ModelAndView companyAuthority(HttpServletRequest request, HttpServletResponse response, @RequestParam int appID, @RequestParam String key, @RequestParam String PFMCompanyID, @RequestParam String callbackURL) {
		//入参验证
		if(appID<1||StringUtils.isBlank(PFMCompanyID)||StringUtils.isBlank(callbackURL)||PFMCompanyID.length()>50){
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		Platform platform = platformService.getPlatform(appID,key,Platform.PLATFORM_TYPE_PFM);
		if (platform == null) {
			throw FoodException.returnException("116001");
		}
		List<PlatformCompany> list=platform.getPlatformCompanyCollection();
		//验证PFM的公司ID唯一性
		if(list!=null&&list.size()>0){
			for(PlatformCompany pc:list){
				if(PFMCompanyID.equals(pc.getPlatformCompanyId())&&pc.getStatus() == FoodConstant.FIELD_STATUS_VALID && pc.getDelFlag() == FoodConstant.DELETE_FLAG_CREATE){
					throw FoodException.returnException("116003");
				}
			}
		}
		ModelMap model = new ModelMap();
		model.addAttribute("appID", appID);
		model.addAttribute("key", key);
		model.addAttribute("PFMCompanyID", PFMCompanyID);
		model.addAttribute("callbackURL", callbackURL);
		return new ModelAndView("redirect:/accredit/acc_index.jsp", model);
		// return new ModelAndView(new
		// RedirectView("/accredit/acc_index.jsp",true,false,false),model);
	}
	/**
	 * 用于第三方平台查询加密PFMCompanyID
	 * @param appID
	 * @param companyID
	 * @param key
	 * @return
	 */
	@RequestMapping(value = "/getPFMCompany", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult getPFMCompany(@RequestParam int appID,@RequestParam String PFMCompanyID,@RequestParam String key){

		Platform platform = platformService.getPlatform(appID,key,Platform.PLATFORM_TYPE_PFM);
		if (platform == null) {
			return CommonStatusResult.fail("116001", null);
		}
		PlatformCompany platformCompany = platformService.getPlatformCompanyByParams(appID, null, null, PFMCompanyID);

		if(platformCompany!=null){
			return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, platformCompany.getEncryptCompanyId());
		}else{
			return CommonStatusResult.fail("116002", null);
		}
	}
	/**
	 * 获取平台信息
	 * @param appID
	 * @return
	 */
	@RequestMapping(value = "/getPlatformById/{appID}", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult getPlatformById(@PathVariable int appID){
		//入参验证
		if(appID<1){
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		Platform platform = platformService.getPlatformById(appID);
		if (platform == null) {
			return CommonStatusResult.fail("116001", null);
		}
		Map<String,Object> result=new HashMap<String,Object>();
		result.put("appName", platform.getName());
		result.put("companyName", platform.getFromCompany());
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result);
	}

	/**
	 * 授权企业
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "/authorizeCompany", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult authorizeCompany(@RequestBody Map<String, Object> paramMap) {
		String username = getStringParam(paramMap, "username");
		String password = getStringParam(paramMap, "password");
		Integer appId = getIntParam(paramMap, "appId");
		String appKey = getStringParam(paramMap, "key");
		String platformCompanyId = getStringParam(paramMap, "platformCompanyId");
		// 用户名密码，appId不能为空
		if (appId == null || appId < 0 || StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
			return CommonStatusResult.fail("012002", null);
		}
		Platform platform = platformService.getPlatform(appId,appKey,Platform.PLATFORM_TYPE_PFM);
		if (platform == null) {
			return CommonStatusResult.fail("116001", null);
		}
		List<PlatformCompany> list=platform.getPlatformCompanyCollection();
		//验证PFM的公司ID唯一性
		if(list!=null&&list.size()>0){
			for(PlatformCompany pc:list){
				if(platformCompanyId.equals(pc.getPlatformCompanyId())&&pc.getStatus() == FoodConstant.FIELD_STATUS_VALID && pc.getDelFlag() == FoodConstant.DELETE_FLAG_CREATE){
					return CommonStatusResult.fail("116004", null);
				}
			}
		}
		AppLoginUser appuser = restaurantEmployeeLoginService.login(username, password, -1, AppLoginUser.TYPE_EMP);
		Integer count = 0;
		String key = KEY_LOGIN + appId + "_" + username;
		// 登录失败超过3次次日才能登录
		if (redisService.hasKey(key)) {
			count = Integer.valueOf(redisService.get(key).toString());
			if (count >= 3) {
				count++;
				Date now = new Date();
				Date tomorrow = TimeOrDateUtils.getDayEnd(now);
				long period = (tomorrow.getTime() - now.getTime()) / 1000 + 1;
				redisService.set(key, count, period);
				return CommonStatusResult.fail("091006", null);
			}
		}
		if (appuser != null) {
			PlatformCompany existed = platformService.getPlatformCompanyByParams(appId,appuser.getEmp().getCompany().getCompanyId(),null,null);
			if (existed != null) {
				return CommonStatusResult.fail("116003", null);
			}
			PlatformCompany platformCompany = new PlatformCompany();
			platformCompany.setCompanyId(appuser.getEmp().getCompany().getCompanyId());
			platformCompany.setPlatformId(platform);
			platformCompany.setPersonId(appuser.getEmp().getPersonId());
			if (StringUtils.isNotBlank(platformCompanyId)) {
				platformCompany.setPlatformCompanyId(platformCompanyId);
			}
			platformCompany.setStatus(FoodConstant.FIELD_STATUS_VALID);
			platformCompany.setCreateUser(appuser.getUsername());
			platformCompany.setCreateDate(new Date());
			platformCompany.setLastModifiedDate(new Date());
			String encryptCompanyId = encryptId(appuser.getEmp().getCompany().getCompanyId());
			platformCompany.setEncryptCompanyId(encryptCompanyId);
			platformService.createPlatformCompany(platformCompany);
			if (redisService.hasKey(key)) {
				Date now = new Date();
				Date tomorrow = TimeOrDateUtils.getDayEnd(now);
				long period = (tomorrow.getTime() - now.getTime()) / 1000 + 1;
				redisService.set(key, count, period);
			}
			String companyName = appuser.getEmp().getCompany().getCompanyName();
			Map<String,Object> result = new HashMap<String,Object>();
			result.put("companyName", companyName);
			result.put("companyId", encryptCompanyId);
			return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result);
		} else {
			if (redisService.hasKey(key)) {
				count = Integer.valueOf(redisService.get(key).toString());
				count++;
				redisService.set(key, count);
			} else {
				count++;
				redisService.set(key, count);
			}
			return CommonStatusResult.fail("012003", count);
		}
	}

	/**
	 * 对id进行加密
	 * 
	 * @param id
	 * @return
	 */
	public String encryptId(Integer id) {
		String companyId = id.toString();
		int sumChar = 0;
		String code;
		for (int i = 0; i < companyId.length(); i++) {
			sumChar += Integer.parseInt(String.valueOf(companyId.charAt(i)));
		}
		if (sumChar < 10) {
			code = "0" + sumChar + companyId;
		} else {
			code = Integer.toString(sumChar).substring(Integer.toString(sumChar).length() - 2) + companyId;
		}
		return Integer.toHexString(Integer.parseInt(code));
	}
	
	/**
	 * 第三方平台 新增供收台账
	 * @param appID
	 * @param key
	 * @param content
	 * @return
	 */
	@RequestMapping(value = "/appBatchDetail", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult appBatchDetail(@RequestParam int appID,@RequestParam String key,@RequestParam String content){
		Platform platform = platformService.getPlatform(appID,key,Platform.PLATFORM_TYPE_PFM);
		if (platform == null) {
			return CommonStatusResult.fail("116001", null);
		}
		JSONObject obj=new JSONObject();
		Integer supLinkedComId=null;//系统内供方企业ID
		Integer recLinkedComId=null;//系统内收房企业ID
		IntCompany supplier = new IntCompany();
		IntCompany receiver = new IntCompany();
		//待新增事务对象
		IntCompany supToCreate = null;
		IntCompany recToCreate = null;
		List<InputMaterial> inputMatListToCreate = new ArrayList<InputMaterial>();
		List<OutputMaterial> outputMatListToCreate = new ArrayList<OutputMaterial>();
		List<InputBatchDetail> ibdListToCreate = new ArrayList<InputBatchDetail>();
		List<OutputBatchDetail> obdListToCreate = new ArrayList<OutputBatchDetail>();
		PlatformData platformData = new PlatformData();
		platformData.setPlatformId(platform);
		platformData.setData(content);
		platformData.setType(PlatformData.PLATFORM_CREATE_BATCH);
		platformData.setCreateDate(new Date());
		try {
			obj = JSONObject.fromObject(content);
			String supplierCompanyID=obj.getString("supplierCompanyID");
			String receiverCompanyID=obj.getString("receiverCompanyID");
			//供应商和收货商企业ID不能同时为空
			if(StringUtils.isBlank(supplierCompanyID)&&StringUtils.isBlank(receiverCompanyID)){
				return CommonStatusResult.fail("116007", null);
			}
			if(StringUtils.isNotBlank(supplierCompanyID)){
				//验证供应商是否授权
				PlatformCompany supplierExisted=platformService.getPlatformCompanyByParams(appID, null, supplierCompanyID, null);
				if(supplierExisted==null){
					return CommonStatusResult.fail("116005", null);
				}
				supLinkedComId=supplierExisted.getCompanyId();
				platformData.setSupplierCompanyId(supLinkedComId);
			}
			if(StringUtils.isNotBlank(receiverCompanyID)){
				//验证收货商是否授权
				PlatformCompany receiverExisted=platformService.getPlatformCompanyByParams(appID, null, receiverCompanyID, null);
				if(receiverExisted==null){
					return CommonStatusResult.fail("116006", null);
				}
				recLinkedComId=receiverExisted.getCompanyId();
				platformData.setReceiverCompanyId(recLinkedComId);
			}
		} catch (Exception e) {
			//json转换错误
			return CommonStatusResult.fail("116000", null);
		}
		try {
			//收方系统内企业ID存在，查询或创建供应商
			if(recLinkedComId!=null&&recLinkedComId>0){
				JSONObject supplierInfo=obj.getJSONObject("supplier");
				if(supplierInfo.isEmpty()){//供应商信息不能为空
					return CommonStatusResult.fail("116008", null);
				}else{
					supplier=DTOPlatformSupplierInfo.createEntityByJson(supplierInfo, recLinkedComId);
					supplier.setLinkedCompanyId(supLinkedComId);
					//验证必填项
					if(StringUtils.isBlank(supplier.getName())||StringUtils.isBlank(supplier.getContactAddress())){
						return CommonStatusResult.fail("116008", null);
					}
					//证件号码至少有一个
					if(StringUtils.isBlank(supplier.getBizCertNum())&&StringUtils.isBlank(supplier.getCateringCert())&&StringUtils.isBlank(supplier.getFoodBusinessCert())&&StringUtils.isBlank(supplier.getFoodCircuCert())&&StringUtils.isBlank(supplier.getFoodProdCert())){
						return CommonStatusResult.fail("116009", null);
					}
					//证件号码格式验证
					if(!isBizCert(supplier.getBizCertNum())||!isCateringCert(supplier.getCateringCert())||!isFoodCircuCert(supplier.getFoodCircuCert())||!isFoodProdCert(supplier.getFoodProdCert())||!isFoodBusinessCert(supplier.getFoodBusinessCert())){
						return CommonStatusResult.fail("116010", null);
					}
					if(StringUtils.isNotBlank(supplier.getCode()) || StringUtils.isNotBlank(supplier.getName())){
						if(recLinkedComId!=null && recLinkedComId>0){
							//查询供应商，供应商不存在创建供应商
							IntCompany existed = internalCompanyService.getInternalCompany(recLinkedComId, IntCompany.COMPANY_TYPE_SUPPLIER, supplier.getName(), true, null, supplier.getCode());
							if(existed==null){
								boolean cateringCertFlag=internalCompanyService.isCertExist(null, "cateringCert", supplier.getCateringCert(), recLinkedComId, IntCompany.COMPANY_TYPE_SUPPLIER);
								boolean foodBusinessCertFlag=internalCompanyService.isCertExist(null, "foodBusinessCert", supplier.getFoodBusinessCert(), recLinkedComId, IntCompany.COMPANY_TYPE_SUPPLIER);
								boolean foodCircuCertFlag=internalCompanyService.isCertExist(null, "foodCircuCert", supplier.getFoodCircuCert(), recLinkedComId, IntCompany.COMPANY_TYPE_SUPPLIER);
								boolean foodProdCertFlag=internalCompanyService.isCertExist(null, "foodProdCert", supplier.getFoodProdCert(), recLinkedComId, IntCompany.COMPANY_TYPE_SUPPLIER);
								if(cateringCertFlag||foodBusinessCertFlag||foodCircuCertFlag||foodProdCertFlag){
									return CommonStatusResult.fail("116020", null);
								}
								supToCreate = supplier;
								//internalCompanyService.createInternalCompany(supplier);
							}else{
								supplier=existed;
							}
						}
					}
				}
			}
		} catch (Exception e) {
			return CommonStatusResult.fail("116011", null);
		}
		try {
			//供方系统内企业ID存在，查询或创建收货商
			if(supLinkedComId != null && supLinkedComId>0){
				JSONObject receiverInfo=obj.getJSONObject("receiver");
				if(receiverInfo.isEmpty()){
					return CommonStatusResult.fail("116012", null);
				}else{
					receiver=DTOPlatformReceiverInfo.createEntityByJson(receiverInfo, supLinkedComId);
					receiver.setLinkedCompanyId(recLinkedComId);
					//验证必填项
					if(StringUtils.isBlank(receiver.getName())||StringUtils.isBlank(receiver.getContactAddress())){
						return CommonStatusResult.fail("116012", null);
					}
					//证件号码至少有一个
//					if(StringUtils.isBlank(receiver.getBizCertNum())&&StringUtils.isBlank(receiver.getCateringCert())&&StringUtils.isBlank(receiver.getFoodBusinessCert())&&StringUtils.isBlank(receiver.getFoodCircuCert())&&StringUtils.isBlank(receiver.getFoodProdCert())){
//						return CommonStatusResult.fail("116013", null);
//					}
					//证件号码格式验证
					if(!isBizCert(receiver.getBizCertNum())||!isCateringCert(receiver.getCateringCert())||!isFoodCircuCert(receiver.getFoodCircuCert())||!isFoodProdCert(receiver.getFoodProdCert())||!isFoodBusinessCert(receiver.getFoodBusinessCert())){
						return CommonStatusResult.fail("116014", null);
					}
					if(StringUtils.isNotBlank(receiver.getCode()) || StringUtils.isNotBlank(receiver.getName())){
						if(supLinkedComId!=null && supLinkedComId>0){
							//查询收货商，收货商不存在创建收货商
							IntCompany existed = internalCompanyService.getInternalCompany(supLinkedComId, IntCompany.COMPANY_TYPE_RECEIVER, receiver.getName(), true, null, receiver.getCode());
							if(existed==null){
								boolean cateringCertFlag=internalCompanyService.isCertExist(null, "cateringCert", receiver.getCateringCert(), supLinkedComId, IntCompany.COMPANY_TYPE_RECEIVER);
								boolean foodBusinessCertFlag=internalCompanyService.isCertExist(null, "foodBusinessCert", receiver.getFoodBusinessCert(), supLinkedComId, IntCompany.COMPANY_TYPE_RECEIVER);
								boolean foodCircuCertFlag=internalCompanyService.isCertExist(null, "foodCircuCert", receiver.getFoodCircuCert(), supLinkedComId, IntCompany.COMPANY_TYPE_RECEIVER);
								boolean foodProdCertFlag=internalCompanyService.isCertExist(null, "foodProdCert", receiver.getFoodProdCert(), supLinkedComId, IntCompany.COMPANY_TYPE_RECEIVER);
								if(cateringCertFlag||foodBusinessCertFlag||foodCircuCertFlag||foodProdCertFlag){
									return CommonStatusResult.fail("116021", null);
								}
								recToCreate = receiver;
								//internalCompanyService.createInternalCompany(receiver);
							}else{
								receiver=existed;
							}
						}
					}
				}
			}
		} catch (Exception e) {
			return CommonStatusResult.fail("116015", null);
		}
		try {
			JSONArray materialList=obj.getJSONArray("material");
			//产品不能为空
			if(materialList==null||materialList.size()<1){
				return CommonStatusResult.fail("116017", null);
			}
			//不能超过1000条上限
			if(materialList.size()>1000){
				return CommonStatusResult.fail("116019", null);
			}
			for(int i =0;i<materialList.size();i++){
				JSONObject matObj=materialList.getJSONObject(i);
				
				//查询采购品或产出品是否存在，不存在创建
				if(recLinkedComId!=null&&recLinkedComId>0){
					InputMaterial inputMat=DTOPlatformMaterialInfo.createInputMaterialByJson(matObj, recLinkedComId);
					//产品必填项验证
					if(StringUtils.isBlank(inputMat.getName())||StringUtils.isBlank(inputMat.getSpec())||inputMat.getTypeGeneral()<0){
						return CommonStatusResult.fail("116016", i);
					}
					//保质期为正数
					if(inputMat.getGuaranteeValue()!=null&&inputMat.getGuaranteeValue()<0){
						return CommonStatusResult.fail("116018", i);
					}
					InputMaterial inputExisted=inputMaterialService.getInputMaterial(recLinkedComId, inputMat.getName(), inputMat.getSpec(), inputMat.getManufacture(), true, null);
					if(inputExisted==null){
						inputMatListToCreate.add(inputMat);
						//inputMaterialService.createInputMaterial(inputMat);
					}
				}
				if(supLinkedComId!=null&&supLinkedComId>0){
					OutputMaterial outputMat=DTOPlatformMaterialInfo.createOutputMaterialByJson(matObj, supLinkedComId);
					//产品必填项验证
					if(StringUtils.isBlank(outputMat.getName())||StringUtils.isBlank(outputMat.getSpec())||outputMat.getTypeGeneral()<0){
						return CommonStatusResult.fail("116016", i);
					}
					//保质期为正数
					if(outputMat.getGuaranteeValue()!=null&&outputMat.getGuaranteeValue()<0){
						return CommonStatusResult.fail("116018", i);
					}
					OutputMaterial outputExisted=outputMaterialService.getOutputMaterial(supLinkedComId, outputMat.getName(), outputMat.getSpec(), outputMat.getManufacture(), true, null);
					if(outputExisted==null){
						outputMatListToCreate.add(outputMat);
						//outputMaterialService.createOutputMaterial(outputMat);
					}
				}
			}
		} catch (Exception e) {
			return CommonStatusResult.fail("116016", null);
		}
		try {
			JSONArray batchList=obj.getJSONArray("batchDetail");
			//台账信息不能为空
			if(batchList==null||batchList.size()<1){
				return CommonStatusResult.fail("116022", null);
			}
			//不能超过1000条上限
			if(batchList.size()>1000){
				return CommonStatusResult.fail("116023", null);
			}
			for(int i=0;i<batchList.size();i++){
				JSONObject batchObj=batchList.getJSONObject(i);
				//收方系统内存在，创建进货台账
				if(recLinkedComId!=null && recLinkedComId>0){
					InputBatchDetail ibd=DTOPlatformBatchInfo.createInputBatchByJson(batchObj, recLinkedComId, supplier, appID);
					if(ibd.getInputDate()==null||StringUtils.isBlank(ibd.getInputMatName())||StringUtils.isBlank(ibd.getSpec())||ibd.getQuantity()==null||ibd.getQuantity().compareTo(BigDecimal.ZERO)<=0||(ibd.getProductionDate()==null&&StringUtils.isBlank(ibd.getProductionBatch()))||(ibd.getProductionDate()!=null&&ibd.getProductionDate().after(ibd.getInputDate()))){
						return CommonStatusResult.fail("116024", i);
					}
					ibdListToCreate.add(ibd);
				}
				//供方系统内存在，创建配送台账
				if(supLinkedComId!=null && supLinkedComId>0){
					OutputBatchDetail obd=DTOPlatformBatchInfo.createOutputBatchByJson(batchObj, supLinkedComId, receiver, appID);
					if(obd.getOutputDate()==null||StringUtils.isBlank(obd.getOutputMatName())||StringUtils.isBlank(obd.getSpec())||obd.getQuantity()==null||obd.getQuantity().compareTo(BigDecimal.ZERO)<=0||(obd.getProductionDate()==null&&StringUtils.isBlank(obd.getProductionBatch()))||(obd.getProductionDate()!=null&&obd.getProductionDate().after(obd.getOutputDate()))){
						return CommonStatusResult.fail("116024", i);
					}
					obdListToCreate.add(obd);
				}
			}
			platformService.createBatchByPlatformData(platformData, supToCreate, recToCreate, inputMatListToCreate, outputMatListToCreate, ibdListToCreate, obdListToCreate, false);
		} catch (Exception e) {
			return CommonStatusResult.fail("116024", null);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}
	@RequestMapping(value = "/erpInputBatchDetail", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult erpInputBatchDetail(@RequestParam int appID,@RequestParam String companyID,@RequestParam String key,@RequestParam String content){
		//授权验证
		PlatformCompany platformCompany = platformService.getPlatformCompany(appID, companyID, key, Platform.PLATFORM_TYPE_ERP);
		if(platformCompany==null){
			return CommonStatusResult.fail("116002", null);
		}
		JSONObject obj=new JSONObject();
		Integer recLinkedComId=platformCompany.getCompanyId();//系统内收房企业ID
		IntCompany supplier = new IntCompany();
		//待新增事务对象
		IntCompany supToCreate = null;
		List<InputMaterial> inputMatListToCreate = new ArrayList<InputMaterial>();
		List<InputBatchDetail> ibdListToCreate = new ArrayList<InputBatchDetail>();
		PlatformData platformData = new PlatformData();
		platformData.setPlatformId(platformCompany.getPlatformId());
		platformData.setData(content);
		platformData.setType(PlatformData.ERP_CREATE_INPUT_BATCH);
		platformData.setCreateDate(new Date());
		platformData.setReceiverCompanyId(recLinkedComId);
		try {
			obj = JSONObject.fromObject(content);
		} catch (Exception e) {
			//json转换错误
			return CommonStatusResult.fail("116000", null);
		}
		try {
			//收方系统内企业ID存在，查询或创建供应商
			if(recLinkedComId!=null&&recLinkedComId>0){
				JSONObject supplierInfo=obj.getJSONObject("supplier");
				if(supplierInfo.isEmpty()){//供应商信息不能为空
					return CommonStatusResult.fail("116008", null);
				}else{
					supplier=DTOPlatformSupplierInfo.createEntityByJson(supplierInfo, recLinkedComId);
					//验证必填项
					if(StringUtils.isBlank(supplier.getName())||StringUtils.isBlank(supplier.getContactAddress())){
						return CommonStatusResult.fail("116008", null);
					}
					//证件号码至少有一个
					if(StringUtils.isBlank(supplier.getBizCertNum())&&StringUtils.isBlank(supplier.getCateringCert())&&StringUtils.isBlank(supplier.getFoodBusinessCert())&&StringUtils.isBlank(supplier.getFoodCircuCert())&&StringUtils.isBlank(supplier.getFoodProdCert())){
						return CommonStatusResult.fail("116009", null);
					}
					//证件号码格式验证
					if(!isBizCert(supplier.getBizCertNum())||!isCateringCert(supplier.getCateringCert())||!isFoodCircuCert(supplier.getFoodCircuCert())||!isFoodProdCert(supplier.getFoodProdCert())||!isFoodBusinessCert(supplier.getFoodBusinessCert())){
						return CommonStatusResult.fail("116010", null);
					}
					if(StringUtils.isNotBlank(supplier.getCode()) || StringUtils.isNotBlank(supplier.getName())){
						if(recLinkedComId!=null && recLinkedComId>0){
							//查询供应商，供应商不存在创建供应商
							IntCompany existed = internalCompanyService.getInternalCompany(recLinkedComId, IntCompany.COMPANY_TYPE_SUPPLIER, supplier.getName(), true, null, supplier.getCode());
							if(existed==null){
								boolean cateringCertFlag=internalCompanyService.isCertExist(null, "cateringCert", supplier.getCateringCert(), recLinkedComId, IntCompany.COMPANY_TYPE_SUPPLIER);
								boolean foodBusinessCertFlag=internalCompanyService.isCertExist(null, "foodBusinessCert", supplier.getFoodBusinessCert(), recLinkedComId, IntCompany.COMPANY_TYPE_SUPPLIER);
								boolean foodCircuCertFlag=internalCompanyService.isCertExist(null, "foodCircuCert", supplier.getFoodCircuCert(), recLinkedComId, IntCompany.COMPANY_TYPE_SUPPLIER);
								boolean foodProdCertFlag=internalCompanyService.isCertExist(null, "foodProdCert", supplier.getFoodProdCert(), recLinkedComId, IntCompany.COMPANY_TYPE_SUPPLIER);
								if(cateringCertFlag||foodBusinessCertFlag||foodCircuCertFlag||foodProdCertFlag){
									return CommonStatusResult.fail("116020", null);
								}
								supToCreate = supplier;
							}else{
								supplier=existed;
							}
						}
					}
				}
			}
		} catch (Exception e) {
			return CommonStatusResult.fail("116011", null);
		}
		try {
			JSONArray materialList=obj.getJSONArray("material");
			//产品不能为空
			if(materialList==null||materialList.size()<1){
				return CommonStatusResult.fail("116017", null);
			}
			//不能超过1000条上限
			if(materialList.size()>1000){
				return CommonStatusResult.fail("116019", null);
			}
			for(int i =0;i<materialList.size();i++){
				JSONObject matObj=materialList.getJSONObject(i);
				
				//查询采购品或产出品是否存在，不存在创建
				if(recLinkedComId!=null&&recLinkedComId>0){
					InputMaterial inputMat=DTOPlatformMaterialInfo.createInputMaterialByJson(matObj, recLinkedComId);
					//产品必填项验证
					if(StringUtils.isBlank(inputMat.getName())||StringUtils.isBlank(inputMat.getSpec())||inputMat.getTypeGeneral()<0){
						return CommonStatusResult.fail("116016", i);
					}
					//保质期为正数
					if(inputMat.getGuaranteeValue()!=null&&inputMat.getGuaranteeValue()<0){
						return CommonStatusResult.fail("116018", i);
					}
					InputMaterial inputExisted=inputMaterialService.getInputMaterial(recLinkedComId, inputMat.getName(), inputMat.getSpec(), inputMat.getManufacture(), true, null);
					if(inputExisted==null){
						inputMatListToCreate.add(inputMat);
					}
				}
			}
		} catch (Exception e) {
			return CommonStatusResult.fail("116016", null);
		}
		try {
			JSONArray batchList=obj.getJSONArray("batchDetail");
			//台账信息不能为空
			if(batchList==null||batchList.size()<1){
				return CommonStatusResult.fail("116022", null);
			}
			//不能超过1000条上限
			if(batchList.size()>1000){
				return CommonStatusResult.fail("116023", null);
			}
			for(int i=0;i<batchList.size();i++){
				JSONObject batchObj=batchList.getJSONObject(i);
				//收方系统内存在，创建进货台账
				if(recLinkedComId!=null && recLinkedComId>0){
					InputBatchDetail ibd=DTOPlatformBatchInfo.createInputBatchByJson(batchObj, recLinkedComId, supplier, appID);
					if(ibd.getInputDate()==null||StringUtils.isBlank(ibd.getInputMatName())||StringUtils.isBlank(ibd.getSpec())||ibd.getQuantity()==null||ibd.getQuantity().compareTo(BigDecimal.ZERO)<=0||(ibd.getProductionDate()==null&&StringUtils.isBlank(ibd.getProductionBatch()))||(ibd.getProductionDate()!=null&&ibd.getProductionDate().after(ibd.getInputDate()))){
						return CommonStatusResult.fail("116024", i);
					}
					ibdListToCreate.add(ibd);
				}
			}
			platformService.createBatchByPlatformData(platformData, supToCreate, null, inputMatListToCreate, null, ibdListToCreate, null, true);
		} catch (Exception e) {
			return CommonStatusResult.fail("116024", null);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}
	/**
	 * ERP 配送台账
	 * @param appID
	 * @param companyID
	 * @param key
	 * @param content
	 * @return
	 */
	@RequestMapping(value = "/erpOutputBatchDetail", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult erpOutputBatchDetail(@RequestParam int appID,@RequestParam String companyID,@RequestParam String key,@RequestParam String content){
		//授权验证
		PlatformCompany platformCompany = platformService.getPlatformCompany(appID, companyID, key, Platform.PLATFORM_TYPE_ERP);
		if(platformCompany==null){
			return CommonStatusResult.fail("116002", null);
		}
		JSONObject obj=new JSONObject();
		Integer supLinkedComId=platformCompany.getCompanyId();//系统内供方企业ID
		IntCompany receiver = new IntCompany();
		//待新增事务对象
		IntCompany recToCreate = null;
		List<OutputMaterial> outputMatListToCreate = new ArrayList<OutputMaterial>();
		List<OutputBatchDetail> obdListToCreate = new ArrayList<OutputBatchDetail>();
		PlatformData platformData = new PlatformData();
		platformData.setPlatformId(platformCompany.getPlatformId());
		platformData.setData(content);
		platformData.setType(PlatformData.ERP_CREATE_OUTPUT_BATCH);
		platformData.setCreateDate(new Date());
		platformData.setSupplierCompanyId(supLinkedComId);
		try {
			obj = JSONObject.fromObject(content);
		} catch (Exception e) {
			//json转换错误
			return CommonStatusResult.fail("116000", null);
		}
		try {
			JSONObject receiverInfo=obj.getJSONObject("receiver");
			if(receiverInfo.isEmpty()){
				return CommonStatusResult.fail("116012", null);
			}else{
				receiver=DTOPlatformReceiverInfo.createEntityByJson(receiverInfo, supLinkedComId);
				//验证必填项
				if(StringUtils.isBlank(receiver.getName())||StringUtils.isBlank(receiver.getContactAddress())){
					return CommonStatusResult.fail("116012", null);
				}
				//证件号码至少有一个
				/*if(StringUtils.isBlank(receiver.getBizCertNum())&&StringUtils.isBlank(receiver.getCateringCert())&&StringUtils.isBlank(receiver.getFoodBusinessCert())&&StringUtils.isBlank(receiver.getFoodCircuCert())&&StringUtils.isBlank(receiver.getFoodProdCert())){
					return CommonStatusResult.fail("116013", null);
				}*/
				//证件号码格式验证
				if(!isBizCert(receiver.getBizCertNum())||!isCateringCert(receiver.getCateringCert())||!isFoodCircuCert(receiver.getFoodCircuCert())||!isFoodProdCert(receiver.getFoodProdCert())||!isFoodBusinessCert(receiver.getFoodBusinessCert())){
					return CommonStatusResult.fail("116014", null);
				}
				if(StringUtils.isNotBlank(receiver.getCode()) || StringUtils.isNotBlank(receiver.getName())){
					//查询收货商，收货商不存在创建收货商
					IntCompany existed = internalCompanyService.getInternalCompany(supLinkedComId, IntCompany.COMPANY_TYPE_RECEIVER, receiver.getName(), true, null, receiver.getCode());
					if(existed==null){
						boolean cateringCertFlag=internalCompanyService.isCertExist(null, "cateringCert", receiver.getCateringCert(), supLinkedComId, IntCompany.COMPANY_TYPE_RECEIVER);
						boolean foodBusinessCertFlag=internalCompanyService.isCertExist(null, "foodBusinessCert", receiver.getFoodBusinessCert(), supLinkedComId, IntCompany.COMPANY_TYPE_RECEIVER);
						boolean foodCircuCertFlag=internalCompanyService.isCertExist(null, "foodCircuCert", receiver.getFoodCircuCert(), supLinkedComId, IntCompany.COMPANY_TYPE_RECEIVER);
						boolean foodProdCertFlag=internalCompanyService.isCertExist(null, "foodProdCert", receiver.getFoodProdCert(), supLinkedComId, IntCompany.COMPANY_TYPE_RECEIVER);
						if(cateringCertFlag||foodBusinessCertFlag||foodCircuCertFlag||foodProdCertFlag){
							return CommonStatusResult.fail("116021", null);
						}
						recToCreate = receiver;
					}else{
						receiver=existed;
					}
				}
			}
		} catch (Exception e) {
			return CommonStatusResult.fail("116015", null);
		}
		try {
			JSONArray materialList=obj.getJSONArray("material");
			//产品不能为空
			if(materialList==null||materialList.size()<1){
				return CommonStatusResult.fail("116017", null);
			}
			//不能超过1000条上限
			if(materialList.size()>1000){
				return CommonStatusResult.fail("116019", null);
			}
			for(int i =0;i<materialList.size();i++){
				JSONObject matObj=materialList.getJSONObject(i);
				
				//查询采购品或产出品是否存在，不存在创建
				OutputMaterial outputMat=DTOPlatformMaterialInfo.createOutputMaterialByJson(matObj, supLinkedComId);
				//产品必填项验证
				if(StringUtils.isBlank(outputMat.getName())||StringUtils.isBlank(outputMat.getSpec())||outputMat.getTypeGeneral()<0){
					return CommonStatusResult.fail("116016", i);
				}
				//保质期为正数
				if(outputMat.getGuaranteeValue()!=null&&outputMat.getGuaranteeValue()<0){
					return CommonStatusResult.fail("116018", i);
				}
				OutputMaterial outputExisted=outputMaterialService.getOutputMaterial(supLinkedComId, outputMat.getName(), outputMat.getSpec(), outputMat.getManufacture(), true, null);
				if(outputExisted==null){
					outputMatListToCreate.add(outputMat);
				}
			}
		} catch (Exception e) {
			return CommonStatusResult.fail("116016", null);
		}
		try {
			JSONArray batchList=obj.getJSONArray("batchDetail");
			//台账信息不能为空
			if(batchList==null||batchList.size()<1){
				return CommonStatusResult.fail("116022", null);
			}
			//不能超过1000条上限
			if(batchList.size()>1000){
				return CommonStatusResult.fail("116023", null);
			}
			for(int i=0;i<batchList.size();i++){
				JSONObject batchObj=batchList.getJSONObject(i);
				//供方系统内存在，创建配送台账
				if(supLinkedComId!=null && supLinkedComId>0){
					OutputBatchDetail obd=DTOPlatformBatchInfo.createOutputBatchByJson(batchObj, supLinkedComId, receiver, appID);
					if(obd.getOutputDate()==null||StringUtils.isBlank(obd.getOutputMatName())||StringUtils.isBlank(obd.getSpec())||obd.getQuantity()==null||obd.getQuantity().compareTo(BigDecimal.ZERO)<=0||(obd.getProductionDate()==null&&StringUtils.isBlank(obd.getProductionBatch()))||(obd.getProductionDate()!=null&&obd.getProductionDate().after(obd.getOutputDate()))){
						return CommonStatusResult.fail("116024", i);
					}
					obdListToCreate.add(obd);
				}
			}
			platformService.createBatchByPlatformData(platformData, null, recToCreate, null, outputMatListToCreate, null, obdListToCreate, true);
		} catch (Exception e) {
			return CommonStatusResult.fail("116024", null);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}
	public boolean isBizCert(String value){
		if(StringUtils.isNotBlank(value)){
			Pattern p=Pattern.compile("^([0-9A-Za-z]{15}$|[0-9A-Za-z]{18}$)");
			Matcher m = p.matcher(value);
			return m.matches();
		}
		return true;
	}
	public boolean isCateringCert(String value){
		if(StringUtils.isNotBlank(value)){
			Pattern p=Pattern.compile("^(西藏|藏|新疆|疆|桂|宁夏|宁|内蒙古|蒙|冀|晋|辽|吉|黑|苏|浙|皖|闽|赣|鲁|豫|鄂|湘|粤|琼|川|蜀|黔|贵|滇|云|陕|秦|甘|陇|青|台|港|澳|京|沪|津|渝)(餐证字)[0-9A-Za-z]{16}$");
			Matcher m = p.matcher(value);
			return m.matches();
		}
		return true;
	}
	public boolean isFoodCircuCert(String value){
		if(StringUtils.isNotBlank(value)){
			Pattern p=Pattern.compile("^(SP|sp)[0-9A-Za-z]{16}$");
			Matcher m = p.matcher(value);
			return m.matches();
		}
		return true;
	}
	public boolean isFoodProdCert(String value){
		if(StringUtils.isNotBlank(value)){
			Pattern p=Pattern.compile("^((QS|qs)[0-9A-Za-z]{12}$|(SC|sc)[0-9A-Za-z]{14}$)");
			Matcher m = p.matcher(value);
			return m.matches();
		}
		return true;
	}
	public boolean isFoodBusinessCert(String value){
		if(StringUtils.isNotBlank(value)){
			Pattern p=Pattern.compile("^(JY|jy)[0-9A-Za-z]{14}$");
			Matcher m = p.matcher(value);
			return m.matches();
		}
		return true;
	}
	public boolean isMobilephone(String value){
		if(StringUtils.isNotBlank(value)){
			Pattern p=Pattern.compile("^(13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9])\\d{8}$");
			Matcher m = p.matcher(value);
			return m.matches();
		}
		return true;
	}
	public boolean isID(String value){
		if(StringUtils.isNotBlank(value)){
			Pattern p=Pattern.compile("^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$");
			Matcher m = p.matcher(value);
			return m.matches();
		}
		return true;
	}
	
	@RequestMapping(value = "/uploadImage", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult companyImage(@RequestParam int appID,@RequestParam String companyID,
			@RequestParam String key,@RequestParam String content,
			@RequestParam String image,HttpServletRequest request){

		//授权验证
		PlatformCompany platformCompany = platformService.getPlatformCompany(appID, companyID, key, null);
		if(platformCompany==null){
			return CommonStatusResult.fail("116002", null);//授权失败
		}
		JSONObject obj=new JSONObject();
		Integer companyId=platformCompany.getCompanyId();
		Restaurant restaurant = restaurantService.getRestaurantById(companyId);
		if(StringUtils.isBlank(image)){
			return CommonStatusResult.fail("117012", null);
		}
		byte[] bytes = Base64.decode(image);
		if(bytes.length>1024*1024*1){
			return CommonStatusResult.fail("117013", null);
		}
		try {
			obj = JSONObject.fromObject(content);
			String type=obj.getString("type");
			String number = obj.getString("number");
			String expDate = obj.getString("expDate");
			Date expireDate = null;
			//证件类型不为空
			if(StringUtils.isEmpty(type)){
				return CommonStatusResult.fail("117003", null);//证件类型为空
			}
			if(!type.equals("COM_GSYYZZ")&&!type.equals("COM_CYFWXKZ")&&!type.equals("COM_SPLTXKZ")&&!type.equals("COM_SPSCXKZ")&&!type.equals("COM_SPJYXKZ")){
				return CommonStatusResult.fail("117010", null);
			}
			//证件号码不为空
			if(StringUtils.isEmpty(number)){
				return CommonStatusResult.fail("117004", null);//证件号码为空
			}
			//证件日期不为空
			if(StringUtils.isEmpty(expDate)){
				return CommonStatusResult.fail("117005", null);//证件日期为空
			}else{
				expireDate = TimeOrDateUtils.parseDate(expDate);
				if(expireDate==null){
					return CommonStatusResult.fail("117007", null);
				}
			}
			//证件号码格式验证
			if((type.equals("COM_GSYYZZ")&&!isBizCert(number))||(type.equals("COM_CYFWXKZ")&&!isCateringCert(number))||(type.equals("COM_SPLTXKZ")&&!isFoodCircuCert(number))||(type.equals("COM_SPSCXKZ")&&!isFoodProdCert(number))||(type.equals("COM_SPJYXKZ")&&!isFoodBusinessCert(number))){
				return CommonStatusResult.fail("117006", null);//证件格式错误
			}
			String certType=null;
			switch (type) {
			case "COM_GSYYZZ":
				restaurant.setBizCertNumber(number);
				restaurant.setBizCertExpDate(expireDate);
				break;
			case "COM_CYFWXKZ":
				restaurant.setCateringCert(number);
				restaurant.setCateringCertExpDate(expireDate);
				certType="cateringCert";
				break;
			case "COM_SPLTXKZ":
				restaurant.setFoodCircuCert(number);
				restaurant.setFoodCircuCertExpDate(expireDate);
				certType="foodCircuCert";
				break;
			case "COM_SPSCXKZ":
				restaurant.setFoodProdCert(number);
				restaurant.setFoodProdCertExpDate(expireDate);
				certType="foodProdCert";
				break;
			case "COM_SPJYXKZ":
				restaurant.setFoodBusinessCert(number);
				restaurant.setFoodBusinessCertExpDate(expireDate);
				certType="foodBusinessCert";
				break;
			}
			if(restaurantService.isCertExist(certType,number,companyId)){
				return CommonStatusResult.fail("117011", null);//证件号码重复
			}
		}catch (Exception e) {
			return CommonStatusResult.fail("116000", null);
		}	
		
		// 添加新图片
		/*QueryResult<Attachment> result=attachmentService.queryAttFile(uploadTypeToAttachTypeMap.get(restaurant.getType()), supLinkedComId, null, null);*/
		QueryResult<Attachment> result=attachmentService.queryAttFile(uploadTypeToAttachTypeMap.get(obj.getString("type")), companyId, null, null);
		if(result==null||result.getResultList()==null||result.getResultList().size()==0){
			try {
				LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
				Attachment att = attachmentService.thirdUploadAttFile(companyId, uploadTypeToAttachTypeMap.get(obj.getString("type")), companyId, null, "", new Date(),bytes);
			} catch (Exception e) {
				return CommonStatusResult.fail("117008", null);
			}
			restaurantService.updateRestaurant(restaurant);
		}else{				
			return CommonStatusResult.fail("117009", null);	//图片已经存在	
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}
	
	/**
	 * ERP 留样台账
	 * @param appID
	 * @param companyID
	 * @param key
	 * @param content
	 * @return
	 */
	@RequestMapping(value = "/erpRetentionSamples", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult erpRetentionSamples(@RequestParam int appID,@RequestParam String companyID,@RequestParam String key,@RequestParam String content){
		//授权验证
		PlatformCompany platformCompany = platformService.getPlatformCompany(appID, companyID, key, Platform.PLATFORM_TYPE_ERP);
		if(platformCompany==null){
			return CommonStatusResult.fail("116002", null);
		}
		JSONObject obj=new JSONObject();
		List<RetentionSamples> sampleListToCreate = new ArrayList<RetentionSamples>();
		PlatformData platformData = new PlatformData();
		platformData.setPlatformId(platformCompany.getPlatformId());
		platformData.setData(content);
		platformData.setType(PlatformData.ERP_CREATE_RETENTION_SAMPLE);
		platformData.setCreateDate(new Date());
		try {
			obj = JSONObject.fromObject(content);
		} catch (Exception e) {
			//json转换错误
			return CommonStatusResult.fail("116000", null);
		}
		try {
			JSONArray sampleList = obj.getJSONArray("samples");
			//留样不能为空
			if(sampleList==null||sampleList.size()<1){
				return CommonStatusResult.fail("116025", null);
			}
			//不能超过1000条上限
			if(sampleList.size()>1000){
				return CommonStatusResult.fail("116027", null);
			}
			for(int i =0;i<sampleList.size();i++){
				JSONObject sampleObj=sampleList.getJSONObject(i);
				RetentionSamples rs = DTOPlatformSampleInfo.createRetentionSamplesByJSON(sampleObj, restaurantService.getRestaurantById(platformCompany.getCompanyId()));
				//留样必填项验证
				if(rs.getSampleDate()==null||rs.getDiningCount()==null||rs.getDiningCount()<0){
					return CommonStatusResult.fail("116026", i);
				}
				sampleListToCreate.add(rs);
			}
			platformService.createSamplesByPlatformData(platformData, sampleListToCreate);
		} catch (Exception e) {
			return CommonStatusResult.fail("116026", null);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}
	
	/**
	 * ERP 从业人员
	 * @param appID
	 * @param companyID
	 * @param key
	 * @param content
	 * @return
	 */
	@RequestMapping(value = "/erpEmployees", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult erpEmployees(@RequestParam int appID,@RequestParam String companyID,@RequestParam String key,@RequestParam String content){
		//授权验证
		PlatformCompany platformCompany = platformService.getPlatformCompany(appID, companyID, key, Platform.PLATFORM_TYPE_ERP);
		if(platformCompany==null){
			return CommonStatusResult.fail("116002", null);
		}
		JSONObject obj=new JSONObject();
		List<ComEmployee> employeeListToCreate = new ArrayList<ComEmployee>();
		PlatformData platformData = new PlatformData();
		platformData.setPlatformId(platformCompany.getPlatformId());
		platformData.setData(content);
		platformData.setType(PlatformData.ERP_CREATE_COM_EMPLOYEE);
		platformData.setCreateDate(new Date());
		Restaurant restaurant = restaurantService.getRestaurantById(platformCompany.getCompanyId());
		try {
			obj = JSONObject.fromObject(content);
		} catch (Exception e) {
			//json转换错误
			return CommonStatusResult.fail("116000", null);
		}
		try {
			JSONArray empList = obj.getJSONArray("employees");
			//从业人员不能为空
			if(empList==null||empList.size()<1){
				return CommonStatusResult.fail("116028", null);
			}
			//不能超过1000条上限
			if(empList.size()>1000){
				return CommonStatusResult.fail("116030", null);
			}
			for(int i =0;i<empList.size();i++){
				JSONObject empObj=empList.getJSONObject(i);
				ComEmployee ce = DTOPlatformComEmployeeInfo.createComEmployeeByJSON(empObj,restaurant,restaurantEmployeeService);
				//必填信息验证不能为空
				if(StringUtils.isBlank(ce.getPersonName())||ce.getSex()==null||ce.getSex()<0||ce.getIdType()==null||ce.getIdType()<0||StringUtils.isBlank(ce.getIdNumber())){
					return CommonStatusResult.fail("116029", null);
				}
				//验证手机号码格式
				if(!isMobilephone(ce.getMobilePhone())){
					return CommonStatusResult.fail("116031", null);
				}
				//验证身份证号码格式
				if(ce.getIdType()==11005&&!isID(ce.getIdNumber())){
					return CommonStatusResult.fail("116032", null);
				}
				employeeListToCreate.add(ce);
			}
			platformService.createEmployeesByPlatformData(platformData,employeeListToCreate);
		} catch (Exception e) {
			return CommonStatusResult.fail("116029", null);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}
}
