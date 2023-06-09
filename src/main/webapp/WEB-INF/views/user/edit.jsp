<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!--  CSS (join) -->
 <link rel="stylesheet"  href="/css/reset.css">
 <link rel="stylesheet"  href="/css/join.css">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 주소 검색 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
#mail {
  display: none;
  /* 다른 스타일 속성들 */
}
</style>

<script>
function showForm() {
	  document.querySelector('#mail').style.display = 'block';
	}
//닉네임 중복확인
var nickChecked = false;
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

function execution_daum_address() {
	console.log("주소찾기실행")
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
//가입 버튼 클릭 시 실행되는 함수
function updateUp() {
	console.log("업데이트싸인 동작")
	// 닉네임 중복 체크 여부 확인
	if (!nickChecked) {
		alert("닉네임 중복 체크를 해주세요.");
	return;
	}
	  if (!validateForm()) {
		  /* e.preventDefault(); //  submit 이벤트 발생 막기 */
	    return;
	  }
	$.ajax({
		url: "/user/edit.do",
		type: "POST",
		data: $("#editForm").serialize(),
	success: function(result) {
			if (result.status == 'success') {
				alert("회원정보 수정완료");
				// 가입이 성공하면 로그인 페이지로 이동
				window.location.href = "/home.do";
			} else {
				alert("회원정보 수정실패");
			}
		},
			error: function(request, status, error) {
			alert("ajax 에러발생.");
			}
	});
}
// 빈 값이 있으면 알럿창 
function validateForm() {
	console.log("validateForm 동작")
    var inputId = document.getElementById("inputId").value;
    var inputName = document.getElementById("inputName").value;
    var inputNick = document.getElementById("inputNick").value;
    var inputPhone1 = document.getElementById("inputPhone1").value;
    var inputPhone2 = document.getElementById("inputPhone2").value;
    var inputPhone3 = document.getElementById("inputPhone3").value;
/*     var email1 = document.getElementById("email1").value;
    var email2 = document.getElementById("email2").value; */
    var u_zip = document.getElementById("adress_num").value;
    var u_addr1 = document.getElementById("adress01").value;

    if (!inputId || !inputName || !inputNick || !inputPhone1 || !inputPhone2 || !inputPhone3 || !email1 || !email2 || !u_zip || !u_addr1) {
      alert("모든 항목을 입력해주세요.");
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
                    <h2>회원정보 수정</h2>
                    <form method="post" id="editForm" action="/user/edit.do" onsubmit="validateForm()">
					  <div class="form_group">
					    <label for="inputId">아이디</label>
						    <div class="input_group">
						      <input type="text" class="" id="inputId" name="u_id" value=${ uinfo.u_id } readonly>
						    </div>
					  </div>
                        <div class="form_group">
                                    <label for="inputName">이름</label>
                                    <div class="input_group">
                                        <input type="text" class="" id="inputName" name="u_name" value=${ uinfo.u_name } readonly>
                                    </div>
                        </div>
                        <div class="form_group">
                                    <label for="inputNick">닉네임</label>
                                    <div class="input_group">
                                        <input type="text" class="" id="inputNick" name="u_nick" value=${ uinfo.u_nick }>
                                  	    <button type="button" id="checkNickBtn" onclick="checkNick()">중복확인</button>
                                    </div>
					  				<div id="nickCheckMsg"></div>
                        </div>
                        <div class="form_group">
                                    <label for="inputPhone1">전화번호</label>
                                    <div class="input_group">
                                        <input type="tel" class="" id="inputPhone1" name="u_phone1" pattern="[0-9]{3}" value=${ uinfo.u_phone1 } required>
                                        <div class="input_group-prepend">
                                            <span class="dash">-</span>
                                        </div>
                                        <input type="tel" class="" id="inputPhone2" name="u_phone2"  pattern="[0-9]{4}" value=${ uinfo.u_phone2 } required>
                                        <div class="input_group-prepend">
                                            <span class="dash">-</span>
                                        </div>
                                        <input type="tel" class="" id="inputPhone3" name="u_phone3"  pattern="[0-9]{4}" value=${ uinfo.u_phone3 } required>
                                    </div>
                        </div>
                        <div class="form_group">
                                    <label for="email1">이메일</label>
                                    <div class="input_group">
                                        <input type="text" class="" id="email" name="u_email" value=${ uinfo.u_email }>
                        <button type="button" class="btn-certi" onclick="showForm()">이메일 변경</button>
                                    </div>
                        </div>
                        <div class="form_group" id="mail">
                                    <label for="email1">이메일</label>
                                    <div class="input_group">
                                        <input type="text" class="w05" id="email1" name="email1"/>
                                        <span class="dash">@</span>
                                        <input type="text" class="w05" id="email2" name="email2"/>
                                        <select name="email_domain" class="s01" onchange="inputEmail(this.form);">
                                        <option value="">직접입력</option>
                                            <option value="naver.com">naver.com</option>
                                            <option value="daum.net">daum.net</option>
                                            <option value="gmail.com">gmail.com</option>
                                        </select>
                                        <!-- 이메일 인증 버튼 -->
                                    </div>
                                   		<!--  <button type="button" class="btn-certi">인증하기</button> -->
                        			</div>
                        <div class="address_wrap form_group">
                            <div class="address_input_wrap ">
                                <label for="adress_num">우편번호</label>
                                <div class="address_input_1_box input_group" >
                                    <input class="adress_input_1" name="u_zip" id="adress_num" value=${ uinfo.u_zip }>
                                   <button type="button" class="address_button" onclick="execution_daum_address(event)">
                                   		주소 찾기
                                   </button>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="address_input_wrap">
                                <label for="adress01">주소</label>
                                <div class="address_input_2_box input_group">
                                    <input class="adress_input_2" id="adress01" name="u_addr1" value=${ uinfo.u_addr1 }>
                                </div>
                            </div>

                            <div class="address_input_wrap ">
                                <label for="adressdDetail">상세주소</label>
                                <div class="address_input_3_box input_group">
                                    <input class="adress_input_3" id="adressd02" name="u_addr2" value=${ uinfo.u_addr2 }>
                                </div>
                            </div>
                        </div>
                        <div class="btn_wrap">
                            <button type="button" class="btn-submit" onclick="updateUp()">수정 완료</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

<%@ include file="../footer.jsp" %>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
