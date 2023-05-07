<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<style>
	/* 카테고리 박스 숨기기 */
	/* 숨길 영역을 초기에 숨기기 */
	.hidden {
	  display: none;
	}
	
	.hidden2 {
	  display: none;
	}
	
	/* 펼치기 버튼 스타일 설정 */
	.btn-toggle {
	  padding: 0;
	  border: none;
	  background: none;
	  text-decoration: underline;
	  cursor: pointer;
	  position: absolute;
	  right: 0;
	  bottom: 0;
	}
	
	.btn-toggle2 {
	  padding: 0;
	  border: none;
	  background: none;
	  text-decoration: underline;
	  cursor: pointer;
	  position: absolute;
	  right: 0;
	  bottom: 0;
	}
	
	/* 카테고리 박스 */
	.categorybox {
		border: 1px solid #ccc;
		width: 90%; 
		margin-left: auto; 
		margin-right: auto;
		margin-bottom: 20px;
	}
	
    /* 테이블 스타일링 */
    table {
        width: 90%;
        border-collapse: collapse;
        margin-left: auto;
    	margin-right: auto;
    }
    th, td {
        border: 1px solid #ccc;
        padding: 10px;
        text-align: left;
    }
    th {
        background-color: #f8f8f8;
        text-align : center;
    }
    tbody tr:nth-child(even) {
        background-color: #f8f8f8;
    }
    tbody tr:hover {
        background-color: #f0f0f0;
    }
    /* 버튼 스타일링 */
    .pagingbtn {
        display: inline-block;
        padding: 5px 10px;
        border: none;
        background-color: #f8f9fa;
        color: #fff;
        text-align: center;
        text-decoration: none;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .pagingbtn:hover {
        background-color: #808080;
    }
    .pagingbtn.disabled {
        opacity: 0.5;
        cursor: default;
    }
    /* 간편선택 사이드 메뉴 스타일 */
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
    
    /* 상단카테고리 메뉴 스타일 */
    .cate {
	  	table-layout: fixed;
	  	width: 100%;
	}

	.catename {
	  	white-space: nowrap;
	  	width: 10%;
	}
	
	.cate_value {
		margin-right: 15px;
		border: 1px solid #ccc;
		text-align: center;
		padding-right: 10px;
		padding-left: 10px;
		padding-top: 5px;
		padding-bottom: 5px;
	}
	
	.matufacturer-list {
	  	position: relative;
	}
	
	#wrap {
		min-width: 1600px;
	}
	
	footer {
		min-width: 1600px;
	}
	
	<c:set var="selectedValue" value="${param.selected}" />

	.cate_value[data-value='${selectedValue}'] {
	  background-color: #617DF8;
	}
	
	.cate_value a[data-value='${selectedValue}'] {
	  color: white;
	}
	
	<c:set var="searchValue" value="${param.searchword}" />

	.cate_value[data-value='${searchValue}'] {
	  background-color: #617DF8;
	}
	
	.cate_value a[data-value='${searchValue}'] {
	  color: white;
	}
	/* 상단 카테고리 메뉴 스타일 끝*/
	
	.search-result {
	    font-weight: bold;
	    font-size: 18px;
	    color: #1a1a1a;
  	}
