<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
    table {
        border-collapse: collapse;
        width: 100%;
    }
    th, td {
        text-align: center;
        padding: 8px;
        border: 1px solid #ddd;
    }
    th {
        background-color: #f2f2f2;
    }
    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    tr:hover {
        background-color: #ddd;
    }
</style>


<script>
$(document).ready(function(){
    // 회원전체보기 버튼 클릭 이벤트
    $("#btn1").click(function(){
        // AJAX를 사용하여 서버로부터 회원 정보를 가져옵니다.
        $.ajax({
            url: "/users",
            type: "GET",
            success: function(data){
                console.log(data);
                // 가져온 회원 정보를 화면에 출력합니다.
                let html = '<table>';
                html += '<a href="/admin/userManagement.do" class="login-link">뒤로가기</a>'
                html += '<h2>전체회원</h2>'
                html += '<thead><tr><th>번호</th><th>아이디</th><th>이름</th><th>닉네임</th><th>전화번호</th><th>이메일</th><th>우편번호</th><th>주소1</th><th>주소2</th><th>타입</th><th>권한</th><th>등록일</th></tr></thead>';
                html += '<tbody>';
                $.each(data, function (index, value) {
                    html += '<tr>' +
                        '<td>' + value.u_num + '</td>' +
                        '<td>' + value.u_id + '</td>' +
                        '<td>' + value.u_name + '</td>' +
                        '<td>' + value.u_nick + '</td>' +
                        '<td>' + value.u_phone + '</td>' +
                        '<td>' + value.u_email + '</td>' +
                        '<td>' + value.u_zip + '</td>' +
                        '<td>' + value.u_addr1 + '</td>' +
                        '<td>' + value.u_addr2 + '</td>' +
                        '<td>' + value.u_type + '</td>' +
                        '<td>' + value.u_authority + '</td>' +
                        '<td>' + value.u_reg + '</td>' +
                        '</tr>';
                });
                html += '</tbody></table>';

                $('#content').html(html);
            },
            error: function(){
                alert("회원 정보를 가져오는 데 실패했습니다.");
            }
        });
    });
});
//일반리스트 조회
$(document).ready(function(){
    // 회원전체보기 버튼 클릭 이벤트
    $("#btn2").click(function(){
        // AJAX를 사용하여 서버로부터 회원 정보를 가져옵니다.
        $.ajax({
            url: "/basicusers",
            type: "GET",
            success: function(data){
                console.log(data);
                // 가져온 회원 정보를 화면에 출력합니다.
                let html = '<table>';
                html += '<a href="/admin/userManagement.do" class="login-link">뒤로가기</a>'
                html += '<h2>블랙리스트 회원</h2>'
                html += '<thead><tr><th>번호</th><th>아이디</th><th>이름</th><th>닉네임</th><th>전화번호</th><th>이메일</th><th>우편번호</th><th>주소1</th><th>주소2</th><th>타입</th><th>권한</th><th>활성화 여부</th><th>등록일</th></tr></thead>';
                html += '<tbody>';
                $.each(data, function (index, value) {
                    html += '<tr>' +
                        '<td>' + value.u_num + '</td>' +
                        '<td>' + value.u_id + '</td>' +
                        '<td>' + value.u_name + '</td>' +
                        '<td>' + value.u_nick + '</td>' +
                        '<td>' + value.u_phone + '</td>' +
                        '<td>' + value.u_email + '</td>' +
                        '<td>' + value.u_zip + '</td>' +
                        '<td>' + value.u_addr1 + '</td>' +
                        '<td>' + value.u_addr2 + '</td>' +
                        '<td>' + value.u_type + '</td>' +
                        '<td>' + value.u_authority + '</td>' +
                        '<td>' + value.u_enabled + '</td>' +
                        '<td>' + value.u_reg + '</td>' +
                        '</tr>';
                });
                html += '</tbody></table>';

                $('#content').html(html);
            },
            error: function(){
                alert("회원 정보를 가져오는 데 실패했습니다.");
            }
        });
    });
});
// 블랙리스트 조회
$(document).ready(function(){
    // 회원전체보기 버튼 클릭 이벤트
    $("#btn3").click(function(){
        // AJAX를 사용하여 서버로부터 회원 정보를 가져옵니다.
        $.ajax({
            url: "/blackusers",
            type: "GET",
            success: function(data){
                console.log(data);
                // 가져온 회원 정보를 화면에 출력합니다.
                let html = '<table>';
                html += '<a href="/admin/userManagement.do" class="login-link">뒤로가기</a>'
                html += '<h2>블랙리스트 회원</h2>'
                html += '<thead><tr><th>번호</th><th>아이디</th><th>이름</th><th>닉네임</th><th>전화번호</th><th>이메일</th><th>우편번호</th><th>주소1</th><th>주소2</th><th>타입</th><th>권한</th><th>활성화 여부</th><th>등록일</th></tr></thead>';
                html += '<tbody>';
                $.each(data, function (index, value) {
                    html += '<tr>' +
                        '<td>' + value.u_num + '</td>' +
                        '<td>' + value.u_id + '</td>' +
                        '<td>' + value.u_name + '</td>' +
                        '<td>' + value.u_nick + '</td>' +
                        '<td>' + value.u_phone + '</td>' +
                        '<td>' + value.u_email + '</td>' +
                        '<td>' + value.u_zip + '</td>' +
                        '<td>' + value.u_addr1 + '</td>' +
                        '<td>' + value.u_addr2 + '</td>' +
                        '<td>' + value.u_type + '</td>' +
                        '<td>' + value.u_authority + '</td>' +
                        '<td>' + value.u_enabled + '</td>' +
                        '<td>' + value.u_reg + '</td>' +
                        '</tr>';
                });
                html += '</tbody></table>';

                $('#content').html(html);
            },
            error: function(){
                alert("회원 정보를 가져오는 데 실패했습니다.");
            }
        });
    });
});
</script>
</head>
<body>
<%@ include file="../header.jsp" %>	
<!-- body 설정  -->
<div id="content" class="user_btn_list" >
  <button id="btn1">회원 전체 보기</button>
  <button id="btn2">일반 회원 보기</button>
  <button id="btn3">블랙리스트 회원 보기</button>
</div>





<%@ include file="../footer.jsp" %>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
