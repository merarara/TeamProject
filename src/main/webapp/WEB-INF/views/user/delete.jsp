<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴 페이지</title>
</head>
<body>
	<h1>회원 탈퇴 페이지</h1>
	<form:form method="post" action="/user/delete.do">
		<p>정말로 회원 탈퇴하시겠습니까?</p>
		<p>탈퇴 후에는 복구가 불가능합니다.</p>
		<input type="submit" value="회원 탈퇴">
	</form:form>
</body>
</html>
