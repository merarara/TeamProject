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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
<style>
table {
    border-collapse: collapse;
    width: 100%;
}

th, td {
    padding: 8px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

th {
    background-color: #f2f2f2;
}

.toggle {
    cursor: pointer;
    text-decoration: underline;
}

.details {
    display: none;
    margin-left: 20px;
}
</style>
<script>
    $(function() {
        $('.toggle').click(function() {
            $(this).next().toggle();
        });
    });
</script>
</head>
<body>
<%@ include file="../header.jsp" %>	
<div id="content">
	<div class="container">
		<table>
			<thead>
	            <tr>
	                <th>구매 번호</th>
	                <th>구매 아이디</th>
	                <th>주소</th>
	                <th>가격</th>
	                <th>수량</th>
	                <th>주문상태</th>
	                <th>주문일</th>
	            </tr>
	        </thead>
			<tbody>
			  <c:forEach items="${orderlist}" var="i">
			    <tr>
			      <td><mark>${i.m_num}</mark></td>
				  <td><mark>${i.u_id}</mark></td>
				  <td><mark>${i.m_addr}</mark></td>
				  <td><mark>${i.m_price}</mark></td>
				  <td><mark>${i.m_qty}</mark></td>
				  <td><mark>${i.m_payment}</mark></td>
				  <td><mark>${i.m_bdate}</mark></td>
			    </tr>
			    <tr>
			      <td colspan="7">
			        <button type="button" class="btn btn-link" data-toggle="collapse"
			                data-target="#collapse${i.m_num}" aria-expanded="false"
			                aria-controls="collapse${i.m_num}">
			          주문 상세
			        </button>
			        <div class="collapse" id="collapse${i.m_num}">
			          <table class="table">
			            <thead>
			              <tr>
			                <th>상품번호</th>
			                <th>상품명</th>
			                <th>상품 가격</th>
			                <th>구매 수량</th>
			              </tr>
			            </thead>
			            <tbody>
			              <c:forEach items="${blist}" var="j">
			                <c:if test="${i.m_num == j.m_num}">
			                  <tr>
			                    <td>${j.p_num}</td>
			                    <td>${j.p_name}</td>
			                    <td>${j.p_price}</td>
			                    <td>${j.bo_qty}</td>
			                  </tr>
			                </c:if>
			              </c:forEach>
			            </tbody>
			          </table>
			        </div>
			      </td>
			    </tr>
			  </c:forEach>
			</tbody>
		</table>
	<table style="margin: 0 auto;">
		<tr>
			<td colspan="5" style="text-align: center;">
			  	<!-- 처음 -->
			  	<c:choose>
			    	<c:when test="${(page.curPage - 1) < 1 }">
			      		<button class="btn btn-link text-dark" disabled>&lt;&lt;</button>
			    	</c:when>
				    <c:otherwise>
				      	<a href="/admin/sellManage.do?page=1&searchword=${ searchword }&searchfield=${ searchfield }" 
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
				      	<a href="/admin/sellManage.do?page=${page.curPage - 1}&searchword=${ searchword }&searchfield=${ searchfield }" 
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
				        	<a href="/admin/sellManage.do?page=${fEach}&searchword=${ searchword }&searchfield=${ searchfield }" 
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
				      	<a href="/admin/sellManage.do?page=${page.curPage + 1}&searchword=${ searchword }&searchfield=${ searchfield }" 
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
				      	<a href="/admin/sellManage.do?page=${page.totalPage}&searchword=${ searchword }&searchfield=${ searchfield }" 
				      		class="btn btn-link text-dark pagingbtn">
				      		&gt;&gt;
				      	</a>
				    </c:otherwise>
				</c:choose>
			</td>
		</tr>
	</table>
	</div>
</div>
<%@ include file="../footer.jsp" %>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>