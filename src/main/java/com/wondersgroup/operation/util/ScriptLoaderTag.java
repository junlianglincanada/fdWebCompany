package com.wondersgroup.operation.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.commons.lang.StringUtils;

public class ScriptLoaderTag extends SimpleTagSupport {
	
	private String proxyListString;
	private String classString;
	private boolean enableCkeditor=false;
	private boolean enableDateExt=false;
	
	public void doTag() throws JspException, IOException {
		PageContext pageContext = (PageContext) getJspContext();  
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		String webPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
		List<String> scriptList = new ArrayList<String>();
		String scriptHolder = "<script src=\"_\" type=\"text/javascript\"></script>";
		
		// add underscore
		String underscoreScript = scriptHolder.replace("_", webPath+"/js/underscore.js");
		scriptList.add(underscoreScript);
		
		//enable ckeditor
		if(enableCkeditor) {
			String ckeditorScript = scriptHolder.replace("_", webPath+"/js/ckeditor/ckeditor.js");
			scriptList.add(ckeditorScript);
		}
		
		//add miniuiHelper.js
		String miniuiScript = scriptHolder.replace("_", webPath+"/js/miniuiHelper.js");
		scriptList.add(miniuiScript);
		
		
		
		//add all proxy js
		if(!StringUtils.isEmpty(proxyListString)) {
			List<String> proxyList = Arrays.asList(proxyListString.split(","));
			for (int i = 0; i < proxyList.size(); i++) {
				String proxyName = proxyList.get(i);
				String proxyScript = scriptHolder.replace("_", webPath+"/js/proxy/"+proxyName+".js");
				scriptList.add(proxyScript);
			}
		}
		
		//add all class js
		if(!StringUtils.isEmpty(classString)) {
			List<String> classList = Arrays.asList(classString.split(","));
			for (int i = 0; i < classList.size(); i++) {
				String className = classList.get(i);
				String classScript = scriptHolder.replace("_", webPath+"/js/class/"+className+".js");
				scriptList.add(classScript);
			}
		}
		
		//one jsp file, one js file
		String jspURL = request.getRequestURL().toString();
		if(!StringUtils.isEmpty(jspURL)) {
			String jsURL = jspURL.replace("WEB-INF/views", "js/business").replace(".jsp", ".js");
			String jsScript = scriptHolder.replace("_", jsURL);
			scriptList.add(jsScript);
		}
		
		for (int i = 0; i < scriptList.size(); i++) {
			String script = scriptList.get(i);
			getJspContext().getOut().println(script);
		}
	}

	
	public String getProxyListString() {
		return proxyListString;
	}

	public void setProxyListString(String proxyListString) {
		this.proxyListString = proxyListString;
	}


	public boolean isEnableCkeditor() {
		return enableCkeditor;
	}


	public void setEnableCkeditor(boolean enableCkeditor) {
		this.enableCkeditor = enableCkeditor;
	}


	public boolean isEnableDateExt() {
		return enableDateExt;
	}


	public void setEnableDateExt(boolean enableDateExt) {
		this.enableDateExt = enableDateExt;
	}


	public String getClassString() {
		return classString;
	}


	public void setClassString(String classString) {
		this.classString = classString;
	}
}
