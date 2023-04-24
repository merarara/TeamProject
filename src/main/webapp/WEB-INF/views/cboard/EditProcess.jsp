<%@ page import="com.project.springboot.cboard.C_BoardDAO" %>
<%@ page import="com.project.springboot.cboard.C_BoardDTO" %>
<%@ page import="com.project.springboot.utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
	<!-- 수정 처리전 로그인 되었는지 확인해야 한다. -->
<%
//폼값 받기
// 폼값 받기
String numStr = request.getParameter("c_num"); 
int num = Integer.parseInt(numStr);
String title = request.getParameter("c_title"); 
String content = request.getParameter("c_content");

// 폼값을 DTO에 저장
C_BoardDTO dto = new C_BoardDTO(); 
dto.setC_num(num);
dto.setC_title(title); 
dto.setC_content(content);

//DB연결 및 update 쿼리문 실행
C_BoardDAO dao = (C_BoardDAO) application.getAttribute("c_boardDAO");
int affected = dao.updateEdit(dto); 
//게시물 수정에 성공하면 내용보기 페이지로 이동한다.
if (affected == 1) {
	response.sendRedirect("View.jsp?num=" + dto.getC_num());
}
else {
	//수정에 실패하면 수정페이지로 이동한다.
	JSFunction.alertBack("수정하기에 실패하였습니다.", out);
}
%>