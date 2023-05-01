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
<h2>공지사항 게시판 - 수정하기(Edit)</h2>
<!-- 글쓰기 페이지를 그대로 사용하되 action 부분만 수정한다. 수정시에도
파일첨부가 있으므로 enctype속성은 추가되어야한다. -->
<form method="post" action="/aboard/aboardedit.do" >
<!-- 게시물 수정을 위한 일련번호 -->	
	<input type="hidden" name="a_num" value="${ aboardDto.a_num }"/>
	<input type="hidden" name="u_id" value="${udto.u_id}" />

	<table border="1" width="90%">
	    <tr>
	        <td>작성자</td>
	        <td>
	            <input type="text" name="u_nick" style="width:150px;" value="${aboardDto.u_nick }" readonly/>
	        </td>
	    </tr>
	    <tr>
	        <td>제목</td>
	        <td>
	            <input type="text" name="a_title" style="width:90%;" value="${ aboardDto.a_title }" />
	        </td>
	    </tr>
	    <tr>
	        <td>내용</td>
	        <td>
	            <textarea name="a_content" style="width:90%;height:100px;">${ aboardDto.a_content }</textarea>
	        </td>
	    </tr>
	    <tr>
	        <td colspan="2" align="center">
	            <button type="submit">수정 완료</button>
	            <button type="button" onclick="location.href='../aboard/aboardlist.do';">
	                목록 바로가기
	            </button>
	        </td>
	    </tr>
	</table>    
</form>
<table border="1">
		<tr>
			<th>이미지</th>
			<th>파일명</th>
			<th>파일크기</th>
			<th></th>
		</tr>
	<c:forEach items="${fileMap }" var="file" varStatus="vs">
		<tr>
			<td><img src="aUpload/${file.key }" width="200" 
					height="150" /></td>
			<td>${file.key }</td>
			<td>${file.value }Kb</td>
			<td><a href="download.do?savedFile=${file.key }&oriFile=원본파일명${vs.count }.jpg">[다운로드]</a></td>
		</tr>
	</c:forEach>
</table>
</div>
</div>
<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>