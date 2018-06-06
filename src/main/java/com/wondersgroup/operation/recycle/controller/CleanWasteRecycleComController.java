package com.wondersgroup.operation.recycle.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.wondersgroup.data.jpa.entity.Attachment;
import com.wondersgroup.data.jpa.entity.CleanOilRecycleCom;
import com.wondersgroup.data.jpa.entity.CleanWasteRecycleCom;
import com.wondersgroup.data.jpa.entity.CleanWasteRecycleRecord;
import com.wondersgroup.framework.common.AttachmentService;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.recycle.model.DTOCleanWasteRecycleRecordCreate;
import com.wondersgroup.operation.recycle.model.DTOCleanWasteRecycleRecordDetail;
import com.wondersgroup.operation.recycle.model.DTOCleanWasteRecycleRecordListData;
import com.wondersgroup.operation.recycle.model.DTOCleanWasteRecycleRecordUpdate;
import com.wondersgroup.operation.recycle.model.DTORecycleCompany;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.operation.util.file.UploadUtils;
import com.wondersgroup.service.clean.CleanService;
import com.wondersgroup.service.company.CompanyService;
import com.wondersgroup.service.company.RestaurantService;
import com.wondersgroup.service.empuser.RestaurantEmployeeService;
import com.wondersgroup.util.StringUtils;

@Controller
@RequestMapping(value = "/restaurant/cleanWasteComMgr")
public class CleanWasteRecycleComController extends AbstractBaseController{
	
	@Autowired
	public CleanService cleanService;
	
	@Autowired
	public CompanyService companyService;

	@Autowired
	private RestaurantEmployeeService employeeService;
	
	@Autowired
	private AttachmentService attachmentService;
    @Autowired
    private RestaurantService restaurantService;

	@Autowired
	private UploadUtils uploadUtils;
	//上传类型  -- 餐厨回收单据附件
	public static final String UPLOAD_WASTE_RECYCLE_IMAGE = "WASTE_RECYCLE_IMAGE";
	
	public static final Map<String, String> uploadTypeToAttachTypeMap = new HashMap<String, String>() {
		private static final long serialVersionUID = 1948879947792327281L;
		{
			put(UPLOAD_WASTE_RECYCLE_IMAGE,FoodConstant.ATT_WASTE_RECYCLE_RECORD);

	}};
	
