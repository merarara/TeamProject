<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>fboard수정</h2>	
	<form action="faq_main.do" method="post">
	<table border="1">
		<tr>
			<th>f_num(수정불가)</th>
			<td><input type="text" name="f_num" value="${dto.f_num }" 
				readonly/></td>			
		</tr>
		<tr>
			<th>f_title</th>
			<td><input type="text" name="f_title" value="${dto.f_title }" /></td>			
		</tr>
		<tr>
			<th>f_content</th>
			<td><input type="text" name="f_content" value="${dto.f_content }" /></td>			
		</tr>		 
		
		<tr>
			<th>u_id</th>
			<td><input type="text" name="u_id" value="${dto.u_id }" /></td>			
		</tr>	
		
	</table>
	<input type="submit" value="전송하기" />
	</form>
</body>
</html>