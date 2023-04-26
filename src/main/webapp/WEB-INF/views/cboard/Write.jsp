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
<script type="text/javascript">
    function validateForm(form) {  // 필수 항목 입력 확인
        if (form.u_id.value.trim() == "") {
            alert("작성자를 입력하세요.");
            form.u_id.focus();
            return false;
        }
        if (form.c_title.value.trim() == "") {
            alert("제목을 입력하세요.");
            form.c_title.focus();
            return false;
        }
        if (form.c_content.value.trim() == "") {
            alert("내용을 입력하세요.");
            form.c_content.focus();
            return false;
        }
        
    }
</script>
</head>
<body>
<%@ include file="../header.jsp" %>
<div id="content">
<h2>파일 첨부형 게시판 - 글쓰기(Write)</h2>
<!-- 파일 첨부를 해야하는 경우 method는 post, enctype이 아래와 같이 지정되어야 한다. -->
<form name="writeFrm" method="post" enctype="multipart/form-data"
      action="/cboard/Write.do" onsubmit="return validateForm(this);">
<table border="1" width="90%">
    <tr>
        <td>작성자</td>
        <td>
            <input type="text" name="u_id" style="width:150px;" />
        </td>
    </tr>
    <tr>
        <td>제목</td>
        <td>
            <input type="text" name="c_title" style="width:90%;" />
        </td>
    </tr>
    <tr>
        <td>내용</td>
        <td>
            <textarea name="c_content" style="width:90%;height:100px;"></textarea>
        </td>
    </tr>    
    <tr>
        <td>멀티 파일 업로드</td>
        <td>
            <form action="multiFileUpload.do" method="post" enctype="multipart/form-data">                
                <input type="file" name="c_file" multiple /><br />                
            </form>
        </td>
    </tr>
    <tr>
        <td colspan="2" align="center">
            <button type="submit">작성 완료</button>
            <button type="reset">RESET</button>
            <button type="button" onclick="location.href='/cboard/List.do';">
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
