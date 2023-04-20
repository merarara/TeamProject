<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</form>






</body>
</html>