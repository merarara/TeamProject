<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div id="wrap">
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	  <div class="container-fluid">
	    <a class="navbar-brand" href="/">TJoeun NoteBook</a>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="navbarColor01">
	      <ul class="navbar-nav me-auto">
	       <s:authorize access="!isAuthenticated()">
            <li class="nav-item">
              <a class="nav-link" href="/user/main.do">로그인</a>
            </li>
          </s:authorize>
          <s:authorize access="hasRole('USER')">
              <li class="nav-item">
			<c:if test="${not empty sessionScope.userId}">
			  <div>
			    <div>${sessionScope.userId}</div>
			  </div>
			</c:if>

              <!-- 로그아웃 버튼 -->
				<form action="${pageContext.request.contextPath}/logout" method="post">
				    <input type="submit" value="로그아웃">
				</form>

            </li>
          </s:authorize>
	        <li class="nav-item">
	          <a class="nav-link" href="/product/productlist.do">판매제품</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="/aboard/aboard_main.do">공지사항</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="/cboard/List.do">커뮤니티</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="/faq/faq_main.do">FAQ</a>
	        </li>
	      </ul>
	      <form class="d-flex ml-auto">
	        <input class="form-control me-sm-2" type="search" placeholder="Search">
	        <button class="btn btn-secondary my-2 my-sm-0" type="submit">검색</button>
	      </form>
	    </div>
	  </div>
	</nav>
</div>
