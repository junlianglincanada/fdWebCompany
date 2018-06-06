package com.wondersgroup.operation.common.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wondersgroup.data.jpa.entity.MainMenu;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.operation.common.model.DTOMainMenu;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.service.menu.MenuService;

@Controller
@RequestMapping("/menu")
public class MainMenuController extends AbstractBaseController{
	private static final Logger logger = LoggerFactory.getLogger(MainMenuController.class);
	
	@Autowired
	private MenuService menuService;
    
	/**
	 * ,获取导航栏信息
	 * @return
	 */
	 @RequestMapping(value = "/getMainMenu", method = RequestMethod.GET)
	 @ResponseBody
	 public CommonStatusResult getMainMenu(){
		List<DTOMainMenu> newList = null;
	    List<MainMenu> resultList = menuService.getMainMenu();
	    if (resultList != null){
	    	newList = DTOMainMenu.createListByEntities(resultList);
	    }
		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS,newList);
	 }
}
