<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css" />
<script>
// 이미지 효과
$(document).ready(function() {
	var firstImgSrc = $('.img').first().attr('src');
	
	$('#showimg').css('background-image', 'url(' + firstImgSrc + ')');
	
    $('.img').on('mouseenter', function() {
        var imgSrc = $(this).attr('src');
        $('#showimg').css('background-image', 'url(' + imgSrc + ')');
    });
    
    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        var target = $(e.target).attr("href") // 탭이 클릭된 대상의 href 값을 가져옴
        if (target === "#productDetail") {
          // 상품상세 탭이 클릭된 경우
          $("#productDetail").show(); // 해당 영역을 보이게 함
          $("#reviewSection").hide(); // 리뷰보기 영역을 숨김
        } else if (target === "#reviewSection") {
          // 리뷰보기 탭이 클릭된 경우
          $("#reviewSection").show(); // 해당 영역을 보이게 함
          $("#productDetail").hide(); // 상품상세 영역을 숨김
        }
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
                    m_addr: '${uinfo.u_addr1}' + '${uinfo.u_addr2}', // 사용자의 주소
                    p_num: '${pinfo.p_num}', // 구매한 상품 번호
                    p_name: '${pinfo.p_name}',
                    m_price: $("#amount").val(), // 상품 가격
                    m_qty: $("#quantity").val(), // 상품 수량
                    p_price: $("#price").val()	 // 상품 원래 가격
                },
                success: function(result) {
                    console.log(result); // 저장 결과 출력
                    location.href = "/product/productinfo.do?p_num=${pinfo.p_num}"
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

function doGoodProcess(num, id) {
	var r_num = num;
	var u_id = id;
	
	if(confirm('이 리뷰에 추천을 하시겠습니까?')) {
		$.ajax({
			type: 'POST',
			url: '/product/doRGood.do',
			data: {
				u_id: u_id,
				r_num: r_num
			},
			success: function(data) {
				if (data.status === 'success') {
					alert('추천되었습니다.');
					location.href = "/product/productinfo.do?p_num=${pinfo.p_num}";
				} else {
					alert('이미 추천한 리뷰입니다.');
				}
			}
		});	
	} else {
		
	}
}

function deleteReview(i, j) {
	var r_num = i;
	var p_num = j;
	
	if(confirm('정말 이 리뷰를 삭제하시겠습니까?')) {
		$.ajax({
			type: 'POST',
			url: '/product/deleteReview.do',
			data: {
				r_num: r_num,
				p_num: p_num
			},
			success: function(data) {
				if (data.status === 'success') {
					alert('삭제되었습니다.');
					location.href = "/product/productinfo.do?p_num=${pinfo.p_num}";
				} else {
					alert('삭제에 실패하였습니다.');
				}
			}
		})		
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

/* 리뷰 스타일 */
.review-container {
  border: 1px solid #ccc;
  padding: 20px;
  margin-bottom: 20px;
}

.review-header {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.review-rating {
  font-size: 24px;
  font-weight: bold;
  margin-right: 10px;
}

.review-info {
  font-size: 14px;
  color: #666;
}

.review-writer {
  margin-right: 10px;
}

.review-content {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.review-image {
  margin-right: 20px;
}

.review-image img {
  display: inline;
  max-width: 100%;
}

.review-text {
  font-size: 16px;
  line-height: 1.5;
  color: #333;
}

.review-footer {
  font-size: 14px;
  color: #666;
  margin-top: 10px;
}

.chkNo {
  font-size: 24px;
  color: #666;
  text-align: center;
  margin: 50px auto;
  border: 2px dashed #666;
  padding: 20px;
  max-width: 600px;
}

.recommend-btn {
  background-color: #4CAF50;
  border: none;
  color: white;
  padding: 5px 10px;
  margin-right: 5px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 12px;
  border-radius: 5px;
  cursor: pointer;
}

.recommend-btn:hover {
  background-color: #3e8e41;
}

.review-recommendation-container {
  display: flex;
  align-items: center;
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
											<img class="img" src="${ imgsrc }" width="50" height="50">
										</div>
									</c:forEach>
								</div>
							</div>
							<div class="col-md-7">
								<span style="font-size: 15pt"><b>가격 :</b></span>
  								<span class="price"><b><fmt:formatNumber type="number" value="${pinfo.p_price}" pattern="#,###" />원</b></span>
  								<br>
  								<br>
  								<br>
  								<br>
  								<br>
  								<form method="post">
  									<input type="hidden" name="p_num" value="${ pinfo.p_num }">
  									<label for="p_count">재고:</label>
  									<input type="text" name="p_count" id="p_count" value="${ pinfo.p_count }" size="2" readonly>
  									<br>
									<label for="quantity">주문 수량:</label>
								  	<input type="number" name="quantity" id="quantity" min="1" max="${ pinfo.p_count }" value="1" required onchange="calculateAmount()">
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
					<hr style="border: 1px solid #000;">
					<div class="d-flex align-items-center justify-content-center">
						<div class="col-md-12">
							<ul class="nav nav-tabs">
							  	<li class="nav-item">
							    	<a class="nav-link active" data-toggle="tab" href="#productDetail">상품상세</a>
							  	</li>
							  	<li class="nav-item">
							    	<a class="nav-link" data-toggle="tab" href="#reviewSection">리뷰보기</a>
							  	</li>
							</ul>
							<div class="tab-content">
							  	<div class="tab-pane active" id="productDetail">
							    	<div>상품상세</div>
							    	<!-- 상품 상세 정보를 담은 코드 -->
							  	</div>
							  	<div class="tab-pane" id="reviewSection">
							    	<c:if test="${ bchk == 'ok' && rchk == 'no'}">
							      		<div>
							        	<!-- 리뷰 작성 폼을 담은 코드 -->
							        		<div>
									  			<a class="btn btn-primary" data-toggle="collapse" href="#collapseReview" role="button" aria-expanded="false" aria-controls="collapseReview" style="margin-bottom: 20px;">
									    			리뷰 작성하기
									  			</a>
								  				<div class="collapse" id="collapseReview" style="border: 1px solid #ccc;">
									    			<form action="/product/reviewUpload.do" method="post" enctype="multipart/form-data">
									    				<input type="hidden" name="u_id" value="${uinfo.u_id }">
									    				<input type="hidden" name="p_num" value="${pinfo.p_num }">
									        			<div class="form-group">
									            			<label for="FormControlTextarea1">리뷰를 작성해주세요.</label>
									            			<textarea name="p_content" class="form-control" id="formControlTextarea1" rows="3"></textarea>
									        			</div>
									        			<div class="form-group">
									            			<label for="formControlFile1">사진을 업로드해주세요.</label>
									            			<input type="file" name="review_file" class="form-control-file" id="formControlFile1" multiple>
									        			</div>
									        			<div class="form-group">
												            <label for="formControlSelect1">별점을 매겨주세요.</label>
												            <select name="r_rating" class="form-control" id="formControlSelect1">
												                <option>1</option>
												                <option>2</option>
												                <option>3</option>
												                <option>4</option>
												                <option>5</option>
												            </select>
									        			</div>
									        			<button type="submit" class="btn btn-primary">리뷰 작성</button>
									    			</form>
												</div>
											</div>
							      		</div>
							    	</c:if>
								    <c:if test="${ bchk == 'no' }">
								      	<h1 class="chkNo">구매한 회원만 리뷰를 작성하실 수 있습니다.</h1>
								    </c:if>
								    <c:if test="${ rchk == 'yes' }">
								    	<h1 class="chkNo">이미 리뷰를 작성하신 상품입니다.</h1>
								    </c:if>
							    	<hr>
							    	<!-- 리뷰를 보여주는 코드 -->
						      		<c:forEach items="${ rdto }" var="i">
						      			<div class="review-container">
									  		<div class="review-header">
									    		<div class="review-rating">
													<c:set var="ratingImgPath" value="" />
													<c:choose>
													    <c:when test="${i.r_rating == 0}">
													        <c:set var="ratingImgPath" value="/productimgs/0.png" />
													    </c:when>
													    <c:when test="${i.r_rating <= 0.99}">
													        <c:set var="ratingImgPath" value="/productimgs/0_5.png" />
													    </c:when>
													    <c:when test="${i.r_rating >= 1 && i.r_rating <= 1.49}">
													        <c:set var="ratingImgPath" value="/productimgs/1.png" />
													    </c:when>
													    <c:when test="${i.r_rating >= 1.5 && i.r_rating <= 1.99}">
													        <c:set var="ratingImgPath" value="/productimgs/1_5.png" />
													    </c:when>
													    <c:when test="${i.r_rating >= 2 && i.r_rating <= 2.49}">
													        <c:set var="ratingImgPath" value="/productimgs/2.png" />
													    </c:when>
													    <c:when test="${i.r_rating >= 2.5 && i.r_rating <= 2.99}">
													        <c:set var="ratingImgPath" value="/productimgs/2_5.png" />
													    </c:when>
													    <c:when test="${i.r_rating >= 3 && i.r_rating <= 3.49}">
													        <c:set var="ratingImgPath" value="/productimgs/3.png" />
													    </c:when>
													    <c:when test="${i.r_rating >= 3.5 && i.r_rating <= 3.99}">
													        <c:set var="ratingImgPath" value="/productimgs/3_5.png" />
													    </c:when>
													    <c:when test="${i.r_rating >= 4 && i.r_rating <= 4.49}">
													        <c:set var="ratingImgPath" value="/productimgs/4.png" />
													    </c:when>
													    <c:when test="${i.r_rating >= 4.5 && i.r_rating <= 4.99}">
													        <c:set var="ratingImgPath" value="/productimgs/4_5.png" />
													    </c:when>
													    <c:otherwise>
													        <c:set var="ratingImgPath" value="/productimgs/5.png" />
													    </c:otherwise>
													</c:choose>
													<img src="${ratingImgPath}" alt="별점" style="width: 80px; height: 18px;"/>
												</div>
								    			<div class="review-info">
								      				<div class="review-writer">${i.u_id}</div>
								      				<div class="review-date">${i.r_date}</div>
								    			</div>
									  		</div>
									  		<div class="review-content">
									    		<div class="review-image">
									      			<c:forEach items="${ ridto }" var="j">
									        			<c:if test="${ i.r_num == j.r_num }">
									          				<c:forEach items="${ file }" var="f">
									            				<c:if test="${ j.r_sfile == f }">
									              					<a href="../revuploads/${f}" data-lightbox="image">
												  						<img src="../revuploads/${f}" alt="리뷰 이미지" width="100px" height="100px">
												  					</a>
									            				</c:if>
									          				</c:forEach>
									        			</c:if>
									      			</c:forEach>
									      			<p style="font-size: 9px; color: #ccc">※ 클릭시 사진이 커집니다</p>
									    		</div>
									  		</div>
									  		<div class="review-text">${i.p_content}</div>
									  		<div class="review-footer">
										  		<div class="review-recommendation-container">
										  			<s:authorize access="isAuthenticated()">
											    		<div class="review-recommendation-button">
											      			<button class="recommend-btn" onclick="doGoodProcess('${i.r_num}', '${uinfo.u_id }');">추천</button>
											    		</div>
										    		</s:authorize>
										    		<div class="review-recommendation">${i.r_good}명이 추천했습니다.</div>
										    		<c:if test="${ i.u_id == uinfo.u_id}">
										    			<div style="margin-left: auto;">
										    				<button class="btn btn-danger" onclick="deleteReview('${i.r_num}', '${pinfo.p_num}');">삭제</button>
										    			</div>
										    		</c:if>
										  		</div>
											</div>
										</div>
						      		</c:forEach>
							  	</div>
							</div>
					    </div>
					</div>
					<hr style="border: 1px solid #000;">
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/js/lightbox.min.js"></script>
</body>
</html>