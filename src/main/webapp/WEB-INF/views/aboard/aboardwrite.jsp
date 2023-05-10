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
<script>
function validateForm() {
    var a_title = document.getElementById("a_title").value;
    var a_content = document.getElementById("a_content").value;

    if (!a_title || !a_content) {
      alert("제목 및 내용을 입력해주세요.");
      return false;
    }
    
    return true;
  }
</script>
</head>
<body>

<%@ include file="../header.jsp" %>	
<div id="content">

<h2>공지사항 게시판 - 글쓰기(write)</h2>
<form action="/aboard/aboardwrite.do" method="post" modelAttribute="aboardDto" enctype="multipart/form-data" class="p-4" onsubmit="return validateForm()">
  <!-- 게시물 수정을 위한 일련번호 -->	
  <input type="hidden" name="u_id" value="${ udto.u_id }"/>

  <div class="form-group row">
    <label for="u_nick" class="col-sm-2 col-form-label">작성자</label>
    <div class="col-sm-10">
      <input type="text" name="u_nick" id="u_nick" class="form-control" value="${udto.u_nick }" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="a_title" class="col-sm-2 col-form-label">제목</label>
    <div class="col-sm-10">
      <input type="text" name="a_title" id="a_title" class="form-control" value="">
    </div>
  </div>
  <div class="form-group row">
    <label for="a_content" class="col-sm-2 col-form-label">내용</label>
    <div class="col-sm-10">
      <textarea name="a_content" id="a_content" class="form-control" rows="10"></textarea>
    </div>
  </div>
  <div class="form-group row">
    <label for="user_file" class="col-sm-2 col-form-label">첨부파일</label>
    <div class="col-sm-10">
      <input type="file" name="user_file" id="user_file" multiple>
    </div>
  </div>
  <div class="form-group row">
    <div class="col-sm-12 text-center">
      <button type="submit" class="btn btn-primary mr-2">작성 완료</button>
      <button type="reset" class="btn btn-secondary mr-2">RESET</button>
      <button type="button" class="btn btn-info" onclick="location.href='../aboard/aboardlist.do';">
        목록 바로가기
      </button>
    </div>
  </div>
</form>
</div>
<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>