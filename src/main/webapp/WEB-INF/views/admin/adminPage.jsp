<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<!-- CSS  -->
<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" href="/css/main.css">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
<style>
/* */
#detail-info {
    display: none;
}

.form-group label {
  	font-weight: bold;
  	display: inline-block;
  	margin-bottom: 0.5rem;
}

.form-group input[type="text"] {
  	display: inline-block;
  	width: 45%;
  	margin-right: 1%;
}

.form-group input[type="file"] {
  	display: block;
  	margin-top: 0.5rem;
}

#detail-info button[type="button"] {
  	margin-bottom: 1rem;
}

#detail-info input[type="submit"] {
  	margin-top: 1rem;
}
</style>
<script>
$(document).ready(function() {
	var checkValue = "${param.check}";
  	if (checkValue == 'yes') {
    	alert("상품이 추가되었습니다.");
  	}
	
	$('#productManageLink').on('click', function() {
	    $('#myModal').modal('show');
	});
	
	var detailButton = $("#detail-btn");
    var detailInfo = $("#detail-info");

    detailButton.click(function() {
        detailInfo.slideToggle();
    });
	
    // '이미지 업로드' 라디오 버튼이 선택될 경우
    $('input[name="image-option"][value="upload"]').on('click', function() {
      	$('input[name="listimg"]').prop('disabled', false).show();
      	$('input[name="p_listimg"]').prop('disabled', true).hide();
    });

    // '이미지 링크' 라디오 버튼이 선택될 경우
    $('input[name="image-option"][value="link"]').on('click', function() {
      	$('input[name="listimg"]').prop('disabled', true).hide();
      	$('input[name="p_listimg"]').prop('disabled', false).show();
    });

    // 페이지 로딩 시 '이미지 업로드' 라디오 버튼이 선택된 상태로 설정
    $('input[name="image-option"][value="upload"]').click();
    
    // '이미지 업로드' 라디오 버튼이 선택될 경우
    $('input[name="infoimage-option"][value="upload"]').on('click', function() {
      	$('input[name="imgsrcs"]').prop('disabled', false).show();
      	$('input[name^="link_imgsrcs"]').prop('disabled', true).hide();
      	$('#imglinkType').hide();
    });

    // '이미지 링크' 라디오 버튼이 선택될 경우
    $('input[name="infoimage-option"][value="link"]').on('click', function() {
      	$('input[name="imgsrcs"]').prop('disabled', true).hide();
      	$('input[name^="link_imgsrcs"]').prop('disabled', false).show();
      	$('#imglinkType').show();
    });

    // 페이지 로딩 시 '이미지 업로드' 라디오 버튼이 선택된 상태로 설정
    $('input[name="infoimage-option"][value="upload"]').click();
    
    // 파일 갯수 체크
    const input = document.getElementById('imgsrcs');
    input.addEventListener('change', () => {
      	if (input.files.length > 4) {
        	// 파일 선택 취소
        	input.value = '';
        	// 경고창 띄우기
        	alert('최대 4개까지만 선택할 수 있습니다.');
      	}
    });
    
    // 파일 확장자 체크
    const filechk1 = document.getElementById('imgsrcs');
    filechk1.addEventListener('change', function(event) {
      	const file = event.target.files[0];
      	const extension = file.name.split('.').pop().toLowerCase();
      	if (!['jpg', 'png', 'gif'].includes(extension)) {
        	alert('JPG, PNG, GIF 파일만 업로드 가능합니다.');
        	filechk1.value = '';
      	}
    });
    
    const filechk2 = document.getElementById('listimg');
    filechk2.addEventListener('change', function(event) {
      	const file = event.target.files[0];
      	const extension = file.name.split('.').pop().toLowerCase();
      	if (!['jpg', 'png', 'gif'].includes(extension)) {
        	alert('JPG, PNG, GIF 파일만 업로드 가능합니다.');
        	filechk2.value = '';
      	}
    });
    
    // 상품 상세 이미지 입력란 추가 / 제거
    const addBtn = document.querySelector('#addBtn');
    const imgsrcsContainer = document.querySelector('#imgsrcsContainer');
    const maxCount = 4; // 최대 추가 가능한 개수

    let count = 0; // 현재 추가된 개수

    addBtn.addEventListener('click', () => {
      	if (count >= maxCount) {
        	return;
      	}

      	const input = document.createElement('input');
      	input.type = 'text';
      	input.className = 'form-control mt-2';
      	input.placeholder = '상품 상세 이미지';
      	input.name = `link_imgsrcs`;
      	input.accept = '.jpg,.png,.gif';

      	const removeBtn = document.createElement('button');
      	removeBtn.className = 'btn btn-danger btn-sm ml-2';
      	removeBtn.textContent = '제거';

      	removeBtn.addEventListener('click', () => {
        	imgsrcsContainer.removeChild(div);
        	count--;
      	});

      	const div = document.createElement('div');
      	div.className = 'd-flex align-items-center';

      	div.appendChild(input);
      	div.appendChild(removeBtn);

      	imgsrcsContainer.appendChild(div);
      	count++;
    });
});
</script>
</head>
<body>
<%@ include file="../header.jsp" %>	
<div id="content">
	<div style="border: 1px solid #ccc; padding: 20px;">
	 	<h1 style="text-align:center;">관리자 안내</h1>
	 	<ul style="text-align:center;">
	   		<li>회원관리 : 차단시킬 회원이나 차단을 해제할 회원 관리</li>
	   		<li>판매관리 : 회원이 결제한 상품 관리</li>
	   		<li>재고관리 : 매장에 신규 상품이 들어올 시 최신화 </li>
	   		<li>상품관리 : 신규 상품 추가</li>
	 	</ul>
	</div>
	<div class="dropdown" style="text-align:center; margin-top: 20px;">
	 	<h2>관리자메뉴</h2>
		<div id="content">
			<Ul class="user-list">
				<li>
					<p>
						회원관리
					</p>
					<img src="/admin/userMng.png" >
		   		<a href="/admin/userManagement.do" class="login-link">회원관리</a>
				</li>
				<li>
					<p>
						판매관리
					</p>
					<img src="/admin/salesMng.png">
					<a href="/admin/sellManage.do" class="login-link">판매관리</a>
				</li>
				<li>
					<p>
						재고관리
					</p>
					<img src="/admin/inventoryMng.png">
					<a href="/admin/searchProduct.do" class="login-link">재고관리</a>
				</li>
				<li>
					<p>
						상품관리 <br>
					</p>
					<img src="/admin/product2.png">
					<a href="#" class="login-link" id="productManageLink">상품관리</a>
				</li>
			</Ul>
			<!-- 모달 -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
			  	<div class="modal-dialog modal-lg" role="document">
			    	<div class="modal-content">
			      		<div class="modal-header">
			        		<h4 class="modal-title" id="myModalLabel">상품관리</h4>
			        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          			<span aria-hidden="true">&times;</span>
			        		</button>
			      		</div>
			      		<div class="modal-body">
			        		<div class="text-center">
								<h1>상품 등록</h1>
							</div>
							<div class="container d-flex justify-content-center align-items-center" style="max-width: 800px;">
								<form action="/admin/doAddProduct.do" method="post" enctype="multipart/form-data" style="width: 580px;">
									<div class="form-group">
										<label for="p_name">상품명</label>
										<input type="text" class="form-control" id="p_name" name="p_name" placeholder="상품명" required>
									</div>
									<div class="form-group">
										<label for="p_price">가격</label>
										<input type="number" class="form-control" id="p_price" name="p_price" placeholder="가격" required>
									</div>
									
									<div id="image-options">
										<label><input type="radio" name="image-option" value="upload" accept=".jpg,.png,.gif" checked>이미지 업로드</label>
										&nbsp;&nbsp;&nbsp;
										<label><input type="radio" name="image-option" value="link">이미지 링크</label>
									</div>
									
									<div class="form-group" style="border: 1px solid #ccc;">
										<label for="listimg">상품 대표이미지</label>
										<input type="file" class="form-control-file" id="listimg" name="listimg" placeholder="상품 대표이미지" accept=".jpg,.png,.gif" required><br>
										<input type="text" class="form-control" id="p_listimg" name="p_listimg" placeholder="상품 대표이미지" required>
										<small class="form-text text-muted">※ 1개만 등록 가능합니다.</small>
									</div>
									
									<div class="form-group">
										<label for="p_company">제조사</label>
										<input type="text" class="form-control" id="p_company" name="p_company" placeholder="제조사" required>
									</div>
									
									<div class="form-group">
										<button type="button" id="detail-btn" class="btn btn-primary" data-toggle="collapse" data-target="#detail-info">상세 정보 입력</button>
									</div>
									
									<!-- 이 부분부터 상세 정보 -->
									<div class="collapse" id="detail-info">
										<div class="row">
											<div class="form-group col-md-6">
												<label for="os">운영체제</label>
												<input type="text" class="form-control" id="os" name="os" placeholder="운영체제">
											</div>
											<div class="form-group col-md-6">
												<label for="monitor">화면정보</label>
												<input type="text" class="form-control" id="monitor" name="monitor" placeholder="화면정보">
											</div>
										</div>
										<div class="row">
											<div class="form-group col-md-6">
												<label for="cpu">CPU</label>
												<input type="text" class="form-control" id="cpu" name="cpu" placeholder="CPU">
											</div>
											<div class="form-group col-md-6">
												<label for="ram">램 교체</label>
												<input type="text" class="form-control" id="ram" name="ram" placeholder="램 교체">
											</div>
										</div>
										<div class="row">
											<div class="form-group col-md-6">
												<label for="r_storage">램 용량</label>
												<input type="text" class="form-control" id="r_storage" name="r_storage" placeholder="램 용량">
											</div>
										
											<div class="form-group col-md-6">
												<label for="graphic">그래픽</label>
												<input type="text" class="form-control" id="graphic" name="graphic" placeholder="그래픽">
											</div>
										</div>
										<div class="row">
											<div class="form-group col-md-6">
												<label for="storage">저장장치</label>
												<input type="text" class="form-control" id="storage" name="storage" placeholder="저장장치">
											</div>
											<div class="form-group col-md-6">
												<label for="network">네트워크</label>
												<input type="text" class="form-control" id="network" name="network" placeholder="네트워크">
											</div>
										</div>
										<div class="row">
											<div class="form-group col-md-6">
												<label for="video_io">영상입출력</label>
												<input type="text" class="form-control" id="video_io" name="video_io" placeholder="영상입출력">
											</div>
											<div class="form-group col-md-6">
												<label for="terminal">단자</label>
												<input type="text" class="form-control" id="terminal" name="terminal" placeholder="단자">
											</div>
										</div>
										<div class="row">
											<div class="form-group col-md-6">
												<label for="add_ons">부가기능</label>
												<input type="text" class="form-control" id="add_ons" name="add_ons" placeholder="부가기능">
											</div>
											<div class="form-group col-md-6">
												<label for="io">입력장치</label>
												<input type="text" class="form-control" id="io" name="io" placeholder="입력장치">
											</div>
										</div>
										<div class="row">
											<div class="form-group col-md-6">
												<label for="power">파워</label>
												<input type="text" class="form-control" id="power" name="power" placeholder="파워">
											</div>
											<div class="form-group col-md-6">
												<label for="hz">주사율</label>
												<input type="text" class="form-control" id="hz" name="hz" placeholder="주사율">
											</div>
										</div>
										<div class="row">
											<div class="form-group col-md-6">
												<label for="etc">기타</label>
												<input type="text" class="form-control" id="etc" name="etc" placeholder="기타">
											</div>
										</div>
										<div id="infoimage-options">
											<label><input type="radio" name="infoimage-option" value="upload" checked>이미지 업로드</label>
											&nbsp;&nbsp;&nbsp;
											<label><input type="radio" name="infoimage-option" value="link">이미지 링크</label>
										</div>
										
										<div class="form-group" style="border: 1px solid #ccc;">
											<label for="imgsrcs">상품 상세 이미지</label>
											<input type="file" class="form-control-file" id="imgsrcs" name="imgsrcs" placeholder="상품 상세 이미지" accept=".jpg,.png,.gif" multiple><br>
											<div id="imglinkType">
												<button type="button" class="btn btn-outline-primary" id="addBtn">입력란 추가</button>
												<div id="imgsrcsContainer" class="align-items-center">
												</div>
											</div>
											<small class="form-text text-muted">※ 최대 4개까지 등록 가능합니다.</small>
										</div>
										<div class="text-center">
											<button type="submit" class="btn btn-primary mt-3">상품 추가</button>
										</div>
									</div>
								</form>
							</div>
			      		</div>
			      		<div class="modal-footer">
			        		<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			      		</div>
			    	</div>
			  	</div>
			</div>
		</div>
	</div>ㄴ
</div>
<%@ include file="../footer.jsp" %>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
