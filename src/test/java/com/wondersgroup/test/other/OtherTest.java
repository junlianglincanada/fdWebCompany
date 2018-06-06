package com.wondersgroup.test.other;

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
public class OtherTest extends BaseTest {
	
	private static final String URL_getStatistics = "/getStatistics";
	
	@Test
	public void getStatistics() throws Exception {
		MvcResult result = mockMvc
				.perform(get(URL_getStatistics)
						.session(session))
				.andDo(MockMvcResultHandlers.print())
				.andReturn();
		printResult(result);
	}
}
