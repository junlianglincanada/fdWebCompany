package com.wondersgroup.test.output;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
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

import com.wondersgroup.operation.output.model.DTOReceiverCreate;
import com.wondersgroup.operation.output.model.DTOReceiverUpdate;
import com.wondersgroup.test.util.BaseTest;


@RunWith(SpringJUnit4ClassRunner.class)  
@WebAppConfiguration(value = "src/main/webapp")  
@ContextHierarchy({  
        @ContextConfiguration(name = "parent", locations = "classpath:application-servlet-test.xml"),  
        @ContextConfiguration(name = "child", locations = {"classpath:mvc-config-test.xml","classpath:application-security-test.xml"})  
})  
public class ReceiverControllerTest extends BaseTest {
	
	private static final String URL_CREATE_RECEIVER = "/inputManage/receiver/createReceiver";
	private static final String URL_UPDATE_RECEIVER = "/inputManage/receiver/updateReceiver";
	private static final String URL_DELETE_RECEIVER = "/inputManage/receiver/deleteReceiver/{receiverId}";
	private static final String URL_GET_RECEIVER = "/inputManage/receiver/getReceiverById/{receiverId}";
	private static final String URL_QUERY_RECEIVER = "/inputManage/receiver/queryReceivers/{pageNo}/{pageSize}";

	@Test
	public void createReceiver() throws Exception {
		DTOReceiverCreate dto = new DTOReceiverCreate();
		dto.setName("丰收日");
		dto.setContactAddress("上海");
		
		MvcResult result = mockMvc
				.perform(post(URL_CREATE_RECEIVER)
						.session(session)
						.contentType(MediaType.APPLICATION_JSON)
						.content(om.writeValueAsString(dto)))
				.andDo(MockMvcResultHandlers.print())
				.andExpect(status().isOk())
				.andExpect(jsonPath("status").exists())
				.andExpect(jsonPath("body.id").exists())
				.andExpect(jsonPath("body.name").exists())
				.andReturn();
		printResult(result);
	}
	
	@Test
	public void updateReceiver() throws Exception {
		DTOReceiverUpdate dto = new DTOReceiverUpdate();
		int receiverId = 1001;
		dto.setId(receiverId);
		String _name = "供应商A";
		String _contactAddress = "上海";
		dto.setName(_name);
		dto.setContactAddress(_contactAddress);
		
		MvcResult result = mockMvc
				.perform(post(URL_UPDATE_RECEIVER)
						.session(session)
						.contentType(MediaType.APPLICATION_JSON)
						.content(om.writeValueAsString(dto)))
				.andDo(MockMvcResultHandlers.print())
				.andExpect(status().isOk())
				.andExpect(jsonPath("status").exists())
				.andExpect(jsonPath("body.id").value(receiverId))
				.andExpect(jsonPath("body.name").value(_name))
				.andExpect(jsonPath("body.contactAddress").value(_contactAddress))
				.andReturn();
		printResult(result);
	}
	
	@Test
	public void deleteReceiver() throws Exception {
		int receiverId = 1001;
		MvcResult result = mockMvc
				.perform(post(URL_DELETE_RECEIVER,receiverId)
						.session(session)
						)
				.andDo(MockMvcResultHandlers.print())
				.andExpect(status().isOk())
				.andReturn();
		printResult(result);
	}
	
	@Test
	public void getReceiverById() throws Exception {
		int receiverId = 1001;
		MvcResult result = mockMvc
				.perform(get(URL_GET_RECEIVER,receiverId)
						.session(session)
						)
				.andDo(MockMvcResultHandlers.print())
				.andExpect(status().isOk())
				.andExpect(jsonPath("status").exists())
				.andExpect(jsonPath("body.id").value(receiverId))
				.andReturn();
		printResult(result);
	}
	
	
	@Test
	public void queryReceivers() throws Exception{
		Map params = new HashMap();
		
		MvcResult result = mockMvc
				.perform(post(URL_QUERY_RECEIVER,1,8)
						.session(session)
						.contentType(MediaType.APPLICATION_JSON)
						.content(om.writeValueAsString(params))
						)
				.andDo(MockMvcResultHandlers.print())
				.andExpect(status().isOk())
				.andExpect(jsonPath("status").exists())
				.andReturn();
		printResult(result);
	}
}
