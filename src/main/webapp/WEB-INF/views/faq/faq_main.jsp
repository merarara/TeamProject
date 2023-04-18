<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>


<meta charset="UTF-8">



	<title>질문과 답변</title>
	<style>
		.answer {
			display: none;
		}
		.question {
			cursor: pointer;
		}
	</style>





</head>
<body>











	<h1>질문과 답변</h1>
	<div class="question" onclick="toggleAnswer(1)">질문 1. 이것은 무엇인가요?</div>
	<div class="answer" id="answer1">이것은 HTML 코드 예시입니다. <a href="edit_question.html?id=1">질문 수정</a></div>
	<div class="question" onclick="toggleAnswer(2)">질문 2. 어떻게 작동하나요?</div>
	<div class="answer" id="answer2">질문을 클릭하면 해당 질문에 대한 답변이 펼쳐집니다. <a href="edit_question.html?id=2">질문 수정</a></div>
	
	<script>
		function toggleAnswer(id) {
			var answer = document.getElementById("answer" + id);
			if (answer.style.display === "none") {
				answer.style.display = "block";
			} else {
				answer.style.display = "none";
			}
		}
	</script>






</body>
</html>