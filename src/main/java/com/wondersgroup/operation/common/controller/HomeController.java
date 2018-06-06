
package com.wondersgroup.operation.common.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.rabbitmq.client.impl.AMQImpl.Access.Request;
import com.wondersgroup.data.jpa.entity.ComEmpLicence;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.data.jpa.entity.ComPoint;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.data.jpa.entity.IntCompany;
import com.wondersgroup.data.jpa.entity.Platform;
import com.wondersgroup.data.jpa.entity.PlatformDevice;
import com.wondersgroup.data.jpa.entity.RegStatistics;
import com.wondersgroup.data.jpa.entity.Restaurant;
import com.wondersgroup.framework.common.AttachmentService;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.operation.util.annotation.LoginRequired;
import com.wondersgroup.service.company.CompanyService;
import com.wondersgroup.service.empuser.RestaurantEmployeeService;
import com.wondersgroup.service.grade.GradeService;
import com.wondersgroup.service.input.InputBatchService;
import com.wondersgroup.service.monitorFace.MonitorFaceService;
import com.wondersgroup.service.monitorFace.MonitorMaintainService;
import com.wondersgroup.service.operation.OperationRestaurantService;
import com.wondersgroup.service.output.OutputBatchService;
import com.wondersgroup.service.platform.PlatformService;
import com.wondersgroup.service.point.ComPointService;
import com.wondersgroup.service.statistics.RegStatisticsService;
import com.wondersgroup.service.statistics.StatisticsService;
import com.wondersgroup.service.sup.SupPublishContentService;
import com.wondersgroup.service.warn.WarnService;
import com.wondersgroup.util.TimeOrDateUtils;

