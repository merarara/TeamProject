<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script>
		function toggleContent(id) {
			var content = document.getElementById("content-" + id);
			if (content.style.display === "none") {
				content.style.display = "block";
			} else {
				content.style.display = "none";
			}
		}
	</script>
</head>
<body>
	<h2>fboard리스트</h2>
	<table border="1">
		<tr>
			<th>F_num</th>
			<th>F_title</th>
			<th>F_content</th>
			<th>U_ID</th>
			<th></th>
		</tr>
		<c:forEach items="${FBoardList}" var="row" varStatus="loop">
			<tr>
				<td>${row.f_num}</td>
				<td>
					<a href="javascript:void(0);" onclick="toggleContent(${row.f_num});">${row.f_title}</a>
				</td>
				<td>
					<div id="content-${row.f_num}" style="display: none;">
						${row.f_content}
					</div>
				</td>
				<td>${row.u_id}</td>
				<td>
					<%--  <a href="edit.do?id=${row.id }">수정</a> --%>
					<%--  <a href="delete.do?id=${row.id }">삭제</a>  --%>
					<%--  <a href="javascript:void(0);" onclick="memberDel('${row.id }');">삭제</a> --%>
				</td>
			</tr>
		</c:forEach>
	</table>
	<a href="faq_regist.do">등록</a>
	<a href="faq_edit.do">수정하기</a>
</body>
</html>
