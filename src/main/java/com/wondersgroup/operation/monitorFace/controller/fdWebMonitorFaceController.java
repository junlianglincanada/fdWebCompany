package com.wondersgroup.operation.monitorFace.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wondersgroup.data.jpa.entity.Attachment;
import com.wondersgroup.data.jpa.entity.DisplayJobRole;
import com.wondersgroup.framework.dao.JdbcAbstractDao;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.monitorFace.model.DTOMonitorFaceComInfo;
import com.wondersgroup.operation.monitorFace.model.DTOMonitorFaceDetailInfo;
import com.wondersgroup.operation.monitorFace.model.DTOMonitorFaceEmpInfo;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.operation.util.file.UploadUtils;
import com.wondersgroup.service.input.InputBatchService;
import com.wondersgroup.service.monitorFace.MonitorFaceService;
import com.wondersgroup.service.monitorFace.MonitorMaintainService;
import com.wondersgroup.service.platform.PlatformService;
import com.wondersgroup.util.TimeOrDateUtils;

@Controller
@RequestMapping("/fdWebMonitorFace")
public class fdWebMonitorFaceController extends AbstractBaseController {
	private static final Logger logger = LoggerFactory
			.getLogger(MonitorFaceController.class);
	@Autowired
	private UploadUtils uploadUtils;
	@Autowired
	private MonitorFaceService monitorFaceService;
	@Autowired
	private MonitorMaintainService monitorService;
	@Autowired
	private PlatformService platformService;
	@Autowired
	private InputBatchService inputBatchService;
	@Autowired
	private MonitorMaintainService monitorMaintainService;
	private String LOCATION = JdbcAbstractDao.getLocation();
	public static final String UPLOAD_TYPE_EMP_DTZ = "EMP_DTZ"; // 从业人员 --大头照
	public static final String UPLOAD_TYPE_COM_SPLTXKZ = "COM_SPLTXKZ"; // 注册企业
																		// --
																		// 食品流通许可证
	public static final String UPLOAD_TYPE_COM_CYFWXKZ = "COM_CYFWXKZ"; // 注册企业
																		// --
																		// 餐饮服务许可证
	public static final String UPLOAD_TYPE_COM_SPJYXKZ = "COM_SPJYXKZ"; // 注册企业
																		// --
																		// 食品经营许可证

	public static final Map<String, String> uploadTypeToAttachTypeMap = new HashMap<String, String>() {
		private static final long serialVersionUID = 1948879947792327281L;
		{
			put(UPLOAD_TYPE_EMP_DTZ, FoodConstant.ATT_EMPLOYEE);
			put(UPLOAD_TYPE_COM_SPLTXKZ, FoodConstant.ATT_COM_SPLTXKZ);
			put(UPLOAD_TYPE_COM_CYFWXKZ, FoodConstant.ATT_COM_CYFWXKZ);
			put(UPLOAD_TYPE_COM_SPJYXKZ, FoodConstant.ATT_COM_SPJYXKZ);
		}
	};
	private static final List<String> singleImageTypes = new ArrayList<String>() {
		private static final long serialVersionUID = 6694506005823947192L;
		{
			add(UPLOAD_TYPE_EMP_DTZ);
			add(UPLOAD_TYPE_COM_SPLTXKZ);
			add(UPLOAD_TYPE_COM_CYFWXKZ);
			add(UPLOAD_TYPE_COM_SPJYXKZ);
		}
	};

