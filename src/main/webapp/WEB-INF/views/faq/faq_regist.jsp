<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>공지사항 게시글 등록</h2>	
	<form action="faq_regist.do" method="post">
	<table border="1">
		<tr>
			<th>f_num</th>
			<td><input type="text" name="f_num" value="" /></td>			
		</tr>
		<tr>
			<th>f_title</th>
			<td><input type="text" name="f_title" value="" /></td>			
		</tr>
		<tr>
			<th>f_content</th>
			<td><input type="text" name="f_content" value="" /></td>			
		</tr>
		<tr>
			<th>u_id</th>
			<td><input type="text" name="u_id" value="" /></td>			
		</tr>	
		
				 
	</table>
	<input type="submit" value="전송하기" />
	</form>
</body>
</html>