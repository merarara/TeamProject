<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script>
  function like(c_num) {
    $.ajax({
        type: "POST",
        url: "like.do",
        data: {"c_num": c_num},
        dataType: "text",
        success: function (data) {
            if (data == "login") {
                alert("로그인이 필요합니다.");
                location.href = "../login/loginform.do";
            } else if (data == "liked") {
                console.log("좋아요 버튼 클릭:", c_num, "좋아요");
                var cnt = parseInt($("#likecnt").text()) + 1;
                $("#likecnt").text(cnt);
                $(".like-btn i").removeClass("far").addClass("fas").css("color", "red");
            } else if (data == "unliked") {
                console.log("좋아요 버튼 클릭:", c_num, "좋아요 취소");
                var cnt = parseInt($("#likecnt").text()) - 1;
                $("#likecnt").text(cnt);
                $(".like-btn i").removeClass("fas").addClass("far").css("color", "");
            } else {
                alert("오류가 발생하였습니다.");
            }
        },
        error: function () {
            alert("오류가 발생하였습니다.");
        }
    });
}
</script>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/css/content.css">
</head>
<body>
<%@ include file="../header.jsp" %>
<div id="content">
<h2>파일 첨부형 게시판 - 상세 보기(View)</h2>
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
      <div class="card">
        <div class="card-body">
          <h5 class="card-title">${ cboardDto.c_title }</h5>
          <p class="card-text">${ cboardDto.c_content }</p>
          <div class="row">
			  <div class="col-md-12">
			    <ul class="list-group list-group-flush">
			      <c:forEach items="${file}" var="f">
			        <c:forEach items="${upDto }" var="i">
			          <c:if test="${i.sfile == f}">
			            <li class="list-group-item">
			              <a href="../uploads/${f}" class="image-link">
			                <img src="../uploads/${f}" width="100px" height="100px" class="img-thumbnail">
			              </a>
			            </li>
			          </c:if>
			        </c:forEach>
			      </c:forEach>
			    </ul>
			  </div>
			</div>
        </div>
      </div>
	<div class="text-center">
    <c:set var="isLiked" value="${asv.checkLiked(c_num, u_id)}" />
    <c:choose>
        <c:when test="${not isLiked}">
            <a href="#" class="like-btn" data-cnum="${c_num}">
                <i class="far fa-heart" style="cursor:pointer; font-size: 20px;"></i>
            </a>
        </c:when>
        <c:otherwise>
            <a href="#" class="like-btn" data-cnum="${c_num}">
                <i class="fas fa-heart" style="cursor:pointer; font-size: 20px; color: red;"></i>
            </a>
        </c:otherwise>
	    </c:choose>
	    <span id="likecnt" style="margin-left:5px;">${likecnt}</span>
	</div>
	<div class="row justify-content-center my-3">
	  <div class="col-sm-6">
	    <button class="btn btn-primary mx-2" type="button" onclick="location.href='/cboard/cboardedit.do?c_num=${cboardDto.c_num}';">수정하기</button>
	    <button class="btn btn-danger mx-2" type="button" onclick="location.href='/cboard/delete?c_num=${cboardDto.c_num}';">삭제하기</button>
	    <button class="btn btn-secondary mx-2" type="button" onclick="location.href='/cboard/cboardlist.do';">목록 바로가기</button>
	  </div>
	</div>
      <div class="card mt-4">
        <div class="card-body">
          <h5 class="card-title">댓글 작성</h5>
          <form method="post" action="/cboard/write.do">
            <div class="form-group">
              <label>댓글 작성자</label>
              <input type="text" class="form-control" name="udto.u_nick" style="width:150px;" value="${udto.u_nick}" readonly/>
            </div>
            <div class="form-group">
              <textarea class="form-control" rows="5" cols="50" name="c_content"></textarea>
            </div>
            <input type="hidden" name="c_num" value="${vo.c_num}" /> <!-- 게시물 번호 -->
            <button type="submit" class="btn btn-primary">댓글 작성</button>
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
		              <a class="btn btn-sm btn-outline-secondary" href="/cboard/replymodify?c_num=${cboardDto.c_num}&c_rno=${reply.c_rno}">수정</a>
		              <a class="btn btn-sm btn-outline-danger" href="/cboard/replydelete?c_num=${cboardDto.c_num}&c_rno=${reply.c_rno}">삭제</a>
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
