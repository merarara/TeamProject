<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>aboard 수정</h2>
	<form method="post" action="aboard_edit.do">
		<input type="hidden" name="a_num" value="${dto.a_num}">
		<label for="a_title">제목:</label>
		<input type="text" id="a_title" name="a_title" value="${dto.a_title}">
		<br><br>
		<label for="a_content">내용:</label>
		<textarea id="a_content" name="a_content">${dto.a_content}</textarea>
		<br><br>
		
		<button type="submit">수정</button>
	</form>
	
</body>
</html>