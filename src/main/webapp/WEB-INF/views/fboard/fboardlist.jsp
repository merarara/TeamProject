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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
  let memberDel = function(f_num){
    if(confirm('삭제할까요?')){
      //<form>태그의 DOM을 얻어온다. 
      let frm = document.getElementById("deleteForm");
      //매개변수로 전달된 값을 input태그에 삽입한다. 
      frm.f_num.value = f_num;
      //폼값을 전송한다. 
      frm.submit();
    }
  }
  
  $(document).on('click', '.page-link', function(e) {
	  e.preventDefault();
	  var url = $(this).attr('href');
	  $.ajax({
	    url: url,
	    type: 'GET',
	    success: function(data) {
	      $('#table-container').html(data); // 데이터를 받아와서 출력하는 부분을 적절히 수정해야 함
	    },
	    error: function() {
	      console.log('Error occurred while fetching data.');
	    }
	  });
	});

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
        		<a href="/fboard/fboardedit.do?f_num=${row.f_num }">수정</a>&nbsp;&nbsp;
				<a href="javascript:void(0);" onclick="memberDel('${row.f_num}');">삭제</a>
				</summary>
           			<div>${ row.f_content }</div>
      		</details>
      	</center>
        </c:forEach>        
    </c:otherwise>    
</c:choose>
</div>

</div>
<!-- 페이징 처리 시작 -->
<c:if test="${totalPage gt 1}">
  <div class="pagination justify-content-center">
    <ul class="pagination">
      <!-- 처음 페이지로 이동 -->
      <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
        <a class="page-link" href="${pageUrl}?currentPage=1${searchParams}" aria-label="Previous">
          <span aria-hidden="true">&laquo;</span>
          <span class="sr-only">Previous</span>
        </a>
      </li>
      
      <!-- 이전 페이지로 이동 -->
      <c:forEach var="i" begin="1" end="${totalPage}">
        <c:if test="${i <= (currentPage + 2) && i >= (currentPage - 2)}">
          <li class="page-item ${i == currentPage ? 'active' : ''}">
            <a class="page-link" href="${pageUrl}?currentPage=${i}${searchParams}">${i}</a>
          </li>
        </c:if>
      </c:forEach>
      
      <!-- 마지막 페이지로 이동 -->
      <li class="page-item ${currentPage == totalPage ? 'disabled' : ''}">
        <a class="page-link" href="${pageUrl}?currentPage=${totalPage}${searchParams}" aria-label="Next">
          <span aria-hidden="true">&raquo;</span>
          <span class="sr-only">Next</span>
        </a>
      </li>
    </ul>
  </div>
</c:if>
<!-- 페이징 처리 끝 -->
<!-- 검색폼 -->
<div style="margin-bottom: 50px";>
    <form method="post">  
    <table align="center" border="1" width="30%">
    <tr>
        <td align="center">
            <select name="searchField">
                <option value="title">제목</option>
                <option value="content">내용</option>
            </select>
            <input type="text" name="searchWord" />
            <input type="submit" value="검색하기" />&nbsp;&nbsp;
            <a href="/fboard/fboardwrite.do">글쓰기</a>
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
