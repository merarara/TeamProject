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
<div class="container">
<div class="container my-5">
  <div class="row justify-content-center">
    <div class="col-lg-10">
      <div class="card shadow-lg border-0 rounded-lg">
        <div class="card-header bg-dark text-white">
          <h3 class="text-center font-weight-light my-4">공지사항 게시판</h3>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-striped table-hover">
              <thead class="thead-dark">
                <tr>
                  <th scope="col" width="10%">번호</th>
                  <th scope="col" width="*">제목</th>
                  <th scope="col" width="15%">작성자</th>
                  <th scope="col" width="15%">작성일</th>
                  <th scope="col" width="15%">좋아요</th>
                  <th scope="col" width="15%">조회수</th>
                </tr>
              </thead>
              <tbody>
                <c:choose>
                  <c:when test="${ empty aboardLists }">
                    <tr>
                      <td colspan="6" align="center">
                        등록된 게시물이 없습니다^^*
                      </td>
                    </tr>
                  </c:when>
                  <c:otherwise>
                    <c:forEach items="${ aboardLists }" var="row" varStatus="loop">
                      <tr align="center">
                        <td>${ row.a_num }</td>
                        <td align="left">
                          <a href="../aboard/aboardview.do?a_num=${ row.a_num }">${ row.a_title }</a>
                        </td>
                        <td>${ row.u_id }</td>
                        <td>${ row.a_regdate }</td>
                        <td>${ row.a_like }</td>
                        <td>${ row.a_visitcount }</td>
                      </tr>
                    </c:forEach>
                  </c:otherwise>
                </c:choose>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="row justify-content-center" style="margin-bottom: 50px;">
    <div class="col-lg-5">
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <li class="page-item">
                    <c:choose>
                        <c:when test="${(page.curPage - 1) < 1 }">
                            <a class="page-link" href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a>
                        </c:when>
                        <c:otherwise>
                            <a class="page-link" href="/aboard/aboardlist.do?page=1&searchField=${searchField}&searchWord=${searchWord}" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a>
                        </c:otherwise>
                    </c:choose>
                </li>
                <c:forEach var="fEach" begin="${page.startPage }" end="${page.endPage }" step="1">
                    <li class="page-item">
                        <c:choose>
                            <c:when test="${page.curPage == fEach }">
                                <a class="page-link" href="#" aria-label="Current page"><strong>${fEach}</strong></a>
                            </c:when>
                            <c:otherwise>
                                <a class="page-link" href="/aboard/aboardlist.do?page=${fEach }&searchField=${searchField}&searchWord=${searchWord}" aria-label="Page ${fEach}">${fEach}</a>
                            </c:otherwise>
                        </c:choose>
                    </li>
                </c:forEach>
                <li class="page-item">
                    <c:choose>
                        <c:when test="${(page.curPage + 1) > page.totalPage }">
                            <a class="page-link" href="#" aria-label="Next"><span aria-hidden="true">&raquo;</span></a>
                        </c:when>
                        <c:otherwise>
                            <a class="page-link" href="/aboard/aboardlist.do?page=${page.curPage + 1 }&searchField=${searchField}&searchWord=${searchWord}" aria-label="Next"><span aria-hidden="true">&raquo;</span></a>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </nav>
    </div>
</div>
	<!-- 검색폼 -->
<div class="container my-5">
  <form action="/aboard/aboardlist.do" method="post">  
    <div class="row justify-content-center">
      <div class="col-8">
        <div class="input-group">
          <select class="form-select" name="searchField">
            <option value="a_title">제목</option>
            <option value="a_content">내용</option>
          </select>
          <input class="form-control" type="text" name="searchWord" placeholder="검색어를 입력해주세요." />
          <button class="btn btn-primary" type="submit">검색하기</button>
          <s:authorize access="hasRole('ADMIN')">
            <a class="btn btn-outline-primary" href="/aboard/aboardwrite.do">글쓰기</a>
          </s:authorize>
        </div>
      </div>
    </div>
  </form>
</div>

	
</div>

</div>
<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>