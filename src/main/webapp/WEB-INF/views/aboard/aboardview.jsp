<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s" %>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function likeBtnHandler(event) {
    event.preventDefault();
    var a_num = $(this).data("a-num");
    $.ajax({
        url: "/aboard/like.do",
        type: "post",
        data: { a_num: a_num },
        dataType: "json",
        success: function(data) {
            // 좋아요 수 업데이트
            $("#like-count").text(data.like_count);
            // 버튼 라벨 변경
            $("#like-btn").text("좋아요 취소");
            // 좋아요 버튼 이벤트 리스너 해제
            $("#like-btn").off("click");
            // 좋아요 취소 버튼 이벤트 리스너 등록
            $("#unlike-btn").click(unlikeBtnHandler);
            alert("좋아요가 성공적으로 처리되었습니다.");
        },
        error: function() {
            alert("서버 오류가 발생하였습니다.");
        }
    });
}

function unlikeBtnHandler(event) {
    event.preventDefault();
    var a_num = $(this).data("a-num");
    $.ajax({
        url: "/aboard/unlike.do",
        type: "post",
        data: { a_num: a_num },
        dataType: "json",
        success: function(data) {
            // 좋아요 수 업데이트
            $("#like-count").text(data.like_count);
            // 버튼 라벨 변경
            $("#unlike-btn").text("좋아요");
            // 좋아요 취소 버튼 이벤트 리스너 해제
            $("#unlike-btn").off("click");
            // 좋아요 버튼 이벤트 리스너 등록
            $("#like-btn").click(likeBtnHandler);
            alert("좋아요 취소가 성공적으로 처리되었습니다.");
        },
        error: function() {
            alert("서버 오류가 발생하였습니다.");
        }
    });
}

//좋아요 버튼 또는 좋아요 취소 버튼 클릭 시 호출될 함수
function likeUnlikeBtnHandler(event) {
    var liked = $(this).data("liked");
    if (liked) {
        unlikeBtnHandler.call(this, event);
    } else {
        likeBtnHandler.call(this, event);
    }
}

$('#like-btn').on('click', function() {
	  var aNum = $(this).data('a-num');
	  $.ajax({
	    url: '/like',
	    type: 'POST',
	    data: {aNum: aNum},
	    success: function() {
	      $('#like-btn').hide();
	      $('#unlike-btn').show();
	    },
	    error: function() {
	      alert('좋아요 처리에 실패했습니다.');
	    }
	  });
	});

//좋아요 취소 버튼 클릭 시 이벤트 핸들러 등록
$("#unlike-btn").click(function(event) {
    event.preventDefault();
    var a_num = $(this).data("a-num");
    $.ajax({
        url: "/aboard/unlike.do",
        type: "post",
        data: { a_num: a_num },
        dataType: "json",
        success: function(data) {
            // 좋아요 수 업데이트
            $("#like-count").text(data.like_count);
            // 버튼 라벨 변경
            $("#unlike-btn").text("좋아요");
            // 좋아요 취소 버튼 이벤트 리스너 해제
            $("#unlike-btn").off("click");
            // 좋아요 버튼 이벤트 리스너 등록
            $("#like-btn").click(likeBtnHandler);
            alert("좋아요 취소가 성공적으로 처리되었습니다.");
        },
        error: function() {
            alert("서버 오류가 발생하였습니다.");
        }
    });
});

//좋아요 버튼 또는 좋아요 취소 버튼 클릭 시 호출될 함수
function likeUnlikeBtnHandler(event) {
	var liked = $(this).data("liked");
	if (liked) {
		unlikeBtnHandler.call(this, event);
	} else {
		likeBtnHandler.call(this, event);
	}
}

// 좋아요 버튼 또는 좋아요 취소 버튼 클릭 이벤트 등록
$(document).on("click", "#like-btn", likeUnlikeBtnHandler);
$(document).on("click", "#unlike-btn", likeUnlikeBtnHandler);

// 좋아요 버튼 클릭 이벤트 핸들러
function likeBtnHandler(event) {
	event.preventDefault();
	var a_num = $(this).data("a-num");
	$.ajax({
	url: "/aboard/like.do",
	type: "post",
	data: { a_num: a_num },
	dataType: "json",
	success: function(data) {
		// 좋아요 수 업데이트
		$("#like-count").text(data.like_count);
		// 버튼 라벨 변경
		$("#like-btn").text("좋아요 취소");
		// 좋아요 상태 값 변경
		$("#like-btn").data("liked", true);
		alert("좋아요가 성공적으로 처리되었습니다.");
	},
	error: function() {
		alert("서버 오류가 발생하였습니다.");
	}
});
}

// 좋아요 취소 버튼 클릭 이벤트 핸들러
function unlikeBtnHandler(event) {
	event.preventDefault();
	var a_num = $(this).data("a-num");
	$.ajax({
		url: "/aboard/unlike.do",
		type: "post",
		data: { a_num: a_num },
		dataType: "json",
		success: function(data) {
			// 좋아요 수 업데이트
			$("#like-count").text(data.like_count-1);	
			// 버튼 라벨 변경
			$("#like-btn").text("좋아요");
			// 좋아요 상태 값 변경
			$("#like-btn").data("liked", false);
			alert("좋아요 취소가 성공적으로 처리되었습니다.");
		},
		error: function() {
			alert("서버 오류가 발생하였습니다.");
		}
	});
}

function validateForm() {
    var ac_comment = document.getElementById("comment-input").value;

    if (!ac_comment) {
      alert("댓글을 입력해주세요.");
      return false;
    }
    
    return true;
  }

</script>
</head>
<body>