	private static final List<String> singleImageTypes = new ArrayList<String>() {
		private static final long serialVersionUID = 6694506005823947192L;
		{
		}
	};
	/**
	 * 添加餐厨回收台账
	 * @param wasteRecycleRecord
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/addWasteRecycleRecord", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult addWasteRecycleRecord(DTOCleanWasteRecycleRecordCreate wasteRecycleRecord, HttpServletRequest request) {
		String userName = getLoginUserName();
    	int companyId = getLoginCompanyId();
			CleanWasteRecycleRecord wasteRecycleRecordEntity = DTOCleanWasteRecycleRecordCreate.toEntity(wasteRecycleRecord,companyId,cleanService,restaurantService,getLoginUserId(),userName);
			wasteRecycleRecordEntity = cleanService.createCleanWasteRecycleRecord(wasteRecycleRecordEntity);
			// 添加附件
		     Map<String, List<MultipartFile>> fileMap = getMultipartFileMapFromRequest(request);
		        // 添加附件
	       LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
	       if (null!=wasteRecycleRecordEntity) {
	       	uploadUtils.uploadFiles(wasteRecycleRecordEntity.getId(),uploadTypeToAttachTypeMap,fileMap,singleImageTypes,resultMap,companyId);
			}
			return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, wasteRecycleRecordEntity);
		
	}
	/**
	 * 根据id删除餐厨回收台账
	 * @param wasteRecycleRecordIds
	 * @return
	 */
	@RequestMapping(value = "/deleteWasteRecycleRecord/{wasteRecycleRecordIds}", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult deleteWasteRecycleRecord(@PathVariable int wasteRecycleRecordIds) {

				cleanService.deleteCleanWasteRecycleRecord(wasteRecycleRecordIds, getLoginCompanyId());
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}
    
	/**
	 * 修改餐厨回收台账
	 * @param wasteRecycleRecord
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/updateWasteRecycleRecord", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateWasteRecycleRecord( DTOCleanWasteRecycleRecordUpdate wasteRecycleRecord, HttpServletRequest request) {
	  	  int companyId = getLoginCompanyId();
		CleanWasteRecycleRecord origionWasteRecycleRecordEntity = cleanService.getCleanWasteRecycleRecordById(wasteRecycleRecord.getId());
			if( origionWasteRecycleRecordEntity == null) {
				throw FoodException.returnException("000003");
			}
			if( origionWasteRecycleRecordEntity.getCompany() == null || !origionWasteRecycleRecordEntity.getCompany().getCompanyId().equals(getLoginCompanyId())) {
				throw FoodException.returnException("000003");
			}
			
			CleanWasteRecycleRecord wasteRecycleRecordEntity	= DTOCleanWasteRecycleRecordUpdate.toEntity(origionWasteRecycleRecordEntity,wasteRecycleRecord,getLoginCompanyId(), cleanService, restaurantService);
			cleanService.updateCleanWasteRecycleRecord(wasteRecycleRecordEntity);
		     Map<String, List<MultipartFile>> fileMap = getMultipartFileMapFromRequest(request);
		        // 添加附件
	    LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
	     if (null!=wasteRecycleRecordEntity) {
	    	uploadUtils.uploadFiles(wasteRecycleRecordEntity.getId(),uploadTypeToAttachTypeMap,fileMap,singleImageTypes,resultMap,companyId);
			}
			return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, wasteRecycleRecordEntity);
	}

	/**
	 * 根据id查询餐厨回收台账
	 */

	@RequestMapping(value = "/getWasteRecycleRecord/{wasteRecycleRecordId}", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult getWasteRecycleRecord(@PathVariable int wasteRecycleRecordId) throws Exception {
		DTOCleanWasteRecycleRecordDetail data = null;
		CleanWasteRecycleRecord record = cleanService.getCleanWasteRecycleRecordById(wasteRecycleRecordId);
		if(record != null){
			data = DTOCleanWasteRecycleRecordDetail.createByEntity(record, attachmentService);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, data);
	}
	/**
	 * 查看餐厨回收台账列表
	 */
	@RequestMapping(value = "/listWasteRecycleRecord/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult listWasteRecycleRecord(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) throws IllegalAccessException,
	Exception {
		
		String newSearch = getStringParam(paramMap, "newSearch");
		//如果是第一次查询将查询参数放入session中
		if(StringUtils.isNotEmpty(newSearch)){
			this.getRequest().getSession().setAttribute("paramMap", paramMap);
			this.getRequest().getSession().setAttribute("pageNo", pageNo);
		}else{
			paramMap = (Map)this.getRequest().getSession().getAttribute("paramMap");
			pageNo=(int)this.getRequest().getSession().getAttribute("pageNo");
		}

		
		int companyId = getLoginCompanyId();
		String recycleDate = getStringParam(paramMap, "recycleDate");
		String sortBy = "recycleDate";
		String sortDirection = "desc";
		QueryResult wasteRecycleRecords=null;
		//10.21 只查询当前关联收货单位的台账列表
	/*	QueryResult<CleanWasteRecycleCom> resultData= cleanService.queryCleanWasteRecycleComsByCompanyId(getLoginCompanyId(), 1, "", -1, -1);
	
		if( resultData != null  && resultData.getResultList().size()>0) {
			CleanWasteRecycleCom   crc= resultData.getResultList().get(0);
			int recycleCompanyId =crc.getId();*/
			 wasteRecycleRecords = cleanService.queryCleanWasteRecycleRecords(null, null, recycleDate, recycleDate, -1, sortBy,
						sortDirection, pageNo, pageSize,companyId, -1);
		if (wasteRecycleRecords != null && wasteRecycleRecords.getResultList() != null) {
			List<DTOCleanWasteRecycleRecordListData> newList = DTOCleanWasteRecycleRecordListData
					.createListByEntities(wasteRecycleRecords.getResultList(), attachmentService);
			wasteRecycleRecords.setResultList(newList);
		}else {
			wasteRecycleRecords = new QueryResult<>();
		}
		/*}*/
	
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, wasteRecycleRecords);
	}
	

	
	
}
