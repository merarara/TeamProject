<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
</head>
<body>
<%@ include file="../header.jsp" %>
<div id="content">

<h2>공지사항 게시글 등록</h2>	
	<form action="aboard_regist.do" method="post">
	<table border="1">
		<tr>
			<th>a_num</th>
			<td><input type="number" name="a_num" value="" /></td>			
		</tr>
		<tr>
			<th>a_title</th>
			<td><input type="text" name="a_title" value="" /></td>			
		</tr>
		<tr>
			<th>a_content</th>
			<td><input type="text" name="a_content" value="" /></td>			
		</tr>	
		<tr>
			<th>a_visitcount</th>
			<td><input type="int" name="a_visitcount" value="" /></td>			
		</tr>	
		<tr>
			<th>u_id</th>
			<td><input type="text" name="u_id" value="" /></td>			
		</tr>
		<tr>
			<th>u_nick</th>
			<td><input type="text" name="u_nick" value="" /></td>			
		</tr>
		<tr>
			<th>a_commend</th>
			<td><input type="text" name="a_commend" value="" /></td>			
		</tr>
		
				 
	</table>
	<input type="submit" value="전송하기" />
	</form>
	
	</div>
<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>