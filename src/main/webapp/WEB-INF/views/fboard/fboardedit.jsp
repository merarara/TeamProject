<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
</head>
<body>
<%@ include file="../header.jsp" %>	
<div id="content">
<center>
<h2>FAQ게시판 - 수정하기(Edit)</h2>
</center>
<!-- 글쓰기 페이지를 그대로 사용하되 action 부분만 수정한다. 수정시에도
파일첨부가 있으므로 enctype속성은 추가되어야한다. -->
<form action="/fboard/fboardedit.do" method="post">
	<input type="hidden" name="f_num" value="${fboardDto.f_num}" /> <!-- f_num 값을 hidden 타입으로 추가 -->
	<input type="hidden" name="u_id" value="${udto.u_id}" />
	<!-- 게시물 수정을 위한 일련번호 -->	
	<input type="hid den" name="u_id" value="${ udto.u_id }"/>
	<table align="center" border="1" width="60%">
		<tr>
		  <td>제목</td>
		  <td>
		    <input type="text" name="f_title" style="width:60%;" value="${fboardDto.f_title}" />
		  </td>
		</tr>
	    <tr>
	        <td>내용</td>
	        <td>
	            <textarea name="f_content" style="width:90%;height:100px;">${ fboardDto.f_content }</textarea>
	        </td>
	    </tr>
	    <tr>
	        <td colspan="2" align="center">
	            <button type="submit">수정 완료</button>
	            <button type="reset">RESET</button>
	            <button type="button" onclick="location.href='/fboard/fboardlist.do';">
	                목록 바로가기
	            </button>
	        </td>
	    </tr>
</table>    
</form>
</div>
<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
