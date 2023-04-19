<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    /* 테이블 스타일링 */
    table {
        width: 90%;
        border-collapse: collapse;
        margin-left: auto;
    	margin-right: auto;
    }
    th, td {
        border: 1px solid #ccc;
        padding: 10px;
        text-align: left;
    }
    th {
        background-color: #f8f8f8;
        text-align : center;
    }
    tbody tr:nth-child(even) {
        background-color: #f8f8f8;
    }
    tbody tr:hover {
        background-color: #f0f0f0;
    }
    /* 버튼 스타일링 */
    .pagingbtn {
        display: inline-block;
        padding: 5px 10px;
        border: none;
        background-color: #f8f9fa;
        color: #fff;
        text-align: center;
        text-decoration: none;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .pagingbtn:hover {
        background-color: #808080;
    }
    .pagingbtn.disabled {
        opacity: 0.5;
        cursor: default;
    }
    /* 간편선택 사이드 메뉴 스타일 */
    .side-menu {
        width: 200px;
        height: 400px;
        background-color: #f8f9fa;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        border: dotted 1px #000;
        padding: 20px;
    }

    .side-menu h5 {
        margin-bottom: 20px;
    }

    .side-menu hr {
        width: 100%;
        margin-top: 10px;
        margin-bottom: 10px;
        border: none;
        border-top: 1px solid #000;
    }

    .side-menu a {
        border: none;
        text-align: center;
        padding: 10px;
        transition: all 0.3s ease;
    }

    .side-menu a:hover {
        background-color: #e9ecef;
    }
    /* 구매가이드 사이드 메뉴 스타일 */
    .side-menu2 {
        width: 200px;
        height: 445px;
        background-color: #f8f9fa;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 20px;
    }

    .side-menu2 hr {
        width: 100%;
        margin-top: 10px;
        margin-bottom: 10px;
        border: none;
        border-top: 1px solid #000;
    }

    .side-menu2 a {
        border: none;
        text-align: center;
        transition: all 0.3s ease;
    }

    .side-menu2 a:hover {
        background-color: #e9ecef;
    }
</style>
</head>
<body>
<%@ include file="../header.jsp" %>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-2 d-flex align-items-center justify-content-center">
		    <!-- 카테고리 메뉴 내용 -->
		    <div class="side-menu">
		        <h5>간편선택</h5>
		        <hr>
		        <div style="width: 100%; display: flex; flex-direction: column;">
		            <a href="#" class="btn btn-link text-dark">노트북 전체</a>
		            <hr> 
		            <a href="#" class="btn btn-link text-dark">ASUS</a>
		            <hr>
		            <a href="#" class="btn btn-link text-dark">APPLE</a>
		            <hr>
		            <a href="#" class="btn btn-link text-dark">DELL</a>
		        </div>  
		    </div>
		</div>
		<div class="col-md-8">
			<table>
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
						<td style="text-align: center;"><img src="${i.p_listimg}"></td>
						<td><h4>${i.p_name}</h4><br>
							<c:set var="ratingImgPath" value="" />
							<c:choose>
							    <c:when test="${i.p_rating == 0}">
							        <c:set var="ratingImgPath" value="/productimgs/0.png" />
							    </c:when>
							    <c:when test="${i.p_rating <= 0.99}">
							        <c:set var="ratingImgPath" value="/productimgs/0_5.png" />
							    </c:when>
							    <c:when test="${i.p_rating >= 1 && i.p_rating <= 1.49}">
							        <c:set var="ratingImgPath" value="/productimgs/1.png" />
							    </c:when>
							    <c:when test="${i.p_rating >= 1.5 && i.p_rating <= 1.99}">
							        <c:set var="ratingImgPath" value="/productimgs/1_5.png" />
							    </c:when>
							    <c:when test="${i.p_rating >= 2 && i.p_rating <= 2.49}">
							        <c:set var="ratingImgPath" value="/productimgs/2.png" />
							    </c:when>
							    <c:when test="${i.p_rating >= 2.5 && i.p_rating <= 2.99}">
							        <c:set var="ratingImgPath" value="/productimgs/2_5.png" />
							    </c:when>
							    <c:when test="${i.p_rating >= 3 && i.p_rating <= 3.49}">
							        <c:set var="ratingImgPath" value="/productimgs/3.png" />
							    </c:when>
							    <c:when test="${i.p_rating >= 3.5 && i.p_rating <= 3.99}">
							        <c:set var="ratingImgPath" value="/productimgs/3_5.png" />
							    </c:when>
							    <c:when test="${i.p_rating >= 4 && i.p_rating <= 4.49}">
							        <c:set var="ratingImgPath" value="/productimgs/4.png" />
							    </c:when>
							    <c:when test="${i.p_rating >= 4.5 && i.p_rating <= 4.99}">
							        <c:set var="ratingImgPath" value="/productimgs/4_5.png" />
							    </c:when>
							    <c:otherwise>
							        <c:set var="ratingImgPath" value="/productimgs/5.png" />
							    </c:otherwise>
							</c:choose>
							<img src="${ratingImgPath}" alt="별점" style="width: 80px; height: 18px;"/> ${ i.p_rating }
							<span style="display: block; text-align: right; font-size: 16px;">
							    등록일 : ${fn:substring(i.p_rdate, 0, 7)}
							</span>
						</td>
						<td style="text-align: center;"><fmt:formatNumber type="number" value="${i.p_price}" pattern="#,###" />원</td>
						<td style="text-align: center;">${i.p_company}</td>
					</tr>
				</c:forEach>
				</tbody>
				<!-- 버튼 페이징 -->
				<tr>
					<td colspan="5" style="text-align: center;">
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
						      	<button class="btn btn-link text-dark pagingbtn" disabled>&lt;</button>
						    </c:when>
						    <c:otherwise>
						      	<a href="/product/productlist.do?page=${page.curPage - 1}" class="btn btn-link text-dark pagingbtn">&lt;</a>
						    </c:otherwise>
						</c:choose>
						  
						<!-- 개별 페이지 -->
						<c:forEach var="fEach" begin="${page.startPage}" end="${page.endPage}" step="1">
						    <c:choose>
						      	<c:when test="${page.curPage == fEach}">
						        	<button class="btn btn-link text-dark pagingbtn" disabled>${fEach}</button>
						      	</c:when>
						      	<c:otherwise>
						        	<a href="/product/productlist.do?page=${fEach}" class="btn btn-link text-dark pagingbtn">${fEach}</a>
						      	</c:otherwise>
						    </c:choose>
						</c:forEach>
						  
						<!-- 다음 -->
						<c:choose>
						    <c:when test="${(page.curPage + 1) > page.totalPage }">
						      	<button class="btn btn-link text-dark pagingbtn" disabled>&gt;</button>
						    </c:when>
						    <c:otherwise>
						      	<a href="/product/productlist.do?page=${page.curPage + 1}" class="btn btn-link text-dark pagingbtn">&gt;</a>
						    </c:otherwise>
						</c:choose>
						  
						<!-- 끝 -->
						<c:choose>
						    <c:when test="${page.curPage == page.totalPage }">
						      	<button class="btn btn-link text-dark pagingbtn" disabled>&gt;&gt;</button>
						    </c:when>
						    <c:otherwise>
						      	<a href="/product/productlist.do?page=${page.totalPage}" class="btn btn-link text-dark pagingbtn">&gt;&gt;</a>
						    </c:otherwise>
						</c:choose>
					</td>
				</tr>
			</table>
		</div>
		<div class="col-md-2 d-flex align-items-center justify-content-center">
			<div class="side-menu2">
		        <img src="/productimgs/cpuNumbering.jpg"/>
		        <b>쇼핑가이드</b>
		        <a href="/product/buyguide/guide1.do" class="text-dark">> 한눈에 보는 노트북 CPU넘버링 가이드 </a><hr>
		        > 대학생 새내기 주목! 슬기로운 대학생활 위한 최고의 노트북은? <hr>
		        > 인텔 11~13세대, AMD 5000~7000번대. 나는 어떤 노트북을 골라야 될까?
		    </div>
		</div>
	</div>
</div>

<%@ include file="../footer.jsp" %>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>