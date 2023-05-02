<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/css/bootstrap.min.css" integrity="sha512-ZlNpJApEhAeuBLvF+s/dfapLe7/GR8hFm70gfJcM9hnXGLOzO+yBf+iJTEhG2Q06Z7neAIwL8eTF7PcL4SDy3A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-36bqSL3hlaHfQcMQm3V/mBYyN9D5GtV5/zwPIIx+k5uea0iNjJmxwEy+5xvNpCp6NldoEdgF/VmlnZtu8jENAQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/js/bootstrap.min.js" integrity="sha512-XWxH47RJiYB9OeBOG86nmPVDLrdki/QV4P4jMn7VZiCnk+zU6VNYgSdmlU6Fr3UqHRO9MsONs8sZ/TYFkbKj3Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<!-- 관리자 표시 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />



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
			<s:authorize access="hasAnyRole('USER', 'BLACKLIST', 'ADMIN')">
			    <li class="nav-item">
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
	          <a class="nav-link" href="/aboard/aboardlist.do">공지사항</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="/cboard/list.do?num=1">커뮤니티</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="/fboard/fboardlist.do">FAQ</a>
	        </li>
	        <s:authorize access="hasAnyRole('USER', 'BLACKLIST')">
              <li class="nav-item">
               <a class="nav-link" href="/product/productbascket.do">장바구니</a>
           	  </li>
          </s:authorize>
	        <s:authorize access="hasRole('ADMIN')">
	        <li class="nav-item">
	          <a class="nav-link" href="/admin/adminPage.do">관리자페이지</a>
	        </li>
	        </s:authorize>
	      </ul>
	      <!-- 일반유저 -->
			<s:authorize access="hasRole('USER')">
			  <li class="nav-item dropdown ml-auto">
			    <a class="nav-link dropdown-toggle" href="#" id="profileDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			      프로필
			    </a>
			    <div class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
			      <h6 class="dropdown-header">${sessionScope.userId}</h6>
			      <a class="dropdown-item" href="${pageContext.request.contextPath}/user/myinfo.do">내 정보</a>
			      <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">로그아웃</a>
			    </div>
			  </li>
			</s:authorize>
			<!-- 블랙리스트 유저 -->
			<s:authorize access="hasRole('BLACKLIST')">
			  <li class="nav-item dropdown ml-auto">
			    <a class="nav-link dropdown-toggle" href="#" id="profileDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			      프로필
			    </a>
			    <div class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
			      <h6 class="dropdown-header">${sessionScope.userId} <span class="badge badge-danger">B</span></h6>
			      <a class="dropdown-item" href="${pageContext.request.contextPath}/user/myinfo.do">내 정보</a>
			      <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">로그아웃</a>
			    </div>
			  </li>
			</s:authorize>

			<!-- 관리자 -->
			<s:authorize access="hasRole('ADMIN')">
			  <li class="nav-item dropdown ml-auto">
			    <a class="nav-link dropdown-toggle" href="#" id="profileDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			      <i class="fas fa-crown"></i> 관리자
			    </a>
			    <div class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
			      <h6 class="dropdown-header">${sessionScope.userId}</h6>
			    </div>
			  </li>
			</s:authorize>




	    </div>
	  </div>
	</nav>
</div>