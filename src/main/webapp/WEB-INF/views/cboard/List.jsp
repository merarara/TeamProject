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
<div id="content">
    <h2>파일 첨부형 게시판 - 목록 보기(List)</h2>
	
    <!-- 검색 폼 -->
    <form method="get">  
    <table border="1" width="90%">
    <tr>
        <td align="center">
            <select name="searchField">
                <option value="title">제목</option>
                <option value="content">내용</option>
                <option value="name">작성자</option>
            </select>
            <input type="text" name="searchWord" />
            <input type="submit" value="검색하기" />
        </td>
    </tr>
    </table>
    </form>

    <!-- 목록 테이블 -->
    <table border="1" width="90%">
        <tr>
            <th width="10%">번호</th>
            <th width="*">제목</th>
            <th width="15%">작성자</th>
            <th width="10%">조회수</th>
            <th width="15%">작성일</th>
            <th width="8%">첨부</th>
        </tr>
<!-- 게시물이 없을 때 -->
<c:choose>
	<c:when test="${ empty boardLists }">
        <tr>
            <td colspan="6" align="center">
                등록된 게시물이 없습니다^^*
            </td>
        </tr>
    </c:when>
    <c:otherwise>
    	<c:forEach items="${ boardLists }" var="row" varStatus="loop">
<!-- 출력할 게시물이 있을때 -->           
        <tr align="center">
            <td>
            	${ map.totalCount - (((map.pageNum-1) * map.pageSize)
            		+ loop.index)}
            </td>
            <td align="left">
                <a href="/cboard/View.do?c_num=${ row.c_num }">
                ${ row.c_title }</a>
            </td> 
            <td>${ row.u_id }</td>
            <td>${ row.c_visitcount }</td>
            <td>${ row.c_postdate }</td>
            <td>
                <c:if test="${ not empty row.c_ofile }">
                	<a href="/cboard/download.do?C_ofile=${ row.c_ofile }
                	&C_sfile=${ row.c_sfile }&C_num=${ row.c_num }">[Down]</a>
                </c:if>
            </td>
        </tr>    
    	</c:forEach>
    </c:otherwise>
</c:choose>
	</table>
<!-- 
가상번호 계산하기
=> 전체게시물갯수-(((페이지번호 -1) * 페이지당 게시물수) + 해당루프의 index)
참고로 varStatus속성의 index는 01부터 시작한다.

전체게시물의 갯수가 5개이고 페이지당 2개만 출력한다면..
	1페이지의 첫번째 게시물 번호 : 5- (((1-1*2) + 0) = 5
	2페이지의 첫번째 게시물 번호 : 5- (((2-1*2) + 0) = 3
 -->
    <table border="1" width="90%">
        <tr align="center">
            <td>
                ${ map.pagingImg }
            </td>
            <td width="100"><button type="button"
                onclick="location.href='/cboard/Write.do';">글쓰기</button></td>
        </tr>
    </table>
</div>
<%@ include file="../footer.jsp" %>
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>

</html>
