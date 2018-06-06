package com.wondersgroup.operation.util;

import java.io.IOException;
import java.util.Dictionary;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.filter.GenericFilterBean;

import com.wondersgroup.framework.support.FoodException;

public class refererFilter extends GenericFilterBean {
	public static String LOGIN_PATH = "j_spring_security_check";
	public static String JSESSIONID_KEY = "JSESSIONID";

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		if (req instanceof HttpServletRequest) {
			HttpServletRequest request = (HttpServletRequest) req;
			String requestURL = request.getRequestURL().toString();
			if (requestURL.contains("j_spring_security_check")) {
//				//  验证 cookie
//				Cookie[] cookies = request.getCookies();
//				if (ArrayUtils.isEmpty(cookies)) {
//					throw FoodException.returnException("Empty cookie!");
//				} else {
//					Map<String, String> m = new HashMap<>();
//					for (Cookie cookie : cookies) {
//						String cvalue = cookie.getValue();
//						if (StringUtils.isNotBlank(cvalue)) {
//							String cname = cookie.getName();
//							m.put(cname, cvalue);
//						}
//					}
//					if (!m.keySet().contains(JSESSIONID_KEY)) {
//						throw FoodException.returnException("Empty cookie!");
//					}
//				}
				//验证 referer
				String refererString = request.getHeader("Referer");
				if (StringUtils.isNotBlank(refererString)) {
					String refHostAndPort;
					String hostAndPort;
					try {
						refHostAndPort = getHostAndPort(refererString);
						hostAndPort = getHostAndPort(requestURL);
					} catch (Exception e) {
						throw FoodException.returnException("Referer error!");
					}
					if (!StringUtils.equals(refHostAndPort, hostAndPort)) {
						throw FoodException.returnException("Referer error!");
					}
				} else {
					throw FoodException.returnException("Referer error!");
				}
			}
		}
		chain.doFilter(req, res);
	}

	private String getHostAndPort(String url) throws Exception {
		if (StringUtils.isEmpty(url)) {
			return url;
		}
		String oldString = url.split("\\/\\/")[1].split("\\/")[0];
		return oldString;
	}
}
