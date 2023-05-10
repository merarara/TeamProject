<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TJoeun Notebook</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<style>
/*최상단 최하단*/
.btns {
  display: flex;
  position: fixed;
  right: .4rem;
  bottom: .4rem;
}

.btns > div {
  padding: .6rem 1.5rem;
  background: #111;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  border-radius: 5px;
  transition: .2s;
  color: #fff;
  margin-right: .4rem;
}

.moveTopBtn:hover {
  color: #000;
  background: #febf00;
}
/* ------ */
/*
* {
  font-family: Pretendard;
  user-select: none;
}

.list > div {
  margin-bottom: 1rem;
  margin-left: .4rem;
  font-size: 1.4rem;
}
*/
/* 로딩 */
#waiting {
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    position: fixed;
    display: flex;
    align-items: center; /* 중앙 정렬 */
    justify-content: center; /* 가운데 정렬 */
    background: white;
    z-index: 999;
    opacity: 0.9;
}

#waiting > img {
    width: fit-content;
    height: fit-content;
    margin: auto;
}

#wrap {
	min-width: 1600px;
}

footer {
	min-width: 1600px;
}

/* 연관검색어 리스트 스타일 */
#displayList {
	border: solid 1px gray; 
	height: 100px; 
	overflow: auto; 
	margin-left: 90px; margin-top; 1px ;
	border-top: 0px;
	position: absolute;
	z-index: 1;
	background-color: #fff;
}
/* 연관색어 리스트 스타일 끝*/

.carousel-control-prev,
.carousel-control-next {
  	background-color: #e9ecef;
}

.carousel-indicators li {
  	background-color: #000; /* 버튼 배경색 */
  	border: none; /* 버튼 테두리 제거 */
  	width: 10px; /* 버튼 가로 크기 */
  	height: 10px; /* 버튼 세로 크기 */
  	margin: 0 5px; /* 버튼 간격 */
}

.carousel-indicators li.active {
  	background-color: gray; /* 활성화된 버튼 배경색 */
}

.carouselWrap {
	background-color: #f8f9fa; /* 배경색상 */
  	box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
  	border-radius: 10px; /* 모서리 둥글게 */
  	border: 1px solid #dee2e6; /* 테두리 스타일 */
  	padding: 1rem; /* 안쪽 여백 */
}
</style>
<script>
$(document).ready(function () {
	$("#displayList").hide();
	$('#searchword').on('keyup', function() {
		checkLength();
	});
});

document.addEventListener("DOMContentLoaded", () => {
	  const $topBtn = document.querySelector(".moveTopBtn");

	  // Top
	  $topBtn.addEventListener("click", () => {
	    window.scrollTo({ top: 0, behavior: "smooth" });
	  });

	  const $bottomBtn = document.querySelector(".moveBottomBtn");

	  // Bottom
	  $bottomBtn.addEventListener("click", () => {
	    window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" });
	  });
	});

