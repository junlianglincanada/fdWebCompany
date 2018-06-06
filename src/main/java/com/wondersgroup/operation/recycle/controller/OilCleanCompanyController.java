package com.wondersgroup.operation.recycle.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wondersgroup.data.jpa.entity.CleanOilRecycleCom;
import com.wondersgroup.data.jpa.entity.CleanWasteRecycleCom;
import com.wondersgroup.data.jpa.entity.Company;
import com.wondersgroup.data.jpa.entity.OilCleanCompany;
import com.wondersgroup.framework.common.DataDictService;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.DataDicConstant;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.operation.recycle.model.DTOCleanOilRecycleCompany;
import com.wondersgroup.operation.recycle.model.DTOCleanOilRecycleCompanyViewData;
import com.wondersgroup.operation.recycle.model.DTOCleanWasteRecycleCompany;
import com.wondersgroup.operation.recycle.model.DTOOilCleanCompanyListData;
import com.wondersgroup.operation.recycle.model.DTORecycleCompany;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.service.clean.CleanService;
import com.wondersgroup.service.company.CompanyService;

@Controller
@RequestMapping(value = "/restaurant/oilCleanComMgr")
public class OilCleanCompanyController extends AbstractBaseController{
	private static Logger LOGGER = LoggerFactory.getLogger(OilCleanCompanyController.class);
	@Autowired
	private CleanService cleanService;
    @Autowired
    private CompanyService companyService;


        
    /**
     * 获取废弃油脂种类列表
     *
     * @return
     */
    @RequestMapping(value = "/getWasteOilTypeList", method = RequestMethod.GET)
    public CommonStatusResult getWasteOilTypeList() {
        Map<Integer, String> map = DataDictService.getDataDicDetailByType(DataDicConstant.DIC_WASTE_OIL_TYPE);
    	return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, map);

    }

    /**
     * 获取计量单位列表
     *
     * @return
     */
    @RequestMapping(value = "/listMeasureUnits", method = RequestMethod.GET)
    public CommonStatusResult listMeasureUnits() {
        Map<Integer, String> map = DataDictService.getDataDicDetailByType(DataDicConstant.DIC_MEASURE_UNIT);
    	return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, map);

    }
	
    /**
     * 获取餐厨回收单位
     *10.19 回收单位只维护一个 若返回空提示创建回收单位
     * @return
     */
	@RequestMapping(value = "/listCompanyWasteRecycle", method = RequestMethod.GET)
	@ResponseBody
	public CommonStatusResult listCompanyWasteRecycle() {
		QueryResult<CleanWasteRecycleCom> resultData= cleanService.queryCleanWasteRecycleComsByCompanyId(getLoginCompanyId(), 1, null, -1, -1);
		DTORecycleCompany  dto=null;
		if( resultData != null  && resultData.getResultList().size()>0) {
          dto= DTORecycleCompany.createByEntity(resultData.getResultList().get(0));
		}
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, dto);
	}
	
	
    /**
     * 新建餐厨垃圾回收单位
     * @param dtoCleanWasteRecycleCompany
     * @param request
     * @return 
     */
    @RequestMapping(value = "/clean/createCleanWasteRecycleCom", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult createCleanWasteRecycleCom( @RequestBody DTOCleanWasteRecycleCompany dtoCleanWasteRecycleCompany){
        int comId = getLoginCompanyId();
        Company company = companyService.getCompanyById(comId);
        if(company==null){
            throw FoodException.returnException("000011");
        }
        
        CleanWasteRecycleCom wasteRecycleCom = DTOCleanWasteRecycleCompany.toEntity(null, dtoCleanWasteRecycleCompany, company);
        wasteRecycleCom = cleanService.createCleanWasteRecycleCom(wasteRecycleCom);
       
        return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, wasteRecycleCom.getId());
    }
    
    
	
    /**
     * 删除厨垃圾回收单位
     * @param dtoCleanWasteRecycleCompany
     * @param request
     * @return 
     */

    @RequestMapping(value = "/clean/deleteCleanWasteRecycleCom/{cleanWasteRecycleComId}", method = RequestMethod.GET)
    @ResponseBody
    public CommonStatusResult deleteCleanWasteRecycleCom(@PathVariable int cleanWasteRecycleComId){

         cleanService.disableCleanWasteRecycleCom(cleanWasteRecycleComId);
       
        return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
    }
    //
    
    /**
     * 根据ID查询餐厨垃圾回收单位
     * @param id
     * @return 
     */
    @RequestMapping(value = "/clean/getCleanWasteRecycleComById/{id}", method = RequestMethod.GET)
    @ResponseBody
    public CommonStatusResult getCleanWasteRecycleComById(@PathVariable Integer id){
        CleanWasteRecycleCom wasteRecycleCom = cleanService.getCleanWasteRecycleComById(id);
        if(wasteRecycleCom==null){
            throw FoodException.returnException("000003");
        } 
        DTOCleanWasteRecycleCompany data = DTOCleanWasteRecycleCompany.createByEntity(wasteRecycleCom);
        return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, data);
    }
    
    /**
     * 更新餐厨垃圾回收单位
     * @param dtoCleanWasteRecycleCompany
     * @param deleteAttIds
     * @param request
     * @return 
     */
    @RequestMapping(value = "/clean/updateCleanWasteRecycleCom", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult updateCleanWasteRecycleCom( @RequestBody DTOCleanWasteRecycleCompany dtoCleanWasteRecycleCompany){
        if(dtoCleanWasteRecycleCompany.getId()==null){
        	throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
        }
        CleanWasteRecycleCom wasteRecycleCom = cleanService.getCleanWasteRecycleComById(dtoCleanWasteRecycleCompany.getId());
        if(wasteRecycleCom==null){
            throw FoodException.returnException("000003");
        }
        
        wasteRecycleCom = DTOCleanWasteRecycleCompany.toEntity(wasteRecycleCom, dtoCleanWasteRecycleCompany, wasteRecycleCom.getCompany());
        cleanService.updateCleanWasteRecycleCom(wasteRecycleCom);
        return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, wasteRecycleCom.getId());
    }
    

    /**
     * 获取废弃油脂回收单位
     *10.19 回收单位只维护一个 若返回空提示用户新增
     * @return
     */
    @RequestMapping(value = "/listCompanyOilRecycle", method = RequestMethod.GET)
    @ResponseBody
    public CommonStatusResult listCompanyOilRecycle() {
        int comId = getLoginCompanyId();
        QueryResult<CleanOilRecycleCom> resultData = cleanService.queryCleanOilRecycleComByCompanyId(comId, 1, null, -1, -1);
        DTORecycleCompany cleanOilRecycleCom =null;
        if (resultData != null && resultData.getResultList().size()>0) {     
      cleanOilRecycleCom = DTORecycleCompany.createByEntity(resultData.getResultList().get(0));
  
    }
        return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, cleanOilRecycleCom);
    }
    

    
    /**
     * 获取废弃油脂注册单位列表
     * @param pageNo
     * @param pageSize
     * @return 
     */
    @RequestMapping(value = "/clean/queryOilCleanCompany/{pageNo}/{pageSize}", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult queryOilCleanCompany(@PathVariable int pageNo, @PathVariable int pageSize){
        QueryResult<DTOOilCleanCompanyListData> result = null;
        QueryResult<OilCleanCompany> qr = cleanService.searchOilCleanCompany(null, pageNo, pageSize);
        if(qr!=null && qr.getResultList().size()>0){
            List<DTOOilCleanCompanyListData> list = DTOOilCleanCompanyListData.createListByEntities(qr.getResultList());
            result = new QueryResult<>(list, qr.getTotalRecord(), qr.getCurrPageNo(), qr.getPageSize());
        }else{
            result = new QueryResult<>(new ArrayList<DTOOilCleanCompanyListData>(), 0l, pageNo, pageSize);
        }
        return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, result);
    }
   /**
    * 根据id获取废弃油脂注册单位信息
    * @param pageNo
    * @param pageSize
    * @return 
    */
   @RequestMapping(value = "/clean/queryOilCleanCompanyById/{id}", method = RequestMethod.GET)
   @ResponseBody
   public CommonStatusResult queryOilCleanCompanyById(@PathVariable int id){
       OilCleanCompany qr = cleanService.getOilCleanCompanyById(id);
          DTOOilCleanCompanyListData dto = DTOOilCleanCompanyListData.createByEntity(qr);
       return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, dto);
   }
   
    
    

    /**
     * 删除废弃油脂回收单位
     * @param dtoCleanOilRecycleCompany
     * @param request
     * @return 
     */
    @RequestMapping(value = "/clean/deleteCleanOilRecycleCom/{cleanOilRecycleComId}", method = RequestMethod.GET)
    @ResponseBody
    public CommonStatusResult deleteCleanOilRecycleCom(@PathVariable int cleanOilRecycleComId){
         cleanService.disableCleanOilRecycleCom(cleanOilRecycleComId);

        return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, null);
    }
    
    
    
    /**
     * 新建废弃油脂回收单位
     * @param dtoCleanOilRecycleCompany
     * @param request
     * @return 
     */
    @RequestMapping(value = "/clean/createCleanOilRecycleCom", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult createCleanOilRecycleCom(@RequestBody DTOCleanOilRecycleCompany dtoCleanOilRecycleCompany){
        int comId = getLoginCompanyId();
        Company company = companyService.getCompanyById(comId);
        if(company==null){
            throw FoodException.returnException("000011");
        }
        if(dtoCleanOilRecycleCompany.getOilCleanCompanyId()==null || dtoCleanOilRecycleCompany.getOilCleanCompanyId() < 1){
            throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
        }
        OilCleanCompany oilCleanCompany = cleanService.getOilCleanCompanyById(dtoCleanOilRecycleCompany.getOilCleanCompanyId());
        if(oilCleanCompany==null){
            throw FoodException.returnException("000003");
        }
        
        CleanOilRecycleCom oilRecycleCom = DTOCleanOilRecycleCompany.toEntity(null, dtoCleanOilRecycleCompany, company, oilCleanCompany);
        oilRecycleCom = cleanService.createCleanOilRecycleCom(oilRecycleCom);

        return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, oilRecycleCom.getId());
    }
    
    /**
     * 更新废弃油脂回收单位
     * @param dtoCleanOilRecycleCompany
     * @param deleteAttIds
     * @param request
     * @return 
     */
    @RequestMapping(value = "/clean/updateCleanOilRecycleCom", method = RequestMethod.POST)
    @ResponseBody
    public CommonStatusResult updateCleanOilRecycleCom(@RequestBody DTOCleanOilRecycleCompany dtoCleanOilRecycleCompany, HttpServletRequest request){
        if(dtoCleanOilRecycleCompany.getId()==null){
        	throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
        }
        CleanOilRecycleCom cleanOilRecycleCom = cleanService.getCleanOilRecycleComById(dtoCleanOilRecycleCompany.getId());
        if(cleanOilRecycleCom==null){
            throw FoodException.returnException("000003");
        }
        
        OilCleanCompany oilCleanCompany = null;
        if(dtoCleanOilRecycleCompany.getOilCleanCompanyId()!=null && dtoCleanOilRecycleCompany.getOilCleanCompanyId() > 0){
            oilCleanCompany = cleanService.getOilCleanCompanyById(dtoCleanOilRecycleCompany.getOilCleanCompanyId());
            if(oilCleanCompany==null){
                throw FoodException.returnException("000003");
            }
        }
        
        cleanOilRecycleCom = DTOCleanOilRecycleCompany.toEntity(cleanOilRecycleCom, dtoCleanOilRecycleCompany, cleanOilRecycleCom.getCompany(), oilCleanCompany);
        cleanService.updateCleanOilRecycleCom(cleanOilRecycleCom);

        return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, cleanOilRecycleCom.getId());
    }
    
    /**
     * 根据ID查询废弃油脂回收单位
     * @param id
     * @return 
     */
    @RequestMapping(value = "/clean/getCleanOilRecycleComById/{id}", method = RequestMethod.GET)
    @ResponseBody
    public CommonStatusResult getCleanOilRecycleComById(@PathVariable Integer id){
        CleanOilRecycleCom cleanOilRecycleCom = cleanService.getCleanOilRecycleComById(id);
        if(cleanOilRecycleCom==null){
            throw FoodException.returnException("000003");
        }

        DTOCleanOilRecycleCompanyViewData data = DTOCleanOilRecycleCompanyViewData.createByEntity(cleanOilRecycleCom);
        return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, data);
    }


    
}
