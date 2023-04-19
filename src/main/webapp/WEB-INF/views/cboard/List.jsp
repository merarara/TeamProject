<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<style>a{text-decoration:none;}</style>
</head>
<body>
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
                <a href="/cboard/view.do?C_idx=${ row.C_num }">
                ${ row.C_title }</a>
            </td> 
            <td>${ row.C_ID }</td>
            <td>${ row.C_visitcount }</td>
            <td>${ row.C_postdate }</td>
            <td>
                <c:if test="${ not empty row.C_ofile }">
                	<a href="/cboard/download.do?C_ofile=${ row.C_ofile }
                	&C_sfile=${ row.C_sfile }&C_num=${ row.C_num }">[Down]</a>
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
</body>
</html>
