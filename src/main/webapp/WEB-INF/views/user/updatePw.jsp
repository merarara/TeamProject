<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link rel="stylesheet"  href="/css/reset.css">
 <link rel="stylesheet"  href="/css/join.css">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
var pwChek = false; 
function validateForm() {
	  // 아이디와 비밀번호를 가져옵니다.
	  var pass = $("#user_pwd").val();
		console.log(pass);
	  // ajax를 이용하여 db에서 아이디와 비밀번호를 비동기적으로 검사합니다.
	  $.ajax({
		type: 'POST',
	    url: "/user/updatePw.do",
	    data: {
	      u_pw: pass
	    },
	    success: function(result) {
	      if (result.status === "success") {
	        alert("비밀번호가 일치합니다.");
	        pwChek = true; 
	      } else {
	        alert("비밀번호가 일치하지 않습니다.");
	        
	        return false;
	      }
	    }
	  });
	}
	
function updatePassword() {
    var newPwd1 = $("#new_pwd1").val();
    var newPwd2 = $("#new_pwd2").val();

    // 기존 비밀번호 확인
    if (!pwChek) {
        alert("기존 비밀번호 인증이 필요합니다.");
        return false;
    }
    // 두 비밀번호가 일치하는지 검사
    if (newPwd1 !== newPwd2) {
        alert("새 비밀번호가 일치하지 않습니다.");
        return false;
    }

    // ajax를 이용하여 새 비밀번호를 서버로 전송합니다.
    $.ajax({
        type: 'POST',
        url: "/user/saveNewPw.do",
        data: {
            u_pw: newPwd1
        },
        success: function(result) {
            if (result.status === "success") {
            	alert("비밀번호가 변경되었습니다.\n로그인 창으로 이동합니다.");
                window.location.href = "/user/logout.do";
                window.location.href = "/user/login.do";
            } else {
                alert("비밀번호 변경에 실패하였습니다.");
            }
        }
    });
}

$(document).ready(function() {
    $("#change_pwd_btn").click(function(event) {
        event.preventDefault(); // 폼의 기본 동작을 막습니다.
        updatePassword(); // updatePassword 함수를 실행합니다.
    });
});

</script>
</head>
<body>
<%@ include file="../header.jsp" %>  
<div id="wrap">
      <div class="inner">
          <div class="form_wrap">
			<form>
			    <div class= "form_group">
			    	<label for="user_pwd">현재 비밀번호</label>
			    		<div class="input_group">
					        <input type="password"  name="user_pwd" id="user_pwd" placeholder="현재 비밀번호를 입력해주세요">
					        <button type="button" class="btn-certi" onclick="validateForm();">확인 </button>
						</div>			    	
			    </div>
			    <div> 
				    <div class= "form_group">
				   		 <label for="user_pwd">새 비밀번호</label>
				    		<div class="input_group">
						        <input type="password" name="my_pass" id="new_pwd1" placeholder="비밀번호를 입력해주세요.">
				    		</div>
				    </div>
			    </div>
			    <div> 
				    <div class= "form_group">
				  		  <label for="user_pwd">새 비밀번호 확인</label>
				    		<div class="input_group">
						        <input type="password" name="my_pass" id="new_pwd2" placeholder="비밀번호를 입력해주세요.">
						    </div>
				    </div>
			    </div>
			    <div>
			        <input type="submit" class="btn-submit" id="change_pwd_btn" value="비밀번호 변경">
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
