<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 삭제</title>
</head>
<body>
<div>
<form method="post" action="/cboard/delete">

	<p>정말 삭제하시겠습니까?</p>
	
	<p>
		<input type="hidden" name="c_num" value="${reply.c_num}">
		<input type="hidden" name="c_rno" value="${reply.c_rno}">
		
		<button type="submit">삭제</button>
	</p>
</form>
</div>
<!-- 댓글 끝 -->
</body>
</html>
