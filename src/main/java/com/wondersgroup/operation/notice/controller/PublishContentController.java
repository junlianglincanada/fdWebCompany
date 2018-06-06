package com.wondersgroup.operation.notice.controller;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.data.jpa.entity.Restaurant;
import com.wondersgroup.data.jpa.entity.SupComNotification;
import com.wondersgroup.data.jpa.entity.SupPublishContent;
import com.wondersgroup.data.jpa.entity.SupPublishContentReply;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.operation.notice.model.DTOPublishContent;
import com.wondersgroup.service.sup.SupComNotificationService;
import com.wondersgroup.service.sup.SupPublishContentService;
import com.wondersgroup.util.TimeOrDateUtils;


@Controller
@RequestMapping("/publishContent")
public class PublishContentController extends AbstractBaseController {
	private static Logger LOGGER = LoggerFactory.getLogger(PublishContentController.class);
	@Autowired
	private SupPublishContentService contentService;	
	@Autowired
	private SupComNotificationService notificationService;
	/**
	 * @author linzhixiang
	 *@param companyName
	 *@param publishDate  发布日期
	 *@param sortBy
	 *@param sortDirection
	 */
	@ResponseBody
	@ResponseStatus(HttpStatus.OK)
	@RequestMapping(value = "/queryPublishContent/{pageNo}/{pageSize}", method = RequestMethod.POST)
	public CommonStatusResult queryPublicContent(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) throws UnsupportedEncodingException {
		String newSearch = getStringParam(paramMap, "newSearch");
		//如果是第一次查询将查询参数放入session中
		if(StringUtils.isNotEmpty(newSearch)){
			this.getRequest().getSession().setAttribute("paramMap", paramMap);
			this.getRequest().getSession().setAttribute("pageNo", pageNo);
		}else{
			paramMap = (Map)this.getRequest().getSession().getAttribute("paramMap");
			pageNo=(int)this.getRequest().getSession().getAttribute("pageNo");
		}
		Date startDate;
		Date endDate;
		int companyId = getLoginCompanyId();
		Company loginCompany = getLoginCompany();
		int regionId = loginCompany.getRegionCounty();
		String orgName = getStringParam(paramMap, "orgName");
		//QueryResult queryResultl =contentService.queryZoneCodeId( companyId);
		//String companyName = getStringParam(paramMap, "companyName");
		String publishDateString = (String) paramMap.get("publishDate");
		Date publishDate = TimeOrDateUtils.parseDate(publishDateString);
		//Integer areaId = -1;
		/*if(queryResultl.getResultList().size()==0){
			areaId = -1;
		}else{
			Map<String,String> strr=(Map<String, String>) queryResultl.getResultList().get(0);
			if(strr.get("SPT_ORGAN_ID")!=null){
				areaId=Integer.parseInt(strr.get("SPT_ORGAN_ID").toString());
				areaId=Integer.parseInt(strr.get("SPT_ORGAN_ID"));		
			}else{
				areaId=-1;
			}
		}*/
		//String zoneCodeId=String.valueOf(areaId);
		if (publishDate != null) {
			startDate = TimeOrDateUtils.getDayBegin(publishDate);
			endDate = TimeOrDateUtils.getDayEnd(publishDate);
		} else {
			startDate = null;
			endDate = null;
		}
		String title = (String) paramMap.get("title");
		//String sortBy = getStringParam(paramMap, "sortBy").trim();
		//String sortDirection = getStringParam(paramMap, "sortDirection").trim();
		QueryResult queryResult = contentService.queryPublishContentListByRegion(regionId,companyId,title,orgName, startDate, endDate, pageNo, pageSize);
		//QueryResult queryResult = contentService.queryPublishContentList( companyId,companyName,Integer.parseInt(zoneCodeId), publishDate, sortBy, sortDirection, startDate, endDate, pageNo, pageSize);
		if (queryResult != null && queryResult.getResultList() != null) {
			List<DTOPublishContent> newList = DTOPublishContent.createListByEntities(queryResult.getResultList());
			queryResult.setResultList(newList);
		}

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);

	}
	

	@ResponseBody
	@ResponseStatus(HttpStatus.OK)
	@RequestMapping(value = "/getPublicContentById/{id}", method = RequestMethod.GET)
	public CommonStatusResult getPublicContentById(@PathVariable int id)   {
		if(id<=0){
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		QueryResult queryResult = contentService.getPublishContentById(id, -1, -1);
		if (queryResult != null && queryResult.getResultList() != null) {
			List<DTOPublishContent> newList = DTOPublishContent.createListByEntities(queryResult.getResultList());
			queryResult.setResultList(newList);
		}
		SupPublishContent content = contentService.getSupPublishContentById(id);
		int companyId = getLoginCompanyId();
		List<SupPublishContentReply> replyList = contentService.getSupPublishContentReplyListByCompanyId(id,companyId);
		if(replyList==null||replyList.size()==0){
			SupPublishContentReply reply = new SupPublishContentReply();
			reply.setContent(content);
			reply.setReplyOrg(getLoginCompany());
			reply.setReplyPerson(getLoginUserId());
			reply.setReplyPersonName(getLoginUserName());
			reply.setReplyTime(new Date());
			reply.setReplyContent("已读");
			contentService.createSupPublishContentReply(reply);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}
	
	/**
	 * 查询未读数量 
	 * @return
	 */
	@ResponseBody
	@ResponseStatus(HttpStatus.OK)
	@RequestMapping(value = "/countUnreadContent", method = RequestMethod.GET)
	public CommonStatusResult countUnreadNotification(){
		Map<String,Object> map = new HashMap<String,Object>();
		int companyId = getLoginCompanyId();
		Company loginCompany = getLoginCompany();
		int regionId = loginCompany.getRegionCounty();
		int countPublishment = contentService.countReadPublishContent(companyId,regionId);
		int countNotification = notificationService.countReadPublishContent(companyId, SupComNotification.IS_NOT_READ);
		map.put("publishment", countPublishment);
		map.put("notification", countNotification);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, map);
	}
}
