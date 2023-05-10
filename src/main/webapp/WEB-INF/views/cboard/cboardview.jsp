<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/js/lightbox.min.js"></script>
<script src="../js/lightbox/js/lightbox.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
  // 좋아요 여부를 확인하는 API 호출
  $.post("/cboard/checkLike.do", {c_num: "${cboardDto.c_num}"}, function(data) {
    if (data) { // 좋아요를 이미 눌렀을 경우
      $("#like-button").hide(); // 좋아요 버튼 숨기기
      $("#unlike-button").show(); // 좋아요 취소 버튼 보이기
    } else { // 좋아요를 누르지 않았을 경우
      $("#like-button").show(); // 좋아요 버튼 보이기
      $("#unlike-button").hide(); // 좋아요 취소 버튼 숨기기
    }
  });
  
  // 좋아요 버튼 클릭 이벤트 핸들러
  $("#like-form").submit(function(event) {
    event.preventDefault(); // 기본 동작 중지
    $.post($(this).attr("action"), function() {
      $("#like-button").hide(); // 좋아요 버튼 숨기기
      $("#unlike-button").show(); // 좋아요 취소 버튼 보이기
    });
  });
  
  // 좋아요 취소 버튼 클릭 이벤트 핸들러
  $("#unlike-form").submit(function(event) {
    event.preventDefault(); // 기본 동작 중지
    $.post($(this).attr("action"), function() {
      $("#like-button").show(); // 좋아요 버튼 보이기
      $("#unlike-button").hide(); // 좋아요 취소 버튼 숨기기
    });
  });
});
</script>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">
<link rel="stylesheet" href="../js/lightbox/css/lightbox.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/css/content.css">
</head>
<body>
<%@ include file="../header.jsp" %>
<div id="content" class="text-center">
  <h2 class="display-4">❀게시글❀</h2>
<div class="container mt-4">
  <div class="row">
    <div class="col-md-12">
      <table class="table table-bordered">
        <thead>
          <tr>
            <th scope="col" style="width: 10%">번호</th>
            <th scope="col" style="width: 30%">제목</th>
            <th scope="col" style="width: 20%">작성자</th>
            <th scope="col" style="width: 20%">작성일</th>
            <th scope="col" style="width: 10%">조회수</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th scope="row">${ cboardDto.c_num }</th>
            <td>${ cboardDto.c_title }</td>
            <td>${ cboardDto.u_nick }</td>
            <td>${ cboardDto.c_regdate }</td>
            <td>${ cboardDto.c_visitcount }</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
  <div class="row">
    <div class="col-md-9">
      ${ cboardDto.c_content }<br>
      <div class="album py-5 bg-light">
        <div class="container">
          <div class="row">
            <c:forEach items="${file}" var="f">
              <c:forEach items="${upDto}" var="i">
                <c:if test="${i.sfile == f}">
                  <div class="col-md-4">
                    <div class="card mb-4 shadow-sm">
                      <a href="../uploads/${f}" class="image-link">
                        <img class="card-img-top" src="../uploads/${f}" alt="Card image cap" width="100%" height="225">
                      </a>
                    </div>
                  </div>
                </c:if>
                <c:if test="${status.index % 3 == 2}">
                  </div><div class="row">
                </c:if>
              </c:forEach>
            </c:forEach>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<s:authorize access="hasAnyRole('USER'),('BLACKLIST')">
  <div class="btn-group d-flex justify-content-center">
    <form id="like-form" action="/cboard/like.do?c_num=${cboardDto.c_num}" method="post">
      <button id="like-button" type="submit" class="btn btn-primary mx-auto"><i class="far fa-heart"></i> 좋아요</button>
    </form>
    <form id="unlike-form" action="/cboard/unlike.do?c_num=${cboardDto.c_num}" method="post">
      <button id="unlike-button" type="submit" class="btn btn-secondary mx-auto" style="margin-left: 10px"><i class="fas fa-heart"></i> 좋아요 취소</button>
    </form>
  </div>
</s:authorize>
	<div class="btn-group d-flex justify-content-center">
	  <div class="col-sm-3">
	  <s:authorize access="hasAnyRole('USER'),('BLACKLIST')">
	    <button class="btn btn-primary mx-auto" type="button" onclick="location.href='/cboard/cboardedit.do?c_num=${cboardDto.c_num}';">수정하기</button>
	    <button class="btn btn-danger mx-auto" type="button" onclick="location.href='/cboard/cboarddelete.do?c_num=${cboardDto.c_num}';">삭제하기</button>
	    </s:authorize>
	    <button class="btn btn-secondary mx-auto" type="button" onclick="location.href='/cboard/cboardlist.do';">목록 바로가기</button>
	  </div>
	</div>
      <div class="card mt-4">
        <div class="card-body">
          <form method="post" action="/cboard/write.do">
            <div class="form-group">
              <label>댓글 작성자</label>
              <input type="text" class="form-control" name="udto.u_nick" style="width:150px;" value="${udto.u_nick}" readonly/>
            </div>
            <div class="form-group">
              <textarea class="form-control" rows="5" cols="50" name="c_content"></textarea>
            </div>
            <input type="hidden" name="c_num" value="${cboardDto.c_num}" /> <!-- 게시물 번호 -->
            <s:authorize access="hasAnyRole('USER'),('BLACKLIST')">
            <button type="submit" class="btn btn-primary">댓글 작성</button>
            </s:authorize>
          </form>
        </div>
      </div>
		<div class="container">
		  <div class="row">
		    <div class="col-md-12">
		      <ul class="list-group">
		        <c:forEach items="${reply}" var="reply">
		          <li class="list-group-item">
		            <div class="d-flex w-100 justify-content-between">
		              <h5 class="mb-1">${reply.u_id}</h5>
		              <small><fmt:formatDate value="${reply.c_regDate}" pattern="yyyy-MM-dd" /></small>
		            </div>
		            <p class="mb-1">${reply.c_content }</p>
		            <div class="d-flex justify-content-end">
		            <s:authorize access="hasAnyRole('USER'),('BLACKLIST')">
		              <a class="btn btn-sm btn-outline-secondary" href="/cboard/replymodify?c_num=${cboardDto.c_num}&c_rno=${reply.c_rno}">수정</a>
		              <a class="btn btn-sm btn-outline-danger" href="/cboard/replydelete?c_num=${cboardDto.c_num}&c_rno=${reply.c_rno}">삭제</a>
		               </s:authorize>
		            </div>
		          </li>
		        </c:forEach>
		      </ul>
		    </div>
		  </div>
		</div>

<%@ include file="../footer.jsp" %>
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
