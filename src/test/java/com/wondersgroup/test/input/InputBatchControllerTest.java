package com.wondersgroup.test.input;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;

import com.wondersgroup.operation.input.model.DTOInputBatchCreate;
import com.wondersgroup.operation.input.model.DTOInputBatchUpdate;
import com.wondersgroup.test.util.BaseTest;
import com.wondersgroup.util.TimeOrDateUtils;


@RunWith(SpringJUnit4ClassRunner.class)  
@WebAppConfiguration(value = "src/main/webapp")  
@ContextHierarchy({  
        @ContextConfiguration(name = "parent", locations = "classpath:application-servlet-test.xml"),  
        @ContextConfiguration(name = "child", locations = {"classpath:mvc-config-test.xml","classpath:application-security-test.xml"})  
})  
public class InputBatchControllerTest extends BaseTest {
	
	private static final String URL_CREATE = "/inputManage/inputBatch/createInputBatch";
	private static final String URL_QUERY = "/inputManage/inputBatch/queryInputBatchs/{pageNo}/{pageSize}";
	private static final String URL_UPDATE = "/inputManage/inputBatch/updateInputBatch";
	private static final String URL_GET_BY_ID = "/inputManage/inputBatch/getInputBatchById/{id}";
	private static final String URL_QUERY_AUTORECEIVE = "/inputManage/inputBatch/queryAutoReceive/{pageNo}/{pageSize}";
	
	

	@Test
	public void createInputBatch() throws Exception {
		Date inputDate = new Date();
		Integer inputMatId = 10241;
		String manufacture = "生产单位A";
		String productionBatch = "XXXXXXXXX_PB";
		Date productionDate = TimeOrDateUtils.parseDate("2015-06-21", TimeOrDateUtils.FULL_YMD);
		String spec = "斤";
		Integer supplierId = 10019;
		
		
		
		DTOInputBatchCreate dto = new DTOInputBatchCreate();
		dto.setInputDate(inputDate);
		dto.setInputMatId(inputMatId);
		dto.setManufacture(manufacture);
		dto.setProductionBatch(productionBatch );
		dto.setProductionDate(productionDate);
		dto.setQuantity(new BigDecimal(5));
		dto.setSpec(spec);
		dto.setSupplierId(supplierId );
		
		
		
		MvcResult result = mockMvc
				.perform(post(URL_CREATE)
						.session(session)
						.contentType(MediaType.APPLICATION_JSON)
						.content(om.writeValueAsString(Arrays.asList(dto,dto))))
				.andDo(MockMvcResultHandlers.print())
				.andExpect(jsonPath("$.status").exists())
				.andExpect(jsonPath("$.body[1].supplierId").value(supplierId))
				.andReturn();
		printResult(result);
	}
	
	
	@Test
	public void updateInputBatch() throws Exception {
		Date inputDate = new Date();
		String id = "f33d257121124a2e9e1ecdc75df5f0f7";
		Integer inputMatId = 10241;
		String manufacture = "生产单位A";
		String productionBatch = "XXXXXXXXX_PB";
		Date productionDate = TimeOrDateUtils.parseDate("2015-06-21", TimeOrDateUtils.FULL_YMD);
		String spec = "斤";
		Integer supplierId = 10019;
		
		
		
		DTOInputBatchUpdate dto = new DTOInputBatchUpdate();
		dto.setId(id);
		dto.setInputDate(inputDate);
		dto.setProductionBatch(productionBatch );
		dto.setProductionDate(productionDate);
		dto.setQuantity(new BigDecimal(5));
		dto.setSupplierId(supplierId );
		
		MvcResult result = mockMvc
				.perform(post(URL_UPDATE)
						.session(session)
						.contentType(MediaType.APPLICATION_JSON)
						.content(om.writeValueAsString(dto)))
				.andDo(MockMvcResultHandlers.print())
				.andExpect(jsonPath("$.status").exists())
				.andExpect(jsonPath("$.body.id").value(id))
				.andExpect(jsonPath("$.body.supplierId").value(supplierId))
				.andReturn();
		printResult(result);
	}
	
	
	
	@Test
	public void queryInputBatchs() throws Exception{
		String inputDate = "2015-01-05";
		String materialName = "水";
		String supplierName = "加工";
		
		Map params = new HashMap();
		params.put("inputDate", inputDate);
		params.put("materialName", materialName);
		params.put("supplierName", supplierName);
		
		
		
		MvcResult result = mockMvc
				.perform(post(URL_QUERY_AUTORECEIVE,1,10)
						.session(session)
						.contentType(MediaType.APPLICATION_JSON)
						.content(om.writeValueAsString(params))
						)
				.andExpect(status().isOk())
				.andDo(MockMvcResultHandlers.print())
				.andReturn();
		printResult(result);
	}
	
	@Test
	public void queryAutoReceive() throws Exception{
		String inputDate = "2015-01-05";
		String outputMatName = "蜇";
		String supplierName = "丰收日";
		
		Map params = new HashMap();
//		params.put("inputDate", inputDate);
//		params.put("outputMatName", outputMatName);
//		params.put("supplierName", supplierName);
		
		
		
		MvcResult result = mockMvc
				.perform(post(URL_QUERY_AUTORECEIVE,1,10)
						.session(session)
						.contentType(MediaType.APPLICATION_JSON)
						.content(om.writeValueAsString(params))
						)
				.andExpect(status().isOk())
				.andDo(MockMvcResultHandlers.print())
				.andReturn();
		printResult(result);
	}
	
	@Test
	public void getInputBatchById() throws Exception {
		String inputBatchlId = "9975a52e00444991b215d003cbb69ad6";
		MvcResult result = mockMvc
				.perform(get(URL_GET_BY_ID,inputBatchlId )
						.session(session))
				.andDo(MockMvcResultHandlers.print())
				.andExpect(jsonPath("$.body.id").value(inputBatchlId))
				.andReturn();
		printResult(result);
	}
}
