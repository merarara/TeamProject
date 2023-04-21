<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<form action="/aboard/aboard_main_detail.do" method="post">
  <input type="hidden" name="a_num" value="${ABoardList2.a_num}}">
  <table>
    <tr>
      <th>제목</th>
      <td><input type="text" name="a_title" value="${ABoardList2.a_title}" readonly></td>
    </tr>
    <tr>
      <th>내용</th>
      <td><textarea name="a_content" rows="10" readonly>${ABoardList2.a_content}</textarea></td>
    </tr>

  </table>

  
  <a href="aboard_edit.do?a_num=${ABoardList2.a_num}">수정</a>
<a href="aboard_delete.do?a_num=${ABoardList2.a_num}">삭제</a>
<a href="aboard_main.do">뒤로 가기</a>
</form>


















 <h1>댓글 목록</h1>
 
 
 
 <h2>aboard리스트</h2>
	<table border="1">
		<tr>
			<th>U_Nick</th>
			<th>comm_num</th>
			<th>U_ID</th>
			<th>comm_Contetn</th>
			<th>comm_Date</th>
			<th>comm_Commend</th>
			<th></th>
		</tr>
		<c:forEach items="${ABoardCommendList}" var="row" varStatus="loop">
			<tr>
				<td>${row.U_Nick}</td>
				<td>${row.comm_num}</td>
				<td>${row.U_ID}</td>
				<td>${row.comm_Content}</td>
				<td>${row.comm_Date}</td>
				<td>${row.comm_Commend}</td>
			</tr>
		</c:forEach>
	</table>
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
    <table>
    
        <tbody>
        <c:forEach var="comment" items="${ABoard_Comment_List}" varStatus="loop">
            <tr>
            	<td>${comment.u_nick}</td>
            	<td>${comment.comm_content}</td>          
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <hr>
  	<form action="aboard_comment_regist.do" method="post">
        <label>닉네임: <input type="text" name="nickname"></label>
        <br>
        <label>내용: <textarea name="content"></textarea></label>
        <br>
        <input type="submit" value="댓글 등록">
    </form>





</body>
</html>