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
        <td>조회수</td> 
        <td>${ aboardDto.a_visitcount }</td>
    </tr>
    <tr>
        <td>제목</td>
        <td colspan="3">${ aboardDto.a_title }</td>
    </tr>
    <tr>
        <td>내용</td>
        <td colspan="3" height="100">
        	${ aboardDto.a_content }
        </td>
    </tr>
<tr>
      	<table border="1">
		<tr>
			<th>이미지</th>
			<th>파일명</th>
			<th>파일크기</th>
			<th></th>
		</tr>
	<c:forEach items="${fileMap }" var="file" varStatus="vs">
		<tr>
			<td><img src="uploads/${file.key }" width="200" 
					height="150" /></td>
			<td>${file.key }</td>
			<td>${file.value }Kb</td>
			<td><a href="download.do?savedFile=${file.key }&oriFile=원본파일명${vs.count }.jpg">[다운로드]</a></td>
		</tr>
	</c:forEach>
	</table> 	
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
<%-- <table border="1">
		<tr>
			<th>이미지</th>
			<th>파일명</th>
			<th>파일크기</th>
			<th></th>
		</tr>
	<c:forEach items="${fileMap }" var="file" varStatus="vs">
		<tr>
			<td><img src="uploads/${file.key }" width="200" 
					height="150" /></td>
			<td>${file.key }</td>
			<td>${file.value }Kb</td>
			<td><a href="download.do?savedFile=${file.key }&oriFile=원본파일명${vs.count }.jpg">[다운로드]</a></td>
		</tr>
	</c:forEach>
	</table>  --%>
</div>
<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>