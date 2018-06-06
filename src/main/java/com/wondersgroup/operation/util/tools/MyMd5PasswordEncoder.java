package com.wondersgroup.operation.util.tools;

import org.springframework.dao.DataAccessException;
import org.springframework.security.authentication.encoding.PasswordEncoder;

import com.wondersgroup.util.EncodeUtils;

@SuppressWarnings("deprecation")
public class MyMd5PasswordEncoder implements PasswordEncoder {

	public String encodePassword(String origPwd, Object salt) throws DataAccessException {
		return EncodeUtils.encodePassword(origPwd);
	}

	public boolean isPasswordValid(String encPwd, String origPwd, Object salt) throws DataAccessException {
		return encPwd.equals(encodePassword(origPwd, salt));
	}
}
