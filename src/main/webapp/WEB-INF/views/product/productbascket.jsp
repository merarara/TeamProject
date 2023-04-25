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
</script>
</head>
<body>
<%@ include file="../header.jsp" %>	
<div id="content">
  <h1>장바구니</h1>
  <hr style="border:1px solid #000">
  <div class="list-group">
    <c:forEach items="${blist}" var="i">
      <div class="list-group-item list-group-item-action flex-column align-items-start">
        <div class="d-flex w-100 justify-content-between">
          <h5 class="mb-1">${i.p_name}</h5>
          <small class="text-muted">상품 수량 : <input type="number" name="quantity" id="quantity_${i.b_num}" min="1" value="${i.m_qty}" onchange="calculateAmount(${i.b_num})"></small>
        </div>
        <img src="${i.p_listimg}" alt="${i.p_name}" class="img-thumbnail mb-3" style="max-width: 500px;">
        <p class="mb-1"><b>가격 : </b><span id="showprice_${i.b_num}"><fmt:formatNumber type="number" value="${i.m_price}" pattern="#,###" />원</span></p>
        <form id="deleteFrm">
          <input type="hidden" name="b_num" value="${i.b_num}">
          <button type="button" onclick="doDelete(this.form);" class="btn btn-danger">장바구니 삭제</button>
        </form>
      </div>
    </c:forEach>
  </div>
  <div class="mt-3">총 결제 금액: <span id="total_price"></span>원</div>
</div>


<%@ include file="../footer.jsp" %>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>