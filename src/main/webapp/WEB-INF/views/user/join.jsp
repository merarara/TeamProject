<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
</head>
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
            <input type="text" class="form-control" id="inputId" name="U_Id" placeholder="아이디를 입력해주세요.">
        </div>
        <div class="form-group">
            <label for="inputPw">비밀번호</label>
            <input type="password" class="form-control" id="inputPw" name="U_Pw" placeholder="비밀번호를 입력해주세요.">
        </div>
        <div class="form-group">
            <label for="inputName">이름</label>
            <input type="text" class="form-control" id="inputName" name="U_Name" placeholder="이름을 입력해주세요.">
        </div>
        <div class="form-group">
            <label for="inputNick">닉네임</label>
            <input type="text" class="form-control" id="inputNick" name="U_Nick" placeholder="닉네임을 입력해주세요">
        </div>
		<div class="form-group">
 			 <label for="inputPhone">전화번호</label>
 			 <input type="text" class="form-control" id="inputPhone" name="U_Phone" placeholder="전화번호를 입력해주세요" value="010">
		</div>
		<div class="form-group">
		    <label for="inputEmail">이메일</label>
		    <div class="input-group">
		        <input type="text" class="form-control" id="inputEmail" name="U_Email" placeholder="이메일 아이디를 입력해주세요.">
		        <div class="input-group-append">
		            <select class="form-control" name="U_Email_domain">
		                <option value="@gmail.com">@gmail.com</option>
		                <option value="@naver.com">@naver.com</option>
		                <option value="@daum.net">@daum.net</option>
		                <option value="@hotmail.com">@hotmail.com</option>
		            </select>
		        </div>
		    </div>
		</div>
       <div class="address_wrap">
       	<div class="address_input_1_wrap">
       		<div class="address_input_1_box">
				<input class="adress_input_1" name="U_Zip">
       		</div>
       		<div class="address_button" onclick="execution_daum_address()">
  					 주소 찾기
  			</div>
  			 	<div class="clearfix"></div>
       	 <div class="address_input_2_wrap">
       	 	<div class="address_input_2_box">
       			<input class="adress_input_2" name="U_Addr1" readonly>
       		</div>
       	 </div>
       	 <div class="address_input_3_wrap">
       	 	<div class="address_input_3_box">
       			<input class="adress_input_3" name="U_Addr2" >
       		</div>
       	 </div>
       	</div>
        <button type="submit" class="btn btn-primary">가입 완료</button>
         <!-- 리캡챠 표시 -->
  		<div class="g-recaptcha" data-sitekey="6Le6S5glAAAAAJaTOGMnoWZJfRi57Ee6AKNWJduX"></div>
    </div>
    </div>
</form>
</div>
<%@ include file="../footer.jsp" %>


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
            document.getElementsByName('U_Zip')[0].value = zip;
            document.getElementsByName('U_Addr1')[0].value = addr1;
        }
    }).open();
}

/////////////////////////////////////////////////////////////
// 리캡챠
function onReCaptchaSuccess(response) {
  // 토큰 생성 후, 서버로 전송
  $.ajax({
    type: "POST",
    url: "/verify-recaptcha",
    data: {recaptchaResponse: response},
    success: function(data) {
      // 토큰 검증 결과에 따라 회원가입 처리 또는 실패 메시지 출력
      if (data.success) {
        // 회원가입 처리
        alert("회원가입이 완료되었습니다.");
      } else {
        // 실패 메시지 출력
        alert("리캡챠 인증에 실패했습니다.");
      }
    }
  });
}

</script>




<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

</body>
</html>