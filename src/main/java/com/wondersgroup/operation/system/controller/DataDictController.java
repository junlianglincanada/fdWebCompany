package com.wondersgroup.operation.system.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wondersgroup.data.jpa.entity.DataDict;
import com.wondersgroup.data.jpa.entity.DataDictDetail;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.dao.DataDictDetailDao;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.operation.system.model.DTODataDictDetail;
import com.wondersgroup.operation.util.AbstractBaseController;

@Controller
@RequestMapping(value = "/system/dataDicMgr")
public class DataDictController extends AbstractBaseController {

	@Autowired
	private DataDictService dataDictService;
	
	@Autowired
	private DataDictDetailDao dataDictDetailDao;
	
	//数据字典类型
	/**
	 * 查询数据字典类型
	 * @param name
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@ResponseBody
	@RequestMapping(value = "/queryDataDictList", method = RequestMethod.POST)
	public CommonStatusResult queryDataDictList(
			@RequestParam(value = "name", required = false) String name)
			throws UnsupportedEncodingException {
		name = name != null && !"".equals(name) ? name : "";
		List<DataDict> resultList = dataDictService.searchDataDict(name);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, resultList);
	}
	
	/**
	 * 编辑数据字典类型
	 * @param dataDict
	 * @return
	 */
	@RequestMapping(value = "/editDataDict", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult editDataDict(@RequestBody DataDict dataDict) {
		if (dataDict == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		if(dataDict.getId()!=null&&!"".equals(dataDict.getId())){
			dataDictService.updateDataDict(dataDict);
		}else{
			dataDictService.createDataDict(dataDict);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, dataDict.getId());
	}
	
	/**
	 * 删除数据字典类型
	 * @param dataDict
	 * @return
	 * @throws FoodException
	 */
	@RequestMapping(value = "/deleteDataDict", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult deleteDataDict(@RequestBody DataDict dataDict) throws FoodException{
		if (dataDict == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		dataDictService.deleteDataDict(dataDict);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}
	
	
	//数据字典详情
	/**
	 * 查询数据字典详情
	 * @param name
	 * @param typeId
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@ResponseBody
	@RequestMapping(value = "/queryDataDictDetail/{typeId}", method = RequestMethod.POST)
	public CommonStatusResult queryDataDictDeatil(
			@RequestParam(value = "name", required = false) String name,
			@PathVariable int typeId)
			throws UnsupportedEncodingException {
		List<DataDictDetail> detailList = dataDictService.searchDataDictDetail(typeId, name);
		List<DTODataDictDetail> DTODataDictDetailList = DTODataDictDetail.createListByEntities(detailList);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, DTODataDictDetailList);
	}
	/**
	 * 通过父级id查询数据字典详情
	 * @param name
	 * @param parentId
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@ResponseBody
	@RequestMapping(value = "/queryDataDictDetailByParentId/{parentId}", method = RequestMethod.POST)
	public CommonStatusResult queryDataDictDeatilByParentId(
			@RequestParam(value = "name", required = false) String name,
			@PathVariable int parentId)
			throws UnsupportedEncodingException {
		List<DataDictDetail> detailList = dataDictService.searchDataDictDetailByParentId(parentId, name);
		List<DTODataDictDetail> DTODataDictDetailList = DTODataDictDetail.createListByEntities(detailList);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, DTODataDictDetailList);
	}
	
	/**
	 * 新增数据字典详情
	 * @param dto
	 * @return
	 */
	@RequestMapping(value = "/saveDataDictDetail", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult saveDataDictDetail(@RequestBody DTODataDictDetail dto) {
		if (dto == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		DataDictDetail detail = new DataDictDetail();
		detail.setValue(dto.getValue());
		detail.setSortNum(dto.getSortNum());
		if (dto.getParentId()==0) {
			detail.setParent(null);
		} else {
			detail.setParent(new DataDictDetail(dto.getParentId()));
		}
		detail.setType(new DataDict(dto.getTypeid()));
		dataDictService.saveDataDictDetail(detail);
		
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, detail.getId());
	}
	
	/**
	 * 更新数据字典详情
	 * @param dtoDataDictDetail
	 * @return
	 */
	@RequestMapping(value = "/updateDataDictDetail", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult updateDataDictDetail(@RequestBody List<DTODataDictDetail> dtoDataDictDetail) {
		if (dtoDataDictDetail == null || dtoDataDictDetail.isEmpty()) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		for (DTODataDictDetail dto : dtoDataDictDetail) {
			int detailId = dto.getId();
			DataDictDetail detailEntity = dataDictService.getDataDictDetailById(detailId);
			if(detailEntity==null) {
				throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
			}
			detailEntity.setValue(dto.getValue());
			detailEntity.setSortNum(dto.getSortNum());
			if (dto.getParentId()==0) {
				detailEntity.setParent(null);
			} else {
				detailEntity.setParent(new DataDictDetail(dto.getParentId()));
			}
			detailEntity.setType(new DataDict(dto.getTypeid()));
			dataDictService.updateDataDictDetail(detailEntity);
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}
	
	/**
	 * 删除数据字典详情
	 * @param detail
	 * @return
	 * @throws FoodException
	 */
	@RequestMapping(value = "/deleteDataDictDetail", method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult detailDelete(@RequestBody DataDictDetail detail) throws FoodException{
		if (detail == null) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		dataDictService.deleteDataDictDetail(detail);
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
	}
}
