<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
<!-- CSS  -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/53a8c415f1.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/css/userLogin.css">
</head>
<body>
<%@ include file="../header.jsp" %>	

 <c:if test="${empty user_id }" var="loginResult">
		<c:if test="${param.error != null}">
   		 <script>
    		   alert("로그인에 실패했습니다. 아이디와 비밀번호를 다시 확인해주세요.");
  		  </script>
		</c:if>
		<form action="/myLoginAction.do" method="post">
 <div class="wrap">
        <div class="login">
            <h2>Log-in</h2>
            <div class="login_sns">
			<li>
			    <a href="/oauth2/authorization/google">
			        <img src="/userimages/google.png" style="width: 24px; height: 24px;">
			    </a>
			</li>
			<li>
			    <a href="/oauth2/authorization/facebook">
			        <img src="/userimages/facebook.png" style="width: 24px; height: 24px;">
			    </a>
			</li>
			<li>
			    <a href="/oauth2/authorization/kakao">
			        <img src="/userimages/kakao.png" style="width: 24px; height: 24px;">
			    </a>
			</li>
			<li>
			    <a href="/oauth2/authorization/naver">
			        <img src="/userimages/naver.png" style="width: 24px; height: 24px;">
			    </a>
			</li>

			
            </div>
            <div class="login_id">
                <h4>아이디</h4>
                <input type="text" name="my_id" id="user_id" placeholder="아이디를 입력해주세요">
            </div>
            <div class="login_pw">
                <h4>비밀번호</h4>
                <input type="password" name="my_pass" id="user_pwd" placeholder="비밀번호를 입력해주세요">
            </div>
            <div class="login_etc">
                <div class="forgot_pw">
            </div>
            </div>
            <div class="submit">
                <input type="submit" value="submit">
            </div>
        </div>
    </div>
       </form>
	</c:if>
   

	
<!--  로그인 성공시 home으로 가기 -->
<c:if test="${not empty user_id }">
    <script type="text/javascript">
      alert("로그인에 성공하였습니다.");
      location.href = "home";
    </script>
</c:if>

<c:if test="${param.error != null}">
    <script>
        alert("로그인에 실패했습니다. 아이디와 비밀번호를 다시 확인해주세요.");
    </script>
</c:if>

	
<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

</body>
</html>