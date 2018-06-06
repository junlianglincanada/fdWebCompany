package com.wondersgroup.test.input;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;

import com.wondersgroup.operation.input.model.DTOSupplierCreate;
import com.wondersgroup.operation.input.model.DTOSupplierUpdate;
import com.wondersgroup.service.company.InternalCompanyService;
import com.wondersgroup.test.util.BaseTest;


@RunWith(SpringJUnit4ClassRunner.class)  
@WebAppConfiguration(value = "src/main/webapp")  
@ContextHierarchy({  
        @ContextConfiguration(name = "parent", locations = "classpath:application-servlet-test.xml"),  
        @ContextConfiguration(name = "child", locations = {"classpath:mvc-config-test.xml","classpath:application-security-test.xml"})  
})  
public class SupplierControllerTest extends BaseTest {
	
	

	
	private static final String URL_CREATE_SUPPLIER = "/inputManage/supplier/createSupplier";
	private static final String URL_UPDATE_SUPPLIER = "/inputManage/supplier/updateSupplier";
	private static final String URL_DELETE_SUPPLIER = "/inputManage/supplier/deleteSupplier/{supplierId}";
	private static final String URL_GET_SUPPLIER = "/inputManage/supplier/getSupplierById/{supplierId}";
	private static final String URL_QUERY_SUPPLIER = "/inputManage/supplier/querySuppliers/{pageNo}/{pageSize}";

	@Test
	public void createSupplier() throws Exception {
		DTOSupplierCreate dto = new DTOSupplierCreate();
		dto.setName("供应商A");
		dto.setContactAddress("上海");
		
		MvcResult result = mockMvc
				.perform(post(URL_CREATE_SUPPLIER)
						.session(session)
						.contentType(MediaType.APPLICATION_JSON)
						.content(om.writeValueAsString(dto)))
				.andDo(MockMvcResultHandlers.print())
				.andExpect(jsonPath("status").exists())
				.andExpect(jsonPath("body.id").exists())
				.andExpect(jsonPath("body.name").exists())
				.andReturn();
		printResult(result);
	}
	
	@Test
	public void updateSupplier() throws Exception {
		DTOSupplierUpdate dto = new DTOSupplierUpdate();
		int supplierId = 1001;
		dto.setId(supplierId);
		String _name = "供应商A";
		String _contactAddress = "上海";
		dto.setName(_name);
		dto.setContactAddress(_contactAddress);
		
		MvcResult result = mockMvc
				.perform(post(URL_UPDATE_SUPPLIER)
						.session(session)
						.contentType(MediaType.APPLICATION_JSON)
						.content(om.writeValueAsString(dto)))
				.andDo(MockMvcResultHandlers.print())
				.andExpect(jsonPath("status").exists())
				.andExpect(jsonPath("body.id").value(supplierId))
				.andExpect(jsonPath("body.name").value(_name))
				.andExpect(jsonPath("body.contactAddress").value(_contactAddress))
				.andReturn();
		printResult(result);
	}
	
	@Test
	public void deleteSupplier() throws Exception {
		int supplierId = 1001;
		MvcResult result = mockMvc
				.perform(post(URL_DELETE_SUPPLIER,supplierId)
						.session(session)
						)
				.andDo(MockMvcResultHandlers.print())
				.andExpect(status().isOk())
//				.andExpect()
				.andReturn();
		printResult(result);
	}
	
	@Test
	public void getSupplierById() throws Exception {
		int supplierId = 1001;
		MvcResult result = mockMvc
				.perform(get(URL_GET_SUPPLIER,supplierId)
						.session(session)
						)
				.andDo(MockMvcResultHandlers.print())
				.andExpect(status().isOk())
				.andExpect(jsonPath("status").exists())
				.andExpect(jsonPath("body.id").value(supplierId))
				.andReturn();
		printResult(result);
	}
	
	
	@Test
	public void querySuppliers() throws Exception{
		Map params = new HashMap();
		
		MvcResult result = mockMvc
				.perform(post(URL_QUERY_SUPPLIER,1,8)
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
	
	
	
	@Test
	public void searchIntCompanyInclusiveAndExlusive(){
		
		
	}
}
