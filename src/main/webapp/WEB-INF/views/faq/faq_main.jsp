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
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
</head>
<body>
<%@ include file="../header.jsp" %>	

<div id="content">
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
					<a href="faq_edit.do?f_num=${row.f_num}">수정</a>
					<a href="faq_delete.do?f_num=${row.f_num}">삭제</a>  
					<%--  <a href="javascript:void(0);" onclick="memberDel('${row.id }');">삭제</a> --%>
				</td>
			</tr>
		</c:forEach>
	</table>
	<a href="faq_regist.do">등록</a>

</div>
<%@ include file="../footer.jsp" %>

	
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
	
</body>
</html>
