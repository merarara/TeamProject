<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>FAQ 수정</title>
</head>
<body>
	<h2>FAQ 수정</h2>
	<form method="post" action="faq_edit.do">
		<input type="hidden" name="f_num" value="${dto.f_num}">
		<label for="f_title">제목:</label>
		<input type="text" id="f_title" name="f_title" value="${dto.f_title}">
		<br><br>
		<label for="f_content">내용:</label>
		<textarea id="f_content" name="f_content">${dto.f_content}</textarea>
		<br><br>
		<label for="u_id">작성자:</label>
		<input type="text" id="u_id" name="u_id" value="${dto.u_id}">
		<br><br>
		<button type="submit">수정</button>
	</form>
	
</body>
</html>