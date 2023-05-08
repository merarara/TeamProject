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
        
     	// 해당 요소의 위치로 스크롤 이동
        var offset = $(target).offset().top;
        $('html, body').animate({scrollTop: offset}, 500);
   });
    
   	$("#displayList").hide();
	$('#searchword').on('keyup', function() {
		checkLength();
	});
	
	 // 파일 확장자 체크
    const filechk1 = document.getElementById('formControlFile1');
    filechk1.addEventListener('change', function(event) {
      	const file = event.target.files[0];
      	const extension = file.name.split('.').pop().toLowerCase();
      	if (!['jpg', 'png', 'gif'].includes(extension)) {
        	alert('JPG, PNG, GIF 파일만 업로드 가능합니다.');
        	filechk1.value = '';
      	}
    });
});

// 상품 검색 자동완성
function checkLength() {
	var wordLength = $('#searchword').val().trim().length;
	if(wordLength == 0){
		$("#displayList").hide();
	} else {
		$.ajax({
			url:"/product/wordSearchShow.do",
			type:"get",
			data:{"searchfield": $("#searchfield").val(),
				  "searchword": $("#searchword").val() },
			dataType:"json",
			success:function(json){
				if(json.length > 0){
					// 검색된 데이터가 있는 경우
					var html = "";
					$.each(json, function(indexs, item){
						var word = item.word;
	                    // 검색목록들과 검색단어를 모두 소문자로 바꾼 후 검색단어가 나타난 곳의 index를 표시.
						var index = word.toLowerCase().indexOf( $("#searchword").val().toLowerCase() );
						var len = $("#searchword").val().length;
						// 검색한 단어를 파랑색으로 표현
						var result = word.substr(0, index) + "<span style='color:blue;'>"+word.substr(index, len)+"</span>" + word.substr(index+len);
						html += "<span class='result' style='cursor:pointer;'>" + result + "</span><br>";
					});
					
					var input_width = $("#searchword").css("width"); // 검색어 input 태그 width 알아오기
					$("#displayList").css({"width":input_width}); // 검색 결과의 width와 일치시키기
					$("#displayList").html(html);
					$("#displayList").show();
				}
			},
			error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
	}
}

function goSearch(form) {
	form.submit();
}
// 자동완성 목록을 클릭하면 검색하기
$(document).on('click', ".result", function(){
	var word = $(this).text();
	$("#searchword").val(word);
	goSearch($('#searchFrm')); // 검색기능
});

function hideDiv() {
    $('#displayList').hide();
}

$(document).click(function(event) {
    if (!$(event.target).closest('#displayList').length) {
        hideDiv();
    }
});
// 상품 검색 자동완성 끝

// 결제 api
function iamport(){
	if('${uinfo.u_id}' == '') {
		alert('로그인 후 이용하실 수 있습니다');
		return false;
	}
	
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
                    u_nick: '${uinfo.u_nick}',
                    m_addr: '${uinfo.u_addr1}' + ' ${uinfo.u_addr2}', // 사용자의 주소
                    p_num: '${pinfo.p_num}', // 구매한 상품 번호
                    p_name: '${pinfo.p_name}',
                    m_price: $("#amount").val(), // 상품 가격
                    m_qty: $("#quantity").val(), // 상품 수량
                    p_price: $("#price").val()	 // 상품 원래 가격
                }
            });
            alert("결제에 성공하였습니다.");
       		location.reload();
        } else {
             var msg = '결제에 실패하였습니다.';
             msg += '에러내용 : ' + rsp.error_msg;
             alert(msg);
        }
    });
}

// 수량에 따른 가격 증가
function calculateAmount() {
	  var quantity = parseInt(document.getElementById("quantity").value);
	  var price = parseInt(document.getElementById("price").value);
	  var amount = quantity * price;
	  document.getElementById("amount").value = amount;
}

