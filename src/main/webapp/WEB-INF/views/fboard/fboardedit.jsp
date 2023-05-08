<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s" %>
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
</head>
<body>
<%@ include file="../header.jsp" %>	
<div id="content">
<div class="container">
  <h2 class="text-center">FAQ게시판 - 수정하기(Edit)</h2>
  <form action="/fboard/fboardedit.do" method="post">
    <input type="hidden" name="f_num" value="${fboardDto.f_num}" />
    <input type="hidden" name="u_id" value="${udto.u_id}" />
    <div class="form-group">
      <label for="title">제목</label>
      <input type="text" class="form-control" id="title" name="f_title" value="${fboardDto.f_title}">
    </div>
    <div class="form-group">
      <label for="content">내용</label>
      <textarea class="form-control" id="content" name="f_content" rows="10">${fboardDto.f_content}</textarea>
    </div>
    <div class="text-center">
      <button type="submit" class="btn btn-primary mr-2">수정 완료</button>
      <button type="button" class="btn btn-secondary" onclick="location.href='/fboard/fboardlist.do';">목록 바로가기</button>
    </div>
  </form>
</div> 

</div>
<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
