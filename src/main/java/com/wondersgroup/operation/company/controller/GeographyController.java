package com.wondersgroup.operation.company.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wondersgroup.data.jpa.entity.Restaurant;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.service.company.RestaurantService;

@Controller
@RequestMapping("/geography")
public class GeographyController extends AbstractBaseController{

	@Autowired
    private RestaurantService restaurantService;
	
	/**
	 * @param addr
	 *            查询的地址
	 * @return
	 */
	public JSONObject getCoordinate(String addr) {
		String address = null;
		JSONObject obj = new JSONObject();
		try {
			address = java.net.URLEncoder.encode(addr, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		String key = "389880a06e3f893ea46036f030c94700";
		String url = String
				.format("http://restapi.amap.com/v3/geocode/geo?key=%s&s=rsv3&city=021&address=%s",
						key,address);
		URL myURL = null;
		URLConnection httpsConn = null;
		try {
			myURL = new URL(url);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
		try {
			httpsConn = (URLConnection) myURL.openConnection();// 不使用代理
			if (httpsConn != null) {
				InputStreamReader insr = new InputStreamReader(
						httpsConn.getInputStream(), "UTF-8");
				BufferedReader br = new BufferedReader(insr);
				String data = null;
				StringBuilder result = new StringBuilder();
				while ((data = br.readLine()) != null) {
					result.append(data.trim());
				}
				obj = JSONObject.fromObject(result.toString());
				insr.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return obj;
	}
	
	@RequestMapping(value = "/updateGis", method = RequestMethod.POST)
    @ResponseBody
	public CommonStatusResult updateGis() throws IOException{
		List<Map> list=restaurantService.getAddressForGis();
		if(list!=null && list.size()>0){
			for(Map map:list){
				int companyId=Integer.valueOf(map.get("COMPANY_ID").toString());
				String address=(String) map.get("COMPANY_ADDRESS");
				JSONObject obj = (JSONObject) getCoordinate(address);
				JSONArray geocodes = obj.getJSONArray("geocodes");
				if(geocodes.size()>0){
					JSONObject trueAddress = geocodes.getJSONObject(0);
					String location = trueAddress.getString("location");
					String lngX = location.split(",")[0];
					String latY = location.split(",")[1];
					Restaurant restaurant=restaurantService.getRestaurantById(companyId);
					restaurant.setGisLongitude(lngX);
					restaurant.setGisLatitude(latY);
					restaurantService.updateRestaurant(restaurant);
				}
			}
		}
		return CommonStatusResult.success("success", list);
	}
}
