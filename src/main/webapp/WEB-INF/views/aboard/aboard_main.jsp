<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


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
				<td>
				${row.a_visitcount} 
				</td>
				<td>${row.a_postdate} </td>
				<td>${row.u_id}</td>
				<td>${row.u_nick}</td>
				<td>${row.a_commend}</td>



			</tr>
		</c:forEach>
	</table>
		<a href="aboard_regist.do">등록</a>
</body>
</html>