</style>
<script>
	// 상품 검색 자동완성 시작 //
	$(document).ready(function() {
		$("#displayList").hide();
		$('#searchword').on('keyup', function() {
			checkLength();
		});
	});

	function checkLength() {
		var wordLength = $('#searchword').val().trim().length;
		console.log(wordLength);
		console.log($("#searchfield").val());
		console.log($("#searchword").val());
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
							// jaVa -> java
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
	
	// 펼치기 버튼에 이벤트 리스너 등록
	window.addEventListener('DOMContentLoaded', () => {
	  	const btnToggle = document.querySelector('.btn-toggle');
	  	btnToggle.addEventListener('click', () => {
	    	const hiddenSpan = document.querySelector('.hidden');
		    if (hiddenSpan.style.display === 'none') {
		      	hiddenSpan.style.display = 'inline';
		      	btnToggle.textContent = '접기';
		    } else {
		      	hiddenSpan.style.display = 'none';
		      	btnToggle.textContent = '펼치기';
		    }
	  	});
	  	
		// URL 쿼리스트링 파싱 함수
		function parseQueryString() {
			const qs = window.location.search.substring(1);
		    const pairs = qs.split('&');
		    const result = {};
		    for (let i = 0; i < pairs.length; i++) {
		    	const pair = pairs[i].split('=');
		        const key = decodeURIComponent(pair[0]);
		        const value = decodeURIComponent(pair[1] || '');
		        result[key] = value;
		    }
		    return result;
		}

	    // URL 쿼리스트링 파싱 결과
	    const query = parseQueryString();

	    // 파라미터 openchk의 값이 'Y'일 때 펼치기 처리
	    if (query.openchk === 'Y') {
	      	const selectedLink = document.querySelector('span.cate_value a[data-value="${param.selected}"]');
	      	const hiddenSpan = document.querySelector('.hidden');
	      	hiddenSpan.style.display = 'inline';
	      	btnToggle.textContent = '접기';
	    } else {
        	const hiddenSpan = document.querySelector('.hidden');
        	hiddenSpan.style.display = 'none';
      	}
	});
	
	window.addEventListener('DOMContentLoaded', () => {
	  	const btnToggle2 = document.querySelector('.btn-toggle2');
	  	btnToggle2.addEventListener('click', () => {
	    	const hiddenSpan2 = document.querySelector('.hidden2');
		    if (hiddenSpan2.style.display === 'none') {
		      	hiddenSpan2.style.display = 'inline';
		      	btnToggle2.textContent = '접기';
		    } else {
		      	hiddenSpan2.style.display = 'none';
		      	btnToggle2.textContent = '펼치기';
		    }
	  	});
	  	
		// URL 쿼리스트링 파싱 함수
		function parseQueryString() {
			const qs = window.location.search.substring(1);
		    const pairs = qs.split('&');
		    const result = {};
		    for (let i = 0; i < pairs.length; i++) {
		    	const pair = pairs[i].split('=');
		        const key = decodeURIComponent(pair[0]);
		        const value = decodeURIComponent(pair[1] || '');
		        result[key] = value;
		    }
		    return result;
		}
	
	    // URL 쿼리스트링 파싱 결과
	    const query = parseQueryString();
	
	    // 파라미터 openchk의 값이 'Y'일 때 펼치기 처리
	    if (query.openchk2 === 'Y') {
	      	const priceLink = document.querySelector('span.cate_value a[data-value="${param.searchword}"]');
		    const hiddenSpan2 = document.querySelector('.hidden2');
		    hiddenSpan2.style.display = 'inline';
		    btnToggle2.textContent = '접기';
		} else {
        	const hiddenSpan = document.querySelector('.hidden2');
        	hiddenSpan.style.display = 'none';
      	}
	});
</script>
</head>
<body>
<%@ include file="../header.jsp" %>

<div class="container-fluid" style="min-width: 1600px;">
	<div class="row" style="padding-top: 30px; padding-bottom: 30px;">
		<div class="col-md-4 offset-md-4">
		    <form action="/product/productlist.do" id="searchFrm" name="searchFrm">
		    	<input type="hidden" name="type" value="search">
		      	<div class="input-group">
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
		<div class="col-md-8">
			<div class="d-flex align-items-center justify-content-center categorybox">
				 <table style="font-size: 10pt;" class="cate">
			        <tr>
			        	<!-- 상단 카테고리 제조사 메뉴 -->
			            <td class="catename"><b>제조사별</b></td>
			            <td>
			            	<div class="matufacturer-list">
					            <span class="cate_value" data-value="삼성전자">
						            <a href="/product/productlist.do?searchfield=p_company&searchword=삼성전자&type=select&selected=삼성전자" 
						        		data-value="삼성전자">
						            	삼성전자
						            </a>
					            </span>
					            <span class="cate_value" data-value="GIGABYTE">
					            	<a href="/product/productlist.do?searchfield=p_company&searchword=GIGABYTE&type=select&selected=GIGABYTE"
					            		data-value="GIGABYTE">
					            		GIGABYTE
					            	</a>
					            </span>
					            <span class="cate_value" data-value="한성컴퓨터">
					            	<a href="/product/productlist.do?searchfield=p_company&searchword=한성컴퓨터&type=select&selected=한성컴퓨터" 
					            		data-value="한성컴퓨터">
					            		한성컴퓨터
					            	</a>
					            </span>
					            <span class="cate_value" data-value="MSI">
					            	<a href="/product/productlist.do?searchfield=p_company&searchword=MSI&type=select&selected=MSI" 
					            		data-value="MSI">
					            		MSI
					            	</a>
					            </span>
					            <span class="cate_value" data-value="에이서">
					            	<a href="/product/productlist.do?searchfield=p_company&searchword=에이서&type=select&selected=에이서" 
					            		data-value="에이서">
					            		에이서
					            	</a>
					            </span>
					            <span class="cate_value" data-value="ASUS">
					            	<a href="/product/productlist.do?searchfield=p_company&searchword=ASUS&type=select&selected=ASUS" 
						            	data-value="ASUS">
						            	ASUS
						            </a>
					            </span>
					            <span class="cate_value" data-value="DELL">
					            	<a href="/product/productlist.do?searchfield=p_company&searchword=DELL&type=select&selected=DELL" 
					            		data-value="DELL">
					            		DELL
					            	</a>
					            </span>
					            <span class="cate_value" data-value="Razer">
					            	<a href="/product/productlist.do?searchfield=p_company&searchword=Razer&type=select&selected=Razer" 
					            		data-value="Razer">
					            		Razer
					            	</a>
					            </span>
					            <span class="cate_value" data-value="APPLE">
					            	<a href="/product/productlist.do?searchfield=p_company&searchword=APPLE&type=select&selected=APPLE" 
					            		data-value="APPLE">
					            		APPLE
					            	</a>
					            </span>			            
					            <button class="btn-toggle">펼치기</button>
			            	</div>
			            	<span class="hidden">
			            		<br>
			            		<span class="cate_value" data-value="Microsoft">
			            			<a href="/product/productlist.do?searchfield=p_company&searchword=Microsoft&type=select&selected=Microsoft&openchk=Y&openchk2=${param.openchk2}"
			            				data-value="Microsoft">
			            				Microsoft
			            			</a>
			            		</span>
			            		<span class="cate_value" data-value="주연테크">
			            			<a href="/product/productlist.do?searchfield=p_company&searchword=주연테크&type=select&selected=주연테크&openchk=Y&openchk2=${param.openchk2}" 
			            				data-value="주연테크">
			            				주연테크
			            			</a>
			            		</span>
					            <span class="cate_value" data-value="LG전자">
						            <a href="/product/productlist.do?searchfield=p_company&searchword=LG전자&type=select&selected=LG전자&openchk=Y&openchk2=${param.openchk2}" 
						            	data-value="LG전자">
						            	LG전자
						            </a>
					            </span>
					            <span class="cate_value" data-value="레노버">
					            	<a href="/product/productlist.do?searchfield=p_company&searchword=레노버&type=select&selected=레노버&openchk=Y&openchk2=${param.openchk2}" 
						            	data-value="레노버">
						            	레노버
						            </a>
					            </span>
				            	<span class="cate_value" data-value="샤오미">
					            	<a href="/product/productlist.do?searchfield=p_company&searchword=샤오미&type=select&selected=샤오미&openchk=Y&openchk2=${param.openchk2}" 
						            	data-value="샤오미">
						            	샤오미
					            	</a>
				            	</span>
				            	<span class="cate_value" data-value="디클">
					            	<a href="/product/productlist.do?searchfield=p_company&searchword=디클&type=select&selected=디클&openchk=Y&openchk2=${param.openchk2}" 
						            	data-value="디클">
						            	디클
					            	</a>
				            	</span>
				            	<span class="cate_value" data-value="HP">
					            	<a href="/product/productlist.do?searchfield=p_company&searchword=HP&type=select&selected=HP&openchk=Y&openchk2=${param.openchk2}" 
						            	data-value="HP">
						            	HP
					            	</a>
				            	</span>
			            	</span>
			            </td>
			        </tr>
			        <tr>
			        	<!-- 상단 카테고리 메뉴 가격별 -->
			            <td class="catename"><b>가격별</b></td>
			            <td>
				            <div class="matufacturer-list">
				            	<span class="cate_value" data-value="500001">
					            	<a href="/product/productlist.do?searchfield=p_price&searchword=500001&type=select&selected=${ param.selected }&openchk2=&openchk=${param.openchk}" 
						            	data-value="500001">
						            	50만원 이하
					            	</a>
				            	</span>
				            	<span class="cate_value" data-value="500000">
					            	<a href="/product/productlist.do?searchfield=p_price&searchword=500000&type=select&selected=${ param.selected }&openchk2=&openchk=${param.openchk}" 
						            	data-value="500000">
						            	50만원 ~ 100만원
					            	</a>
				            	</span>
				            	<span class="cate_value" data-value="1000000">
					            	<a href="/product/productlist.do?searchfield=p_price&searchword=1000000&type=select&selected=${ param.selected }&openchk2=&openchk=${param.openchk}" 
						            	data-value="1000000">
						            	100만원 ~ 150만원
					            	</a>
				            	</span>
				            	<span class="cate_value" data-value="1500000">
					            	<a href="/product/productlist.do?searchfield=p_price&searchword=1500000&type=select&selected=${ param.selected }&openchk2=&openchk=${param.openchk}" 
						            	data-value="1500000">
						            	150만원 ~ 200만원
					            	</a>
				            	</span>
				            	<span class="cate_value" data-value="2000000">
					            	<a href="/product/productlist.do?searchfield=p_price&searchword=2000000&type=select&selected=${ param.selected }&openchk2=&openchk=${param.openchk}" 
						            	data-value="2000000">
						            	200만원 ~ 300만원
					            	</a>
				            	</span>
				            	<button class="btn-toggle2">펼치기</button>
				            </div>
				            <span class="hidden2">
				            	<br>
				            	<span class="cate_value" data-value="3000000">
					            	<a href="/product/productlist.do?searchfield=p_price&searchword=3000000&type=select&selected=${ param.selected }&openchk2=Y&openchk=${param.openchk}" 
						            	data-value="3000000">
						            	300만원 ~ 400만원
					            	</a>
				            	</span>
				            	<span class="cate_value" data-value="4000000">
				            		<a href="/product/productlist.do?searchfield=p_price&searchword=4000000&type=select&selected=${ param.selected }&openchk2=Y&openchk=${param.openchk}" 
					            		data-value="4000000">
					            		400만원 ~ 500만원
					            	</a>
				            	</span>
				            	<span class="cate_value" data-value="5000000">
					            	<a href="/product/productlist.do?searchfield=p_price&searchword=5000000&type=select&selected=${ param.selected }&openchk2=Y&openchk=${param.openchk}" 
						            	data-value="5000000">
						            	500만원 이상
					            	</a>
				            	</span>
				            </span>
			            </td>
			        </tr>
			    </table>
			</div>
			<div class="search-result" style="width: 100%; text-align: center;">
				검색된 상품 수 : ${ page.totalCount }
			</div>
			<!-- 상품 목록 -->
			<table>
				<thead>
				<tr>
					<th>상품이미지</th>
					<th>상품명</th>
					<th>가격</th>
					<th>제조사</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${plist}" var="i">
					<tr>
						<td style="text-align: center;" width="130" height="130">
							<c:if test="${fn:contains(i.p_listimg, '/') }">
								<img src="${i.p_listimg}"  width="130" height="130" style="object-fit: cover;">
							</c:if>
							<c:if test="${not fn:contains(i.p_listimg, '/') }">
								<img src="../productuploads/${i.p_listimg}"  width="130" height="130" style="object-fit: cover;">
							</c:if>
						</td>
						<td><h4><a href="/product/productinfo.do?p_num=${i.p_num}" class="text-dark">${i.p_name}</a></h4><br>
							<c:set var="ratingImgPath" value="" />
							<c:choose>
							    <c:when test="${i.p_rating == 0}">
							        <c:set var="ratingImgPath" value="/productimgs/0.png" />
							    </c:when>
							    <c:when test="${i.p_rating <= 0.99}">
							        <c:set var="ratingImgPath" value="/productimgs/0_5.png" />
							    </c:when>
							    <c:when test="${i.p_rating >= 1 && i.p_rating <= 1.49}">
							        <c:set var="ratingImgPath" value="/productimgs/1.png" />
							    </c:when>
							    <c:when test="${i.p_rating >= 1.5 && i.p_rating <= 1.99}">
							        <c:set var="ratingImgPath" value="/productimgs/1_5.png" />
							    </c:when>
							    <c:when test="${i.p_rating >= 2 && i.p_rating <= 2.49}">
							        <c:set var="ratingImgPath" value="/productimgs/2.png" />
							    </c:when>
							    <c:when test="${i.p_rating >= 2.5 && i.p_rating <= 2.99}">
							        <c:set var="ratingImgPath" value="/productimgs/2_5.png" />
							    </c:when>
							    <c:when test="${i.p_rating >= 3 && i.p_rating <= 3.49}">
							        <c:set var="ratingImgPath" value="/productimgs/3.png" />
							    </c:when>
							    <c:when test="${i.p_rating >= 3.5 && i.p_rating <= 3.99}">
							        <c:set var="ratingImgPath" value="/productimgs/3_5.png" />
							    </c:when>
							    <c:when test="${i.p_rating >= 4 && i.p_rating <= 4.49}">
							        <c:set var="ratingImgPath" value="/productimgs/4.png" />
							    </c:when>
							    <c:when test="${i.p_rating >= 4.5 && i.p_rating <= 4.99}">
							        <c:set var="ratingImgPath" value="/productimgs/4_5.png" />
							    </c:when>
							    <c:otherwise>
							        <c:set var="ratingImgPath" value="/productimgs/5.png" />
							    </c:otherwise>
							</c:choose>
							<div style="display: flex; align-items: center;">
							    <div style="flex: 1;">
							        <img src="${ratingImgPath}" alt="별점" style="width: 80px; height: 18px;"/> ${ i.p_rating }
							    </div>
							    <div style="font-size: 16px;">
							        등록일 : ${fn:substring(i.p_rdate, 0, 7)}
							    </div>
							</div>
						</td>
						<td style="text-align: center;"><fmt:formatNumber type="number" value="${i.p_price}" pattern="#,###" />원<br>
						<c:if test="${ i.p_count < 3 && i.p_count > 0 }"><div style="color: red;">매진임박</div></c:if>
						<c:if test="${ i.p_count == 0 }"><div style="color: red;">매진</div></c:if>
						</td>
						<td style="text-align: center;">${i.p_company}</td>
					</tr>
				</c:forEach>
				</tbody>
				<!-- 버튼 페이징 -->
				<tr>
					<td colspan="5" style="text-align: center;">
					  	<!-- 처음 -->
					  	<c:choose>
					    	<c:when test="${(page.curPage - 1) < 1 }">
					      		<button class="btn btn-link text-dark" disabled>&lt;&lt;</button>
					    	</c:when>
						    <c:otherwise>
						      	<a href="/product/productlist.do?page=1&searchfield=${param.searchfield}&searchword=${param.searchword}&type=${param.type}&selected=${ param.selected }" 
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
						      	<a href="/product/productlist.do?page=${page.curPage - 1}&searchfield=${param.searchfield}&searchword=${param.searchword}&type=${param.type}&selected=${ param.selected }" 
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
						        	<a href="/product/productlist.do?page=${fEach}&searchfield=${param.searchfield}&searchword=${param.searchword}&type=${param.type}&selected=${ param.selected }" 
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
						      	<a href="/product/productlist.do?page=${page.curPage + 1}&searchfield=${param.searchfield}&searchword=${param.searchword}&type=${param.type}&selected=${ param.selected }" 
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
						      	<a href="/product/productlist.do?page=${page.totalPage}&searchfield=${param.searchfield}&searchword=${param.searchword}&type=${param.type}&selected=${ param.selected }" 
						      		class="btn btn-link text-dark pagingbtn">
						      		&gt;&gt;
						      	</a>
						    </c:otherwise>
						</c:choose>
					</td>
				</tr>
			</table>
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
</body>
</html>