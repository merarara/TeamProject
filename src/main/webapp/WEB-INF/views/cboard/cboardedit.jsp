<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<div align="center">
    <h1>게시물 수정하기</h1>
<div>
    <h3>게시물 수정</h3>
    <form action="/cboard/cboardedit.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="c_num" value="${cboardDto.c_num}">

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
                <td colspan="3"><input type="text" name="c_title" value="${ cboardDto.c_title }"></td>
            </tr>
            <tr>
               <td>내용</td>
			<td colspan="3">
			    <textarea name="c_content" rows="10">${cboardDto.c_content}</textarea>
			    <br>
			<div class="box-footer" id="fileDiv">
            <a href="#this" class="btn btn-default file_add" onclick="addFile()">파일추가</a><br/><br/>
            <c:forEach items="${upDto }" var="i">
            	<p>
            	<span class="cboard-file" aria-hidden="true"></span>
            	${i.sfile }
            	<input type="hidden" name="FILE_${i.c_num }" value="true">
            	<a href="#this" class="btn" name="delete">삭제</a>
            	</p>
           </c:forEach>
        </div>
		</td>
		</tr>
		<tr>
		<td>첨부파일</td>
		<td>
		    <c:forEach items="${upDto}" var="i">
		        <c:if test="${i.sfile == cboardDto.c_num}">
		            <a href="download.do?savedFile=${i.sfile}&oriFile=${i.ofile}">${i.ofile}</a>
		            <br>
		        </c:if>
		    </c:forEach>
		</td>
		</tr>
		<tr>
		<td colspan="4" align="center">
		    <button type="submit">수정완료</button>
		    <button type="button" onclick="location.href='/cboard/cboardlist.do';">목록 바로가기</button>
		</td>
		</tr>
		</table>
		</form>
		<script type="text/javascript">
		var gfv_count = 1;
		$(document).ready(function(){
            $("a[name='delete']").on("click", function(e){
                e.preventDefault();
                deleteFile($(this));
            });
		})
		function addFile() {
			var str = "<p><input type='file' name='file' class='file_input'><a href='#this' class='btn' name='delete'>삭제</a></p>";
			$("#fileDiv").append(str);
			 $("a[name='delete']").on("click", function(e){
	                e.preventDefault();
	                deleteFile($(this));
	            });
		}
		function deleteFile(obj) {
			obj.parent().remove();
		}
</script>




<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>