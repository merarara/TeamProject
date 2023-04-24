<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴 페이지</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/css/content.css">
</head>
<body>
<%@ include file="../header.jsp" %>	
<div class="container mt-5">
	<div class="card">
		<div class="card-header">
			<h1 class="text-center">회원 탈퇴 페이지</h1>
		</div>
		<div class="card-body">
			<form:form method="post" action="/user/delete.do" class="text-center" onsubmit="return checkPassword();">
				<p>정말로 회원 탈퇴하시겠습니까?</p>
				<p>탈퇴 후에는 복구가 불가능합니다.</p>
				<div class="form-group">
					<input type="password" class="form-control" id="password_check" name="u_pw">
				</div>
				<div class="form-group">
					<button type="submit" class="btn btn-danger">회원 탈퇴</button>
				</div>
			</form:form>
		</div>
	</div>
</div>

<%@ include file="../footer.jsp" %>


<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<script>
function checkPassword() {
  if (confirm("정말로 회원 탈퇴하시겠습니까?")) {
    return true;
  } else {
    return false;
  }
}
</script>

</body>
</html>
