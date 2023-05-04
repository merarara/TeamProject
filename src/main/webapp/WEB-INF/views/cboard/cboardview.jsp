<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
</head>
<body>
<%@ include file="../header.jsp" %>
<div id="content">
<h2>파일 첨부형 게시판 - 상세 보기(View)</h2>

<table border="1" width="90%">
    <colgroup>
        <col width="15%"/> <col width="35%"/>
        <col width="15%"/> <col width="*"/>
    </colgroup> 
    <tr>
        <td>번호</td> <td>${ cboardDto.c_num }</td>
        <td>작성자</td> <td>${ cboardDto.u_nick }</td>
    </tr>
    <tr>
        <td>작성일</td> <td>${ cboardDto.c_regdate }</td>
        <td>조회수</td> <td>${ cboardDto.c_visitcount }</td>
    </tr>
    <tr>
        <td>제목</td>
        <td colspan="3">${ cboardDto.c_title }</td>
    </tr>
    <tr>
        <td>내용</td>
        <td colspan="3" height="100">${ cboardDto.c_content }
        <c:forEach items="${fileMap }" var="file" varStatus="vs">
		    <tr>
		        <img src="uploads/${c_file_path }" width="200" height="50" />
		    </tr>
		</c:forEach> 

        <!-- 첨부한 파일이 이미지라면 img태그로 화면에 출력한다. -->
        
    </tr> 
    <tr>
        <td>첨부파일</td>
			<td>          
			  <c:forEach items="${fileMap }" var="file">
			    <p>${c_file_path }</p>
			  </c:forEach>
			</td>


         <td>다운로드수</td>
        <td>${ view.c_downcount }</td>
    </tr> 
    <tr>
        <td colspan="4" align="center">
            <button type="button" onclick="location.href='/cboard/cboardedit.do?c_num=${view.c_num}';">수정하기</button>
            <button type="button" onclick="location.href='/cboard/delete?c_num=${view.c_num}';">삭제하기</button>
            <button type="button" onclick="location.href='/cboard/cboardlist.do';">목록 바로가기</button>
        </td>
    </tr>
</table>
</div>
<!-- 댓글 시작 -->

<hr />

<ul>
	<!-- <li>
		<div>
			<p>첫번째 댓글 작성자</p>
			<p>첫번째 댓글</p>
		</div>
	</li>
	<li>
		<div>
			<p>두번째 댓글 작성자</p>
			<p>두번째 댓글</p>
		</div>
	</li>
	<li>
		<div>
			<p>세번째 댓글 작성자</p>
			<p>세번째 댓글</p>
		</div>
	</li> -->
	
	<c:forEach items="${c_reply}" var="reply">
	<li>
		<div>
			<p>${reply.u_id} / <fmt:formatDate value="${reply.c_postdate}" pattern="yyyy-MM-dd" />
			<p>${reply.c_content }</p>
						
			<p>
				<a href="/reply/modify?c_num=${cboardDto.c_num}&c_rno=${reply.c_rno}">수정</a> / <a href="/reply/delete?c_num=${cboardDto.c_num}&c_rno=${reply.c_rno}">삭제</a>
			</p>
			
			<hr />
			
		</div>
	</li>	
	</c:forEach>
</ul>

<div>

	<form method="post" action="/reply/write">
	
		<p>
			<label>댓글 작성자</label> <input type="text" name="u_id">
		</p>
		<p>
			<textarea rows="5" cols="50" name="c_content"></textarea>
		</p>
		<p>
			<input type="hidden" name="c_num" value="${cboardDto.c_num}">
			<button type="submit">댓글 작성</button>
		</p>
	</form>
	
</div>

<%@ include file="../footer.jsp" %>
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
