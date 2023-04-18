package com.project.springboot.utils;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

public class JSFunction {

	//Javascript함수를 통해 경고창을 띄우고 원하는 페이지로 이동한다.
	public static void alertLocation(String msg, String url, JspWriter out) {
		/*
		 Java클래스에서는JSP의 내장객체를 사용할 수 없으므로 반드시 매개변수로
		 전달받아 사용해야한다.
		 여기서는 화면에 문자열을 출력하기 위해 out 내장객체를 JspWriter타입으로
		 받은 후 사용하고 있다.		  
		 */
		try {
			String script = ""
						  + "<script>"
						  + "	alert('" + msg + "');"
						  + " 	location.href='" + url + "';"
						  + "</script>";
			out.println(script);
		}
		catch (Exception e) {}
	}
	//JS를 통해 경고창을 띄운 후 뒤로 이동한다.
	public static void alertBack(String msg, JspWriter out) {
		try {
			String script = ""
						  + "<script>"
						  + "	alert('" + msg + "');"
						  + " 	history.back();"
						  + "</script>";
			out.println(script);
		}
		catch (Exception e) {}
	}
	//단순히 경고창만 띄울 수 있는 메서드 정의
	public static void alertMsg(String msg, JspWriter out) {
		try {
			String script = ""
						  + "<script>"
						  + "	alert('" + msg + "');"
						  + "</script>";
			out.println(script);
		}
		catch (Exception e) {}
	}
	 public static void alertLocation(HttpServletResponse resp, String msg, String url) {
	        try { 
	        	resp.setContentType("text/html; charset=UTF-8"); 
	        	PrintWriter writer = resp.getWriter();
	        	
	            String script = "<script>"
	                          + "    alert('" + msg + "');"
	                          + "    location.href='" + url + "';"
	                          + "</script>";
	            writer.println(script);
	        }
	        catch (Exception e) {}
	    }
	    public static void alertBack(HttpServletResponse resp, String msg) {
	        try {
	        	resp.setContentType("text/html; charset=UTF-8");
	        	PrintWriter writer = resp.getWriter();
	        	
	            String script = "<script>"
	                          + "    alert('" + msg + "');"
	                          + "    history.back();"
	                          + "</script>";
	            writer.println(script);
	        }
	        catch (Exception e) {}
	    }

}
