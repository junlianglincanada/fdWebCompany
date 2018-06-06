package com.wondersgroup.operation.monitorFace.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wondersgroup.data.jpa.entity.DisplayInputMaterial;
import com.wondersgroup.data.jpa.entity.DisplayJobRole;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.monitorFace.model.DTODisplayInputMaterialCreate;
import com.wondersgroup.operation.monitorFace.model.DTODisplayInputMaterialInfo;
import com.wondersgroup.operation.monitorFace.model.DTODisplayJobRoleCreate;
import com.wondersgroup.operation.monitorFace.model.DTOMonitorFaceEmpInfo;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.operation.util.file.UploadUtils;
import com.wondersgroup.service.monitorFace.MonitorFaceService;
import com.wondersgroup.service.monitorFace.MonitorMaintainService;

@Controller
@RequestMapping("/monitor")
public class MonitorMaintainController extends AbstractBaseController{

	private static final Logger logger = LoggerFactory.getLogger(MonitorMaintainController.class);
	
	@Autowired
	private UploadUtils uploadUtils;
	@Autowired
    private MonitorMaintainService monitorService;
	@Autowired
    private MonitorFaceService monitorFaceService;
	
	public static final String UPLOAD_TYPE_COM_EMP = "COM_EMP"; //从业人员 --大头照
	public static final String UPLOAD_TYPE_COM_SPLTXKZ = "COM_SPLTXKZ"; //注册企业 -- 食品流通许可证
	public static final String UPLOAD_TYPE_COM_CYFWXKZ = "COM_CYFWXKZ"; //注册企业 -- 餐饮服务许可证
	public static final String UPLOAD_TYPE_COM_SPJYXKZ = "COM_SPJYXKZ"; //注册企业 -- 食品经营许可证
	    
	public static final Map<String, String> uploadTypeToAttachTypeMap = new HashMap<String, String>() {
		private static final long serialVersionUID = 1948879947792327281L;
		{
			put(UPLOAD_TYPE_COM_EMP, FoodConstant.ATT_EMPLOYEE);
			put(UPLOAD_TYPE_COM_SPLTXKZ, FoodConstant.ATT_COM_SPLTXKZ);
			put(UPLOAD_TYPE_COM_CYFWXKZ, FoodConstant.ATT_COM_CYFWXKZ);
			put(UPLOAD_TYPE_COM_SPJYXKZ, FoodConstant.ATT_COM_SPJYXKZ);
		}};
		
	private static final List<String> singleImageTypes = new ArrayList<String>() {
		private static final long serialVersionUID = 6694506005823947192L;
		{
			add(UPLOAD_TYPE_COM_EMP);
			add(UPLOAD_TYPE_COM_SPLTXKZ);
			add(UPLOAD_TYPE_COM_CYFWXKZ);
			add(UPLOAD_TYPE_COM_SPJYXKZ);
		}
	};

	/**
	 * 查询从业人员岗位照片
	 * @return
	 */
	@RequestMapping(value = "/queryEmpInfo", method = RequestMethod.POST)
    @ResponseBody
	public CommonStatusResult getJobRoleList(){
		int companyId = getLoginCompanyId();
		int hasDisJob = monitorService.hasDisplayJobRole(companyId);
		//岗位表无数据则查询从业人员表默认岗位数据
		if(hasDisJob<1){
			QueryResult empInfo=monitorFaceService.queryMonitorFaceEmpInfo(companyId);
			List<DTOMonitorFaceEmpInfo> dtoEmpInfo=DTOMonitorFaceEmpInfo.toDtoList(empInfo);
	        for (DTOMonitorFaceEmpInfo emp : dtoEmpInfo) {
	        	DisplayJobRole entity = DTOMonitorFaceEmpInfo.toEntity(companyId, emp);
	        	monitorService.createDisplayJobRole(entity);
			}
		}
		List<Map> list = monitorService.getDisJobRoleList(companyId);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, list);
	}
	
	/**
	 * 查询从业人员信息，用于维护公示屏从业人员弹出选择
	 * @return
	 */
	@RequestMapping(value = "/getEmpInfoLists/{pageNo}/{pageSize}", method = RequestMethod.POST)
    @ResponseBody
	public CommonStatusResult getEmpInfoList(@RequestBody Map<String, Object> paramMap ,@PathVariable int pageNo, @PathVariable int pageSize){
		String keyword=getStringParam(paramMap, "keyword");
		int companyId = getLoginCompanyId();
		QueryResult<Map> list = monitorService.getEmpInfoList(companyId,keyword,pageNo,pageSize);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, list);
	}
	
	/**
	 * 新增公示屏职务人员
	 * @param dto
	 * @return
	 */
	@RequestMapping(value = "/addEmpInfo", method = RequestMethod.POST)
    @ResponseBody
	public CommonStatusResult addDisplayJobRole(@Valid @RequestBody DTODisplayJobRoleCreate dto){
		int companyId = getLoginCompanyId();
		DisplayJobRole entity = DTODisplayJobRoleCreate.toEntity(companyId, dto);
		DisplayJobRole result = monitorService.createDisplayJobRole(entity);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result.getId());
	}
	
	/**
	 * 删除公示屏职务人员
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/deleteJobRole/{id}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult deleteJobRole(@PathVariable int id){
		monitorService.deleteDisplayJobRole(id);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}
	
	/**
	 * 获取采购品列表，按名称去重
	 * @param keyword 
	 * @return
	 */
	@RequestMapping(value = "/getInputMatName", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult getInputMatNameList(@RequestParam String keyword){
		int companyId = getLoginCompanyId();
		List<Map> list = monitorService.getInputNameList(companyId, keyword);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, list);
	}

	/**
	 * 获取公示采购品列表
	 * @return
	 */
	@RequestMapping(value = "/getDisplayInputMat", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult getDisplayInputMat(){
		int companyId = getLoginCompanyId();
		List<DisplayInputMaterial> list = monitorService.getDisplayInputMaterialList(companyId);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, DTODisplayInputMaterialInfo.createByEntities(list));
	}
	
	/**
	 * 新增公示采购品
	 * @param dto
	 * @return
	 */
	@RequestMapping(value = "/addDisplayInputMaterial", method = RequestMethod.POST)
    @ResponseBody
	public CommonStatusResult createDisplayInputMat(@Valid @RequestBody DTODisplayInputMaterialCreate dto){
		int companyId = getLoginCompanyId();
		DisplayInputMaterial entity = DTODisplayInputMaterialCreate.createByDto(companyId, dto);
		DisplayInputMaterial result = monitorService.createDisplayInputMaterial(entity);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result.getId());
	}
	
	/**
	 * 删除公示采购品
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/deleteDisplayInputMaterial/{id}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult deleteDisplayInputMat(@PathVariable int id){
		monitorService.deleteDisplayInputMaterial(id);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}
	
	/**
	 * 批量删除公示采购品
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/deleteDisplayInputMaterials", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult deleteDisplayInputMats(){
		int companyId = getLoginCompanyId();
		monitorService.deleteDisplayInputMaterials(companyId);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}
}
