<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<style>a{text-decoration:none;}</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">

</head>
<body>
<%@ include file="../header.jsp" %>
<!-- 게시판 영역 -->
<div class="container py-5">
  <h2 class="text-center mb-4">파일 첨부형 게시판 - 목록 보기(List)</h2>
  <!-- 목록 테이블 -->
  <div class="table-responsive">
    <table class="table table-striped table-bordered">
      <thead class="table-primary">
        <tr>
          <th scope="col" style="width: 10%;">번호</th>
          <th scope="col" style="width: 50%;">제목</th>
          <th scope="col" style="width: 15%;">작성자</th>
          <th scope="col" style="width: 15%;">작성일</th>
          <th scope="col" style="width: 5%;">좋아요</th>
          <th scope="col" style="width: 5%;">조회수</th>
        </tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${ empty cboardLists }">  
            <tr>
              <td colspan="6" class="text-center">등록된 게시물이 없습니다^^*</td>
            </tr>
          </c:when>
          <c:otherwise>  
            <c:forEach items="${ cboardLists }" var="row" varStatus="loop">
              <tr>
                <td class="align-middle">${ row.c_num }</td>
                <td class="align-middle">
                  <a href="../cboard/cboardview.do?c_num=${ row.c_num }">${ row.c_title }</a>
                </td>
                <td class="align-middle">${ row.u_id }</td>
                <td class="align-middle">${ row.c_regdate }</td>
                <td class="align-middle">${ row.c_like }</td> 
                <td class="align-middle">${ row.c_visitcount }</td>
              </tr>
            </c:forEach>        
          </c:otherwise>    
        </c:choose>
      </tbody>
    </table>
  </div>
</div>
  <!-- 페이징 및 글쓰기 버튼 -->
<div class="d-flex justify-content-between align-items-center" style="width: 100%;">
  <div>${ map.pagingImg }</div>
  <div class="text-center">
    <button type="button" class="btn btn-primary" onclick="location.href='/cboard/cboardwrite.do';">
      글쓰기
    </button>
  </div>
</div>

<!-- 검색 폼 -->
<div class="container my-5">
  <form action="/cboard/cboardlist.do" method="post" class="form-inline justify-content-center">
    <div class="form-group mx-sm-3 mb-2">
      <label for="searchField" class="sr-only">검색필드</label>
      <select name="searchField" id="searchField" class="form-control">
        <option value="c_title">제목</option>
        <option value="c_content">내용</option>
      </select>
    </div>
    <div class="form-group mx-sm-3 mb-2">
      <label for="searchWord" class="sr-only">검색어</label>
      <input type="text" name="searchWord" id="searchWord" class="form-control" placeholder="검색어를 입력하세요">
    </div>
    <button type="submit" class="btn btn-secondary mb-2">검색하기</button>
  </form>
</div>

<!-- 페이징 -->
<div class="container my-5">
  <nav aria-label="...">
    <ul class="pagination justify-content-center">
      <li class="page-item ${page.curPage == 1 ? 'disabled' : ''}">
        <a class="page-link" href="/cboard/cboardlist.do?page=${page.curPage - 1}&searchfield=${param.searchfield}&searchword=${param.searchword}&type=${param.type}&selected=${param.selected}" tabindex="-1" aria-disabled="${page.curPage == 1 ? 'true' : 'false'}">이전</a>
      </li>
      <c:forEach var="fEach" begin="${page.startPage}" end="${page.endPage}" step="1">
        <li class="page-item ${page.curPage == fEach ? 'active' : ''}">
          <a class="page-link" href="/cboard/cboardlist.do?page=${fEach}&searchfield=${param.searchfield}&searchword=${param.searchword}&type=${param.type}&selected=${param.selected}">${fEach}</a>
        </li>
      </c:forEach>
      <li class="page-item ${page.curPage == page.totalPage ? 'disabled' : ''}">
        <a class="page-link" href="/cboard/cboardlist.do?page=${page.curPage + 1}&searchfield=${param.searchfield}&searchword=${param.searchword}&type=${param.type}&selected=${param.selected}" aria-disabled="${page.curPage == page.totalPage ? 'true' : 'false'}">다음</a>
      </li>
    </ul>
  </nav>
</div>


<%@ include file="../footer.jsp" %>
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>

</html>
