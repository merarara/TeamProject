<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
</head>
<body>

<form method="post" >

<label>제목</label>
<input type="text" name="c_title" value="${view.c_title}"/><br />

<label>작성자</label>
<input type="text" name="u_id" value="${view.u_id}"/><br />

<label>내용</label>
<textarea cols="50" rows="5" name="c_content">${view.c_content}</textarea><br />

<button type="submit" onclick="goToList()">완료</button>

<input type="hidden" name="c_num" value="${view.c_num}" />

<script>
  function goToList() {
    location.href = "/cboard/list.do";
  }
</script>

</form>

</body>
</html>