// 장바구니 담기
function doAddBascket() {
	if('${uinfo.u_id}' == '') {
		alert('로그인 후 이용하실 수 있습니다');
		return false;
	}
	
	if(confirm('장바구니에 담으시겠습니까?')) {
		$.ajax({
			type: 'POST',
			url: '/product/add_bascket.do',
			data: {
				u_id: '${uinfo.u_id}',
				p_num: '${pinfo.p_num}',
				u_nick: '${uinfo.u_nick}',
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

// 리뷰 좋아요
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

// 리뷰 삭제
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
/* 상품 메인 스타일 */
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
  margin-left: 300px;
  color: #0067A3;
  font-size: 20pt;
}
/* 상품 메인 스타일 끝 */

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
/* 리뷰 스타일 끝 */

/* 연관검색어 리스트 스타일 */
#displayList {
	border: solid 1px gray; 
	height: 100px; 
	overflow: auto; 
	margin-left: 81px; margin-top; 1px ;
	border-top: 0px;
	position: absolute;
	z-index: 1;
	background-color: #fff;
}
/* 연관색어 리스트 스타일 끝*/

table {
  border-collapse: collapse;
  margin-bottom: 20px;
  width: 100%;
  margin-top: 20px;
}

th, td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: left;
  vertical-align: top;
}

th {
  background-color: #f2f2f2;
  font-weight: bold;
}

/* 간편선택 사이드 메뉴 스타일링 */
.side-menu {
    width: 200px;
    height: 400px;
    background-color: #f8f9fa;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    border: dotted 1px #000;
    padding: 20px;
    margin-left: 30px;
}

.side-menu h5 {
    margin-bottom: 20px;
}

.side-menu hr {
    width: 100%;
    margin-top: 10px;
    margin-bottom: 10px;
    border: none;
    border-top: 1px solid #000;
}

.side-menu a {
    border: none;
    text-align: center;
    padding: 10px;
    transition: all 0.3s ease;
}

.side-menu a:hover {
    background-color: #e9ecef;
}

#wrap {
	min-width: 1600px;
}

footer {
	min-width: 1600px;
}

/* 구매가이드 사이드 메뉴 스타일 */
.side-menu2 {
    width: 200px;
    height: 445px;
    background-color: #f8f9fa;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 20px;
}

.side-menu2 hr {
    width: 100%;
    margin-top: 10px;
    margin-bottom: 10px;
    border: none;
    border-top: 1px solid #000;
}

.side-menu2 a {
    border: none;
    text-align: center;
    transition: all 0.3s ease;
}

.side-menu2 a:hover {
    background-color: #e9ecef;
}

/* */

#collapseReview {
  background-color: #f8f9fa;
  border-radius: 4px;
  border: 1px solid #dee2e6;
  padding: 10px;
}

label {
  font-weight: bold;
}

.rev-group {
  margin-bottom: 20px;
}

textarea {
  resize: vertical;
}

.form-control-file {
  overflow: hidden;
}

.btn-primary:focus {
  box-shadow: none;
}

#formControlSelect1 {
  appearance: none;
  background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 30"><path d="M0 10h30L15 27z"/></svg>') no-repeat right center/10px 10px, transparent;
  font-size: 16px;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  width: 300px;
  background-color: #fff;
}

#formControlSelect1::-ms-expand {
  display: none;
}
</style>
</head>
<body>

