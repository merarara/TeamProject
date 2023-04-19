package com.project.springboot.utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//쿠키 생성, 읽기, 삭제를 위한 유틸리티 클래스
public class CookieManager {
	//쿠키생성 :  생성시 response내장 객체가 필요하므로 매개변수로 선언한다.
	public static void makeCookie(HttpServletResponse response, String cName,
			String cValue, int cTime) {
		//생성자를 통해 쿠키 객체를 생성한다. 이때 쿠키명과 값이 설정된다.
		Cookie cookie = new Cookie(cName, cValue);
		//쿠키가 적용될 경로 설정
		cookie.setPath("/");
		//유효기간 설정
		cookie.setMaxAge(cTime);
		//응답헤더에 추가하여 클라이언트로 전송한다.
		response.addCookie(cookie);
	}
	
	//쿠키값 읽기 : request내장객체가 필요하므로 매개변수로 선언한다.
	public static String readCookie(HttpServletRequest request, String cName) {
		String cookieValue = "";
		//생성된 모든 쿠키를 배열로 얻어온다.
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			//쿠키의 갯수만큼 반복한다.
			for (Cookie c : cookies) {
				//쿠키명을 얻어온다.
				String cookieName = c.getName();
				//내가 찾는 쿠키가 있는지 확인한다.
				if (cookieName.equals(cName)) {
					//쿠키명이 일치하면 쿠키값을 읽어서 저장한다.
					cookieValue = c.getValue();
				}
			}
		}
		return cookieValue;
	}
	//쿠키삭제
	public static void deleteCookie(HttpServletResponse response, String cName) {
		/*
		 쿠키는 삭제를 위한 메서드가 없으므로, 유효시간을 0으로 설정하면
		 삭제된다. 따라서 앞에서 생성한 makeCookie()메서드는 재활용한다.
		 */
		makeCookie(response, cName, "", 0);
	}
}
