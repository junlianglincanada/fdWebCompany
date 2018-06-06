package com.wondersgroup.operation.notice.controller;

import java.util.List;
import java.util.Map;

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

import com.wondersgroup.data.jpa.entity.SupComNotification;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.operation.notice.model.DTOSupNotification;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.service.sup.SupComNotificationService;
import com.wondersgroup.util.StringUtils;

@Controller
@RequestMapping("/supNotification")
public class SupComNotificationController extends AbstractBaseController {

	private static Logger LOGGER = LoggerFactory.getLogger(SupComNotificationController.class);
	@Autowired
	private SupComNotificationService notificationService;
	
	/**
	 * 查询监管提示列表
	 * @param paramMap
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/queryNotificationList/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult getNotificationList(@RequestBody Map<String, Object> paramMap,@PathVariable int pageNo, @PathVariable int pageSize){
		int companyId = getLoginCompanyId();
		QueryResult queryResult = notificationService.querySupComNotificationList(companyId, pageNo, pageSize);
		if(queryResult!=null&&queryResult.getResultList()!=null){
			List<DTOSupNotification> list = DTOSupNotification.toDTOList(queryResult.getResultList());
			queryResult.setResultList(list);
		}else{
			queryResult = new QueryResult();
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryResult);
	}
	
	/**
	 * 设置为已读
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/setNotificationListRead", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult setNotificationListRead(@RequestParam String ids){
		if(StringUtils.isBlank(ids)){
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		String[] idArray = ids.split(",");
		try {
			for(int i=0;i<idArray.length;i++){
				Integer id = Integer.parseInt(idArray[i]);
				notificationService.setNotificationRead(id);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, true);
	}
}
