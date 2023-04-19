<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
</head>
<body>
<h2>파일 첨부형 게시판 - 상세 보기(View)</h2>

<table border="1" width="90%">
    <colgroup>
        <col width="15%"/> <col width="35%"/>
        <col width="15%"/> <col width="*"/>
    </colgroup> 
    <tr>
        <td>번호</td> <td>${ dto.C_num }</td>
        <td>작성자</td> <td>${ dto.C_name }</td>
    </tr>
    <tr>
        <td>작성일</td> <td>${ dto.C_postdate }</td>
        <td>조회수</td> <td>${ dto.C_visitcount }</td>
    </tr>
    <tr>
        <td>제목</td>
        <td colspan="3">${ dto.C_title }</td>
    </tr>
    <tr>
        <td>내용</td>
        <td colspan="3" height="100">${ dto.C_content }
        <c:if test="${ isImage eq true }">
        	<p>
        		<img src="../Uploads/${dto.C_sfile }"
        			style="max-width:500px;" />
        	</p>
        </c:if></td>
        <!-- 첨부한 파일이 이미지라면 img태그로 화면에 출력한다. -->
        
    </tr> 
    <tr>
        <td>첨부파일</td>
        <td>          
 	       	<c:if test="${ not empty dto.ofile }">
        	${ dto.ofile }
        	<a href="/cboard/download.do?C_ofile=${ dto.C_ofile }&C_sfile=${ dto.C_sfile }$C_num=${ dto.C_num }">[다운로드]</a>
        	</c:if>                            
        </td>
         <td>다운로드수</td>
        <td>${ dto.C_downcount }</td>
    </tr> 
    <tr>
        <td colspan="4" align="center">
            <button type="button" onclick="location.href='/cboard/pass.do?mode=edit&C_num=${ param.C_num }';">수정하기</button>
            <button type="button" onclick="location.href='/cboard/pass.do?mode=delete&C_num=${ param.C_num }';">삭제하기</button>
            <button type="button" onclick="location.href='/cboard/list.do';">목록 바로가기</button>
        </td>
    </tr>
</table>
</body>
</html>