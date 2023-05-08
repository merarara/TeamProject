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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
  // 좋아요 버튼 클릭 이벤트
  $('#like').click(function() {
    var a_num = $('#a_num').val(); // 수정된 부분
    likeOrUnlike(a_num, 'like');
  });

  // 싫어요 버튼 클릭 이벤트
  $('#unlike').click(function() {
    var a_num = $('#a_num').val(); // 수정된 부분
    likeOrUnlike(a_num, 'unlike');
  });
});

function likeOrUnlike(a_num, type) {
  $.ajax({
    url: '/aboard/' + type + '.do?a_num=' + a_num,
    type: 'POST',
    data: {a_num: a_num},
    success: function(result) {
      // 성공적으로 처리되었을 때 수행할 코드
      alert('처리 완료!');
    },
    error: function(xhr, status, error) {
      // 처리 중 에러가 발생했을 때 수행할 코드
      alert('처리 중 에러가 발생했습니다.');
    }
  });
}
</script>
</head>
<body>

<%@ include file="../header.jsp" %>	
<div id="content">
<h2>공지사항 게시판 - 상세 보기(View)</h2>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card">
                <div class="card-header">
                    <strong>게시글 정보</strong>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <strong>번호:</strong>
                        </div>
                        <div class="col-md-3">
                            ${ aboardDto.a_num }
                        </div>
                        <div class="col-md-3">
                            <strong>작성자:</strong>
                        </div>
                        <div class="col-md-3">
                            ${ aboardDto.u_nick }
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <strong>작성일:</strong>
                        </div>
                        <div class="col-md-3">
                            ${ aboardDto.a_regdate }
                        </div>
                        <div class="col-md-3">
                            <strong>좋아요:</strong>
                        </div>
                        <div class="col-md-3">
                            ${ aboardDto.a_like }
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <strong>조회수:</strong>
                        </div>
                        <div class="col-md-3">
                            ${ aboardDto.a_visitcount }
                        </div>
                        <div class="col-md-3">
                            <strong>제목:</strong>
                        </div>
                        <div class="col-md-3">
                            ${ aboardDto.a_title }
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <strong>내용:</strong>
                        </div>
                        <div class="col-md-9">
                            ${ aboardDto.a_content }<br>
                            <c:forEach items="${file}" var="f">
                                <c:forEach items="${aupDto }" var="i">
                                    <c:if test="${i.sfile == f}">
                                        <a href="../aUpload/${f}" data-lightbox="image">
                                            <img src="../aUpload/${f}" width="100px" height="100px">
                                        </a>
                                    </c:if>
                                </c:forEach> 
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card mt-3">
                <div class="card-body">
                    <s:authorize access="hasRole('ADMIN')">
                        <button type="button" class="btn btn-primary mr-2" 
                            onclick="location.href='../aboard/aboardedit.do?a_num=${ aboardDto.a_num }';">
                            수정하기
                        </button>
                        <button type="button" class="btn btn-danger mr-2" 
                            onclick="location.href='../aboard/aboarddelete.do?a_num=${ aboardDto.a_num }';">
                            삭제하기
                        </button>
                    </s:authorize>
                    <button type="button" class="btn btn-secondary" onclick="location.href='../aboard/aboardlist.do';">
                        목록 바로가기
                    </button>
                    <s:authorize access="hasRole('USER')">
               <%--      <form action="/aboard/like.do?a_num=${aboardDto.a_num}" method="post">
						<button type="submit" class="btn btn-primary">좋아요</button>
					</form>
					<form action="/aboard/unlike.do?a_num=${aboardDto.a_num}" method="post">
  						<button type="submit" class="btn btn-danger">싫어요</button>
					</form> --%>
					<form>
  						<input type="hidden" id="a_num" value="${aboardDto.a_num}"> <!-- 수정된 부분 -->
						<button type="button" class="btn btn-primary" id="like">좋아요</button>
						<button type="button" class="btn btn-danger" id="unlike">싫어요</button>
					</form>
                    </s:authorize>
                </div>
            </div>
        </div>
    </div>`
</div>

<s:authorize access="hasRole('USER')">
<form action="/aboard/like.do?a_num=${aboardDto.a_num}" method="post">
    <input type="submit" value="좋아요">
</form>
<form action="/aboard/unlike.do?a_num=${aboardDto.a_num}" method="post">
    <input type="submit" value="싫어요">
</form>
</s:authorize>
<div id="comment-section">
    <h3 class="mb-3">댓글</h3>
    <div class="table-responsive">
        <table class="table">
            <tbody>
                <c:forEach var="acDto" items="${acList}">
                    <tr>
                        <td class="align-middle">${acDto.u_nick}</td>
                        <td class="align-middle">${acDto.ac_comment}</td>
                        <c:if test="${acDto.u_id != udto.u_id}">
                            <s:authorize access="hasRole('USER')">
                                <td class="align-middle">
                                    <form action="/aboard/acomment/aclike.do?a_num=${acDto.a_num}" method="post">
                                        <input type="hidden" name="ac_num" value="${acDto.ac_num}">
                                        <button type="submit" class="btn btn-outline-primary">
                                            <i class="far fa-thumbs-up"></i> 좋아요
                                        </button>
                                    </form>
                                </td>
                                <td class="align-middle">
                                    <form action="/aboard/acomment/acunlike.do?a_num=${acDto.a_num}" method="post">
                                        <input type="hidden" name="ac_num" value="${acDto.ac_num}">
                                        <button type="submit" class="btn btn-outline-secondary">
                                            <i class="far fa-thumbs-down"></i> 싫어요
                                        </button>
                                    </form>
                                </td>
                            </s:authorize>
                        </c:if>
                        <c:if test="${acDto.u_id == udto.u_id}">
                            <td class="align-middle">
                                <form action="/aboard/acomment/deleteac.do?a_num=${acDto.a_num}" method="post">
                                    <input type="submit" class="btn btn-outline-danger" value="삭제">
                                    <input type="hidden" name="ac_num" value="${acDto.ac_num}">
                                </form>
                            </td>
                        </c:if>
                        <td class="align-middle">
                            <span class="badge badge-secondary">좋아요 ${ acDto.ac_like }</span>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <form action="/aboard/acomment/insertac.do" method="post" class="mt-3">
        <input type="hidden" name="a_num" value="${aboardDto.a_num}">
        <div class="form-group">
            <textarea name="ac_comment" rows="3" class="form-control"></textarea>
        </div>
        <button type="submit" class="btn btn-primary">댓글 입력</button>
    </form>
</div>

</div>
</div>
<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>