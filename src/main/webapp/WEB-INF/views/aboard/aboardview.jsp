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
function toggleLike() {
    $.ajax({
        type: 'POST',
        url: '/aboard/toggleLike.do',
        data: {"a_num": a_num},
        dataType: 'json',
        success: function(result) {
            if (result.success) {
                // 좋아요 상태가 변경되면 버튼의 색상을 변경합니다.
                if (result.liked) {
                    $('#likeButton_' + a_num).addClass('liked');
                } else {
                    $('#likeButton_' + a_num).removeClass('liked');
                }
                // 좋아요 개수를 갱신합니다.
                $('#likeCount_' + a_num).text(result.likeCount);
            } else {
                alert(result.errorMessage);
            }
        },
        error: function(xhr, status, error) {
            alert(error);
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
                        <div class="d-inline-block ml-2">
                            <button type="button" class="btn btn-outline-primary" onclick="like('${ aboardDto.a_num }')">
                                <i class="far fa-thumbs-up"></i> 좋아요
                            </button>
                        </div>
                    </s:authorize>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>