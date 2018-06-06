package com.wondersgroup.operation.recycle.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
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
import com.wondersgroup.data.jpa.entity.CleanOilRecycleRecord;
import com.wondersgroup.framework.common.AttachmentService;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.recycle.model.DTOCleanOilRecycleRecord;
import com.wondersgroup.operation.recycle.model.DTOCleanOilRecycleRecordCreate;
import com.wondersgroup.operation.recycle.model.DTOCleanOilRecycleRecordDetail;
import com.wondersgroup.operation.recycle.model.DTOCleanOilRecycleRecordUpdate;
import com.wondersgroup.operation.recycle.model.DTORecycleCompany;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.operation.util.file.UploadUtils;
import com.wondersgroup.service.clean.CleanService;
import com.wondersgroup.service.company.CompanyService;
import com.wondersgroup.service.company.RestaurantService;
import com.wondersgroup.service.empuser.RestaurantEmployeeService;

@Controller
@RequestMapping(value = "/recycle/cleanOilComMgr")
public class CleanOilRecycleComController extends AbstractBaseController{
	
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
	//上传类型  -- 废弃油脂回收单据附件
	public static final String UPLOAD_OIL_RECYCLE_IMAGE = "OIL_RECYCLE_IMAGE";
	
	public static final Map<String, String> uploadTypeToAttachTypeMap = new HashMap<String, String>() {
		private static final long serialVersionUID = 1948879947792327281L;
		{
			put(UPLOAD_OIL_RECYCLE_IMAGE,  FoodConstant.ATT_OIL_RECYCLE_RECORD);

	}};
	
	private static final List<String> singleImageTypes = new ArrayList<String>() {
		private static final long serialVersionUID = 6694506005823947192L;
		{
		}
	};
    /**
     * 添加废弃油脂回收台账</br>
     */
    @RequestMapping(value = "/addOilRecycleRecord", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult addOilRecycleRecord( DTOCleanOilRecycleRecordCreate oilRecycleRecord,HttpServletRequest request) {
        String userName = getLoginUserName();
    	int companyId = getLoginCompanyId();
        CleanOilRecycleRecord oilRecycleRecordEntity = DTOCleanOilRecycleRecordCreate.toEntity(oilRecycleRecord, companyId, cleanService, restaurantService, getLoginUserId(), userName);
        oilRecycleRecordEntity = cleanService.createCleanOilRecycleRecord(oilRecycleRecordEntity); 
	     Map<String, List<MultipartFile>> fileMap = getMultipartFileMapFromRequest(request);
	        // 添加附件
       LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
       if (null!=oilRecycleRecordEntity) {
       	uploadUtils.uploadFiles(oilRecycleRecordEntity.getId(),uploadTypeToAttachTypeMap,fileMap,singleImageTypes,resultMap,companyId);
		}
   	  return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, oilRecycleRecordEntity);
    }
	
    
  /**
   * 【×】更新废弃油脂回收台</br>
   *
   */
  @RequestMapping(value = "/updateOilRecycleRecord", method = RequestMethod.POST)
  @ResponseBody
  public CommonStatusResult updateOilRecycleRecord( DTOCleanOilRecycleRecordUpdate oilRecycleRecord, HttpServletRequest request) {
  	  int companyId = getLoginCompanyId();
      CleanOilRecycleRecord oilRecycleRecordEntity = DTOCleanOilRecycleRecordUpdate.toEntity(oilRecycleRecord, getLoginCompanyId(), cleanService, restaurantService);
      if (null==oilRecycleRecordEntity||null==oilRecycleRecordEntity.getId()) {
    		throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
	}
      cleanService.updateCleanOilRecycleRecord(oilRecycleRecordEntity);

	     Map<String, List<MultipartFile>> fileMap = getMultipartFileMapFromRequest(request);
	        // 添加附件
    LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
     if (null!=oilRecycleRecordEntity) {
    	uploadUtils.uploadFiles(oilRecycleRecordEntity.getId(),uploadTypeToAttachTypeMap,fileMap,singleImageTypes,resultMap,companyId);
		}
  	  return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, oilRecycleRecordEntity);
  }
    /**	
	 * 查看废弃油脂回收台账列表
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, value = "/queryDTOCleanOilRecycleList/{pageNo}/{pageSize}" )
	public CommonStatusResult queryDTOCleanOilRecycleList(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize)
			throws Exception {
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
		QueryResult queryResult = null;
		//10.21 只查询当前关联收货单位的台账列表
/*		   QueryResult<CleanOilRecycleCom> resultData = cleanService.queryCleanOilRecycleComByCompanyId(companyId, 1, "", -1, -1);
	        DTORecycleCompany cleanOilRecycleCom =null;
	        if (resultData != null && resultData.getResultList().size()>0) {     
	      cleanOilRecycleCom = DTORecycleCompany.createByEntity(resultData.getResultList().get(0));
	      int recycleCompanyId=cleanOilRecycleCom.getId();*/
			// 本查询对象为该餐饮企业所有添加的废弃油脂回收台账列表；
			 queryResult = cleanService.queryCleanOilRecycleRecords(null, null,recycleDate, recycleDate, null,sortBy, sortDirection, pageNo, pageSize, companyId, -1);
			List<DTOCleanOilRecycleRecord> dtoList = new ArrayList<DTOCleanOilRecycleRecord>();
			List<CleanOilRecycleRecord> resultList = queryResult.getResultList();
			if (resultList != null && resultList.size() > 0) {
				for (CleanOilRecycleRecord cleanOilRecycleRecord : resultList) {
					DTOCleanOilRecycleRecord dto = DTOCleanOilRecycleRecord.toDTO(cleanOilRecycleRecord,attachmentService);
					dtoList.add(dto);
				}
				queryResult.setResultList(dtoList);
			}
	        

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}
	
	
    /**
     * 【×】删除废弃油脂回收台账</br>
     *
     * @param oilRecycleRecordId 废弃油脂回收台账编号
     */
    @RequestMapping(value = "/deleteOilRecycleRecord/{oilRecycleRecordId}", method = RequestMethod.GET)
    @ResponseBody
    public CommonStatusResult deleteOilRecycleRecord(@PathVariable int oilRecycleRecordId) {
   
                cleanService.deleteCleanOilRecycleRecord(oilRecycleRecordId, getLoginCompanyId());
            return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
    }
	
    
    /**
     * 【×】查看废弃油脂回收台明细</br> 【异常】：参见公共异常
     *
     * @param oilRecycleRecordId 废弃油脂回收台账编号
     * @return
     */
    @RequestMapping(value = "/getOilRecycleRecord/{oilRecycleRecordId}", method = RequestMethod.GET)
    @ResponseBody
    public CommonStatusResult getOilRecycleRecord(@PathVariable int oilRecycleRecordId) throws Exception {
        CleanOilRecycleRecord record = cleanService.getCleanOilRecycleRecordById(oilRecycleRecordId);
        if (null == record) {
            return null;
        }
        DTOCleanOilRecycleRecordDetail data = DTOCleanOilRecycleRecordDetail.createByEntity(record,attachmentService);
        return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, data);
    }

    

	
}
