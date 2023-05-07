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
<h2 class="text-center">공지사항 게시판 - 수정하기</h2>

<form method="post" action="/aboard/aboardedit.do" enctype="multipart/form-data">
    <!-- 게시물 수정을 위한 일련번호 -->    
    <input type="hidden" name="a_num" value="${aboardDto.a_num}"/>
    <input type="hidden" name="u_id" value="${udto.u_id}" />

    <div class="container">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="form-group">
                    <label for="u_nick">작성자</label>
                    <input type="text" class="form-control" id="u_nick" name="u_nick" value="${aboardDto.u_nick}" readonly>
                </div>
                <div class="form-group">
                    <label for="a_title">제목</label>
                    <input type="text" class="form-control" id="a_title" name="a_title" value="${aboardDto.a_title}">
                </div>
                <div class="form-group">
                    <label for="a_content">내용</label>
                    <textarea class="form-control" id="a_content" name="a_content" rows="10">${aboardDto.a_content}</textarea>
                </div>
                <div class="form-group">
                    <label for="user_file">첨부파일</label>
                    <input type="file" class="form-control-file" id="user_file" name="user_file" multiple>
                </div>
                <div class="form-group">
                    <label for="file_list">첨부파일 목록</label>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th scope="col"></th>
                                <th scope="col">파일명</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${aupDto}" var="file">
                                <tr>
                                    <td><input type="checkbox" name="file" value="${file.sfile}"></td>
                                    <td>${file.ofile}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary mr-2">수정 완료</button>
                    <button type="button" class="btn btn-secondary" onclick="location.href='../aboard/aboardlist.do';">목록 바로가기</button>
                </div>
            </div>
        </div>
    </div>
</form>
</div>
<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>