<%@ include file="../header.jsp" %>	
<div class="container-fluid" id="content" style="min-width: 1600px;">
	<div class="row justify-content-center" style="padding-top: 30px; padding-bottom: 30px;">
		<!-- 검색창 -->
		<div class="col-md-5">
		    <form action="/product/productlist.do" id="searchFrm" name="searchFrm">
		    	<input type="hidden" name="type" value="search">
		      	<div class="input-group">
		      		<a href="/product/productlist.do">
		      			<button type="button" class="btn btn-outline-primary">돌아가기</button>
		      		</a>
		      		&nbsp;&nbsp;
		        	<select class="form-select" name="searchfield" id="searchfield">
		          		<option value="p_name">상품명</option>
		          		<option value="p_company">제조사</option>
		        	</select>
		        	&nbsp;&nbsp;
		        	<input type="search" class="form-control" name="searchword" id="searchword" placeholder="검색어를 입력하세요">
		        	&nbsp;&nbsp;
		        	<button class="btn btn-secondary" type="button" onclick="goSearch(this.form)">검색</button>
		      	</div>
		    </form>
		    <!-- 검색어 자동완성이 보여질 구역 -->
			<div id="displayList" onclick="hideDiv()">
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-2 d-flex align-items-center justify-content-center">
		    <!-- 카테고리 메뉴 내용 -->
		    <div class="side-menu">
		        <h5>간편선택</h5>
		        <hr>
		        <div style="width: 100%; display: flex; flex-direction: column;">
		            <a href="/product/productlist.do" class="btn btn-link text-dark">노트북 전체</a>
		            <hr> 
		            <a href="/product/productlist.do?searchfield=p_company&searchword=ASUS&type=select&selected=ASUS" class="btn btn-link text-dark">ASUS</a>
		            <hr>
		            <a href="/product/productlist.do?searchfield=p_company&searchword=APPLE&type=select&selected=APPLE" class="btn btn-link text-dark">APPLE</a>
		            <hr>
		            <a href="/product/productlist.do?searchfield=p_company&searchword=DELL&type=select&selected=DELL" class="btn btn-link text-dark">DELL</a>
		        </div>  
		    </div>
		</div>
		<!-- 상품 내용 -->
		<div class="col-md-8">
			<div class="row">
				<div class="d-flex align-items-center justify-content-center">
					<div id="contentwrap" style="width: 90%;">
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
												<c:if test="${fn:contains(imgsrc, '/') }">
													<img class="img" src="${ imgsrc }" width="50" height="50">
												</c:if>
												<c:if test="${not fn:contains(imgsrc, '/') }">
													<img class="img" src="../productuploads/${ imgsrc }" width="50" height="50">
												</c:if>
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
									  	<div class="form-group mb-3">
									    	<label for="p_count">재고</label>
									    	<input type="text" class="form-control" name="p_count" id="p_count" value="${pinfo.p_count}" readonly>
									  	</div>
									  	<div class="form-group mb-3">
									    	<label for="quantity">주문 수량</label>
									    	<input type="number" class="form-control" name="quantity" id="quantity" min="1" max="${pinfo.p_count}" value="1" required onchange="calculateAmount()">
									  	</div>
									  	<div class="form-group mb-3">
									    	<label for="price">상품 가격</label>
									    	<input type="text" class="form-control" name="price" id="price" value="100" readonly>
									  	</div>
									  	<div class="form-group mb-3">
									    	<label for="amount">결제 금액</label>
									    	<input type="text" class="form-control" name="amount" id="amount" value="100" readonly>
									  	</div>
									  	<div class="d-grid gap-2 mb-3">
									    	<button name="paymentButton" id="paymentButton" onclick="iamport(); return false;" class="btn btn-warning btn-lg" type="submit">바로 결제하기</button>
									    	<button name="addBascket" id="addBascket" onclick="doAddBascket();" class="btn btn-primary btn-lg" type="button">장바구니 추가</button>
									  	</div>
									  	<c:if test="${pinfo.p_count == 0}">
								    	<h1 class="chkNo">매진된 상품입니다. <br>입고될때까지 기다려주세요.</h1>
									  	</c:if>
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
								  		<table>
								  			<caption>제품 정보</caption>
										  <tr>
										    <th width="250">운영체제</th>
										    <td>${ pinfo.os }</td>
										  </tr>
										  <tr>
										    <th width="250">화면정보</th>
										    <td>${ pinfo.monitor }</td>
										  </tr>
										  <tr>
										    <th width="250">CPU</th>
										    <td>${ pinfo.cpu }</td>
										  </tr>
										  <tr>
										    <th width="250">램</th>
										    <td>${ pinfo.r_storage }</td>
										  </tr>
										  <tr>
										    <th width="250">램 교체</th>
										    <td>${ pinfo.ram }</td>
										  </tr>
										  <tr>
										    <th width="250">그래픽</th>
										    <td>${ pinfo.graphic }</td>
										  </tr>
										  <tr>
										    <th width="250">저장장치</th>
										    <td>${ pinfo.storage }</td>
										  </tr>
										  <tr>
										    <th width="250">네트워크</th>
										    <td>${ pinfo.network }</td>
										  </tr>
										  <tr>
										    <th width="250">영상입출력</th>
										    <td>${ pinfo.video_io }</td>
										  </tr>
										  <tr>
										    <th width="250">단자</th>
										    <td>${ pinfo.terminal }</td>
										  </tr>
										  <tr>
										    <th width="250">부가기능</th>
										    <td>${ pinfo.add_ons }</td>
										  </tr>
										  <tr>
										    <th width="250">입력장치</th>
										    <td>${ pinfo.io }</td>
										  </tr>
										  <tr>
										    <th width="250">파워</th>
										    <td>${ pinfo.power }</td>
										  </tr>
										  <c:if test="${ not empty pinfo.hz }" >
										    <tr>
										      <th width="250">주사율</th>
										      <td>${ pinfo.hz }</td>
										    </tr>
										  </c:if>
										  <c:if test="${ not empty pinfo.etc }" >
										    <tr>
										      <th width="250">주요제원</th>
										      <td>${ pinfo.etc }</td>
										    </tr>
										  </c:if>
										</table>
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
										    				<input type="hidden" name="u_nick" value="${uinfo.u_nick }">
										        			<div class="form-group rev-group">
										            			<label for="FormControlTextarea1">리뷰를 작성해주세요.</label>
										            			<textarea name="p_content" class="form-control" id="formControlTextarea1" rows="3" placeholder="리뷰 내용을 작성해주세요"></textarea>
										        			</div>
										        			<div class="form-group rev-group">
										            			<label for="formControlFile1">사진을 업로드해주세요.</label>
										            			<input type="file" name="review_file" class="form-control-file" id="formControlFile1" accept=".jpg,.png,.gif" multiple>
										        			</div>
										        			<div class="form-group rev-group">
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
								    	<c:if test="${ reviewNo == 'Yes' }">
								    		<h1 class="chkNo">작성된 리뷰가 아직 없는 상품입니다.</h1>
								    	</c:if>
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
									      				<div class="review-writer">${i.u_nick}</div>
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
		<div class="col-md-2 d-flex align-items-center justify-content-center">
			<div class="side-menu2">
		        <a href="/product/buyguide/guide1.do"><img src="/productimgs/cpuNumbering.jpg"/></a>
		        <b>쇼핑가이드</b>
		        <a href="/product/buyguide/guide1.do" class="text-dark">
		        	> 한눈에 보는 노트북 CPU넘버링 가이드 
		        </a>
		        <hr>
		        > 대학생 새내기 주목! 슬기로운 대학생활 위한 최고의 노트북은? <hr>
		        > 인텔 11~13세대, AMD 5000~7000번대. 나는 어떤 노트북을 골라야 될까?
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