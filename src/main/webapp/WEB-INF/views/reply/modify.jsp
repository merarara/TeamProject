<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" c_contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
</head>
<body>

<div>

	<form method="post" action="/reply/modify">
	
		<p>
			<label>댓글 작성자</label> <input type="text" name="c_writer" readonly="readonly" value="${reply.u_id}">
		</p>
		<p>
			<textarea rows="5" cols="50" name="c_content">${reply.c_content}</textarea>
		</p>
		<p>
			<input type="hidden" name="c_num" value="${reply.c_num}">
			<input type="hidden" name="c_rno" value="${reply.c_rno}">
			
			<button type="submit">댓글 수정</button>
		</p>
	</form>
	
</div>

<!-- 댓글 끝 -->

</body>
</html>