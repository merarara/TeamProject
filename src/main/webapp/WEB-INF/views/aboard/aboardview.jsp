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
<table border="1" width="90%">
    <colgroup>
        <col width="15%"/> <col width="35%"/>
        <col width="15%"/> <col width="*"/>
    </colgroup>

 <!-- 게시글 정보 -->
    <tr>
        <td>번호</td> 
        <td>${ aboardDto.a_num }</td>
        <td>작성자</td> 
        <td>${ aboardDto.u_nick }</td>
    </tr>
    <tr>
        <td>작성일</td> 
        <td>${ aboardDto.a_regdate }</td>
        <td>좋아요</td>
        <td>${ aboardDto.a_like }</td>
        <td>조회수</td> 
        <td>${ aboardDto.a_visitcount }</td>
    </tr>
    <tr>
        <td>제목</td>
        <td colspan="3">${ aboardDto.a_title }</td>
    </tr>
    <tr>
        <td>내용</td>
        <td colspan="3">
        	${ aboardDto.a_content }</br>
        	
        <c:forEach items="${file}" var="f">
	        <c:forEach items="${aupDto }" var="i">
	  			<c:if test="${i.sfile == f}">
	   				 <a href="../aUpload/${f}" data-lightbox="image">
	     			 <img src="../aUpload/${f}" width="100px" height="100px">
	    			 </a>
	  			</c:if>
			</c:forEach>	
		</c:forEach>
        </td>
    </tr>

    <!-- 하단 메뉴(버튼) -->
    <tr>
        <td colspan="4" align="center">
        	<s:authorize access="hasRole('ADMIN')">
            <button type="button" 
            	onclick="location.href='../aboard/aboardedit.do?a_num=${ aboardDto.a_num }';">
                수정하기
            </button>&nbsp;&nbsp;
            <button type="button" 
            	onclick="location.href='../aboard/aboarddelete.do?a_num=${ aboardDto.a_num }';">
                삭제하기
            </button>&nbsp;&nbsp;
          	</s:authorize>
            <button type="button" onclick="location.href='../aboard/aboardlist.do';">
                목록 바로가기
            </button>
        </td>
    </tr>
</table>
<s:authorize access="hasRole('USER')">
<form action="/aboard/like.do?a_num=${aboardDto.a_num}" method="post">
    <input type="submit" value="좋아요">
</form>
<form action="/aboard/unlike.do?a_num=${aboardDto.a_num}" method="post">
    <input type="submit" value="싫어요">
</form>
<h3>댓글</h3>
<table>
	<tr>
	<td>${ acDto.u_nick }</td>
	<td>${ acDto.ac_comment }</td>
	</tr>
</table>
    <form action="/aboard/acomment/insertac.do" method="post">
        <input type="hidden" name="a_num" value="${aboardDto.a_num}">
        <textarea name="ac_comment" rows="1" cols="100"></textarea>
        <button type="submit">댓글 입력</button>
</form>
</s:authorize>
</div>
<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>