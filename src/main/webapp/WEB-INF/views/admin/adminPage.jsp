<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- CSS  -->
<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" href="/css/main.css">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
</head>
<body>
<%@ include file="../header.jsp" %>	
<div id="content">
<div style="border: 1px solid #ccc; padding: 20px;">
 <h1 style="text-align:center;">관리자 안내</h1>
 <ul style="text-align:center;">
   <li>회원관리: 차단시킬 회원이나 차단을 해제할 회원 관리</li>
   <li>판매관리 : 회원이 결제한 상품  관리</li>
   <li>재고관리 : 매장에 신규 상품이 들어올 시 최신화 </li>
   <li>상품관리 : 판매하지 않는 제품 삭제 및 신규 상품 최신화</li>
 </ul>
</div>
<div class="dropdown" style="text-align:center; margin-top: 20px;">
 <h2>관리자메뉴</h2>
<div id="content">
	<Ul class="user-list">
		<li>
			<p>
				회원관리
			</p>
			<img src="/admin/userMng.png" >
   		<a href="/admin/userManagement.do" class="login-link">회원관리</a>
		</li>
		<li>
			<p>
				판매관리
			</p>
			<img src="/admin/salesMng.png">
			<a href="/admin/sellManage.do" class="login-link">판매관리</a>
		</li>
		<li>
			<p>
				재고관리
			</p>
			<img src="/admin/inventoryMng.png">
			<a href="/admin/searchProduct.do" class="login-link">재고관리</a>
		</li>
		<li>
			<p>
				상품관리 <br>
			</p>
			<img src="/admin/product2.png">
			<a href="" class="login-link">상품관리</a>
		</li>
	</Ul>
</div>
</div>
</div>
<%@ include file="../footer.jsp" %>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
