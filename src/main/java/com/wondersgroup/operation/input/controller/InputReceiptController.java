package com.wondersgroup.operation.input.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import com.wondersgroup.data.jpa.entity.InputReceipt;
import com.wondersgroup.data.jpa.entity.LastUpdateBizData;
import com.wondersgroup.framework.common.AttachmentService;
import com.wondersgroup.framework.common.LastUpdateBizDataService;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.operation.input.model.DTOInputReceipt;
import com.wondersgroup.operation.input.model.DTOInputReceiptCreate;
import com.wondersgroup.operation.input.model.DTOInputReceiptList;
import com.wondersgroup.operation.input.model.DTOInputReceiptUpdate;
import com.wondersgroup.operation.input.model.DTOInputReceiptView;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.operation.util.file.UploadUtils;
import com.wondersgroup.service.input.InputReceiptService;

/**
 * 进货非随货票据维护
 * 
 * @author wanglei
 * 
 */
@Controller
@RequestMapping("/inputManage/inputReceipt")
public class InputReceiptController extends AbstractBaseController {

	private static Logger LOGGER = LoggerFactory.getLogger(InputReceiptController.class);

	@Autowired
	InputReceiptService inputReceiptService;

	@Autowired
	private UploadUtils uploadUtils;
	@Autowired
	private AttachmentService attachmentService;

	@Autowired
	private LastUpdateBizDataService lastUpdateBizDataService;

	// 上传类型 -- 进货票据附件
	public static final String UPLOAD_INPUT_RECEIPT_IMAGE = "OINPUT_RECEIPT_IMAGE";

	public static final Map<String, String> uploadTypeToAttachTypeMap = new HashMap<String, String>() {
		private static final long serialVersionUID = 1948879947792327281L;
		{
			put(UPLOAD_INPUT_RECEIPT_IMAGE, FoodConstant.ATT_INPUT_RECEIPT);

		}
	};

	private static final List<String> singleImageTypes = new ArrayList<String>() {
		private static final long serialVersionUID = 6694506005823947192L;
		{
		}
	};

