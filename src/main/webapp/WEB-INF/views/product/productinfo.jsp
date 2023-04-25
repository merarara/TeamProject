<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
<script>
// 이미지 효과
$(document).ready(function() {
	var firstImgSrc = $('img').first().attr('src');
	
	$('#showimg').css('background-image', 'url(' + firstImgSrc + ')');
	
    $('img').on('mouseenter', function() {
        var imgSrc = $(this).attr('src');
        $('#showimg').css('background-image', 'url(' + imgSrc + ')');
    });
});

// 결제 api
function iamport(){
    //가맹점 식별코드
    IMP.init('imp08750518');
    IMP.request_pay({
        pg : 'INIpayTest',
        pay_method : 'card',
        merchant_uid : 'merchant_' + new Date().getTime(),
        name : '${pinfo.p_name}' , //결제창에서 보여질 이름
        amount : $("#amount").val(), //실제 결제되는 가격
        buyer_email : '${uinfo.u_email}',
        buyer_name : '${uinfo.u_name}',
        buyer_tel : '${uinfo.u_phone}',
        buyer_addr : '${uinfo.u_addr1}',
        buyer_postcode : '${uinfo.u_zip}'
    }, function(rsp) {
        console.log(rsp);
        if ( rsp.success ) {
            var msg = '결제가 완료되었습니다.';
            msg += '고유ID : ' + rsp.imp_uid;
            msg += '상점 거래ID : ' + rsp.merchant_uid;
            msg += '결제 금액 : ' + rsp.paid_amount;
            msg += '카드 승인번호 : ' + rsp.apply_num;
            console.log(msg);
            
            // 결제 정보를 order_info 테이블에 저장하는 로직 추가
            $.ajax({
                type: 'POST',
                url: '/product/save_oinfo.do', // 저장하는 컨트롤러의 URL
                data: {
                    u_id: '${uinfo.u_id}', // 구매한 사용자의 아이디
                    m_addr: '${uinfo.u_addr1}', // 사용자의 주소
                    p_num: '${pinfo.p_num}', // 구매한 상품 번호
                    p_name: '${pinfo.p_name}',
                    m_price: $("#amount").val(), // 상품 가격
                    m_qty: $("#quantity").val(), // 상품 수량
                    p_price: $("#price").val()	 // 상품 원래 가격
                },
                success: function(result) {
                    console.log(result); // 저장 결과 출력
                }
            });
            
        } else {
             var msg = '결제에 실패하였습니다.';
             msg += '에러내용 : ' + rsp.error_msg;
        }
        alert(msg);
    });
}

// 수량에 따른 가격 증가
function calculateAmount() {
	  var quantity = parseInt(document.getElementById("quantity").value);
	  var price = parseInt(document.getElementById("price").value);
	  var amount = quantity * price;
	  document.getElementById("amount").value = amount;
}

function doAddBascket() {
	if(confirm('장바구니에 담으시겠습니까?')) {
		$.ajax({
			type: 'POST',
			url: '/product/add_bascket.do',
			data: {
				u_id: '${uinfo.u_id}',
				p_num: '${pinfo.p_num}',
				m_qty: $("#quantity").val(),
				p_name: '${pinfo.p_name}',
				p_listimg: '${pinfo.p_listimg}',
				m_price: $("#amount").val(),
				p_price: $("#price").val()
			},
			success: function(data) {
				if (data.status === 'success') {
					if (confirm('장바구니에 성공적으로 추가되었습니다. 장바구니 페이지로 이동하시겠습니까?')) {
						location.href = "/product/productbascket.do";
					}
				} else {
					alert('장바구니 추가에 실패하였습니다.');
				}
			}
		});
	} else {
			
	}
}
</script>
<style>
#contentwrap {
	width: 100%;
   	border-collapse: collapse;
    margin-left: auto;
   	margin-right: auto;
}

.items {
	width: 700;
	height: 80;
	font-size: 10pt;
	color: #868e96;
}

.imgcon {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

#showimg {
  margin: 0 auto;
  width: 330px;
  height: 330px;
  background-size: contain;
  background-repeat: no-repeat;
  background-position: center;
}

.img-list {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
}

.img-item {
  margin: 5px;
}

.price {
  margin-left: 340px;
  color: #0067A3;
  font-size: 20pt;
}
</style>
</head>
<body>

<%@ include file="../header.jsp" %>	
<div id="content">
	<p style="text-align: center;">검색창</p>
	<div class="container">
		<div class="row">
			<div class="d-flex align-items-center justify-content-center">
				<div id="contentwrap">
					<h2>${ pinfo.p_name }</h2>
					<div class="items">
						<b>운영체제</b>: ${ pinfo.os } / <b>화면정보</b>: ${ pinfo.monitor } / <b>CPU</b>: ${ pinfo.cpu } / <b>램</b>: ${ pinfo.r_storage } / <b>램 교체</b>: ${ pinfo.ram }
						<b>그래픽</b>: ${ pinfo.graphic } / <b>저장장치</b>: ${ pinfo.storage } / <b>네트워크</b>: ${ pinfo.network } / <b>영상입출력</b>: ${ pinfo.video_io } / <b>단자</b>: ${ pinfo.terminal } / <b>부가기능</b>: ${ pinfo.add_ons }
						<b>입력장치</b>: ${ pinfo.io } / <b>파워</b>: ${ pinfo.power }  
						<c:if test="${ not empty pinfo.hz }" >
							/ <b>주사율</b>: ${ pinfo.hz }
						</c:if>
						<c:if test="${ not empty pinfo.etc }" >
							/ <b>주요제원</b>: ${ pinfo.etc }
						</c:if>
						<br>
					</div>
					<hr style="border: 1px solid #000;">
					
					<br>
					<div class="container">
						<div class="row">
							<div class="col-md-5 imgcon text-center">
								<div id="showimg"></div>
								<div class="img-list">
									<c:forEach items="${ pinfo.p_imgsrcs }" var="imgsrc">
										<div class="img-item">
											<img src="${ imgsrc }" width="50" height="50">
										</div>
									</c:forEach>
								</div>
							</div>
							<div class="col-md-7">
								<span style="font-size: 15pt"><b>가격 :</b></span>
  								<span class="price"><b><fmt:formatNumber type="number" value="${pinfo.p_price}" pattern="#,###" />원</b></span>
  								<br>
  								<form method="post">
  									<input type="hidden" name="p_num" value="${ pinfo.p_num }">
									<label for="quantity">주문 수량:</label>
								  	<input type="number" name="quantity" id="quantity" min="1" value="1" required onchange="calculateAmount()">
								  	<br>
								  	<label for="price">상품 가격:</label>
								  	<input type="text" name="price" id="price" value="100" readonly>
								  	<br>
								  	<label for="amount">결제 금액:</label>
								  	<input type="text" name="amount" id="amount" value="100" readonly>
								  	<br>
								  	<button name="paymentButton" id="paymentButton" onclick="iamport(); return false;" class="w-100 btn btn-warning btn-lg" type="submit">
								    	결제하기
								  	</button>
								  	<button name="addBascket" id="addBascket" onclick="doAddBascket();" class="w-100 btn btn-primary btn-lg" type="button">
								    	장바구니 추가
								  	</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</body>
</html>