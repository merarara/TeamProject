<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
</head>
<body>
<%@ include file="../header.jsp" %>	
<div id="content">
<!-- 회원가입 폼 시작 -->
<form method="post" action="/user/signUp.do">
    <div class="container">
        <h1>회원가입</h1>
		<div class="form-group">
		    <label for="inputId">아이디</label>
		    <input type="text" class="form-control" id="inputId" name="u_id" placeholder="아이디를 입력해주세요.">
		    <button type="button" id="checkIdBtn" class="btn btn-primary">중복확인</button>
		</div>
        <div class="form-group">
            <label for="inputPw">비밀번호</label>
            <input type="password" class="form-control" id="inputPw" name="u_pw" placeholder="비밀번호를 입력해주세요.">
        </div>
        <div class="form-group">
            <label for="inputName">이름</label>
            <input type="text" class="form-control" id="inputName" name="u_name" placeholder="이름을 입력해주세요.">
        </div>
        <div class="form-group">
            <label for="inputNick">닉네임</label>
            <input type="text" class="form-control" id="inputNick" name="u_nick" placeholder="닉네임을 입력해주세요">
        </div>
		<div class="form-group">
 			 <label for="inputPhone">전화번호</label>
 			 <input type="text" class="form-control" id="inputPhone" name="u_phone" placeholder="전화번호를 입력해주세요" value="010">
		</div>
		<div class="form-group">
		    <label for="inputEmail">이메일</label>
		    <div class="input-group">
		        <input type="text" class="form-control" id="inputEmail" name="u_email" placeholder="이메일을 입력해주세요.">
		        <div class="input-group-append">
		            <select class="form-control" name="u_email_domain">
		                <option value="@gmail.com">@gmail.com</option>
		                <option value="@naver.com">@naver.com</option>
		                <option value="@daum.net">@daum.net</option>
		                <option value="@hotmail.com">@hotmail.com</option>
		            </select>
		        </div>
		    </div>
			<!-- 이메일 인증 버튼 -->
			<button type="button" class="btn btn-primary" onclick="sendEmail()">인증하기</button>

		</div>
       <div class="address_wrap">
       	<div class="address_input_1_wrap">
       		<div class="address_input_1_box">
				<input class="adress_input_1" name="u_zip">
       		</div>
       		<div class="address_button" onclick="execution_daum_address()">
  					 주소 찾기
  			</div>
  			 	<div class="clearfix"></div>
       	 <div class="address_input_2_wrap">
       	 	<div class="address_input_2_box">
       			<input class="adress_input_2" name="u_addr1" readonly>
       		</div>
       	 </div>
       	 <div class="address_input_3_wrap">
       	 	<div class="address_input_3_box">
       			<input class="adress_input_3" name="u_addr2" >
       		</div>
       	 </div>
       	</div>
        <button type="submit" class="btn btn-primary">가입 완료</button>
    </div>
    </div>
</form>
</div>
<%@ include file="../footer.jsp" %>


<!-- 기능  -->
<script>

// 선택된 이메일 도메인 값을 가져오는 함수
function getEmailDomain() {
    var selectBox = document.getElementsByName("u_email_domain")[0];
    var selectedValue = selectBox.options[selectBox.selectedIndex].value;
    return selectedValue;
}

// 이메일 아이디와 도메인 값을 합쳐주는 함수
function combineEmailValues() {
    var emailId = document.getElementById("inputEmail").value;
    var emailDomain = getEmailDomain();
    var combinedEmail = emailId + emailDomain;
    document.getElementsByName("u_email")[0].value = combinedEmail;
}

// 도메인 선택 값이 변경될 때마다 이메일 값을 합쳐주는 이벤트 핸들러
document.getElementsByName("u_email_domain")[0].addEventListener("change", combineEmailValues);
</script>
<!-- 주소 검색 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 주소 검색 기능 -->
<script>

function execution_daum_address() {
    new daum.Postcode({
        oncomplete: function(data) {
            var zip = data.zonecode; // 우편번호
            var addr1 = data.roadAddress; // 도로명주소
            // 우편번호, 주소1, 주소2 입력필드에 값 채우기
            document.getElementsByName('u_zip')[0].value = zip;
            document.getElementsByName('u_addr1')[0].value = addr1;
        }
    }).open();
}

</script>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

</body>
</html>