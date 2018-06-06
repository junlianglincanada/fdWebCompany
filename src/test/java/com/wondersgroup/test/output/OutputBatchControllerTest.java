package com.wondersgroup.test.output;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.fileUpload;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.io.FileInputStream;
import java.math.BigDecimal;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;

import com.wondersgroup.operation.output.model.DTOOutputBatchCreate;
import com.wondersgroup.operation.output.model.DTOOutputBatchUpdate;
import com.wondersgroup.test.util.BaseTest;
import com.wondersgroup.util.TimeOrDateUtils;


@RunWith(SpringJUnit4ClassRunner.class)  
@WebAppConfiguration(value = "src/main/webapp")  
@ContextHierarchy({  
        @ContextConfiguration(name = "parent", locations = "classpath:application-servlet-test.xml"),  
        @ContextConfiguration(name = "child", locations = {"classpath:mvc-config-test.xml","classpath:application-security-test.xml"})  
})  
public class OutputBatchControllerTest extends BaseTest {
	
	private static final String URL_CREATE = "/outputManage/outputBatch/createOutputBatch";
	private static final String URL_QUERY = "/outputManage/outputBatch/queryOutputBatchs/{pageNo}/{pageSize}";
	private static final String URL_UPDATE = "/outputManage/outputBatch/updateOutputBatch";
	private static final String URL_GET_BY_ID = "/outputManage/outputBatch/getOutputBatchById/{id}";
	private static final String URL_IMPORT = "/outputManage/outputBatch/importOutputBatch";
	
	

	@Test
	public void createOutputBatch() throws Exception {
		Date outputDate = new Date();
		Integer outputMatId = 1599;
		String manufacture = "生产单位A";
		String productionBatch = "XXXXXXXXX_PB";
		Date productionDate = TimeOrDateUtils.parseDate("2015-06-21", TimeOrDateUtils.FULL_YMD);
		String spec = "斤";
		Integer receiverId = 10486;
		
		
		
		DTOOutputBatchCreate dto = new DTOOutputBatchCreate();
		dto.setOutputDate(outputDate);
		dto.setOutputMatId(outputMatId);
		dto.setManufacture(manufacture);
		dto.setProductionBatch(productionBatch );
		dto.setProductionDate(productionDate);
		dto.setQuantity(new BigDecimal(5));
		dto.setSpec(spec);
//		dto.setReceiverId(receiverId );
		
		MvcResult result = mockMvc
				.perform(post(URL_CREATE)
						.session(session)
						.contentType(MediaType.APPLICATION_JSON)
						.content(om.writeValueAsString(dto)))
				.andDo(MockMvcResultHandlers.print())
				.andExpect(jsonPath("$.status").exists())
				.andExpect(jsonPath("$.body.receiverId").value(receiverId))
				.andReturn();
		printResult(result);
	}
	
	@Test
	public void updateOutputBatch() throws Exception {
		Date outputDate = new Date();
		String id = "7584af6248a14575987f5a14fddc70c7";
//		Integer outputMatId = 10241;
//		String manufacture = "生产单位A";
		String productionBatch = "XXXXXXXXX_PB";
		Date productionDate = TimeOrDateUtils.parseDate("2015-06-21", TimeOrDateUtils.FULL_YMD);
//		String spec = "斤";
		Integer receiverId = 10019;
		
		
		
		DTOOutputBatchUpdate dto = new DTOOutputBatchUpdate();
		dto.setId(id);
		dto.setOutputDate(outputDate);
		dto.setProductionBatch(productionBatch );
		dto.setProductionDate(productionDate);
		dto.setQuantity(new BigDecimal(5));
		dto.setReceiverId(receiverId );
		
		MvcResult result = mockMvc
				.perform(post(URL_UPDATE)
						.session(session)
						.contentType(MediaType.APPLICATION_JSON)
						.content(om.writeValueAsString(dto)))
				.andDo(MockMvcResultHandlers.print())
				.andExpect(jsonPath("$.status").exists())
				.andExpect(jsonPath("$.body.id").value(id))
				.andExpect(jsonPath("$.body.receiverId").value(receiverId))
				.andReturn();
		printResult(result);
	}
	
	@Test
	public void queryOutputBatchs() throws Exception{
		String outputDate = "2015-05-24";
		String materialName = "米";
		String receiverName = "有";
		
		Map params = new HashMap();
		params.put("outputDate", outputDate);
		params.put("materialName", materialName);
		params.put("receiverName", receiverName);
		
		
		
		MvcResult result = mockMvc
				.perform(post(URL_QUERY,1,10)
						.session(session)
						.contentType(MediaType.APPLICATION_JSON)
						.content(om.writeValueAsString(params))
						)
				.andExpect(status().isOk())
				.andExpect(jsonPath("$.status").exists())
				.andDo(MockMvcResultHandlers.print())
				.andReturn();
		printResult(result);
	}
	
	
	@Test
	public void getOutputBatchById() throws Exception {
		String outputBatchlId = "44db058a3d354c87998cdef29d8e0061";
		MvcResult result = mockMvc
				.perform(get(URL_GET_BY_ID,outputBatchlId )
						.session(session))
				.andDo(MockMvcResultHandlers.print())
				.andExpect(jsonPath("$.body.id").value(outputBatchlId))
				.andReturn();
		printResult(result);
	}
	
	
	@Test
	public void importOutputBatch() throws Exception{
		 FileInputStream fis = new FileInputStream("c:\\upload\\1.xlsx");
//         MockMultipartFile multipartFile = new MockMultipartFile("1.xlsx", fis);
         
         
         MockMultipartFile firstFile = new MockMultipartFile("dd", "1.xlsx", "application/ms-excel", fis);
         
		 MvcResult result = mockMvc
				.perform(fileUpload(URL_IMPORT)
						.file(firstFile)
						.session(session)
						)
				.andDo(MockMvcResultHandlers.print())
				.andExpect(status().isOk())
				.andExpect(jsonPath("$.status").exists())
				.andReturn(); 
		printResult(result);
	}

}