	/**
	 * 查询企业供应商票据列表
	 * 
	 * @param name
	 *            供应商名称
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/queryInputReceipt/{pageNo}/{pageSize}", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryInputReceipt(@RequestBody Map<String, Object> paramMap, @PathVariable int pageNo, @PathVariable int pageSize) {
		String newSearch = getStringParam(paramMap, "newSearch");
		//如果是第一次查询将查询参数放入session中
		if(StringUtils.isNotEmpty(newSearch)){
			this.getRequest().getSession().setAttribute("paramMap", paramMap);
			this.getRequest().getSession().setAttribute("pageNo", pageNo);
		}else{
			paramMap = (Map)this.getRequest().getSession().getAttribute("paramMap");
			pageNo=(int)this.getRequest().getSession().getAttribute("pageNo");
		}
		String name = getStringParam(paramMap, "name");
		String startDate = getStringParam(paramMap, "startDate");
		String endDate = getStringParam(paramMap, "endDate");
		int companyId = getLoginCompanyId();
		List<DTOInputReceiptList> list = new ArrayList<>();
		QueryResult queryMap = inputReceiptService.queryInputReceiptCompanyId(companyId, -1, name, FoodConstant.ATT_INPUT_RECEIPT, startDate, endDate, pageNo, pageSize);
		List<Map> maps = queryMap.getResultList();
		if (null != maps && maps.size() > 0) {
			for (Map m : maps) {
				DTOInputReceiptList dto = DTOInputReceiptList.toDTO(m);
				List<DTOInputReceipt> imageList = new ArrayList<>();
				if (null != dto.getInputReceiptId()) {
					QueryResult<Attachment> attachmentList = attachmentService.queryAttFile(FoodConstant.ATT_INPUT_RECEIPT, dto.getInputReceiptId().toString(), null, null, -1, -1);
					if (null != attachmentList && attachmentList.getResultList().size() > 0) {
						dto.setAttachmentList(attachmentList.getResultList());
					}
				}

				list.add(dto);
			}
			queryMap.setResultList(list);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, queryMap);
	}

	/**
	 * 根据供应商id查询票据列表
	 * 
	 * @param name
	 *            供应商名称
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	// @RequestMapping(value="/queryInputReceiptBySupperlierId/{supplierId}/{pageNo}/{pageSize}",method
	// =RequestMethod.POST)
	// @ResponseBody
	// public CommonStatusResult queryInputReceiptBySupperlierId(@RequestBody
	// Map<String, Object> paramMap, @PathVariable int supplierId, @PathVariable
	// int pageNo, @PathVariable int pageSize){
	// String startDate = getStringParam(paramMap, "startDate");
	// String endDate = getStringParam(paramMap, "endDate");
	// int companyId=getLoginCompanyId();
	// List<DTOInputReceipt> list=new ArrayList<>();
	// QueryResult
	// queryMap=inputReceiptService.queryInputReceiptBySupperlierId(companyId,
	// supplierId, startDate, endDate, pageNo, pageSize);
	// List<Map> maps=queryMap.getResultList();
	// if(null!=maps&&maps.size()>0){
	// for (Map m:maps) {
	// DTOInputReceipt dto=DTOInputReceipt.toDTO(m);
	// list.add(dto);
	// }
	// queryMap.setResultList(list);
	// }
	// return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS,
	// queryMap);
	// }

	/**
	 * 根据票据id查询信息
	 * 
	 * @param name
	 *            供应商名称
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/queryInputReceiptBySupperlierId/{attachmentId}", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult queryInputReceiptByAttachmentId(@PathVariable int attachmentId) {

		DTOInputReceiptView dto = null;
		Map map = inputReceiptService.queryInputReceiptByAttchmentId(attachmentId);
		if (null != map) {

			dto = DTOInputReceiptView.toDTO(map);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, dto);
	}

	/**
	 * 新增单据
	 * 
	 * @param dtoInputReceipt
	 * @return
	 */
	@RequestMapping(value = "/createInputReceipt", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult createInputReceipt(DTOInputReceiptCreate dto, HttpServletRequest request) {
		if (null == dto || dto.getSuppilerId() == null || dto.getInputDate() == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		InputReceipt inputReceipt = null;
		int companyId = getLoginCompanyId();
		if (dto != null) {
			inputReceipt = DTOInputReceiptCreate.toEntitie(dto, companyId, inputReceiptService);
			if (inputReceipt != null && inputReceipt.getId() == null) {
				inputReceipt = inputReceiptService.createInputReceipt(companyId, inputReceipt);
			}
			Map<String, List<MultipartFile>> fileMap = getMultipartFileMapFromRequest(request);
			// 添加附件
			LinkedMultiValueMap<String, Attachment> resultMap = new LinkedMultiValueMap<>();
			if (null != inputReceipt) {
				uploadUtils.uploadFiles(inputReceipt.getId(), uploadTypeToAttachTypeMap, fileMap, singleImageTypes, resultMap, companyId);
			}
		}
		lastUpdateBizDataService.updateLastUpdateBizData(companyId, LastUpdateBizData.TYPE_INPUT_RECEIPT);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, inputReceipt);
	}

	/**
	 * 更新单据
	 * 
	 * @param dtoInputReceipt
	 * @return
	 */
	@RequestMapping(value = "/updateInputReceipt", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateInputReceipt(@RequestBody DTOInputReceiptUpdate dto) {
		if (null == dto || dto.getId() == null || dto.getSuppilerId() == null || null == dto.getInputDate()) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		InputReceipt inputReceipt = null;
		int companyId = getLoginCompanyId();
		if (null != dto) {
			inputReceipt = DTOInputReceiptUpdate.toEntitie(dto, companyId, inputReceiptService);
			if (inputReceipt != null && inputReceipt.getId() == null) {
				inputReceipt = inputReceiptService.createInputReceipt(companyId, inputReceipt);
			}
			Attachment attachment = attachmentService.getAttachment(dto.getId());
			if (null != inputReceipt && null != attachment) {
				String inputReceiptId = attachment.getObjId();
				attachment.setObjId(inputReceipt.getId().toString());
				attachmentService.updateAttachment(attachment);
				// 查询原来票据是否有单据附件 若没有更新为无效数据
				QueryResult<Attachment> queryResult = attachmentService.queryAttFile(FoodConstant.ATT_INPUT_RECEIPT, inputReceiptId, null, null);
				if (queryResult == null || queryResult.getResultList().size() == 0) {
					inputReceiptService.deleteInputReceiptNew(companyId, Integer.parseInt(inputReceiptId));
				}
			}
		}
		lastUpdateBizDataService.updateLastUpdateBizData(companyId, LastUpdateBizData.TYPE_INPUT_RECEIPT);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}

	/**
	 * 删除单据
	 * 
	 * @param dtoInputReceipt
	 * @return
	 */

	@RequestMapping(value = "/delInputReceipt", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult delAttachments(@RequestBody(required = true) List<Integer> restIdList) throws Exception {
		attachmentService.deleteAttFiles(restIdList);
		int companyId = getLoginCompanyId();
		for (Integer id : restIdList) {
			Attachment a = inputReceiptService.findAttachmentById(id);
			if (a != null) {
				QueryResult<Attachment> queryResult = attachmentService.queryAttFile(FoodConstant.ATT_INPUT_RECEIPT, a.getObjId(), null, null);
				if (queryResult == null || queryResult.getResultList().size() == 0) {
					inputReceiptService.deleteInputReceiptNew(companyId, Integer.parseInt(a.getObjId()));
				}
			}
		}
		lastUpdateBizDataService.updateLastUpdateBizData(companyId, LastUpdateBizData.TYPE_INPUT_RECEIPT);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}

}