	/**
	 * 公示屏公司及人员信息*非触摸屏
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/monitorFaceComInfo", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult monitorFaceComInfo() {
		Integer companyId = getLoginCompanyId();
		String[] imageTypes = { "COM_SPJYXKZ", "COM_CYFWXKZ", "COM_SPLTXKZ" };
		QueryResult comInfo = new QueryResult();
		comInfo=monitorFaceService.queryMonitorFaceComInfoById(companyId);
		LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
		QueryResult empInfo = new QueryResult();
		List<DTOMonitorFaceEmpInfo> dtoEmpInfo = new ArrayList<DTOMonitorFaceEmpInfo>();
		if (companyId > 0) {
			for (String imageType : imageTypes) {
				String attachType = uploadTypeToAttachTypeMap.get(imageType);
				if (StringUtils.isNotBlank(attachType)) {
					List<Attachment> resultList = uploadUtils.queryAttFile(
							attachType, companyId, null, null);
					resultMap.put(imageType, resultList);
				}
			}
			int displayEmp = monitorMaintainService
					.hasDisplayJobRole(companyId);
			if (displayEmp > 0) {
				empInfo = monitorFaceService
						.queryMonitorFaceDisplayJobRole(companyId);
				dtoEmpInfo = DTOMonitorFaceEmpInfo.displayList(empInfo);
			} else {
				empInfo = monitorFaceService.queryMonitorFaceEmpInfo(companyId);
				dtoEmpInfo = DTOMonitorFaceEmpInfo.toDtoList(empInfo);
				for (DTOMonitorFaceEmpInfo dto : dtoEmpInfo) {
					DisplayJobRole entity = DTOMonitorFaceEmpInfo.toEntity(dto,
							companyId);
					monitorService.createDisplayJobRole(entity);
				}
			}
		}
		for (DTOMonitorFaceEmpInfo emp : dtoEmpInfo) {
			String attachType = uploadTypeToAttachTypeMap
					.get(UPLOAD_TYPE_EMP_DTZ);
			if (StringUtils.isNotBlank(emp.getPersonId().toString())) {
				List<Attachment> resultList = uploadUtils.queryAttFile(
						attachType, emp.getPersonId().toString(), null, null);
				if (resultList != null && resultList.size() > 0) {
					emp.setImg(resultList.get(0));
				}
			}
		}
		DTOMonitorFaceComInfo dtoComInfo = DTOMonitorFaceComInfo.toDto(comInfo,
				resultMap, dtoEmpInfo);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS,
				dtoComInfo);
	}

	/**
	 * 公示屏台账信息*是否触摸屏都一样
	 * 
	 * @param request
	 * @return
	 * @throws java.text.ParseException
	 */
	@RequestMapping(value = "/monitorFaceDetailInfo", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult monitorFaceDetailInfo()
			throws java.text.ParseException {
		Integer companyId = getLoginCompanyId();
		@SuppressWarnings("rawtypes")
		QueryResult detailInfo = new QueryResult();
		List<DTOMonitorFaceDetailInfo> dtoDetailInfo = new ArrayList<DTOMonitorFaceDetailInfo>();
		List<DTOMonitorFaceDetailInfo> returnDtoDetailInfo= new ArrayList<DTOMonitorFaceDetailInfo>();
		QueryResult matNameList = monitorFaceService
				.queryMonitorFaceMatName(companyId);
		if (matNameList != null && matNameList.getResultList() != null
				&& matNameList.getResultList().size() > 0) {
			List<String> matName = new ArrayList<String>();
			List<Map> matNameMapList = matNameList.getResultList();
			StringBuilder hBaseResultString = new StringBuilder();
			boolean first = true;
			for (Map matNameMap : matNameMapList) {
				matName.add(matNameMap.get("INPUT_MAT_NAME").toString());
				if (first) {
					first = false;
				} else {
					hBaseResultString.append(",");
				}
				hBaseResultString.append(matNameMap.get("INPUT_MAT_NAME")
						.toString());
			}
			detailInfo = monitorFaceService.queryMonitorFaceDetailByMatName(
					companyId, matName);
			if (detailInfo != null && detailInfo.getResultList() != null
					&& detailInfo.getResultList().size() > 0
					&& detailInfo.getResultList().size() < matName.size()) {
				dtoDetailInfo = DTOMonitorFaceDetailInfo.toDtoList(detailInfo);

				QueryResult hBaseResult = inputBatchService
						.searchHBaseInputBatchHabaseByMatName(companyId,
								hBaseResultString.toString(), 1, 50);
				List<Map<String, Object>> hBaselist = hBaseResult.getResultList();
				List<Map<String, Object>> hBaselist1=new ArrayList<Map<String, Object>>();
				hBaselist1.addAll(hBaselist);
				int myI=0;
				for (int hbsei = 0; hbsei < hBaselist.size(); hbsei++) {
					Map<String, Object> hBaseMap = hBaselist.get(hbsei);
					List<Object[]> detailInfoList = detailInfo.getResultList();
					String hBaseMatName = hBaseMap.get("input_mat_name") == null ? null
							: hBaseMap.get("input_mat_name").toString();
					for (Object[] obj : detailInfoList) {
						String objMatName = obj[1] == null ? "" : obj[1]
								.toString();
						if (hBaseMatName.equals(objMatName)) {
							if(hbsei-myI<hBaselist1.size()){
								hBaselist1.remove(hbsei-myI);
    							myI++;
							}
						}
					}
				}
				for (Map<String, Object> hBaseMap : hBaselist1) {
					DTOMonitorFaceDetailInfo hBaseDto = new DTOMonitorFaceDetailInfo();
					hBaseDto.setManufacture(hBaseMap.get("manufacture") == null ? null
							: hBaseMap.get("manufacture").toString());
					hBaseDto.setInputName(hBaseMap.get("input_mat_name") == null ? null
							: hBaseMap.get("input_mat_name").toString());
					hBaseDto.setInputDate(hBaseMap.get("input_date") == null ? null
							: TimeOrDateUtils.formateDate(
									TimeOrDateUtils.parseDate(hBaseMap.get(
											"input_date").toString()),
									TimeOrDateUtils.FULL_YMD));
					dtoDetailInfo.add(hBaseDto);
				}
				for(String str : matName){
					for(DTOMonitorFaceDetailInfo dTOMonitorFaceDetailInfo:dtoDetailInfo){
						if(dTOMonitorFaceDetailInfo.getInputName().equals(str)){
							returnDtoDetailInfo.add(dTOMonitorFaceDetailInfo);
						}
					}
				}
			} else {
				returnDtoDetailInfo = DTOMonitorFaceDetailInfo.toDtoList(detailInfo);
			}
		} else {
			detailInfo = monitorFaceService
					.queryMonitorFaceDetailInfo(companyId);
			returnDtoDetailInfo = DTOMonitorFaceDetailInfo.toDtoList(detailInfo);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS,
				returnDtoDetailInfo);
	}
}
