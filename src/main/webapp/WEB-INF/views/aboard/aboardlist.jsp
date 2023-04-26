<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
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
    <h2">FAQ 게시판 </h2>
	
	
	
<!-- 	<!-- 검색폼 -->
<div style="margin-top: 50px;">
    <form method="post">  
    <table align="center" border="1" width="90%">
    <tr>
        <td align="center">
            <select name="searchField">
                <option value="title">제목</option>
                <option value="content">내용</option>
            </select>
            <input type="text" name="searchWord" />
            <input type="submit" value="검색하기" />
        </td>
    </tr>
    </table>
    </form>

    <table align="center" border="1" width="90%">
        <tr>
            <th width="10%">번호</th>
            <th width="*">제목</th>
            <th width="15%">작성자</th>
            <th width="15%">작성일</th>
        </tr>
<c:choose>
    <c:when test="${ empty fboardLists }">  
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
        <c:forEach items="${ fboardLists }" var="row" varStatus="loop">
        <tr align="center">
        	<td>${ row.f_num }</td>
            <td align="center">
<!-- 제목을 클릭할 경우 내용보기 페이지로 이동한다. -->            
<a href="../fboard/fboardview.do?num=${ row.f_num }">${ row.f_title }</a>
			</td>
            <td>${ row.u_id }</td>
            <td>${ row.regdatef }</td> 
               <details>
        <summary>${ row.f_title }</summary>
        <ul>
            <li>${ row.f_content }</li>

        </ul>
      </details>
        </tr>
        </c:forEach>        
    </c:otherwise>    
</c:choose>
    </table>

</div>
	<a href="/fboard/fboardwrite.do">글쓰기</a>
</div>

<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
 --%>