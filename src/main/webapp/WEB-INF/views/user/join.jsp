<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>

<!--  CSS (join) -->
 <link rel="stylesheet"  href="/css/reset.css">
 <link rel="stylesheet"  href="/css/join.css">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
<!--  API기능  -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://www.google.com/recaptcha/enterprise.js?render=6Lfd49MlAAAAANS-AmiQi_nazkcpIKwod-M9Q4eB"></script>
<script>
// 리캡챠
grecaptcha.enterprise.ready(function() {
    grecaptcha.enterprise.execute('6Lfd49MlAAAAANS-AmiQi_nazkcpIKwod-M9Q4eB', {action: 'login'}).then(function(token) {
      
    });
});
/* 주소 API를 통해 DB에 값 넣는 기능 */
function execution_daum_address(e) {
	 e.preventDefault(); // 기본 이벤트 발생 방지
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
/* 이메일 선택 시 도메인 자동 입력 */
function inputEmail(form) {
    var selectVal = form.email_domain.value;
    $('#email2').attr('value', selectVal);
    if (selectVal !== $('#email2').val()) {
        $('#email2').val(selectVal);
    }
}
// 아이디 중복확인
var idChecked = false; // 중복체크 확인 여부 변수
function checkId() {
    var u_id = $("#inputId").val();
    if (u_id == "") {
        alert("아이디를 입력해주세요.");
    } else {
    	$.ajax({
    	    url: "/user/checkId",
    	    type: "POST",
    	    data: { "u_id": u_id },
    	    dataType: "json",
    	    success: function(result) {
    	        if (result.duplicate === "exist") {
    	            $("#idCheckMsg").html("이미 사용중인 아이디입니다.");
    	        } else if (result.duplicate === "unexist") {
    	            $("#idCheckMsg").html("사용 가능한 아이디입니다.");
    	            idChecked = true;
    	        }
    	    },
    	    error: function(request, status, error) {
    	        alert("ajax 에러발생.");
    	    }
    	});
    }
}
// 닉네임 중복확인
var nickChecked = false; // 중복체크 확인 여부 변수 
function checkNick() {
    var u_nick = $("#inputNick").val();
    if (u_nick == "") {
        alert("닉네임을 입력해주세요.");
    } else {
    	$.ajax({
    	    url: "/user/checkNick",
    	    type: "POST",
    	    data: { "u_nick": u_nick },
    	    dataType: "json",
    	    success: function(result) {
    	        if (result.duplicate === "exist") {
    	            $("#nickCheckMsg").html("이미 사용중인 닉네임입니다..");
    	        } else if (result.duplicate === "unexist") {
    	            $("#nickCheckMsg").html("사용 가능한 닉네임입니다.");
    	            nickChecked = true;
    	        }
    	    },
    	    error: function(request, status, error) {
    	        alert("ajax 에러발생.");
    	    }
    	});
    }
}
//가입 버튼 클릭 시 실행되는 함수
function signUp() {
	// 아이디 중복 체크 여부 확인
	if (!idChecked) {
		alert("아이디 중복 체크를 해주세요.");
	return;
	}
	// 닉네임 중복 체크 여부 확인
	if (!nickChecked) {
		alert("닉네임 중복 체크를 해주세요.");
	return;
	}
	// 서버로 통신하기전에 조건 체크
	// 모든 항목이 입력되었는지 확인
	  if (!validateForm()) {
		  /* e.preventDefault(); //  submit 이벤트 발생 막기 */
	    return;
	  }
	
	// 가입 정보를 서버에 전송하는 ajax 호출
	$.ajax({
		url: "/user/signUp.do",
		type: "POST",
		data: $("#regFrm").serialize(),
	success: function(result) {
			if (result.status == 'success') {
				alert("가입이 완료되었습니다.");
				// 가입이 성공하면 로그인 페이지로 이동
				window.location.href = "/auth/login.do";
			} else {
				alert("가입에 실패했습니다. 다시 시도해주세요.");
			}
		},
			error: function(request, status, error) {
			alert("ajax 에러발생.");
			}
	});
}
// 이메일
/* function checkMail() {
  var email1 = $("#email1").val();
  var email2 = $("#email2").val();
  var email_domain = $("select[name='email_domain']").val();
  
  // 이메일 주소 조합
  var email = email1 + "@" + email2;
  if(email_domain) {
    email = email1 + "@" + email_domain;
  }
  $.ajax({
	  type: "POST",
	  url: "/emailConfirm",
	  data: { email1: email1, email2: email2 },
	  dataType: "json",
	  success: function(data) {
	    // ajax 요청이 성공적으로 수행된 경우 실행되는 코드
	    alert(data); // 서버에서 전달된 결과 출력
	  },
	  error: function(request, status, error) {
	    // ajax 요청이 실패한 경우 실행되는 코드
	    alert("ajax에러 "+ status + " - " + error);
	  }
	});
} */


// 빈 값이 있으면 알럿창 
function validateForm() {
    var inputId = document.getElementById("inputId").value;
    var inputPw = document.getElementById("inputPw").value;
    var inputName = document.getElementById("inputName").value;
    var inputNick = document.getElementById("inputNick").value;
    var inputPhone1 = document.getElementById("inputPhone1").value;
    var inputPhone2 = document.getElementById("inputPhone2").value;
    var inputPhone3 = document.getElementById("inputPhone3").value;
    var email1 = document.getElementById("email1").value;
    var email2 = document.getElementById("email2").value;
    var u_zip = document.getElementById("adress_num").value;
    var u_addr1 = document.getElementById("adress01").value;

    if (!inputId || inputId.length < 4 || !inputPw || inputPw.length < 12 || !inputName || !inputNick || !inputPhone1 || !inputPhone2 || !inputPhone3 || !email1 || !email2 || !u_zip || !u_addr1) {
      alert("아이디는 4글자 이상, 비밀번호는 12자 이상으로 입력해주세요.\n 모든 항목은 필수 입력사항입니다.");
      return false;
    }
    
    var response = grecaptcha.getResponse();
    if (response.length === 0) {
      alert("리캡차를 확인해주세요.");
      return false;
    }
    
    return true;
  }
 
  
</script>
</head>
<body>
<%@ include file="../header.jsp" %>	
   <div id="wrap">
       <div class="inner">
           <div class="form_wrap">
               <!-- 회원가입 폼 시작 -->
               <h2>회원가입</h2>
               <form method="post" id="regFrm" action="/user/signUp.do" onsubmit="validateForm()">
				  <div class="form_group">
				    <label for="inputId">아이디</label>
					    <div class="input_group">
					      <input type="text" class="" id="inputId" name="u_id" placeholder="아이디를 입력해주세요." pattern="[A-Za-z0-9]{4,}">
					      <button type="button" id="checkIdBtn" onclick="checkId()">중복확인</button>
					    </div>
				    <div id="idCheckMsg"></div>
				  </div>
                   <div class="form_group">
                               <label for="inputPw">비밀번호</label>
                               <div class="input_group">
                                   <input type="password" class="" id="inputPw" name="u_pw" placeholder="비밀번호를 입력해주세요." pattern=".{12,}">
                               </div>
                   </div>
                   <div class="form_group">
                               <label for="inputName">이름</label>
                               <div class="input_group">
                                   <input type="text" class="" id="inputName" name="u_name" placeholder="이름을 입력해주세요.">
                               </div>
                   </div>
                   <div class="form_group">
                               <label for="inputNick">닉네임</label>
                               <div class="input_group">
                                   <input type="text" class="" id="inputNick" name="u_nick" placeholder="닉네임을 입력해주세요">
                             	    <button type="button" id="checkNickBtn" onclick="checkNick()">중복확인</button>
                               </div>
  				<div id="nickCheckMsg"></div>
                   </div>
                   <div class="form_group">
                               <label for="inputPhone1">전화번호</label>
                               <div class="input_group">
                                   <input type="tel" class="" id="inputPhone1" name="u_phone1" placeholder="010" pattern="[0-9]{3}" required>
                                   <div class="input_group-prepend">
                                       <span class="dash">-</span>
                                   </div>
                                   <input type="tel" class="" id="inputPhone2" name="u_phone2" placeholder="0000" pattern="[0-9]{4}" required>
                                   <div class="input_group-prepend">
                                       <span class="dash">-</span>
                                   </div>
                                   <input type="tel" class="" id="inputPhone3" name="u_phone3" placeholder="0000" pattern="[0-9]{4}" required>
                               </div>
                   </div>
                   <div class="form_group">
                               <label for="email1">이메일</label>
                               <div class="input_group">
                                   <input type="text" class="w05" id="email1" name="email1" value="" />
                                   <span class="dash">@</span>
                                   <input type="text" class="w05" id="email2" name="email2" value="" />
                                   <select name="email_domain" class="s01" onchange="inputEmail(this.form);">
                                   <option value="">직접입력</option>
                                       <option value="naver.com">naver.com</option>
                                       <option value="daum.net">daum.net</option>
                                       <option value="gmail.com">gmail.com</option>
                                   </select>
                                   <!-- 이메일 인증 버튼 -->
                               </div>
                              <!--  <button type="button" class="btn-certi" onclick="checkMail()">인증하기</button>  -->
                   </div>
							<!-- <input type="text" placeholder="인증번호 입력" id="email_auth_key"> -->
                   <div class="address_wrap form_group">
                       <div class="address_input_wrap ">
                           <label for="adress_num">우편번호</label>
                           <div class="address_input_1_box input_group" >
                               <input class="adress_input_1" name="u_zip" id="adress_num">
                              <button class="address_button" onclick="execution_daum_address(event)">
                              		주소 찾기
                              </button>
                           </div>
                       </div>
                       <div class="clearfix"></div>
                       <div class="address_input_wrap">
                           <label for="adress01">주소</label>
                           <div class="address_input_2_box input_group">
                               <input class="adress_input_2" id="adress01" name="u_addr1" readonly>
                           </div>
                       </div>

                       <div class="address_input_wrap ">
                           <label for="adressdDetail">상세주소</label>
                           <div class="address_input_3_box input_group">
                               <input class="adress_input_3" id="adressd02" name="u_addr2" >
                           </div>
                       </div>
                   </div>
                   <div class="btn_wrap">
                       <button type="button" id ="signupBtn" class="btn-submit" onclick="signUp()">가입 완료</button>
                   </div>
               </form>
					<div id="google_recaptha">
						<script src='https://www.google.com/recaptcha/api.js'></script>
						<div class="g-recaptcha" data-sitekey="6LeDHNQlAAAAAFS1lpWcwEd4WMADWCVMEgOM7-Qx"></div>
					</div>
       </div>
   </div>
</div>
   <%@ include file="../footer.jsp" %>
   <!--  jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>