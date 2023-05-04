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
<div class="container text-center" id="content">
    <h2>파일 첨부형 게시판 - 목록 보기(List)</h2>
	
    
    <!-- 목록 테이블 -->
<table class="table table-striped " align="center" border="1" width="90%">
<thead class="table-primary">
        <tr>
            <th scope="col" width="10%">번호</th>
            <th scope="col" width="*">제목</th>
            <th scope="col" width="15%">작성자</th>
            <th scope="col" width="15%">작성일</th>
            <th scope="col" width="15%">좋아요</th>
            <th scope="col" width="15%">조회수</th>
        </tr>
</thead>
<tbody class="table-group-divider">
<c:choose>
    <c:when test="${ empty cboardLists }">  
    	<!-- 게시물을 저장하고 있는 boardLists 컬렉션에 저장된 내용이 없다면
    	아래와 같이 출력한다. -->
        <tr>
            <td colspan="6" align="center">
                등록된 게시물이 없습니다^^*
            </td>
        </tr>
    </c:when>
    <c:otherwise>  
    	<!-- 출력할 게시물이 있다면 저장된 갯수만큼 반복하여 출력한다. -->
        <c:forEach items="${ cboardLists }" var="row" varStatus="loop">
        <tr align="center">
        	<td>${ row.c_num }</td>
            <td align="center">
<!-- 제목을 클릭할 경우 내용보기 페이지로 이동한다. -->            
<a href="../cboard/cboardview.do?c_num=${ row.c_num }">${ row.c_title }</a>
			</td>
            <td>${ row.u_id }</td>
            <td>${ row.c_regdate }</td>
            <td>${ row.c_like }</td> 
            <td>${ row.c_visitcount }</td>
        </tr>
        </c:forEach>        
    </c:otherwise>    
</c:choose>
    </table>
    <table align="center" border="1" width="90%">
            <td>
                ${ map.pagingImg }
            </td>
            <td width="100"><button type="button" class="btn btn-primary" onclick="location.href='/cboard/cboardwrite.do';">글쓰기</button></td>
	</tbody>
    </table>
</div>
<div align="center" style="margin-bottom: 50px;">
	<table>
		<tr>
			<td>
			    <nav aria-label="...">
			      <ul class="pagination">
			        <li class="page-item ${page.curPage == 1 ? 'disabled' : ''}">
			          <a class="page-link" href="/cboard/cboardlist.do?page=${page.curPage - 1}&searchfield=${param.searchfield}&searchword=${param.searchword}&type=${param.type}&selected=${param.selected}" tabindex="-1" aria-disabled="${page.curPage == 1 ? 'true' : 'false'}">이전 </a>
			        </li>
			        <c:forEach var="fEach" begin="${page.startPage}" end="${page.endPage}" step="1">
			          <li class="page-item ${page.curPage == fEach ? 'active' : ''}">
			            <a class="page-link" href="/cboard/cboardlist.do?page=${fEach}&searchfield=${param.searchfield}&searchword=${param.searchword}&type=${param.type}&selected=${param.selected}">${fEach}</a>
			          </li>
			        </c:forEach>
			        <li class="page-item ${page.curPage == page.totalPage ? 'disabled' : ''}">
			          <a class="page-link" href="/cboard/cboardlist.do?page=${page.curPage + 1}&searchfield=${param.searchfield}&searchword=${param.searchword}&type=${param.type}&selected=${param.selected}" aria-disabled="${page.curPage == page.totalPage ? 'true' : 'false'}">다음 </a>
			        </li>
			      </ul>
			    </nav>
			</td>
		</tr>
	</table>
</div>


<!-- 검색폼 -->
<div style="margin-top: 50px; text-align: center;">
  <form action="/cboard/cboardlist.do" method="post">  
    <table align="center" border="1" width="30%">
      <tr>
        <td align="center">
          <select name="searchField">
            <option value="c_title">제목</option>
            <option value="c_content">내용</option>
          </select>
          <input type="text" name="searchWord" />
          <input class="btn btn-secondary" type="submit" value="검색하기" />&nbsp;&nbsp;
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
