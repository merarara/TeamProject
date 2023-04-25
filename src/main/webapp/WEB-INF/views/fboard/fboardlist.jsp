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
	let memberDel = function(userid){
		if(confirm('삭제할까요?')){
			//<form>태그의 DOM을 얻어온다. 
			let frm = document.deleteForm;
			//매개변수로 전달된 값을 input태그에 삽입한다. 
			frm.id.value = userid;
			//<form>태그에 속성을 부여한다. 
			frm.method = "post";
			frm.action = "delete.do";
			//폼값을 전송한다. 
			frm.submit();
		}
	}
</script>
</head>
<body>

<%@ include file="../header.jsp" %>	
<div id="content">
	<center>
    <h2>FAQ</h2>
	<center>
<!-- 검색폼 -->
<div style="margin-top: 50px;">
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

<div id="container">
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
        		<a href="edit.do?id=${row.u_id }">수정</a>&nbsp;&nbsp;
				<a href="javascript:void(0);" onclick="memberDel('${row.u_id }');">삭제</a>
				</summary>
           			<div>${ row.f_content }</div>
      		</details>
      	</center>
        </c:forEach>        
    </c:otherwise>    
</c:choose>
</div>
</div>
	
</div>
<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
