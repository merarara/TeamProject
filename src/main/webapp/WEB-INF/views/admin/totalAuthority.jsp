<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
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
body {
      background-color: #f0f0f0;
      font-family: Arial, sans-serif;
    }
    h1 {
      text-align: center;
      margin-top: 50px;
    }
    form {
      width: 400px;
      margin: 0 auto;
      background-color: #fff;
      padding: 20px;
      border-radius: 5px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      margin-top: 50px;
    }
    label {
      display: block;
      margin-bottom: 10px;
      font-size: 14px;
      font-weight: bold;
    }
    input[type="text"] {
      width: 100%;
      padding: 10px;
      border-radius: 5px;
      border: none;
      margin-bottom: 20px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    input[type="hidden"] {
      display: none;
    }
    button[type="submit"] {
      display: block;
      width: 100%;
      background-color: #007bff;
      color: #fff;
      padding: 10px;
      border-radius: 5px;
      border: none;
      cursor: pointer;
    }
    button[type="submit"]:hover {
      background-color: #0062cc;
    }
</style>
</head>
<body>

<%@ include file="../header.jsp" %>	
<div id="content">

<div>
	<a href="/admin/userManagement.do" class="back">뒤로가기</a>
</div>
	<h1>회원 권한 수정</h1>
 <form id="blacklistForm" action="/updateAuthority" method="post">
   <label for="u_id">아이디:</label>
   <input type="text" name="u_id" id="u_id">
   <input type="hidden" name="u_authority" value="ROLE_BLACKLIST">
   <button type="submit">블랙리스트 부여</button>
 </form>
 <form id="userForm" action="/updateAuthority" method="post">
   <label for="u_id">아이디:</label>
   <input type="text" name="u_id" id="u_id">
   <input type="hidden" name="u_authority" value="ROLE_USER">
   <button type="submit">일반회원으로 변경</button>
 </form>



</div>
<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
