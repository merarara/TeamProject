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
/* 결제 승인 */
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

// 체크박스 체크 갯수 체크
function checkLimit(checkbox, boQty, p_num, m_num) {
	const checkedCount = $(".barcode_" + m_num + "_" + p_num + ":checked").length;
	  
	if (checkedCount > boQty) {
	    checkbox.checked = false;
	    alert("해당 상품의 수량은 " + boQty + "개 입니다.");
	}
}

// 승인 보내기
function doConfirm(totalQty, m_num, btn) {
	const checkedTotal = $(".totalQty_" + m_num + " .form-check-input:checked").length;
	const barcodelist = [];
	const p_num = [];
	
	$(".totalQty_" + m_num + " .form-check-input:checked").each(function () {
		barcodelist.push($(this).val());
	});
	
	$(".toggle_" + m_num).children("td:first-child").each(function () {
		p_num.push($(this).text());
	});
	
	
	if (totalQty == checkedTotal) {
		if(confirm("이 정보로 주문을 승낙하시겠습니까?")) {
			$.ajax({
				type: 'POST',
				url: '/admin/confirmOrder.do',
				data: {
					barcodelist: barcodelist,
					m_num: m_num,
					p_num: p_num
				},
				success: function (data) {
					if (data.status == "success") {
						alert(m_num + "번 결제가 승인 되었습니다.");
						$("#collapse" + m_num).remove();
						
						$(btn).remove();
						
						$("#toggle" + m_num).remove();
						
						$("#payment_" + m_num).text("주문상태: 배송준비중");
					} else {
						
					}				
				}
			});
		}
	} else {
		alert("주문한 총 갯수와 일치하지 않습니다.");
	}
}

function doReadyDelivery(m_num, btn) {
	if (confirm(m_num + "번 주문을 배송시키시겠습니까?")) {
		$.ajax ({
			type: 'POST',
			url: '/admin/doDelivery.do',
			data: {
				m_num: m_num,
				status: '배송준비중'
			},
			success: function (data) {
				if (data.status == "success") {
					alert(m_num + "번 주문이 배송중으로 변경되었습니다.");
					
					$("#payment_ready_" + m_num).text("주문상태: 배송중");
					$(btn).remove();
				} else {
					
				}
			}
		});
	}
}

function SellComplete(m_num, btn) {
	if (confirm(m_num + "번 주문을 배송시키시겠습니까?")) {
		$.ajax ({
			type: 'POST',
			url: '/admin/doConfirmSell.do',
			data: {
				m_num: m_num,
				status: '배송중'
			},
			success: function (data) {
				if (data.status == "success") {
					$("#payment_deliev_" + m_num).text("주문상태: 판매완료");
					
					$(btn).remove();
					
					alert(m_num + "번 주문이 판매 완료 되었습니다.");
				} else {
					
				}
			}
		});
	}
}

