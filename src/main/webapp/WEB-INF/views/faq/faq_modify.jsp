<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>질문 수정</h1>
	<form action="save_question.php" method="post">
		<label for="question">질문 내용:</label>
		<input type="text" id="question" name="question" value="이것은 무엇인가요?">
		<br>
		<label for="answer">답변 내용:</label>
		<textarea id="answer" name="answer" rows="5" cols="40">이것은 HTML 코드 예시입니다.</textarea>
		<br>
		<input type="hidden" id="id" name="id" value="1">
		<input type="submit" value="저장">
	</form>
</body>
</html>