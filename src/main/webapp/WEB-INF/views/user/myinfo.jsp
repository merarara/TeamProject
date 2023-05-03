<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!--  login CSS -->
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

<div id="content">
	<Ul class="user-list">
		<li>
			<p>
				결재내역<br>
				내가 구매한 상품 보러 가기
			</p>
			<img src="/userimages/buyHistory.png">
			<a href="/user/buyHistory.do" class="login-link">결재내역</a>
		</li>
		<li>
			<p>
				내 정보 수정하기!<br> 컴 온 컴 온 
			</p>
			<img src="/userimages/ico_update.png" >
    		<a href="/user/edit.do" class="login-link">회원수정 하기</a>
		</li>
		<li>
			<p>
				회원탈퇴를 원하세요?<br>
				한번 더 고민해 보시는건 어떠세요?
			</p>
			<img src="/userimages/ico_delete.png">
			<a href="/user/delete.do" class="login-link">회원탈퇴 하기</a>
		</li>
	</Ul>
</div>



</div>
<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
