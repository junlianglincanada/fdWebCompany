package com.wondersgroup.operation.util.file;

import java.io.InputStream;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.framework.util.FoodConstant;

import net.sf.jxls.reader.ReaderBuilder;
import net.sf.jxls.reader.ReaderConfig;
import net.sf.jxls.reader.XLSReadStatus;
import net.sf.jxls.reader.XLSReader;

public class DataImportUtil {
	
	/**
	 * 通过Excel 读取 DTO List
	 */
	public static <T> List<T> readExcelToDTO(T t,String mappingFileName,MultipartFile file)  {
		try {
			InputStream inputXML =DataImportUtil.class.getClassLoader().getResourceAsStream(FoodConstant.MAPPING_FILE_PATH + "/" + mappingFileName);
			XLSReader mainReader = ReaderBuilder.buildFromXML(inputXML);
			List<T> result = new ArrayList<T>();
			Map beans = new HashMap();
			beans.put("result", result);
			ReaderConfig.getInstance().setSkipErrors(true);
			XLSReadStatus readStatus = mainReader.read(file.getInputStream(), beans);
			return result;
		} catch (Exception e) {
			throw new FoodException(e);
		}
	}
	
	/**
	 * 获取key为名字,Value为实体的Map
	 */
	public static <T> Map<String, T> getNameEntityMap(QueryResult<T> result,String methodName){
		if(StringUtils.isEmpty(methodName)) {
			methodName = "getName";
		}
		Map<String, T> map = new HashMap<String, T>();
		try {
			if (result != null && result.getResultList() != null) {
				List<T> list = result.getResultList();
				for (T entity : list) {
					Method method= entity.getClass().getMethod(methodName);
					String key = (String)method.invoke(entity);
					map.put(key, entity);
				}
			} else {
				throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
			}
		} catch (Exception e) {
			throw FoodException.returnException(ErrorMessageConstant.CODE_PARAM_ERROR);
		}
		return map;
	}
	
}