function goToAdminPage() {
    window.location.href = '/admin/adminPage.do';
}
</script>
</head>
<body>
<%@ include file="../header.jsp" %>	
<div id="content">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<ul class="nav nav-tabs">
				  	<li class="nav-item">
					    <a class="nav-link ${tab == null || tab == 'tab1' ? 'active' : ''}" href="/admin/sellManage.do?searchword=${searchword }&searchfield=${searchfield}&tab=tab1">결제 승인</a>
					</li>
					<li class="nav-item">
					    <a class="nav-link ${tab == 'tab2' ? 'active' : ''}"  href="/admin/sellManage.do?searchword=${searchword }&searchfield=${searchfield}&tab=tab2">배송 준비</a>
					</li>
					<li class="nav-item">
					    <a class="nav-link ${tab == 'tab3' ? 'active' : ''}"  href="/admin/sellManage.do?searchword=${searchword }&searchfield=${searchfield}&tab=tab3">배송중</a>
					</li>
					<li class="nav-item">
					    <a class="nav-link ${tab == 'tab4' ? 'active' : ''}"  href="/admin/sellManage.do?searchword=${searchword }&searchfield=${searchfield}&tab=tab4">판매내역</a>
					</li>
					<li class="nav-item">
					    <a class="nav-link ${tab == 'tab5' ? 'active' : ''}"  href="/admin/sellManage.do?searchword=${searchword }&searchfield=${searchfield}&tab=tab5">전체보기</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="row d-flex justify-content-center">
			<div class="col-md-12 d-flex justify-content-center" style="margin-top: 10px; margin-bottom: 10px;">
				<form action="/admin/sellManage.do" id="searchFrm" name="searchFrm">
			      	<div class="input-group">
			      		<a href="#" onclick="goToAdminPage();" class="btn btn-outline-primary float-left">돌아가기</a>
			      		&nbsp;&nbsp;
			      		<select class="form-select" name="tab" id="tab">
			          		<option value="tab1">결제승인</option>
			          		<option value="tab2">배송준비</option>
			          		<option value="tab3">배송중</option>
			          		<option value="tab4">판매내역</option>
			          		<option value="tab5">전체</option>
			        	</select>
			      		&nbsp;&nbsp;
			        	<select class="form-select" name="searchfield" id="searchfield">
			          		<option value="m_num">주문번호</option>
			          		<option value="u_id">회원아이디</option>
			        	</select>
			        	&nbsp;&nbsp;
			        	<input type="search" class="form-control" name="searchword" id="searchword" placeholder="검색어를 입력하세요">
			        	&nbsp;&nbsp;
			        	<button class="btn btn-secondary" type="submit">검색</button>
			      	</div>
			    </form>
			</div>
			<div class="col-md-12" style="margin-top: 20px;">
				<div class="tab-content">
					<!-- 결제 승인 탭 시작 -->
	  				<div id="tab1" class="tab-pane fade ${tab == null || tab == 'tab1' ? 'show active' : '' }">
						<c:if test="${ isOrder == 'No' }">
						<div class="col-md-12 d-flex align-items-center justify-content-center" style="height: 80vh; margin-top: 20px;">
							<h5 style="color: gray; font-size: 20px; font-weight: bold;">승인 대기중인 결제 정보가 없습니다.</h5>
						</div>
					</c:if>
					<c:if test="${ isOrder == 'Yes' }">
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
							        <h6 class="card-subtitle mb-2 text-muted" id="payment_${i.m_num }">주문상태: ${i.m_payment}</h6>
							        <button type="button" class="btn btn-link toggle" id="toggle${i.m_num }" data-toggle="collapse"
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
					                    		<tr class="bartoggle toggle_${i.m_num }">
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
										                			<th style="text-align: center;">${ j.p_num }번 상품의 바코드 번호 목록</th>
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
																				  		<input type="checkbox" value="${x.p_barcode }" class="form-check-input barcode_${i.m_num }_${ j.p_num }" id="${ x.p_barcode }" onclick="checkLimit(this, ${j.bo_qty}, ${j.p_num }, ${i.m_num })">
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
									  	<button type="button" class="btn btn-primary" onclick="doConfirm(${i.m_qty}, ${i.m_num }, this);">승인</button>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					</c:if>
					</div>
					<!-- 결제 승인 탭 끝 -->
					<!-- 배송 준비 탭 시작-->
					<div id="tab2" class="tab-pane fade ${tab == 'tab2' ? 'show active' : '' }" >
				    <c:if test="${ isOrder == 'No' }">
						<div class="col-md-12 d-flex align-items-center justify-content-center" style="height: 80vh; margin-top: 20px;">
							<h5 style="color: gray; font-size: 20px; font-weight: bold;">배송 준비중인 결제 정보가 없습니다.</h5>
						</div>
					</c:if>
					<c:if test="${ isOrder == 'Yes' }">
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
							        <h6 class="card-subtitle mb-2 text-muted" id="payment_ready_${i.m_num }">주문상태: ${i.m_payment}</h6>
							        <button type="button" class="btn btn-link toggle" id="toggle${i.m_num }" data-toggle="collapse"
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
					                    		<tr class="bartoggle toggle_${i.m_num }">
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
										                			<th style="text-align: center;">${ j.p_num }번 상품의 승인된 바코드 번호 목록</th>
										              			</tr>
										            		</thead>
										            		<tbody>
										              		<c:forEach items="${soldlist}" var="x">
										                		<c:if test="${j.p_num == x.p_num && i.m_num == x.m_num && i.m_payment == '배송준비중'}">
										                  			<tr>
										                    			<td style="padding: 0; padding-top:5px;">
										                    				<div class="form-check form-check-inline">
										                    					<ul>	
										                    						<li>
												                    					<label>${ x.p_barcode }</label>
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
										<div style="text-align:center;">
									  		<button type="button" class="btn btn-primary" onclick="doReadyDelivery(${i.m_num }, this);">배송준비완료</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					</c:if>
				  	</div>
				  	<!-- 배송 준비 탭 끝-->
				  	<!-- 배송중 탭 시작-->
				  	<div id="tab3" class="tab-pane fade ${tab == 'tab3' ? 'show active' : '' }">
				    <c:if test="${ isOrder == 'No' }">
						<div class="col-md-12 d-flex align-items-center justify-content-center" style="height: 80vh; margin-top: 20px;">
							<h5 style="color: gray; font-size: 20px; font-weight: bold;">배송중인 결제 정보가 없습니다.</h5>
						</div>
					</c:if>
					<c:if test="${ isOrder == 'Yes' }">
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
							        <h6 class="card-subtitle mb-2 text-muted" id="payment_deliev_${i.m_num }">주문상태: ${i.m_payment}</h6>
							        <button type="button" class="btn btn-link toggle" id="toggle${i.m_num }" data-toggle="collapse"
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
					                    		<tr class="bartoggle toggle_${i.m_num }">
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
										                			<th style="text-align: center;">${ j.p_num }번 상품의 승인된 바코드 번호 목록</th>
										              			</tr>
										            		</thead>
										            		<tbody>
										              		<c:forEach items="${soldlist}" var="x">
										                		<c:if test="${j.p_num == x.p_num && i.m_num == x.m_num && i.m_payment == '배송중'}">
										                  			<tr>
										                    			<td style="padding: 0; padding-top:5px;">
										                    				<div class="form-check form-check-inline">
										                    					<ul>	
										                    						<li>
												                    					<label>${ x.p_barcode }</label>
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
										<div style="text-align:center;">
									  		<button type="button" class="btn btn-primary" onclick="SellComplete(${i.m_num }, this);">배송완료</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					</c:if>
				  	</div>
				  	<!-- 배송중 탭 끝-->
				  	<div id="tab4" class="tab-pane fade ${tab == 'tab4' ? 'show active' : '' }">
				    <c:if test="${ isOrder == 'No' }">
						<div class="col-md-12 d-flex align-items-center justify-content-center" style="height: 80vh; margin-top: 20px;">
							<h5 style="color: gray; font-size: 20px; font-weight: bold;">판매 완료된 결제 정보가 없습니다.</h5>
						</div>
					</c:if>
					<c:if test="${ isOrder == 'Yes' }">
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
							        <h6 class="card-subtitle mb-2 text-muted" id="payment_complete_${i.m_num }">주문상태: ${i.m_payment}</h6>
							        <button type="button" class="btn btn-link toggle" id="toggle${i.m_num }" data-toggle="collapse"
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
					                    		<tr class="bartoggle toggle_${i.m_num }">
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
										                			<th style="text-align: center;">${ j.p_num }번 상품의 승인된 바코드 번호 목록</th>
										              			</tr>
										            		</thead>
										            		<tbody>
										              		<c:forEach items="${soldlist}" var="x">
										                		<c:if test="${j.p_num == x.p_num && i.m_num == x.m_num && i.m_payment == '판매완료'}">
										                  			<tr>
										                    			<td style="padding: 0; padding-top:5px;">
										                    				<div class="form-check form-check-inline">
										                    					<ul>	
										                    						<li>
												                    					<label>${ x.p_barcode }</label>
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
								</div>
							</div>
						</div>
					</c:forEach>
					</c:if>
				  	</div>
				  	<div id="tab5" class="tab-pane fade ${tab == 'tab5' ? 'show active' : '' }">
				    <c:if test="${ isOrder == 'No' }">
						<div class="col-md-12 d-flex align-items-center justify-content-center" style="height: 80vh; margin-top: 20px;">
							<h5 style="color: gray; font-size: 20px; font-weight: bold;">승인 대기중인 결제 정보가 없습니다.</h5>
						</div>
					</c:if>
					<c:if test="${ isOrder == 'Yes' }">
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
							        <h6 class="card-subtitle mb-2 text-muted" id="payment_${i.m_num }">주문상태: ${i.m_payment}</h6>
								</div>
							</div>
						</div>
					</c:forEach>
					</c:if>
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
									      	<a href="/admin/sellManage.do?page=1&searchword=${ searchword }&searchfield=${ searchfield }&tab=${ tab }" 
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
									      	<a href="/admin/sellManage.do?page=${page.curPage - 1}&searchword=${ searchword }&searchfield=${ searchfield }&tab=tab5" 
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
									        	<a href="/admin/sellManage.do?page=${fEach}&searchword=${ searchword }&searchfield=${ searchfield }&tab=${ tab }" 
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
									      	<a href="/admin/sellManage.do?page=${page.curPage + 1}&searchword=${ searchword }&searchfield=${ searchfield }&tab=${ tab }" 
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
									      	<a href="/admin/sellManage.do?page=${page.totalPage}&searchword=${ searchword }&searchfield=${ searchfield }&tab=${ tab }" 
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
		</div>
	</div>
</div>
<%@ include file="../footer.jsp" %>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>