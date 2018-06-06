package com.wondersgroup.operation.util;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ObjecttToMaoUtil {
	private Logger logger = LoggerFactory.getLogger(ObjecttToMaoUtil.class);
	public static Map getValue(Object thisObj)  
    {  
      Map map = new HashMap();  
      Class c;  
      try  
      {  
        c = Class.forName(thisObj.getClass().getName());  
        Method[] m = c.getMethods();  
        for (int i = 0; i < m.length; i++)  
        {  
          String method = m[i].getName();  
          if (method.startsWith("get"))  
          {  
            try{  
            Object value = m[i].invoke(thisObj);  
            if (value != null)  
            {  
              String key=method.substring(3);  
              key=key.substring(0,1).toUpperCase()+key.substring(1);  
              map.put(key, value);  
            }  
            }catch (Exception e) {  
              // TODO: handle exception  
              System.out.println("error:"+method);  
            }  
          }  
        }  
      }  
      catch (Exception e)  
      {  
        // TODO: handle exception  
        e.printStackTrace();  
      }  
      return map;  
    } 

}
