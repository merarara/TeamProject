<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="css/home.css">
</head>
<body>
<%@ include file="../header.jsp" %>
<div id="wrapper">
	<table border="1">
		<thead>
		<tr>
			<th>상품이미지</th>
			<th>상품명</th>
			<th>가격</th>
			<th>제조사</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${plist}" var="i">
			<tr>
				<td><img src="${i.p_listimg}"></td>
				<td>${i.p_name}</td>
				<td>${i.p_price}</td>
				<td>${i.p_company}</td>
			</tr>
		</c:forEach>
	</tbody>
		<!-- 버튼 페이징 -->
		<tr>
			<td colspan="5">
			  	<!-- 처음 -->
			  	<c:choose>
			    	<c:when test="${(page.curPage - 1) < 1 }">
			      		<button class="btn btn-link text-dark" disabled>&lt;&lt;</button>
			    	</c:when>
				    <c:otherwise>
				      	<a href="/product/productlist.do?page=1" class="btn btn-link text-dark">&lt;&lt;</a>
				    </c:otherwise>
				</c:choose>
				  
				<!-- 이전 -->
				<c:choose>
				    <c:when test="${(page.curPage - 1) < 1 }">
				      	<button class="btn btn-link text-dark" disabled>&lt;</button>
				    </c:when>
				    <c:otherwise>
				      	<a href="/product/productlist.do?page=${page.curPage - 1}" class="btn btn-link text-dark">&lt;</a>
				    </c:otherwise>
				</c:choose>
				  
				<!-- 개별 페이지 -->
				<c:forEach var="fEach" begin="${page.startPage}" end="${page.endPage}" step="1">
				    <c:choose>
				      	<c:when test="${page.curPage == fEach}">
				        	<button class="btn btn-link text-dark" disabled>${fEach}</button>
				      	</c:when>
				      	<c:otherwise>
				        	<a href="/product/productlist.do?page=${fEach}" class="btn btn-link text-dark">${fEach}</a>
				      	</c:otherwise>
				    </c:choose>
				</c:forEach>
				  
				<!-- 다음 -->
				<c:choose>
				    <c:when test="${(page.curPage + 1) > page.totalPage }">
				      	<button class="btn btn-link text-dark" disabled>&gt;</button>
				    </c:when>
				    <c:otherwise>
				      	<a href="/product/productlist.do?page=${page.curPage + 1}" class="btn btn-link text-dark">&gt;</a>
				    </c:otherwise>
				</c:choose>
				  
				<!-- 끝 -->
				<c:choose>
				    <c:when test="${page.curPage == page.totalPage }">
				      	<button class="btn btn-link text-dark" disabled>&gt;&gt;</button>
				    </c:when>
				    <c:otherwise>
				      	<a href="/product/productlist.do?page=${page.totalPage}" class="btn btn-link text-dark">&gt;&gt;</a>
				    </c:otherwise>
				</c:choose>
			</td>
		</tr>
	</table>
	totalCount : ${page.totalCount }<br>
	listCount : ${page.listCount }<br>
	totalPage : ${page.totalPage }<br>
	curPage : ${page.curPage }<br>
	pageCount : ${page.pageCount }<br>
	startPage : ${page.startPage }<br>
	endPage : ${page.endPage }<br>
</div>
<%@ include file="../footer.jsp" %>

	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>