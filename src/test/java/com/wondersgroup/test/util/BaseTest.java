package com.wondersgroup.test.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.annotation.Resource;
import javax.naming.NamingException;

import org.junit.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.FilterChainProxy;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.wondersgroup.operation.util.security.UserService;



public class BaseTest extends AbstractTransactionalJUnit4SpringContextTests {
	private static final String USERNAME = "wgj";

	@Resource
	protected FilterChainProxy springSecurityFilterChain;
	
	@Autowired
	protected UserService userDetailsService;
	
	@Autowired
	protected WebApplicationContext wac;
	
	protected ObjectMapper om = new ObjectMapper();
	
	protected MockMvc mockMvc;

	protected UsernamePasswordAuthenticationToken principal;

	protected MockHttpSession session;
	
	protected UsernamePasswordAuthenticationToken getAuth(String username) {

        UserDetails user = userDetailsService.loadUserByUsername(username);

        UsernamePasswordAuthenticationToken authentication = 
                new UsernamePasswordAuthenticationToken(
                        user, 
                        user.getPassword(), 
                        user.getAuthorities());

        return authentication;
    }
	
	@Before
    public void setupMockMvc() throws NamingException {

        // setup mock MVC
        this.mockMvc = MockMvcBuilders
                .webAppContextSetup(this.wac)
                .addFilters(this.springSecurityFilterChain)
                .build();
        
        
        principal = getAuth(USERNAME);
		session = new MockHttpSession();
		session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, new MockSecurityContext(principal));
		
		
//		mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();
//		mockMvc = MockMvcBuilders.standaloneSetup(new InputMaterialController()).build();
    }
	
	
	protected void printResult(MvcResult result) throws UnsupportedEncodingException, IOException, JsonParseException, JsonMappingException, JsonProcessingException {
		String contentAsString = result.getResponse().getContentAsString();
		
		String responseJson = contentAsString;
		try {
			Object jsonObject = om.readValue(contentAsString, Object.class);	
			responseJson = om.writerWithDefaultPrettyPrinter().writeValueAsString(jsonObject);
		} catch (Exception e) {
		}
		
		System.out.println(responseJson);
	}


	public static class MockSecurityContext implements SecurityContext {
		private static final long serialVersionUID = -1386535243513362694L;
		private Authentication authentication;

		public MockSecurityContext(Authentication authentication) {
			this.authentication = authentication;
		}

		@Override
		public Authentication getAuthentication() {
			return this.authentication;
		}

		@Override
		public void setAuthentication(Authentication authentication) {
			this.authentication = authentication;
		}
	}

	
	
}
