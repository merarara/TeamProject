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
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
<script>
$(document).ready(function() {
    $('img').on('mouseenter', function() {
        var imgSrc = $(this).attr('src');
        $('#showimg').css('background-image', 'url(' + imgSrc + ')');
    });
});
</script>
<style>
#contentwrap {
	width: 100%;
   	border-collapse: collapse;
    margin-left: auto;
   	margin-right: auto;
}

.items {
	width: 970;
	height: 80;
	font-size: 10pt;
	color: #868e96;
}

#showimg {
    width: 330px;
    height: 330px;
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center;
}

.imgcon {
    justify-content: center;
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
						<b>운영체제</b>: ${ pinfo.os } / <b>화면정보</b>: ${ pinfo.monitor } / <b>CPU</b>: ${ pinfo.cpu } / <b>램</b>: ${ pinfo.r_storage } / <b>램 교체</b>: ${ pinfo.ram }<br>
						<b>그래픽</b>: ${ pinfo.graphic } / <b>저장장치</b>: ${ pinfo.storage } / <b>네트워크</b>: ${ pinfo.network } / <b>영상입출력</b>: ${ pinfo.video_io } / <b>단자</b>: ${ pinfo.terminal } / <b>부가기능</b>: ${ pinfo.add_ons }<br>
						<b>입력장치</b>: ${ pinfo.io } / <b>파워</b>: ${ pinfo.power }  
						<c:if test="${ not empty pinfo.hz }" >
							/ <b>주사율</b>: ${ pinfo.hz }
						</c:if>
						<c:if test="${ not empty pinfo.etc }" >
							/ <b>주요제원</b>: ${ pinfo.etc }
						</c:if>
						<br>
						
						<hr style="border: 1px solid #000;">
						
						<br>
						<div class="container">
							<div class="row">
								<div class="col-md-6 imgcon">
									<div id="showimg"></div>
									<c:forEach items="${ pinfo.p_imgsrcs }" var="imgsrc">
										<tr>
											<td><img src="${ imgsrc }" width="50" height="50"></td>
										</tr>
									</c:forEach>
								</div>
								<div class="col-md-6">
									ddd
								</div>
							</div>
						</div>
					</div>
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