<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
<style>
table {
    border-collapse: collapse;
    width: 100%;
}

th, td {
    padding: 8px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

th {
    background-color: #f2f2f2;
}

.toggle {
    cursor: pointer;
    text-decoration: underline;
}

.details {
    display: none;
    margin-left: 20px;
}

#wrap {
	min-width: 1600px;
}

footer {
	min-width: 1600px;
}

.bartoggle {
    cursor: pointer;
}

</style>
<script>
$(function() {
    $('.toggle').click(function() {
        $(this).next().toggle();
    });
});

$(document).ready(function() {
  	// toggle 클래스 클릭 시 다음 요소의 detail 클래스를 토글
  	$('.bartoggle').click(function() {
    	$(this).next().toggle();
  	});
});

function checkLimit(checkbox, boQty, p_num) {
	const checkedCount = $(".barcode" + p_num + ":checked").length;
	  
	if (checkedCount > boQty) {
	    checkbox.checked = false;
	    alert("해당 상품의 수량은 " + boQty + "개 입니다.");
	}
}

function doConfirm(totalQty, m_num) {
	const checkedTotal = $(".totalQty_" + m_num + " .form-check-input:checked").length;
	const barcodelist = [];
	
	$(".totalQty_" + m_num + " .form-check-input:checked").each(function () {
		barcodelist.push($(this).val());
	});
	
	if (totalQty == checkedTotal) {
		if(confirm("이 정보로 주문을 승낙하시겠습니까?")) {
			$.ajax({
				type: 'POST',
				url: '/admin/confirmOrder.do',
				data: {
					barcodelist: barcodelist,
					m_num: m_num
				},
			});
		}
	} else {
		alert("주문한 총 갯수와 일치하지 않습니다.");
	}
}
</script>
</head>
<body>
<%@ include file="../header.jsp" %>	
<div id="content">
	<div class="container">
		<div class="row">
		<c:forEach items="${orderlist}" var="i">
		    	<div class="col-md-12">
		      		<div class="card mb-3">
		        		<div class="card-header">
		          			<h5 class="card-title">주문번호: ${i.m_num}</h5>
					        <h6 class="card-subtitle mb-2 text-muted">주문일: ${i.m_bdate}</h6>
					        <h6 class="card-subtitle mb-2 text-muted">회원아이디: ${i.u_id}</h6>
		        		</div>
		        		<div class="card-body">
					        <h6 class="card-subtitle mb-2 text-muted">주소: ${i.m_addr}</h6>
					        <h6 class="card-subtitle mb-2 text-muted">가격: ${i.m_price}</h6>
					        <h6 class="card-subtitle mb-2 text-muted">수량: ${i.m_qty}</h6>
					        <h6 class="card-subtitle mb-2 text-muted">주문상태: ${i.m_payment}</h6>
					        <button type="button" class="btn btn-link toggle" data-toggle="collapse"
					            data-target="#collapse${i.m_num}" aria-expanded="false" aria-controls="collapse${i.m_num}">
					            주문상세
					        </button>
					        <div class="details collapse" id="collapse${i.m_num}">
					        	<table class="table mt-3">
					              	<thead>
						                <tr>
						                  	<th>상품번호</th>
						                  	<th>상품명</th>
						                  	<th>상품 가격</th>
						                  	<th>구매 수량</th>
						                </tr>
					              	</thead>
					              	<tbody>
				                	<c:forEach items="${blist}" var="j">
				                  		<c:if test="${i.m_num == j.m_num}">
				                    		<tr class="bartoggle">
					                      		<td>${j.p_num}</td>
					                      		<td>${j.p_name}</td>
					                      		<td>${j.p_price}</td>
					                      		<td id="qty_${j.p_num }">${j.bo_qty}</td>
					                    	</tr>
					                    	<tr style="display: none;">
									        	<td colspan="4">
									          		<table style="width: 60%; margin: 0 auto;" class="totalQty_${i.m_num }">
									            		<thead>
									              			<tr>
									                			<th style="text-align: center;">${ j.p_num } 상품 코드 번호</th>
									              			</tr>
									            		</thead>
									            		<tbody>
									              		<c:forEach items="${pclist}" var="x">
									                		<c:if test="${j.p_num == x.p_num && i.m_payment == '상품준비중'}">
									                  			<tr>
									                    			<td style="padding: 0; padding-top:5px;">
									                    				<div class="form-check form-check-inline">
									                    					<ul>	
									                    						<li>
											                    					<label class="form-check-label" for="${ x.p_barcode }">${ x.p_barcode }</label>
																			  		<input type="checkbox" value="${x.p_barcode }" class="form-check-input barcode${ j.p_num }" id="${ x.p_barcode }" onclick="checkLimit(this, ${j.bo_qty}, ${j.p_num })">
																	  			</li>
																	  		</ul>
																		</div>
																	</td>
									                  			</tr>
									                		</c:if>
									              		</c:forEach>
									            		</tbody>
									          		</table>
									        	</td>
									      	</tr>
					                	</c:if>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div style="text-align:center;">
						  <button type="button" class="btn btn-primary" onclick="doConfirm(${i.m_qty}, ${i.m_num });">승인</button>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
		</div>
		<table style="margin: 0 auto;">
			<tr>
				<td colspan="5" style="text-align: center;">
				  	<!-- 처음 -->
				  	<c:choose>
				    	<c:when test="${(page.curPage - 1) < 1 }">
				      		<button class="btn btn-link text-dark" disabled>&lt;&lt;</button>
				    	</c:when>
					    <c:otherwise>
					      	<a href="/admin/sellManage.do?page=1&searchword=${ searchword }&searchfield=${ searchfield }" 
					      		class="btn btn-link text-dark">
					      		&lt;&lt;
					      	</a>
					    </c:otherwise>
					</c:choose>
					  
					<!-- 이전 -->
					<c:choose>
					    <c:when test="${(page.curPage - 1) < 1 }">
					      	<button class="btn btn-link text-dark pagingbtn" disabled>&lt;</button>
					    </c:when>
					    <c:otherwise>
					      	<a href="/admin/sellManage.do?page=${page.curPage - 1}&searchword=${ searchword }&searchfield=${ searchfield }" 
					      		class="btn btn-link text-dark pagingbtn">
					      		&lt;
					      	</a>
					    </c:otherwise>
					</c:choose>
					  
					<!-- 개별 페이지 -->
					<c:forEach var="fEach" begin="${page.startPage}" end="${page.endPage}" step="1">
					    <c:choose>
					      	<c:when test="${page.curPage == fEach}">
					        	<button class="btn btn-link text-dark pagingbtn" disabled>${fEach}</button>
					      	</c:when>
					      	<c:otherwise>
					        	<a href="/admin/sellManage.do?page=${fEach}&searchword=${ searchword }&searchfield=${ searchfield }" 
					        		class="btn btn-link text-dark pagingbtn">
					        		${fEach}
					        	</a>
					      	</c:otherwise>
					    </c:choose>
					</c:forEach>
					  
					<!-- 다음 -->
					<c:choose>
					    <c:when test="${(page.curPage + 1) > page.totalPage }">
					      	<button class="btn btn-link text-dark pagingbtn" disabled>&gt;</button>
					    </c:when>
					    <c:otherwise>
					      	<a href="/admin/sellManage.do?page=${page.curPage + 1}&searchword=${ searchword }&searchfield=${ searchfield }" 
						      	class="btn btn-link text-dark pagingbtn">
						      	&gt;
					      	</a>
					    </c:otherwise>
					</c:choose>
					  
					<!-- 끝 -->
					<c:choose>
					    <c:when test="${page.curPage == page.totalPage }">
					      	<button class="btn btn-link text-dark pagingbtn" disabled>&gt;&gt;</button>
					    </c:when>
					    <c:otherwise>
					      	<a href="/admin/sellManage.do?page=${page.totalPage}&searchword=${ searchword }&searchfield=${ searchfield }" 
					      		class="btn btn-link text-dark pagingbtn">
					      		&gt;&gt;
					      	</a>
					    </c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
	</div>
</div>
<%@ include file="../footer.jsp" %>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>