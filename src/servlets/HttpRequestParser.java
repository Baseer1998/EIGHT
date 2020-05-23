package com.voidmain.servlets;

import java.lang.reflect.Method;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

public class HttpRequestParser {
	
	public static Object parseRequest(HttpServletRequest request,Object obj)
	{
		Enumeration<String> enumeration=request.getParameterNames();

		while(enumeration.hasMoreElements())
		{
			String parameterName=enumeration.nextElement();

			Method[] methods=obj.getClass().getDeclaredMethods();

			for(Method method : methods)
			{
				String methodName=method.getName();

				if(methodName.equalsIgnoreCase("set"+parameterName))
				{
					try {
						method.setAccessible(true);
						method.invoke(obj,request.getParameter(parameterName));
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}

		return obj;
	}
}
