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
<script type="text/javascript">
	/* 패스워드 검증을 통해 수정페이지로 진입하므로 해당 페이지에서는
	추가로 패스워드를 입력하지 않는다. */
    function validateForm(form) {
        if (form.title.value == "") {
            alert("제목을 입력하세요.");
            form.title.focus();
            return false;
        }
        if (form.content.value == "") {
            alert("내용을 입력하세요.");
            form.content.focus();
            return false;
        }
    }
</script>
<body>

<%@ include file="../header.jsp" %>	
<div id="content">

<h2>FAQ게시판 - 글쓰기(write)</h2>
<!-- 글쓰기 페이지를 그대로 사용하되 action 부분만 수정한다. 수정시에도
파일첨부가 있으므로 enctype속성은 추가되어야한다. -->
<form action="/fboard/fboardwrite.do" method="post">
<!-- 게시물 수정을 위한 일련번호 -->	
<input type="hid_den" name="u_id" value="${ udto.u_id }"/>
<table border="1" width="90%">
    <tr>
        <td>작성자</td>
        <td>
            <input type="text" name="u_nick" style="width:150px;" value="${udto.u_nick }" readonly/>
        </td>
    </tr>
    <tr>
        <td>제목</td>
        <td>
            <input type="text" name="f_title" style="width:90%;" value="" />
        </td>
    </tr>
    <tr>
        <td>내용</td>
        <td>
            <textarea name="f_content" style="width:90%;height:100px;" ></textarea>
        </td>
    </tr>
    <tr>
        <td colspan="2" align="center">
            <button type="submit">작성 완료</button>
            <button type="reset">RESET</button>
            
            <button type="button" onclick="location.href='/fboard/fboardlist.do';">
                목록 바로가기
            </button>
        </td>
    </tr>
</table>    
</form>
</div>
<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
