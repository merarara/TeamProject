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
function doDelete(form) {
	if(confirm('장바구니에서 제거하시겠습니까?')) {
		$.ajax({
			type: 'POST',
			url: '/product/deletebascket.do',
			data: $('#deleteFrm').serialize(),
			success: function(data) {
				if (data.status === 'success') {
					alert("해당상품이 장바구니에서 제거되었습니다.");
					location.href = "/product/productbascket.do"
				} else {
					
				}
			},
			error: function(xhr, status, error) {
				alert("장바구니에서 상품을 삭제하는 중 오류가 발생했습니다.");
			}
		});
	} else {
		
	}
}

// 각 상품 수량에 따른 값 변화 로직
function calculateAmount(b_num) {
	  var quantity = parseInt(document.getElementById(`quantity_` + b_num).value);
	  var price = parseInt(document.getElementById(`price_` + b_num).value);
	  var amount = quantity * price;
	  document.getElementById(`amount_` + b_num).value = amount;
	  document.getElementById(`showprice_` + b_num).innerText = new Intl.NumberFormat('ko-KR').format(amount) + "원";
	  updateTotalPrice();
}

function updateTotalPrice() {
	  var total = 0;
	  var amounts = document.getElementsByName("amount");
	  for (var i = 0; i < amounts.length; i++) {
	    total += parseInt(amounts[i].value);
	  }
	  document.getElementById("total_price").innerHTML = total;
}

window.onload = function() {
	  updateTotalPrice();
}

function doPayment() {
	var p_num = [];
    var p_name = [];
    var p_price = [];
    var bo_qty = [];
    var total_qty = 0;
    var total_price = $("#total_price").text().replace(/,/g, '');
    $("input[name='p_num']").each(function(index) {
        p_num.push($(this).val());
    });
    $("input[name='p_name']").each(function(index) {
        p_name.push($(this).val());
    });
    $("input[name='price']").each(function(index) {
        p_price.push($(this).val());
    });
    $("input[name='quantity']").each(function(index) {
        var qty = $(this).val();
        bo_qty.push(qty);
        total_qty += parseInt(qty);
    });
    
    IMP.init('imp08750518');
    IMP.request_pay({
        pg : 'INIpayTest',
        pay_method : 'card',
        merchant_uid : 'merchant_' + new Date().getTime(),
        name : '장바구니 결제', //결제창에서 보여질 이름
        amount : $("#total_price").text().replace(/,/g, ''), //실제 결제되는 가격
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
            $.ajax({
                type: 'POST',
                url: '/product/save_bascket_order.do',
                data: {
                    u_id: '${uinfo.u_id}',
                    m_addr: '${uinfo.u_addr1}' + ' ${uinfo.u_addr2}',
                    u_nick: '${uinfo.u_nick}',
                    m_price: total_price,
                    m_qty: total_qty
                },
                success: function(result) {
                	if (result.status === "success") {
                		$.ajax({
                        	type: 'POST',
                        	url: '/product/save_bascket_oinfo.do',
                        	data: {
                        		u_id: '${uinfo.u_id}',
                        		u_nick: '${uinfo.u_nick}',
                        		p_num: p_num,
                        		p_name: p_name,
                        		p_price: p_price,
                        		bo_qty: bo_qty
                        	},
                        	success: function(result) {
                        		alert("정상적으로 구매되었습니다.");
                        		location.href="/product/bascketdeleteAll.do?u_id=${uinfo.u_id}";
                        	}
                        });
                	} else {
                		alert("결제중 에러가 발생했습니다.");
                	}
                }, 
            });
        } else {
            var msg = '결제에 실패하였습니다.';
            msg += '에러내용 : ' + rsp.error_msg;
            alert(msg);
        }
    });
    
}
</script>
<style>
#content {
    margin: 0 auto;
    width: 1000px;
    max-width: 1200px;
    padding: 20px;
}

#total_price {
    display: inline-block;
    margin-left: 20px;
}
</style>
</head>
<body>
<%@ include file="../header.jsp" %>	
<div id="content">
  	<h1>장바구니</h1>
  	<hr style="border:1px solid #000">
  	<div class="list-group">
  		<c:if test="${empty blist}">
  		<div class="col-md-12 d-flex align-items-center justify-content-center" style="height: 80vh; margin-top: 20px;">
			<h5 style="color: gray; font-size: 20px; font-weight: bold;">장바구니에 담긴 상품이 없습니다.</h5><br>
			<h5 style="color: gray; font-size: 20px; font-weight: bold;"><a href="/product/productlist.do">상품목록 이동</a></h5>
		</div>
  		</c:if>
  		<c:if test="${not empty blist }">
    	<c:forEach items="${blist}" var="i">
      		<div class="list-group-item list-group-item-action flex-column align-items-start">
        		<div class="d-flex w-100 justify-content-between">
          			<h5 class="mb-1">${i.p_name}</h5>
          			<small class="text-muted">상품 수량 : <input type="number" name="quantity" id="quantity_${i.b_num}" min="1" value="${i.m_qty}" onchange="calculateAmount(${i.b_num})"></small>
        		</div>
        		<input type="hidden" name="p_num" value="${ i.p_num }">
        		<input type="hidden" name="price" id="price_${ i.b_num }" value="${ i.p_price }">
        		<input type="hidden" name="p_name" id="p_name_${ i.p_name }" value="${ i.p_name }">
        		<img src="${i.p_listimg}" alt="${i.p_name}" class="img-thumbnail mb-3" style="max-width: 500px;">
        		<input type="hidden" name="amount" id="amount_${ i.b_num }" value="${i.m_qty * i.p_price }">
        		<p class="mb-1"><b>가격 : </b><span id="showprice_${i.b_num}"><fmt:formatNumber type="number" value="${i.p_price * i.m_qty}" pattern="#,###" />원</span></p>
        		<form id="deleteFrm">
          			<input type="hidden" name="b_num" value="${i.b_num}">
          			<button type="button" onclick="doDelete(this.form);" class="btn btn-danger">장바구니 삭제</button>
        		</form>
      		</div>
    	</c:forEach>
    	<div class="mt-3">총 결제 금액: <span id="total_price"></span>원</div>
  		<div><button type="button" class="btn btn-primary" onclick="doPayment();">구매</button></div>
    	</c:if>
  	</div>
</div>


<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</body>
</html>