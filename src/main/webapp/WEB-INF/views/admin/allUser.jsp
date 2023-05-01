<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
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
<style>
    table {
        border-collapse: collapse;
        width: 100%;
    }
    th, td {
        text-align: center;
        padding: 8px;
        border: 1px solid #ddd;
    }
    th {
        background-color: #f2f2f2;
    }
    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    tr:hover {
        background-color: #ddd;
    }
</style>
</head>
<body>

<%@ include file="../header.jsp" %>	
<div id="content">
  <form method="POST" id="" action="/admin/allUser.do">
    <button type="button" onclick="location.href='/admin/userManagement.do'">뒤로가기</button>
    <h1>전체 회원 조회</h1>
    <label for="search-id">회원 아이디 검색</label>
     <input type="text" id="searchId" name="searchId" placeholder="검색어를 입력하세요">
    <button type="submit">검색</button>
    <table>
      <thead>
        <tr>
          <th>번호</th>
          <th>아이디</th>
          <th>이름</th>
          <th>닉네임</th>
          <th>전화번호</th>
          <th>이메일</th>
          <th>권한</th>
          <th>가입일</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${userList}" var="user">
          <tr>
            <td>${user.u_num}</td>
            <td>${user.u_id}</td>
            <td>${user.u_name}</td>
            <td>${user.u_nick}</td>
            <td>${user.u_phone}</td>
            <td>${user.u_email}</td>
            <td>${user.u_authority}</td>
            <td>${user.u_reg}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
    <div class="paging" style="text-align:center">
      <c:if test="${page > 1}">
        <a href="?page=${page-1}">이전</a>
      </c:if>
       
      <c:forEach begin="1" end="${maxPage}" var="pageNum">
        <c:if test="${pageNum == page}">
          <b>${pageNum}</b>
        </c:if>
        <c:if test="${pageNum != page}">
          <a href="?page=${pageNum}">${pageNum}</a>
        </c:if>
      </c:forEach>
       
      <c:if test="${totalCount > (page * limit)}">
        <a href="?page=${page+1}">다음</a>
      </c:if>
    </div>
  </form>
</div>

<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
