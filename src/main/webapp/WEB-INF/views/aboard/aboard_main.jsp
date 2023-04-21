<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>






<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
</head>
<body>

<%@ include file="../header.jsp" %>
<div id="content">
<h2>aboard리스트</h2>
	<table border="1">
		<tr>
			<th>A_num</th>
			<th>A_title</th>
			<th>A_content</th>
			<th>A_visitcount</th>
			<th>A_postdate</th>
			<th>U_ID</th>
			<th>U_Nick</th>
			<th>A_commend</th>
			<th></th>
		</tr>
		<c:forEach items="${ABoardList}" var="row" varStatus="loop">
			<tr>
				<td>${row.a_num}</td>
				<td>${row.a_title}</td>
				<td>
      				<a href="aboard_main_detail.do?a_num=${row.a_num }">${row.a_content}</a>
				</td>
				<td>${row.a_visitcount}</td>
				<td>${row.a_postdate} </td>
				<td>${row.u_id}</td>
				<td>${row.u_nick}</td>
				<td>${row.a_commend}</td>



			</tr>
		</c:forEach>
	</table>
		<a href="aboard_regist.do">등록</a>
		</div>
<%@ include file="../footer.jsp" %>
src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
