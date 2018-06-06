package com.wondersgroup.operation.common.controller;

import java.util.List;
import java.util.TreeMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.wondersgroup.data.jpa.entity.GeoAdminRegion;
import com.wondersgroup.framework.common.GeoAdminRegionService;

@Controller
@RequestMapping("/base/getAdminRegion")
public class GeoAdminRegionController {
	private static Logger LOGGER = LoggerFactory.getLogger(GeoAdminRegionController.class);

	
	@Autowired
    private GeoAdminRegionService geoAdminRegionService;
	
	@ResponseBody
	@ResponseStatus(HttpStatus.OK)
	@RequestMapping(value="/map/{parentId}",method = RequestMethod.GET)
	public TreeMap<GeoAdminRegion, List<GeoAdminRegion>> getGeoAdminRegionMapByParentId(@PathVariable int parentId){
		return this.geoAdminRegionService.getTreeByParentId(parentId);
	}

	@ResponseBody
	@ResponseStatus(HttpStatus.OK)
	@RequestMapping(value="/",method = RequestMethod.GET)
		public TreeMap<String, List<String>> getGeoAdminRegion(){
		return geoAdminRegionService.getGeoRegion();
	}
	
	@ResponseBody
	@ResponseStatus(HttpStatus.OK)
	@RequestMapping(value="/{parentId}",method = RequestMethod.GET)
	public List<GeoAdminRegion> getGeoAdminRegionByParentId(@PathVariable int parentId){
		return this.geoAdminRegionService.getGeoAdminRegionByParentId(parentId);
	}
	
	@ResponseBody
	@ResponseStatus(HttpStatus.OK)
	@RequestMapping(value="/getRegionById/{regionId}",method = RequestMethod.GET)
	public GeoAdminRegion getDetailById(@PathVariable int regionId){
		return this.geoAdminRegionService.getGeoAdminRegionById(regionId);
	}
	
	@ResponseBody
	@ResponseStatus(HttpStatus.OK)
	@RequestMapping(value="/getByLevel/{level}",method = RequestMethod.GET)
	public List<GeoAdminRegion> getByLevel(@PathVariable int level){
		return this.geoAdminRegionService.getGeoAdminRegionByLevel(level);
	}
}
