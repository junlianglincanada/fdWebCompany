package com.wondersgroup.test.input;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
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

import com.wondersgroup.operation.input.model.DTOInputMaterialCreate;
import com.wondersgroup.operation.input.model.DTOInputMaterialUpdate;
import com.wondersgroup.test.util.BaseTest;


@RunWith(SpringJUnit4ClassRunner.class)  
@WebAppConfiguration(value = "src/main/webapp")  
@ContextHierarchy({  
        @ContextConfiguration(name = "parent", locations = "classpath:application-servlet-test.xml"),  
        @ContextConfiguration(name = "child", locations = {"classpath:mvc-config-test.xml","classpath:application-security-test.xml"})  
})  
public class InputMaterialControllerTest extends BaseTest {
	
	private static final String URL_CREATE = "/inputManage/inputMaterial/createInputMaterial";
	private static final String URL_QUERY = "/inputManage/inputMaterial/queryInputMaterials/{pageNo}/{pageSize}";
	private static final String URL_UPDATE = "/inputManage/inputMaterial/updateInputMaterial";
	private static final String URL_QUERY_ByName = "/inputManage/inputMaterial/queryInputMaterialsByName/{pageNo}/{pageSize}";
	private static final String URL_GET_BY_ID = "/inputManage/inputMaterial/getInputMaterialById/{id}";

	@Test
	public void createInputMaterial() throws Exception {
		DTOInputMaterialCreate dto = new DTOInputMaterialCreate();
		dto.setName("大豆");
		dto.setTypeGeneral(9020);
		
		MvcResult result = mockMvc
				.perform(post(URL_CREATE)
						.session(session)
						.contentType(MediaType.APPLICATION_JSON)
						.content(om.writeValueAsString(dto)))
				.andDo(MockMvcResultHandlers.print())
				.andReturn();
		printResult(result);
	}
	
	@Test
	public void updateInputMaterial() throws Exception {
		DTOInputMaterialUpdate dto = new DTOInputMaterialUpdate();
		dto.setId(1787);
		dto.setName("大豆");
		dto.setTypeGeneral(9020);
		
		
		MvcResult result = mockMvc
				.perform(post(URL_UPDATE)
						.session(session)
						.contentType(MediaType.APPLICATION_JSON)
						.content(om.writeValueAsString(dto)))
				.andDo(MockMvcResultHandlers.print())
				.andReturn();
		printResult(result);
	}
	
	@Test
	public void queryInputMaterials() throws Exception{
		Map params = new HashMap();
		
		MvcResult result = mockMvc
				.perform(post(URL_QUERY,-1,-1)
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
	public void queryInputMaterialsByName() throws Exception{
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
	public void getInputMaterialById() throws Exception {
		Integer inputMaterialId = 10008;
		MvcResult result = mockMvc
				.perform(get(URL_GET_BY_ID,inputMaterialId )
						.session(session))
				.andDo(MockMvcResultHandlers.print())
				.andExpect(jsonPath("$.body.id").value(inputMaterialId))
				.andReturn();
		printResult(result);
	}
}
