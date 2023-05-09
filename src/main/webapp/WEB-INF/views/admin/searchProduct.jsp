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
.list {
  list-style: none;
  margin: 0;
  padding: 0;
}

.list-item {
  border: 1px solid #ccc;
  border-radius: 5px;
  padding: 10px;
  margin-bottom: 10px;
}

.list-item h3 {
  margin-top: 0;
  font-size: 20px;
  cursor: pointer;
}

.list-item p {
  margin: 0;
}

.barcodes {
  display: none;
}

.barcodes ul {
  margin: 0;
  padding: 0;
}

.barcodes li {
  list-style-type: none;
}
</style>
<script>
function showBarcodes(elem) {
	  var barcodes = elem.nextElementSibling;
	  if (barcodes.style.display === "none" || barcodes.style.display === "") {
	    barcodes.style.display = "block";
	  } else {
	    barcodes.style.display = "none";
	  }
}

function doDeleteCnt(barcode, p_num) {
	if (confirm("정말 제거하시겠습니까?")) {
		$.ajax({
			type: 'POST',
			url: '/admin/deleteCount.do',
			data: {
				barcode: barcode,
				p_num: p_num
			},
			success: function (data) {
				if (data.status == "success") {
					alert(barcode + " 상품이 제거 되었습니다.");

					 // 삭제 대상 요소 찾기
                    var targetElem = $('td:contains(' + barcode + ')').closest('tr');

                    // 해당 요소 삭제
                    targetElem.remove();
                    
                 	// 재고 수량 업데이트
					var countElem = document.getElementById("count_" + p_num);
					countElem.innerHTML = parseInt(countElem.innerHTML) - 1;
				} else {
					alert("삭제하는도중 오류가 발생하였습니다.");
				}
			}
		});	
	}
}

function doAddCnt(p_num) {
	var barcode = $('#barcode_' + p_num).val();
	var barcodes = $('.barcodes_' + p_num);
	var barChk = 'No'; 
	
	// 중복 체크
	barcodes.each(function () {
		if (barcode == $(this).text()) {
			alert('이미 등록된 바코드번호입니다.');
			barChk = 'Yes';
		}
	})
	
	if (barChk == 'No') {
		if (confirm('(' + barcode + ') 해당 바코드번호를 ' + p_num + '번 상품에 추가하시겠습니까?')) {
			$.ajax({
				type: 'POST',
				url: '/admin/addBarcode.do',
				data: {
					p_num: p_num,
					barcode: barcode
				},
				success: function (data) {
					if (data.status === "success") {
						alert("추가되었습니다.");
						var newTd = '<tr><td>' +
				             '<span class="barcodes_' + p_num + '">' + barcode + '</span>' +
				             '<span class="float-right">' +
				             '<button class="btn btn-outline-danger" onclick="doDeleteCnt(\'' + barcode + '\', \'' + p_num + '\');">삭제</button>' +
				             '</span>' +
				             '</td></tr>';
			    		$('table tbody').append(newTd);
			    		
			    		// 재고 수량 업데이트
						var countElem = document.getElementById("count_" + p_num);
						countElem.innerHTML = parseInt(countElem.innerHTML) + 1;
					} else {
						alert('추가에 실패하였습니다.');
					}
				}
			});
		}
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
	<div class="col-md-4 offset-md-4" style="margin-top: 10px; margin-bottom: 10px;">
		<form action="/admin/searchProduct.do" id="searchFrm" name="searchFrm">
	      	<div class="input-group">
	      		<a href="#" onclick="goToAdminPage();" class="btn btn-outline-primary float-left">돌아가기</a>
	      		&nbsp;&nbsp;
	        	<select class="form-select" name="searchfield" id="searchfield">
	          		<option value="p_name">상품명</option>
	          		<option value="p_num">상품번호</option>
	        	</select>
	        	&nbsp;&nbsp;
	        	<input type="search" class="form-control" name="searchword" id="searchword" placeholder="검색어를 입력하세요">
	        	&nbsp;&nbsp;
	        	<button class="btn btn-secondary" type="submit">검색</button>
	      	</div>
	    </form>
	</div>
	<dl class="list" style="width: 70%; margin: 0 auto;">
	  	<c:forEach items="${plist}" var="i">
	    	<dd class="list-item">
	      		<h3 onclick="showBarcodes(this)" style="color: #0067A3;">상품명: ${i.p_name}</h3>
	      		<div class="barcodes">
	      			재고: <span id="count_${i.p_num}">${i.p_count}</span>
	      			<br>
					  <label for="barcode" style="font-size: 11px; color: #ccc">※ 등록하실 바코드 번호를 입력해주세요</label><br>
					  <input type="text" class="form-control" id="barcode_${i.p_num }" placeholder="바코드 번호를 입력해주세요" style="width: 250px; display: inline-block;">
					  <button type="button" class="btn btn-outline-primary" onclick="doAddCnt('${i.p_num}')">등록</button>
			  		<table class="table" style="margin-top: 10px; margin-bottom: 10px;">
			    		<thead>
			      			<tr>
			        			<th>코드번호</th>
			      			</tr>
			    		</thead>
			    		<tbody>
			      		<c:forEach items="${pcnt}" var="j">
			        		<c:if test="${i.p_num == j.p_num}">
			          		<tr>
			            		<td>
			            			<span class="barcodes_${i.p_num }">${j.p_barcode}</span>
			            			<span class="float-right">
			            				<button class="btn btn-outline-danger" onclick="doDeleteCnt('${j.p_barcode }', '${i.p_num }');">삭제</button>
			            			</span>
			            		</td>
			          		</tr>
			        		</c:if>
			      		</c:forEach>
			    		</tbody>
			  		</table>
				</div>
	      		<h6 style="color: #800010;">상품번호: ${i.p_num}</h6>
	    	</dd>
	  	</c:forEach>
	</dl>
	<table style="margin: 0 auto;">
		<tr>
			<td colspan="5" style="text-align: center;">
			  	<!-- 처음 -->
			  	<c:choose>
			    	<c:when test="${(page.curPage - 1) < 1 }">
			      		<button class="btn btn-link text-dark" disabled>&lt;&lt;</button>
			    	</c:when>
				    <c:otherwise>
				      	<a href="/admin/searchProduct.do?page=1&searchword=${ searchword }&searchfield=${ searchfield }" 
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
				      	<a href="/admin/searchProduct.do?page=${page.curPage - 1}&searchword=${ searchword }&searchfield=${ searchfield }" 
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
				        	<a href="/admin/searchProduct.do?page=${fEach}&searchword=${ searchword }&searchfield=${ searchfield }" 
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
				      	<a href="/admin/searchProduct.do?page=${page.curPage + 1}&searchword=${ searchword }&searchfield=${ searchfield }" 
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
				      	<a href="/admin/searchProduct.do?page=${page.totalPage}&searchword=${ searchword }&searchfield=${ searchfield }" 
				      		class="btn btn-link text-dark pagingbtn">
				      		&gt;&gt;
				      	</a>
				    </c:otherwise>
				</c:choose>
			</td>
		</tr>
	</table>
</div>
<%@ include file="../footer.jsp" %>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>