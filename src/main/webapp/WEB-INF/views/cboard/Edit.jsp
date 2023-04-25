<%@ page import="com.project.springboot.cboard.C_BoardDAO" %>
<%@ page import="com.project.springboot.cboard.C_BoardDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!-- 수정페이지로 진입시 로그인을 확인한다. -->
<%
//파라미터로 전달된 일련번호를 받아 레코드를 인출한다.
int c_num = Integer.parseInt(request.getParameter("c_num"));
C_BoardDAO dao = (C_BoardDAO) application.getAttribute("c_boardDAO");
C_BoardDTO dto = dao.selectView(c_num);
//세션영역에 저장된 회원아이디와 작성자를 비교한다.
String sessionId = session.getAttribute("userId").toString();
//작성자 본인이 아니라면 진입할 수 없도록 뒤로 이동한다.
if (!sessionId.equals(dto.getU_id())) {
out.println("<script>alert('본인이 작성한 글이 아닙니다.'); history.back();</script>");
return;
}
/*URL의 패턴을 파악하면 내가 작성한 게시물이 아니어도 얼마든지
수정페이지로 진입할 수 있으므로 본인확인을 위한 코드를 추가해야 한다.*/
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title>회원제 게시판</title> 
<script type="text/javascript"> 
function validateForm(form) {
	if (form.title.value == "") { 
		alert("제목을 입력하세요."); 
		form.title.focus(); 
		return false;
	}
	if (form.content.value=="") {
			alert("내용을 입력하세요.");
			form.content.focus();
			return false;
	}
}
</script>
</head>
<body>
<h2>회원제 게시판 - 수정하기(Edit)</h2>
<form name="writeFrm" method="post" action="EditProcess.jsp" 
	onsubmit="return validateForm(this);">
	<!-- 게시물의 일련번호를 서버로 전송하기 위해 hidden타입의 입력상자가
	반드시 필요하다. -->
	<input type="hidden" name="c_num" value="<%= dto.getC_num() %>" /> 
	<table border="1" width="90%">
﻿	<tr>
		<td>제목</td>
		<td>
			<input type="text" name="c_title" style="width: 90%;" 
					value="<%= dto.getC_title() %>"/>
		</td>
	</tr>
	<tr>
		<td>내용</td>
		<td>
			<textarea name="c_content" style="width: 90%; height: 100px;"><%= dto.getC_content() %></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<button type="submit">작성완료</button>
			<button type="reset">다시 입력</button>
			<button type="button" onclick="location.href='/cboard/List.jsp';"> 
				목록보기</button>
		</td>
	</tr>
</table>
</form>
</body>
</html>