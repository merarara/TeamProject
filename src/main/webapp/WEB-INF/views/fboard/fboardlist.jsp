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
<style>
/* 부모 요소에 text-align: center 추가 */
.parent-element {
  text-align: center;
}

details {
  border: 1px solid #d1d1d1;
  padding: 0.5em;
  margin: 1em 0;
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.2);
  border-radius: 4px;
  width: 50%;
}

details[open] {
  box-shadow: 0 4px 4px rgba(0, 0, 0, 0.2);
}

details summary {
  font-weight: bold;
  margin-bottom: 0.5em;
  display: inline-block;
  cursor: pointer;
  position: relative;
}

details summary:before {
  content: "";
  display: inline-block;
  height: 0.5em;
  width: 0.5em;
  margin-right: 0.5em;
  border-style: solid;
  border-width: 0.25em 0.25em 0 0;
  transform: rotate(45deg);
}

details[open] summary:before {
  transform: rotate(-135deg);
}

details caption {
  font-weight: bold;
  margin-bottom: 0.5em;
}
</style>
<script>
  //함수명이 없는 무기명함수로 정의
  let faqDel = function(f_num){
    if(confirm('삭제할까요?')){
      //<form>태그의 DOM을 얻어온다. 
      let frm = document.getElementById("deleteForm");
      //매개변수로 전달된 값을 input태그에 삽입한다. 
      frm.f_num.value = f_num;
      //폼값을 전송한다. 
      frm.submit();
    }
  }

</script>
</head>
<body>
<form id="deleteForm" name="deleteForm" method="post" action="/fboard/fboarddelete.do">
  <input type="hidden" name="f_num" value="">
</form>
<%@ include file="../header.jsp" %>	
<div id="content">
<center>
    <h2>FAQ 게시판</h2>
</center>
<div id="table-container">
	<c:choose>
    <c:when test="${ empty fboardLists }">  
        <tr>
            <td colspan="6" align="center">
                등록된 FAQ게시물이 없습니다^^*
            </td>
    </c:when>
    <c:otherwise>  
    	<!-- 출력할 게시물이 있다면 저장된 갯수만큼 반복하여 출력한다. -->
        <c:forEach items="${ fboardLists }" var="row" varStatus="loop">
        <center>
        	<details>
        		<summary>
        		${ row.f_num} : ${ row.f_title }&nbsp;&nbsp;&nbsp;
        		<s:authorize access="hasRole('ADMIN')">
        		<a href="/fboard/fboardedit.do?f_num=${row.f_num }">수정</a>&nbsp;&nbsp;
				<a href="javascript:void(0);" onclick="faqDel('${row.f_num}');">삭제</a>
				</s:authorize>
				</summary>
           			<div>${ row.f_content }</div>
      		</details>
      	</center>
        </c:forEach>        
    </c:otherwise>    
</c:choose>
</div>
</div>

<div class="row justify-content-center" style="margin-bottom: 50px">
    <ul class="pagination">
        <li class="page-item">
            <c:choose>
                <c:when test="${(page.curPage - 1) < 1}">
                    <span class="page-link"> &lt;&lt; </span>
                </c:when>
                <c:otherwise>
                    <a class="page-link" href="/fboard/fboardlist.do?page=1&searchField=${searchField}&searchWord=${searchWord}"> &lt;&lt; </a>
                </c:otherwise>
            </c:choose>
        </li>
        <li class="page-item">
            <c:choose>
                <c:when test="${(page.curPage - 1) < 1}">
                    <span class="page-link"> &lt; </span>
                </c:when>
                <c:otherwise>
                    <a class="page-link" href="/fboard/fboardlist.do?page=${page.curPage - 1 }&searchField=${searchField}&searchWord=${searchWord}"> &lt; </a>
                </c:otherwise>
            </c:choose>
        </li>

        <c:forEach var="fEach" begin="${page.startPage }" end="${page.endPage }" step="1">
            <li class="page-item">
                <c:choose>
                    <c:when test="${page.curPage == fEach}">
                        <span class="page-link"> ${fEach} </span>
                    </c:when>
                    <c:otherwise>
                        <a class="page-link" href="/fboard/fboardlist.do?page=${fEach }&searchField=${searchField}&searchWord=${searchWord}"> ${fEach } </a>
                    </c:otherwise>
                </c:choose>
            </li>
        </c:forEach>

        <li class="page-item">
            <c:choose>
                <c:when test="${(page.curPage + 1) > page.totalPage}">
                    <span class="page-link"> &gt; </span>
                </c:when>
                <c:otherwise>
                    <a class="page-link" href="/fboard/fboardlist.do?page=${page.curPage + 1 }&searchField=${searchField}&searchWord=${searchWord}"> &gt; </a>
                </c:otherwise>
            </c:choose>
        </li>
        <li class="page-item">
            <c:choose>
                <c:when test="${page.curPage == page.totalPage}">
                    <span class="page-link"> &gt;&gt; </span>
                </c:when>
                <c:otherwise>
                    <a class="page-link" href="/fboard/fboardlist.do?page=${page.totalPage }&searchField=${searchField}&searchWord=${searchWord}"> &gt;&gt; </a>
                </c:otherwise>
            </c:choose>
        </li>
    </ul>
</div>
<!-- 검색폼 -->
<div class="container my-5">
  <form action="/fboard/fboardlist.do" method="post">  
    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="input-group">
          <select class="form-select" name="searchField">
            <option value="f_title">제목</option>
            <option value="f_content">내용</option>
          </select>
          <input class="form-control" type="text" name="searchWord" placeholder="검색어를 입력해주세요." />
          <button class="btn btn-primary" type="submit">검색하기</button>
          <s:authorize access="hasRole('ADMIN')">
            <a class="btn btn-outline-primary" href="/fboard/fboardwrite.do">글쓰기</a>
          </s:authorize>
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
