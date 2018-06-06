package com.wondersgroup.operation.util.aop;

import java.lang.reflect.Method;

import org.aopalliance.aop.Advice;
import org.springframework.aop.Pointcut;
import org.springframework.aop.support.AbstractPointcutAdvisor;
import org.springframework.aop.support.StaticMethodMatcherPointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;

@Component
public class VisitAdvisor extends AbstractPointcutAdvisor {

	private final StaticMethodMatcherPointcut pointcut = new StaticMethodMatcherPointcut() {
		@Override
		public boolean matches(Method method, Class<?> targetClass) {
			return (method.isAnnotationPresent(RequestMapping.class));
		}
	};

	@Autowired
	private VisitMethodAdvice visitMethodAdvice;

	@Override
	public Pointcut getPointcut() {
		return this.pointcut;
	}

	@Override
	public Advice getAdvice() {
		return this.visitMethodAdvice;
	}

	public VisitMethodAdvice getVisitMethodAdvice() {
		return visitMethodAdvice;
	}

	public void setVisitMethodAdvice(VisitMethodAdvice visitMethodAdvice) {
		this.visitMethodAdvice = visitMethodAdvice;
	}

}
