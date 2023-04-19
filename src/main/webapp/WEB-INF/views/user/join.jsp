<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
            <input type="text" class="form-control" id="inputPhone" name="U_Phone" placeholder="전화번호를 입력해주세요">
        </div>
        <div class="form-group">
            <label for="inputEmail">이메일</label>
            <input type="text" class="form-control" id="inputEmail" name="U_Email" placeholder="이메일을 입력해주세요">
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
    </div>
    </div>
</form>

<!--  API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>



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



</script>

</body>
</html>