<%@ include file="../header.jsp" %>	
<div id="content">
<div class="container">
    <div class="row justify-content-center" style="margin-top: 30px;">
        <div class="col-md-10">
            <div class="card">
                <div class="card-header">
                    <strong>게시글 정보</strong>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <strong>번호:</strong>
                        </div>
                        <div class="col-md-3">
                            ${ aboardDto.a_num }
                        </div>
                       	<div class="col-md-3">
                            <strong>작성일:</strong>
                        </div>
                        <div class="col-md-3">
                            ${ aboardDto.a_regdate }
                        </div>
                    	</div>
                   		<div class="row">
                   		 <div class="col-md-3">
                            <strong>작성자:</strong>
                        </div>
                        <div class="col-md-3">
                            ${ aboardDto.u_nick }
                        </div>
                        <div class="col-md-3">
                            <strong>조회수:</strong>
                        </div>
                        <div class="col-md-3">
                            ${ aboardDto.a_visitcount }
                        </div>
                    </div>
                    <div class="row">
                     	<div class="col-md-3">
                            <strong>제목:</strong>
                        </div>
                        <div class="col-md-3">
                            ${ aboardDto.a_title }
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <strong>내용:</strong>
                        </div>
                        <div class="col-md-9">
                            ${ aboardDto.a_content }<br>
                            <c:forEach items="${file}" var="f">
                                <c:forEach items="${aupDto }" var="i">
                                    <c:if test="${i.sfile == f}">
                                        <a href="../aUpload/${f}" data-lightbox="image">
                                            <img src="../aUpload/${f}" width="100px" height="100px">
                                        </a>
                                    </c:if>
                                </c:forEach> 
                            </c:forEach>
                        </div>
                        <div class="col-md-3">
                            <strong>좋아요:</strong>
                        </div>
                           	<!-- 좋아요 수 -->
						<div id="like-count">
							${aboardDto.a_like}
						</div>
                      	<%--  <div class="col-md-3">
                            ${ aboardDto.a_like }
                        </div> --%>
                    </div>
                </div>
            </div>
			 <div class="card mt-3">
			 	<div class="card-body">
			 	<s:authorize access="hasRole('ADMIN')">
			    	<button type="button" class="btn btn-primary mr-2" 
			        	onclick="location.href='../aboard/aboardedit.do?a_num=${aboardDto.a_num}';">
			        	수정하기
			        </button>
			      	<button type="button" class="btn btn-danger mr-2" 
			        	onclick="location.href='../aboard/aboarddelete.do?a_num=${aboardDto.a_num}';">
			        	삭제하기
			      	</button>
				</s:authorize>
			    	<button type="button" class="btn btn-secondary mr-2" onclick="location.href='../aboard/aboardlist.do';">
			      		목록 바로가기
			    	</button>
			    <s:authorize access="hasRole('USER')">
				<div class="btn-group">
				    <!-- 좋아요 버튼 -->
				    <button id="like-btn" class="btn btn-primary" data-a-num="${aboardDto.a_num}">좋아요</button>
				    <!-- 좋아요 취소 버튼 -->
				    <button id="unlike-btn" class="btn btn-primary" data-a-num="${aboardDto.a_num}" style="display: none;">좋아요 취소</button>
				</div>
				</s:authorize>
				</div>
			</div>
        </div>
	</div>
</div>
	<div class="container">
	    <div class="row justify-content-center">
	        <div class="col-md-10">
					<div class="card mt-3">
					 	<div class="card-body">
						    <table class="table">
						      <tbody>
						        <c:forEach var="acDto" items="${acList}">
						          <tr>
						            <td class="align-middle">${acDto.u_nick}</td>
						            <td class="align-middle">${acDto.ac_comment}</td>
						            <c:if test="${acDto.u_id != udto.u_id}">
						              <s:authorize access="hasRole('USER')">
						                <td class="align-middle">
							            	<form action="/aboard/acomment/aclike.do?a_num=${acDto.a_num}" method="post">
							                	<input type="hidden" name="ac_num" value="${acDto.ac_num}">
							                	<button type="submit" class="btn btn-sm btn-outline-primary">
							                    	<i class="far fa-thumbs-up"></i> 좋아요
							                    </button>
							           		</form>
						                </td>
						                <td class="align-middle">
						                  <form action="/aboard/acomment/acunlike.do?a_num=${acDto.a_num}" method="post">
						                    <input type="hidden" name="ac_num" value="${acDto.ac_num}">
						                    <button type="submit" class="btn btn-sm btn-outline-secondary">
						                      <i class="far fa-thumbs-down"></i> 좋아요 취소
						                    </button>
						                  </form>
						                </td>
						              </s:authorize>
						            </c:if>
						            <c:if test="${acDto.u_id == udto.u_id}">
						              <td class="align-middle">
						                <form action="/aboard/acomment/deleteac.do?a_num=${acDto.a_num}" method="post">
						                  <input type="submit" class="btn btn-sm btn-outline-danger" value="삭제">
						                  <input type="hidden" name="ac_num" value="${acDto.ac_num}">
						                </form>
						              </td>
						            </c:if>
						            <td class="align-middle">
						              <span class="badge badge-secondary">좋아요 ${ acDto.ac_like }</span>
						            </td>
						          </tr>
						        </c:forEach>
						      </tbody>
						    </table>
						  <s:authorize access="hasAnyRole('USER', 'ADMIN')">
							  <form action="/aboard/acomment/insertac.do" method="post" class="mt-3" onsubmit="return validateForm()">
							    <input type="hidden" name="a_num" value="${aboardDto.a_num}">
							    <div class="form-group">
							      <label for="comment-input">댓글 입력</label>
							      <textarea name="ac_comment" rows="3" class="form-control" id="comment-input"></textarea>
							    </div>
							    <button type="submit" class="btn btn-primary">댓글 입력</button>
							  </form>
						  </s:authorize>
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