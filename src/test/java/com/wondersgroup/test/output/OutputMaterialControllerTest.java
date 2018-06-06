package com.wondersgroup.test.output;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

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

import com.wondersgroup.operation.output.model.DTOOutputMaterialCreate;
import com.wondersgroup.operation.output.model.DTOOutputMaterialUpdate;
import com.wondersgroup.test.util.BaseTest;


@RunWith(SpringJUnit4ClassRunner.class)  
@WebAppConfiguration(value = "src/main/webapp")  
@ContextHierarchy({  
        @ContextConfiguration(name = "parent", locations = "classpath:application-servlet-test.xml"),  
        @ContextConfiguration(name = "child", locations = {"classpath:mvc-config-test.xml","classpath:application-security-test.xml"})  
})  
public class OutputMaterialControllerTest extends BaseTest {
	
	private static final String URL_CREATE = "/outputManage/outputMaterial/createOutputMaterial";
	private static final String URL_QUERY = "/outputManage/outputMaterial/queryOutputMaterials/{pageNo}/{pageSize}";
	private static final String URL_UPDATE = "/outputManage/outputMaterial/updateOutputMaterial";
	private static final String URL_QUERY_ByName = "/outputManage/outputMaterial/queryOutputMaterialsByName/{pageNo}/{pageSize}";
	private static final String URL_GET_BY_ID = "/outputManage/outputMaterial/getOutputMaterialById/{id}";
	
	
	@Test
	public void createOutputMaterial() throws Exception {
		String outMatName = "大豆";
		String manufacture = "某工厂B";
		String productionBarcode = "XXXXX2323_PB";
		String spec = "千克";
		
		DTOOutputMaterialCreate dto = new DTOOutputMaterialCreate();
		dto.setName(outMatName);
		int typeGeneral = 9020;
		dto.setTypeGeneral(typeGeneral);
		dto.setManufacture(manufacture);
		dto.setProductionBarcode(productionBarcode);
		dto.setSpec(spec);
		
		MvcResult result = mockMvc
				.perform(post(URL_CREATE)
						.session(session)
						.contentType(MediaType.APPLICATION_JSON)
						.content(om.writeValueAsString(dto)))
				.andDo(MockMvcResultHandlers.print())
				.andExpect(jsonPath("$.body.name").value(outMatName))
				.andExpect(jsonPath("$.body.manufacture").value(manufacture))
				.andReturn();
		printResult(result);
	}
	
	@Test
	public void updateOutputMaterial() throws Exception {
		DTOOutputMaterialUpdate dto = new DTOOutputMaterialUpdate();
		int outputMaterialId = 1787;
		dto.setId(outputMaterialId);
		dto.setName("大豆");
		dto.setTypeGeneral(9020);
		dto.setSpec("test");
		MvcResult result = mockMvc
				.perform(post(URL_UPDATE)
						.session(session)
						.contentType(MediaType.APPLICATION_JSON)
						.content(om.writeValueAsString(dto)))
				.andExpect(jsonPath("$.body").value(outputMaterialId))
				.andDo(MockMvcResultHandlers.print())
				.andReturn();
		printResult(result);
	}
	
	@Test
	public void queryOutputMaterials() throws Exception{
		Map params = new HashMap();
		
		MvcResult result = mockMvc
				.perform(post(URL_QUERY,-1,-1)
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
	public void queryOutputMaterialsByName() throws Exception{
		Map params = new HashMap();
		MvcResult result = mockMvc
				.perform(post(URL_QUERY_ByName,-1,-1)
						.session(session)
						.contentType(MediaType.APPLICATION_JSON)
						.content(om.writeValueAsString(params))
						)
				.andExpect(status().isOk())
				.andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON))
				.andDo(MockMvcResultHandlers.print())
				.andReturn();
		printResult(result);
	}
	
	@Test
	public void getOutputMaterialById() throws Exception {
		Integer outputMaterialId = 896;
		MvcResult result = mockMvc
				.perform(get(URL_GET_BY_ID,outputMaterialId )
						.session(session))
				.andDo(MockMvcResultHandlers.print())
				.andExpect(jsonPath("$.body.id").value(outputMaterialId))
				.andReturn();
		printResult(result);
	}
}
