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
    <h2>공지사항 게시판 </h2>
<!-- 검색폼 -->
<div style="margin-top: 50px;">
    <form action="/aboard/searchAboard.do" method="post">  
    <table align="center" border="1" width="90%">
    <tr>
        <td align="center">
            <select name="searchField">
                <option value="a_title">제목</option>
                <option value="a_content">내용</option>
            </select>
            <input type="text" name="searchWord" />
            <input type="submit" value="검색하기" />&nbsp;&nbsp;
            <s:authorize access="hasRole('ADMIN')">
                    <a href="/aboard/aboardwrite.do">글쓰기</a>
            </s:authorize>
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
            <th width="15%">조회수</th>
        </tr>
<c:choose>
    <c:when test="${ empty aboardLists }">  
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
        <c:forEach items="${ aboardLists }" var="row" varStatus="loop">
        <tr align="center">
        	<td>${ row.a_num }</td>
            <td align="center">
<!-- 제목을 클릭할 경우 내용보기 페이지로 이동한다. -->            
<a href="../aboard/aboardview.do?a_num=${ row.a_num }">${ row.a_title }</a>
			</td>
            <td>${ row.u_id }</td>
            <td>${ row.a_regdate }</td> 
            <td>${ row.a_visitcount }</td>
        </tr>
        </c:forEach>        
    </c:otherwise>    
</c:choose>
    </table>

</div>
<div align="center" style="margin-bottom: 50px";>
	<tr>
		<td colspan="5">
		<!-- 처음 -->
		<c:choose>
		<c:when test="${(page.curPage - 1) < 1 }">
			[ &lt;&lt; ]
		</c:when>
		<c:otherwise>
			<a href="/aboard/aboardlist.do??page=1&searchfield=${param.searchfield}&searchword=${param.searchword}&type=${param.type}&selected=${ param.selected }">[ &lt;&lt; ]</a>
		</c:otherwise>
		</c:choose>
		<!-- 이전 -->
		<c:choose>
		<c:when test="${(page.curPage - 1) < 1 }">
			[ &lt; ]
		</c:when>
		<c:otherwise>
			<a href="/aboard/aboardlist.do?page=${page.curPage - 1 }&searchfield=${param.searchfield}&searchword=${param.searchword}&type=${param.type}&selected=${ param.selected }">[ &lt; ]</a>
		</c:otherwise>
		</c:choose>
		
		<!-- 개별 페이지 -->
		<c:forEach var="fEach" begin="${page.startPage }" end="${page.endPage }" step="1">
			<c:choose>
			<c:when test="${page.curPage == fEach }">
				[ ${fEach} ] &nbsp;
			</c:when>
			<c:otherwise>
				<a href="/aboard/aboardlist.do?page=${fEach }&searchfield=${param.searchfield}&searchword=${param.searchword}&type=${param.type}&selected=${ param.selected }">[ ${fEach } ]</a> &nbsp;
			</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<!-- 다움 -->
		<c:choose>
		<c:when test="${(page.curPage + 1) > page.totalPage }">
			[ &gt; ]
		</c:when>
		<c:otherwise>
			<a href="/aboard/aboardlist.do?page=${page.curPage + 1 }">[ &gt; ]</a>
		</c:otherwise>
		</c:choose>
		<!-- 끝 -->
		<c:choose>
		<c:when test="${page.curPage == page.totalPage }">
			[ &gt;&gt; ]
		</c:when>
		<c:otherwise>
			<a href="/aboard/aboardlist.do?page=${page.totalPage }">[ &gt;&gt; ]</a>
		</c:otherwise>
		</c:choose>
		</td>
	</tr>	
</div>
</div>
<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>