@Controller
public class HomeController extends AbstractBaseController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private CompanyService companyService;
	@Autowired
	private AttachmentService attachmentService;

	@Autowired
	private StatisticsService statisticsService;
    @Autowired
    private MonitorFaceService monitorFaceService;
	@Autowired
    private MonitorMaintainService monitorService;
	@Autowired
	private PlatformService platformService;
	@Autowired
	private MonitorMaintainService monitorMaintainService;
	@Autowired
	private SupPublishContentService contentService;

	@Autowired
	private OperationRestaurantService operationRestaurantService;
	@Autowired
	private RestaurantEmployeeService restaurantEmployeeService;

	@Autowired
	private WarnService WarnService;

	@Autowired
	private ComPointService comPointService;
	
	@Autowired
	private GradeService gradeService;
	
	@Autowired
	private InputBatchService inputBatchService;
	
	@Autowired
	private OutputBatchService outputBatchService;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Locale locale, Model model) {

		return "login";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String login(HttpServletRequest request, HttpServletResponse response) {
		request.getSession().invalidate();

		Cookie cookie = new Cookie("JSESSIONID", "");
		response.addCookie(cookie);

		return "redirect:/login.jsp";
	}

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {

		return "home";
	}

	@RequestMapping(value = "/default", method = RequestMethod.GET)
	@LoginRequired
	public String defaultPage(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		return "home";
	}

	@RequestMapping(value = "/forgetPwd", method = RequestMethod.GET)
	public String forgetPwd(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		System.out.println("in forget pwd");
		return "forgetPwd";
	}

	@RequestMapping(value = "/resetPwd", method = RequestMethod.GET)
	public String resetetPwd(Locale locale, Model model, @RequestParam(value = "username", required = true) String username) {
		logger.info("Welcome home! The client locale is {}.", locale);
		model.addAttribute("username", username);
		return "resetPwd";
	}
	
	@RequestMapping(value = "/accredit/display", method = RequestMethod.GET)
	public String display(Locale locale, Model model, @RequestParam(value = "code", required = true) String code) {
		int i= code.length();
		String ii=code.substring(24,26);
		if((code.length()!=40&&code.length()!=42)||(code.length()==40&&!code.substring(24,26).equals("JY"))||(code.length()==42&&!code.substring(24,26).equals("HC"))){
			return "accredit/parameterError";
			//return "accredit/mismatching";
		}else{
			int appID= Integer.parseInt(code.substring(0,4));
			String key= code.substring(4,12);
			String webdeviceId= code.substring(12,24);
			String deviceId=webdeviceId.substring(0,2)+"-"+webdeviceId.substring(2,4)+"-"+webdeviceId.substring(4,6)+"-"+webdeviceId.substring(6,8)+"-"+webdeviceId.substring(8,10)+"-"+webdeviceId.substring(10,12);
			String zzTypeS= code.substring(24,26);
			int zzType=-1;
			String zzNumber="";
			if(zzTypeS.equals("HC")){
				zzType=1;
				zzNumber="沪餐证字"+code.substring(26,42);
			}else if(zzTypeS.equals("JY")){
				zzType=0;
				zzNumber="JY"+code.substring(26,40);
			}
	    	PlatformDevice device =new PlatformDevice();
	    	//入参验证
			if(appID<1){
				return "accredit/parameterError";
			}
			Platform platform = platformService.getPlatform(appID,key,Platform.PLATFORM_TYPE_MGR);
			QueryResult<PlatformDevice> deviceResult=monitorFaceService.queryDevice(deviceId, zzNumber);
			if (platform == null) {
				return "accredit/parameterError";
			}else if(deviceResult==null||deviceResult.getResultList()==null||deviceResult.getResultList().size()<=0){
				return "accredit/parameterError";
			}else{
				QueryResult comInfo=new QueryResult();
		    	if(!StringUtils.isEmpty(zzNumber)&&zzType>=0){
		    		comInfo=monitorFaceService.queryMonitorFaceComInfo(zzType, zzNumber);
		    	}
		    	if(comInfo==null||comInfo.getResultList()==null||comInfo.getResultList().size()<1){
		    		return "accredit/mismatching";
		    	}else{
		    		return "accredit/display";
			}
			}
		
		}
	}

	@RequestMapping(value = "/loadmenu", method = RequestMethod.GET)
	@ResponseBody
	@ResponseStatus(HttpStatus.OK)
	public ResponseEntity<String> getLeftMenu() {
		StringBuilder response = null;
		try {
			InputStream inputStream = this.getClass().getClassLoader().getResourceAsStream("leftmenu.json");
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream, Charset.forName("UTF-8")));
			response = new StringBuilder();
			String inputLine;
			while ((inputLine = bufferedReader.readLine()) != null) {
				response.append(inputLine);
			}
			inputStream.close();
			bufferedReader.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		HttpHeaders header = new HttpHeaders();
		MediaType media = new MediaType("application", "json", Charset.forName("UTF-8"));
		header.setContentType(media);
		String result = response != null ? response.toString() : "";
		return new ResponseEntity<String>(result.replaceAll("\t", ""), header, HttpStatus.OK);
	}

	@RequestMapping(value = "/findView/{pathInfo:.+}", method = RequestMethod.GET)
	public String findView(Locale locale, Model model, @PathVariable String pathInfo, @RequestParam MultiValueMap<String, String> args) {
		String path = "";
		if (args != null) {
			Iterator<String> it = args.keySet().iterator();
			while (it.hasNext()) {
				String key = (String) it.next();
				List<String> valueList = args.get(key);
				if (valueList != null) {
					for (String value : valueList) {
						model.addAttribute(key, value);
					}
				}
			}
		}
		if (!StringUtils.isEmpty(pathInfo)) {
			path = pathInfo.replaceAll("\\.", "/");
		}
		logger.info(path);
		return path;
	}

	@RequestMapping(value = "/delAttachments", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult delAttachments(@RequestBody(required = true) List<Integer> restIdList) throws Exception {
		attachmentService.deleteAttFiles(restIdList);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}

	@RequestMapping(value = "/getStatistics", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult getStatistics() throws Exception {
		Integer companyId = getLoginCompanyId();
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, getresultMap(companyId));

	}

	@Cacheable(value = "Statistics", key = "'WebCompany'+'_'+'Home'+'_'+'Statistics'+#companyId")
	public Map<String, Object> getresultMap(Integer companyId) {
		Map<String, Object> resultMap = new HashMap<>();

		int countInputMaterial = statisticsService.countInputMaterials(companyId);
		resultMap.put("countInputMaterial", countInputMaterial);
		System.out.println("222");

		int countOutputMaterial = statisticsService.countOutputMaterials(companyId);
		resultMap.put("countOutputMaterial", countOutputMaterial);

		int countSuppliers = statisticsService.countSuppliers(companyId);
		resultMap.put("countSuppliers", countSuppliers);

		int countReceivers = statisticsService.countReceivers(companyId);
		resultMap.put("countReceivers", countReceivers);

		return resultMap;
	}

	/**
	 * 获取企业首页通知公告和积分
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getHomeIntegralController")
	@ResponseBody
	public CommonStatusResult getHomeIntegralController() {
		int companyId = getLoginCompanyId();
		Map<String, Object> map = new HashMap<>();
		Company loginCompany = getLoginCompany();
		int regionId = loginCompany.getRegionCounty();
		QueryResult notice = contentService.queryPublishContentListByRegion(regionId,companyId,null,null, null, null, 1, 5);
		if (notice != null && notice.getResultList() != null && notice.getResultList().size() > 0) {
			map.put("notice", notice.getResultList());
		}
//		/**
//		 * 查询监督检查评级 2016.3.15 by linzhengkang
//		 */
//		GradeOfficial gradeOfficial=gradeService.getCompanyGrade(companyId);
//		if(gradeOfficial != null){
//			String grade=gradeOfficial.getGrade();
//			String evalDate=gradeOfficial.getEvalDate();
//			map.put("grade", grade);
//			map.put("evalDate", evalDate);
//		}else{
//			map.put("grade", null);
//			map.put("evalDate", null);
//		}
		Map gradeMap = gradeService.getCompanyBaseGrade(companyId);
		if(gradeMap != null){
			String grade=null;
			if(gradeMap.get("grade")!=null){
				grade=gradeMap.get("grade").toString();
			}
			String evalDate=null;
			if(gradeMap.get("evalDate")!=null){
				evalDate=gradeMap.get("evalDate").toString().substring(0, 10);
			}
			map.put("grade", grade);
			map.put("evalDate", evalDate);
		}else{
			map.put("grade", null);
			map.put("evalDate", null);
		}
		// 获取企业积分
		ComPoint comPoint = comPointService.getComPointById(companyId);
		if (comPoint != null) {
			map.put("jf", comPoint.getTotalPoint());
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, map);
	}
	/**
	 * 查询企业首页 证照预警 人员预警 台帐预警
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getHomeExceptionController")
	@ResponseBody
	public CommonStatusResult getHomeController(HttpServletRequest request) {
		Date statusDate = new Date();// 当前时间
		int companyId = getLoginCompanyId();
		Map<String, Object> map = new HashMap<>();
		HttpSession session = request.getSession(true);
		if (session.getAttribute("homeDate") != null && session.getAttribute("homeMap") != null) {
			Date sessionDate = (Date) session.getAttribute("homeDate");
			map = (Map) session.getAttribute("homeMap");
			if (statusDate.getTime() - sessionDate.getTime() >= 10 * 60 * 1000) {
				map = getHomeMap(companyId);
				session.setAttribute("homeMap", map);
				session.setAttribute("homeDate", statusDate);
			}
		} else {
			map = getHomeMap(companyId);
			session.setAttribute("homeMap", map);
			session.setAttribute("homeDate", statusDate);
		}

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, map);
	}

	public Map getHomeMap(int companyId) {
		Map<String, Object> map = new HashMap<>();
		Date statusDate = new Date();// 当前时间
		String newDate = TimeOrDateUtils.formateDate(statusDate, TimeOrDateUtils.FULL_YMD);
		statusDate = TimeOrDateUtils.parseDate(newDate);
		Date date = TimeOrDateUtils.getOneMonthAfterCurrentTime();// 一个月以后的时间
		int gs = 0;// 工商营业执照 ,已经过期
		int gsk = 0;// 工商营业执照 ,快过期
		int cy = 0;// 餐饮服务许可证 ,已经过期
		int cyk = 0;
		int lt = 0;// 食品流通许可证 ,已经过期
		int ltk = 0;
		int sc = 0;// 食品生产许可证 ,已经过期
		int sck = 0;
		int jy = 0;// 食品经营许可证 ,已经过期
		int jyk = 0;

		int jk = 0;// 健康证, 已经过期
		int jkk = 0;
		int px = 0;// 培训证, 已经过期
		int pxk = 0;

		// 获取企业所有台帐预警
		List<Map> list = WarnService.queryAccountWarning(companyId);
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				String day = "0";
				Date accoutDateS = null;
				if (list.get(i).get("date") != null) {
					String dateString = list.get(i).get("date").toString();
					accoutDateS = TimeOrDateUtils.parseDate(dateString);
				}

				if (accoutDateS != null) {
					long searhDate = statusDate.getTime() - accoutDateS.getTime() - 24 * 60 * 60 * 1000;
					if (searhDate > 0) {
						day = String.valueOf(searhDate / 86400000);
					}
				}else{
					day="-1";
				}
				// 0-4 分别为进货台帐, 配送台帐,废弃油脂台帐, 餐厨垃圾台帐 ,留样台帐
				if (i == 0) {
					//2016-12-09 台账预警若30天内无数据则查HBASE表
					if(day=="-1"){
						QueryResult queryResult = inputBatchService.searchHBaseInputBatch(companyId, null, null, null, null, null, 1, 1);
						if(queryResult!=null&&queryResult.getResultList()!=null&&queryResult.getResultList().size()>0){
							Map newest = (Map) queryResult.getResultList().get(0);
							if(newest!=null&&newest.get("input_date")!=null){
								Date newestDate = TimeOrDateUtils.parseDate(newest.get("input_date").toString());
								long diff = statusDate.getTime() - newestDate.getTime() - 24 * 60 * 60 * 1000;
								if(diff > 0){
									day = String.valueOf(diff / 86400000);
								}
							}
						}
					}
					map.put("jhtz", day);
				}
				if (i == 1) {
					//2016-12-09 台账预警若30天内无数据则查HBASE表
					if(day=="-1"){
						QueryResult queryResult = outputBatchService.searchHBaseOutputBatch(companyId, null, null, null, null, null, 1, 1);
						if(queryResult!=null&&queryResult.getResultList()!=null&&queryResult.getResultList().size()>0){
							Map newest = (Map) queryResult.getResultList().get(0);
							if(newest!=null&&newest.get("output_date")!=null){
								Date newestDate = TimeOrDateUtils.parseDate(newest.get("output_date").toString());
								long diff = statusDate.getTime() - newestDate.getTime() - 24 * 60 * 60 * 1000;
								if(diff > 0){
									day = String.valueOf(diff / 86400000);
								}
							}
						}
					}
					map.put("pstz", day);
				}
				if (i == 2) {
					map.put("lytz", day);
				}
				if (i == 3) {
					map.put("yztz", day);
				}
				if (i == 4) {
					map.put("ljtz", day);
				}
			}
		}
		// 获取企业 所有供应商证照预警 过期与快过期数量
		QueryResult licensesException = operationRestaurantService.queryIntCompany(null, "SUPPLIER", companyId, date, "", "", null, null, -1, -1);
		if (licensesException != null && licensesException.getResultList() != null && licensesException.getResultList().size() > 0) {
			List<IntCompany> newList = licensesException.getResultList();
			if (newList.size() > 0 && newList != null) {
				for (int i = 0; i < newList.size(); i++) {
					Date getBizStatus = newList.get(i).getBizCertExpDate();
					Date getCateringStatus = newList.get(i).getCateringCertExpDate();
					Date getFoodCircuCertStatus = newList.get(i).getFoodCircuCertExpDate();
					Date getFoodProdStatus = newList.get(i).getFoodProdCertExpDate();
					Date getFoodBusinessStatus = newList.get(i).getFoodBusinessCertExpDate();
					if(getBizStatus != null){
						if (getBizStatus.getTime() < statusDate.getTime()) {
							gs++;
						}else if (getBizStatus.getTime() >= statusDate.getTime()&&getBizStatus.getTime()<date.getTime()) {
							gsk++;
						}
					}
					if(getCateringStatus != null){
						if ( getCateringStatus.getTime() < statusDate.getTime()) {
							cy++;
						}else if (getCateringStatus.getTime() >= statusDate.getTime()&&getCateringStatus.getTime()<date.getTime()) {
							cyk++;
						}	
					}
					if(getFoodCircuCertStatus != null){
						if (getFoodCircuCertStatus.getTime() < statusDate.getTime()) {
							lt++;
						}else if (getFoodCircuCertStatus.getTime() >= statusDate.getTime()&&getFoodCircuCertStatus.getTime()<date.getTime()) {
							ltk++;
						}	
					}
					
					if(getFoodProdStatus != null ){
						if ( getFoodProdStatus.getTime() < statusDate.getTime()) {
							sc++;
						}else if (getFoodProdStatus.getTime() >= statusDate.getTime()&&getFoodProdStatus.getTime()<date.getTime()) {
							sck++;
						}
					}
					if(getFoodBusinessStatus != null ){
						if (getFoodBusinessStatus.getTime() < statusDate.getTime()) {
							jy++;
						}
						if (getFoodBusinessStatus.getTime() >= statusDate.getTime()&&getFoodBusinessStatus.getTime()<date.getTime()) {
							jyk++;
						}		
					}
				}
			}
		}
		// 获取本单位的证照预警信息
		Restaurant restaurant = WarnService.queryRestaurant(companyId);
		if (restaurant != null) {
			Date gsDate = restaurant.getBizCertExpDate();
			if (gsDate != null) {
				if (statusDate.getTime() < gsDate.getTime() && gsDate.getTime() < date.getTime()) {
					gsk++;
				} else if (gsDate.getTime() < statusDate.getTime()) {
					gs++;
				}
			}
			Date cyDate = restaurant.getCateringCertExpDate();
			if (cyDate != null) {
				if (statusDate.getTime() < cyDate.getTime() && cyDate.getTime() < date.getTime()) {
					cyk++;
				} else if (cyDate.getTime() < statusDate.getTime()) {
					cy++;
				}
			}
			Date ltDate = restaurant.getFoodCircuCertExpDate();
			if (ltDate != null) {
				if (statusDate.getTime() < ltDate.getTime() && ltDate.getTime() < date.getTime()) {
					ltk++;
				} else if (ltDate.getTime() < statusDate.getTime()) {
					lt++;
				}
			}
			Date scDate = restaurant.getFoodProdCertExpDate();
			if (scDate != null) {
				if (statusDate.getTime() < scDate.getTime() && scDate.getTime() < date.getTime()) {
					sck++;
				} else if (scDate.getTime() < statusDate.getTime()) {
					sc++;
				}
			}
		}
		Date jyDate = restaurant.getFoodBusinessCertExpDate();
		if (jyDate != null) {
			if (statusDate.getTime() < jyDate.getTime() && jyDate.getTime() < date.getTime()) {
				jyk++;
			} else if (jyDate.getTime() < statusDate.getTime()) {
				jy++;
			}
		}
		map.put("gs", gs);
		map.put("gsk", gsk);
		map.put("cy", cy);
		map.put("cyk", cyk);
		map.put("lt", lt);
		map.put("ltk", ltk);
		map.put("sc", sc);
		map.put("sck", sck);
		map.put("jy", jy);
		map.put("jyk", jyk);
		List<Integer> licenceTypes = new ArrayList<Integer>();
		licenceTypes.add(FoodConstant.COM_EMP_LICENCE_HEALTH_ID);
		licenceTypes.add(FoodConstant.COM_EMP_LICENCE_TRAINING_ID);
		// 获取健康证 培训证 预警
		QueryResult queryResult = WarnService.queryEmployeesWithLicenceTo(companyId, licenceTypes, date, -1, -1);
		if (queryResult != null && queryResult.getResultList() != null && queryResult.getResultList().size() > 0) {
			List<ComEmployee> newList = queryResult.getResultList();
			if (newList.size() > 0 && newList != null) {
				for (ComEmployee entity : newList) {
					if (entity.getComEmpLicenceList() != null && entity.getComEmpLicenceList().size() > 0) {
						for (ComEmpLicence come : entity.getComEmpLicenceList()) {
							if (come.getLicenceType() == FoodConstant.COM_EMP_LICENCE_HEALTH_ID && come.getDelFlag() != 0) {
								if (come.getExpireDate() != null) {
									if ((come.getExpireDate().getTime()) >= statusDate.getTime() && (come.getExpireDate().getTime()) < date.getTime()) {
										jkk++;
										break;
									} else if (come.getExpireDate().getTime() < statusDate.getTime()) {
										jk++;
										break;
									}
								}
							}
						}
						for (ComEmpLicence come : entity.getComEmpLicenceList()) {
							if (come.getLicenceType() == FoodConstant.COM_EMP_LICENCE_TRAINING_ID && come.getDelFlag() != 0) {
								if (come.getExpireDate() != null) {
									if ((come.getExpireDate().getTime()) >= statusDate.getTime() && (come.getExpireDate().getTime()) < date.getTime()) {
										pxk++;
										break;
									} else if (come.getExpireDate().getTime() < statusDate.getTime()) {
										px++;
										break;
									}
								}
							}
						}

					}
				}

			}
		}
		map.put("jk", jk);
		map.put("jkk", jkk);
		map.put("px", px);
		map.put("pxk", pxk);

		return map;
	}
}