//상품 검색 자동완성
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
</script>
</head>
<body>
<%@ include file="./header.jsp" %>	
<div class="container-fluid" id="content" style="min-width: 1600px;">
	<div class="container d-flex align-items-center justify-content-center" style=" border-bottom: 2px solid #ddd;">
		<div class="row">
			<div class="col-md-12">
				<h1 style="font-size: 48px; font-weight: bold; color: #2c3e50; margin-top: 20px; font-family: 'Roboto', sans-serif;">TJoeun NoteBook</h1>
			</div>
		</div>
	</div>
	<div class="row justify-content-center" style="padding-top: 30px; padding-bottom: 30px;">
		<!-- 검색창 -->
		<div class="col-md-4">
		    <form action="/product/productlist.do" id="searchFrm" name="searchFrm">
		    	<input type="hidden" name="type" value="search">
		      	<div class="input-group">
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
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h4 style="text-align: center;  border-bottom: 2px solid #ddd;">추천 상품</h4>
			</div>
		</div>
	</div>
	<div class="container d-flex align-items-center justify-content-center carouselWrap">
        <div class="row">
            <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                <ol class="carousel-indicators">
				  	<c:forEach items="${plist}" var="product" varStatus="status">
				    <li data-target="#carouselExampleIndicators" data-slide-to="${status.index}" class="${status.index == 0 ? 'active' : ''}"></li>
				  	</c:forEach>
				</ol>
                <div class="carousel-inner">
                    <c:forEach items="${plist}" var="p" varStatus="status">
					<div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                    	<div class="row align-items-center">
                    		<div class="col-md-6">
                    			<a href="/product/productinfo.do?p_num=${p.p_num }">
                    			<c:if test="${fn:contains(p.p_listimg, '/') }">
                    				<c:if test="${fn:contains(p.p_listimg, '130:130') }">
			                        <img src="${p.p_listimg.indexOf('130:130') != -1 ? p.p_listimg.replace('130:130', '800:400') : p.p_listimg }" 
			                        	class="d-block w-100" alt="...">
		                        	</c:if>
		                        	<c:if test="${not fn:contains(p.p_listimg, '130:130') }">
		                        	<img src="${p.p_listimg}" width="800px" height="400px" class="d-block w-100" alt="...">
		                        	</c:if>
		                        </c:if>
		                        <c:if test="${not fn:contains(p.p_listimg, '/') }">
		                        	<img src="../productuploads/${p.p_listimg }" width="800px" height="400px" class="d-block w-100" alt="...">
		                        </c:if>
		                        </a>
	                        </div>
	                        <div class="col-md-6">
	                            <h5>${p.p_name }</h5>
	                            <p>
	                            	<c:set var="ratingImgPath" value="" />
									<c:choose>
									    <c:when test="${p.p_rating == 0}">
									        <c:set var="ratingImgPath" value="/productimgs/0.png" />
									    </c:when>
									    <c:when test="${p.p_rating <= 0.99}">
									        <c:set var="ratingImgPath" value="/productimgs/0_5.png" />
									    </c:when>
									    <c:when test="${p.p_rating >= 1 && p.p_rating <= 1.49}">
									        <c:set var="ratingImgPath" value="/productimgs/1.png" />
									    </c:when>
									    <c:when test="${p.p_rating >= 1.5 && p.p_rating <= 1.99}">
									        <c:set var="ratingImgPath" value="/productimgs/1_5.png" />
									    </c:when>
									    <c:when test="${p.p_rating >= 2 && p.p_rating <= 2.49}">
									        <c:set var="ratingImgPath" value="/productimgs/2.png" />
									    </c:when>
									    <c:when test="${p.p_rating >= 2.5 && p.p_rating <= 2.99}">
									        <c:set var="ratingImgPath" value="/productimgs/2_5.png" />
									    </c:when>
									    <c:when test="${p.p_rating >= 3 && p.p_rating <= 3.49}">
									        <c:set var="ratingImgPath" value="/productimgs/3.png" />
									    </c:when>
									    <c:when test="${p.p_rating >= 3.5 && p.p_rating <= 3.99}">
									        <c:set var="ratingImgPath" value="/productimgs/3_5.png" />
									    </c:when>
									    <c:when test="${p.p_rating >= 4 && p.p_rating <= 4.49}">
									        <c:set var="ratingImgPath" value="/productimgs/4.png" />
									    </c:when>
									    <c:when test="${p.p_rating >= 4.5 && p.p_rating <= 4.99}">
									        <c:set var="ratingImgPath" value="/productimgs/4_5.png" />
									    </c:when>
									    <c:otherwise>
									        <c:set var="ratingImgPath" value="/productimgs/5.png" />
									    </c:otherwise>
									</c:choose>
									<img src="${ratingImgPath}" alt="별점" style="width: 80px; height: 18px;"/>
	                            </p>
	                        </div>
                        </div>
                    </div>
					</c:forEach>
                </div>
                <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div>
    </div>
	<div class="container mt-3" style="margin-bottom: 20px;">
	  	<div class="row justify-content-center">
	    	<div class="col-lg-6">
	      		<div class="card">
	        		<div class="card-body">
	          			<h4 class="card-title text-center">공지사항</h4>
	          			<ul class="list-group list-group-flush">
	            		<c:forEach items="${nlist}" var="n">
	              			<li class="list-group-item py-2">
	                			<a href="/aboard/aboardview.do?a_num=${n.a_num}">${n.a_title}</a>
	                			<small class="text-muted float-right">${n.a_regdate}</small>
	              			</li>
	            		</c:forEach>
	          			</ul>
	        		</div>
	      		</div>
	    	</div>
	    	<div class="col-lg-6">
	    		<div class="card">
	        		<div class="card-body">
	          			<h4 class="card-title text-center">커뮤니티</h4>
	          			<ul class="list-group list-group-flush">
	            		<c:forEach items="${clist}" var="c">
	              			<li class="list-group-item py-2">
	                			<a href="/aboard/aboardview.do?a_num=${c.c_num}">${c.c_title}</a>
	                			<small class="text-muted float-right">${c.c_regdate}</small>
	              			</li>
	            		</c:forEach>
	          			</ul>
	        		</div>
	      		</div>
	    	</div>
	  	</div>
	</div>
	<div class="btns">
	  	<div class="moveTopBtn">위로가기</div>
	  	<div class="moveBottomBtn">아래로가기</div>
	</div>
</div>
<%@ include file="./footer.jsp" %>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
