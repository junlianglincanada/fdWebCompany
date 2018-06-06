package com.wondersgroup.operation.util;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.NoSuchMessageException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.ErrorMessageConstant;

/**
 * 全局异常拦截处理类
 * 
 * @author wanglei
 */
public class DefaultHandlerExceptionResolver extends org.springframework.web.servlet.mvc.support.DefaultHandlerExceptionResolver {
	private static final Logger LOGGER = LoggerFactory.getLogger(DefaultHandlerExceptionResolver.class);
	private ObjectMapper objectMapper;
	private String defaultErrorView = "error";
	@Autowired
	private MessageSource messageSource;

	public DefaultHandlerExceptionResolver() {
		super();
		setOrder(HIGHEST_PRECEDENCE);
	}

	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object o, Exception e) {
		String errorCode = null;
		String errorMessage = null;
		String exceptionInfo = "";
		CommonStatusResult result = null;
		if (e != null) {
			if (e instanceof FoodException) {
				errorCode = ((FoodException) e).getErrorCode();
				errorMessage = ((FoodException) e).getMessage();
				if (errorCode == null) {
					errorCode = ((FoodException) e).getMessage();
				}
				if (errorMessage == null || errorMessage.isEmpty()) {
					result = CommonStatusResult.fail(errorCode, null);
				} else {
					result = CommonStatusResult.create(CommonStatusResult.STATUS_FAIL, errorCode, errorMessage, "", null);
				}
			} else if (e instanceof MethodArgumentNotValidException) {
				MethodArgumentNotValidException notValidEx = (MethodArgumentNotValidException) e;
				BindingResult br = notValidEx.getBindingResult();
				FieldError ferror = br.getFieldError();
				Locale locale = Locale.getDefault();
				result = CommonStatusResult.create(CommonStatusResult.STATUS_FAIL, ErrorMessageConstant.CODE_PARAM_ERROR, processFieldError(ferror), "", locale);
			} else {
				exceptionInfo = e.getMessage();
				result = CommonStatusResult.error(exceptionInfo, exceptionInfo, null);
			}
		}
		if (result != null) {
			errorCode = result.getMessageCode();
			errorMessage = result.getMessage();
			exceptionInfo = result.getException();
		}
		LOGGER.error("Error: [" + (errorCode != null ? errorCode : "") + "] Message: " + (errorMessage != null ? errorMessage : ""));
		if (e != null) {
			LOGGER.error("Exception: ", e);
		}
		String error = null;
		try {
			error = objectMapper.writeValueAsString(result);
		} catch (JsonProcessingException ex) {
			error = "{\"status\":1,\"messageCode\":\"" + (errorCode != null ? errorCode : "") + "\",\"message\":\"" + (errorMessage != null ? errorMessage : "")
					+ "\",\"exception\":\"" + (exceptionInfo != null ? exceptionInfo : "") + "\",\"body\":null}";
		}
		ModelAndView modelAndView = new ModelAndView(defaultErrorView);
//		ModelAndView modelAndView = super.doResolveException(request, response, o, e);
		modelAndView.addObject("error", error);
		return modelAndView;
	}

	public ObjectMapper getObjectMapper() {
		return objectMapper;
	}

	public void setObjectMapper(ObjectMapper objectMapper) {
		this.objectMapper = objectMapper;
	}

	public String getDefaultErrorView() {
		return defaultErrorView;
	}

	public void setDefaultErrorView(String defaultErrorView) {
		this.defaultErrorView = defaultErrorView;
	}

	private String processFieldError(FieldError error) {
		String message = "";
		if (error != null) {
			try {
				message = messageSource.getMessage(error.getDefaultMessage(), null, null);
			} catch (NoSuchMessageException e) {
				message = error.getDefaultMessage();
			}
		}
		return message;
	}
}
