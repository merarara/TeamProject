<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매가이드 페이지</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
<script>
//상품 검색 자동완성 시작 //
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
</script>
<style>
.rounded-box {
	border: 1px solid #ccc;
	border-radius: 10px;
	padding: 5px;
	font-size: 14px;
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

#wrap {
	min-width: 1600px;
}

footer {
	min-width: 1600px;
}
</style>
</head>
<body>
<%@ include file="../../header.jsp" %>
<div id="content">
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
		<div class="col-md-8" style="border: 1px solid #ccc;">
	  		<div class="d-flex align-items-center justify-content-center">
		  		<div class="col-md-12">
			      	<br>
			      	<h2>한눈에 보는 노트북 CPU넘버링 가이드</h2>
			      	<p style="font-size: 3px;">2023.04.05. 08:48:11</p>
			      	<hr>
			      	<span class="rounded-box" style="font-size: 13px;">관련상품</span>
			      	삼성전자 갤럭시북2 NT550XEZ-A58A 16GB램 (SSD 256GB) 가격 690,990원<br>
			      	<br><br>
			      	
			      	<div style="text-align: center;">
				      	<p>
				      		<span style="font-weight: bold; font-size: 18pt; background-color: rgb(56, 118, 29); color: #ffffff;">
				      			신규 출시 노트북 CPU 넘버링 가이드
				      		</span>
				      	</p> 
						<br>
						<h4>인텔 13세대</h4>
						<br>
						인텔은 보통 세대와 CPU 설계구조가 연계되나,
						<br><br>
						
						<span style="color: rgb(102, 102, 102);">
							(예)
						</span>
						<br>
					
						<span style="color: rgb(102, 102, 102);">
							12세대 엘더레이크
						</span>
						<br>
					
						<span style="color: rgb(102, 102, 102);">
							13세대 랩터레이크
						</span>
						<br>
						<br>
						
						<br>
						캐시구조나 크기, 코어 변경에 따라,
						
						<br>
						변경 R(리프레시) 버전이 나오기도 했습니다.
						
						<br><br>
						13세대의 경우 HX 라인업이 추가 되었네요.
						
						<br><br>
						<b>CPU 세대 표기만 봐도 어느 정도 출시 년도 확인이 가능합니다.</b>
				      	
				      	<br><br><br>
				      	<img src="/productimgs/buyguide/guide1_1.png">
				      	
				      	<br><br><br>
				      	<h4>AMD 2023년 출시 제품</h4>
				      	<br>
						
						<br>
						AMD는 2023년부터
						
						<br>
						출시년도와 설계구조를 분리하여 표기 했습니다.
						
						<br><br>
						Zen4   : 라파엘  
						
						<br>
						Zen3+ : 램브란트 (6XXX로 불림) 2022년 2월
						
						<br>
						Zen3   : 세잔       (5XXX로 불림) 2021년 1월
						
						<br>
						Zen2   : 르누아르 (5XXX로 불림) 2020년 4월
						
						<br><br><br>
						<b>따라서 새로나온 AMD 7시리즈는</b> 
							
						<br>
						<b>앞자리 '7'은 단순히 출시 년도일 뿐입니다.</b>
						
						<br>
						<b>기존 설계구조(인텔로 치면 세대)는</b>
						
						<br>
						<b>3번째 번호로 확인이 가능합니다.</b>
								      	
						<br><br>
						<img src="/productimgs/buyguide/guide1_2.png">
						
						<br><br>
						
						<a href="/product/productlist.do">돌아가기</a>
						<br><br>
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
<%@ include file="../../footer.jsp" %>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>