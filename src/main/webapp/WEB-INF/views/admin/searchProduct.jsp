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
<link rel="stylesheet" type="text/css" href="/css/content.css">
<style>
<style>
<style>
.list {
  list-style: none;
  margin: 0;
  padding: 0;
}

.list-item {
  border: 1px solid #ccc;
  border-radius: 5px;
  padding: 10px;
  margin-bottom: 10px;
}

.list-item h3 {
  margin-top: 0;
  font-size: 20px;
  cursor: pointer;
}

.list-item p {
  margin: 0;
}

.barcodes {
  display: none;
}

.barcodes ul {
  margin: 0;
  padding: 0;
}

.barcodes li {
  list-style-type: none;
}
</style>
<script>
function showBarcodes(elem) {
	  var barcodes = elem.nextElementSibling;
	  if (barcodes.style.display === "none" || barcodes.style.display === "") {
	    barcodes.style.display = "block";
	  } else {
	    barcodes.style.display = "none";
	  }
	}
</script>
</head>
<body>
<%@ include file="../header.jsp" %>	
<div id="content">
	<ul class="list" style="width: 70%; margin: 0 auto;">
	  <c:forEach items="${plist}" var="i">
	    <li class="list-item">
	      <h3 onclick="showBarcodes(this)">상품명: ${i.p_name}</h3>
	      <div class="barcodes">
	        <ul>
	          <c:forEach items="${pcnt}" var="j">
	            <c:if test="${i.p_num == j.p_num}">
	              <li>${j.p_barcode}</li>
	            </c:if>
	          </c:forEach>
	        </ul>
	      </div>
	      <p>상품번호: ${i.p_num}</p>
	    </li>
	  </c:forEach>
	</ul>
	<table style="margin: 0 auto;">
		<tr>
			<td colspan="5" style="text-align: center;">
			  	<!-- 처음 -->
			  	<c:choose>
			    	<c:when test="${(page.curPage - 1) < 1 }">
			      		<button class="btn btn-link text-dark" disabled>&lt;&lt;</button>
			    	</c:when>
				    <c:otherwise>
				      	<a href="/admin/searchProduct.do?page=1" 
				      		class="btn btn-link text-dark">
				      		&lt;&lt;
				      	</a>
				    </c:otherwise>
				</c:choose>
				  
				<!-- 이전 -->
				<c:choose>
				    <c:when test="${(page.curPage - 1) < 1 }">
				      	<button class="btn btn-link text-dark pagingbtn" disabled>&lt;</button>
				    </c:when>
				    <c:otherwise>
				      	<a href="/admin/searchProduct.do?page=${page.curPage - 1}" 
				      		class="btn btn-link text-dark pagingbtn">
				      		&lt;
				      	</a>
				    </c:otherwise>
				</c:choose>
				  
				<!-- 개별 페이지 -->
				<c:forEach var="fEach" begin="${page.startPage}" end="${page.endPage}" step="1">
				    <c:choose>
				      	<c:when test="${page.curPage == fEach}">
				        	<button class="btn btn-link text-dark pagingbtn" disabled>${fEach}</button>
				      	</c:when>
				      	<c:otherwise>
				        	<a href="/admin/searchProduct.do?page=${fEach}" 
				        		class="btn btn-link text-dark pagingbtn">
				        		${fEach}
				        	</a>
				      	</c:otherwise>
				    </c:choose>
				</c:forEach>
				  
				<!-- 다음 -->
				<c:choose>
				    <c:when test="${(page.curPage + 1) > page.totalPage }">
				      	<button class="btn btn-link text-dark pagingbtn" disabled>&gt;</button>
				    </c:when>
				    <c:otherwise>
				      	<a href="/admin/searchProduct.do?page=${page.curPage + 1}" 
					      	class="btn btn-link text-dark pagingbtn">
					      	&gt;
				      	</a>
				    </c:otherwise>
				</c:choose>
				  
				<!-- 끝 -->
				<c:choose>
				    <c:when test="${page.curPage == page.totalPage }">
				      	<button class="btn btn-link text-dark pagingbtn" disabled>&gt;&gt;</button>
				    </c:when>
				    <c:otherwise>
				      	<a href="/admin/searchProduct.do?page=${page.totalPage}" 
				      		class="btn btn-link text-dark pagingbtn">
				      		&gt;&gt;
				      	</a>
				    </c:otherwise>
				</c:choose>
			</td>
		</tr>
	</table>
</div>
<%@ include file="../footer.jsp" %>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>