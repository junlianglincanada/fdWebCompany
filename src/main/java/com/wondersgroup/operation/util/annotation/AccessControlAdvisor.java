package com.wondersgroup.operation.util.annotation;

import java.lang.reflect.Method;

import org.aopalliance.aop.Advice;
import org.springframework.aop.Pointcut;
import org.springframework.aop.support.AbstractPointcutAdvisor;
import org.springframework.aop.support.StaticMethodMatcherPointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * 登录和权限验证相关AOP Advisor
 * @author mengke
 */
public class AccessControlAdvisor extends AbstractPointcutAdvisor {
	private static final long serialVersionUID = 1L;

	private final StaticMethodMatcherPointcut pointcut = new StaticMethodMatcherPointcut() {
		@Override
		public boolean matches(Method method, Class<?> targetClass) {
			return (method.isAnnotationPresent(LoginRequired.class) || 
					method.isAnnotationPresent(HasPermission.class) ||
					method.isAnnotationPresent(RequestMapping.class));
		}
	};

	@Autowired
	private AccessControlMethodInterceptor accessControlMethodInterceptor;

	@Override
	public Pointcut getPointcut() {
		return this.pointcut;
	}

	@Override
	public Advice getAdvice() {
		return (Advice) this.accessControlMethodInterceptor;
	}

}
