<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
  <head>
    <meta charset="UTF-8" />
    <title>게시판 - 글쓰기</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="/css/content.css">
<script type="text/javascript">
    function validateForm(form) {  // 필수 항목 입력 확인
        if (form.u_id.value.trim() == "") {
            alert("작성자를 입력하세요.");
            form.u_id.focus();
            return false;
        }
        if (form.c_title.value.trim() == "") {
            alert("제목을 입력하세요.");
            form.c_title.focus();
            return false;
        }
        if (form.c_content.value.trim() == "") {
            alert("내용을 입력하세요.");
            form.c_content.focus();
            return false;
        }
        
    }
</script>
  </head>
 <body>
    <header th:insert="../header.jsp"></header>
    <div class="container">
      <form action="/cboard/write.do" method="post" enctype="multipart/form-data">
        <div class="form-group row">
          <label for="inputTitle" class="col-sm-2 col-form-label"><strong>제목</strong></label>
          <div class="col-sm-10">
            <input type="text" name="c_title" class="form-control" id="inputTitle" />
          </div>
        </div>
        <div class="form-group row">
          <label for="inputAuthor" class="col-sm-2 col-form-label"><strong>작성자</strong></label>
          <div class="col-sm-10">
            <input type="text" name="u_id" class="form-control" id="inputAuthor" />
          </div>
        </div>
        <div class="form-group row">
          <label for="inputContent" class="col-sm-2 col-form-label"><strong>내용</strong></label>
          <div class="col-sm-10">
            <textarea type="text" name="c_content" class="form-control" id="inputContent"></textarea>
          </div>
        </div>
        <div class="form-group row">
          <label for="inputFile" class="col-sm-2 col-form-label"><strong>첨부 파일</strong></label>
          <div class="col-sm-10">
            <div class="custom-file" id="inputFile">
              <input name="c_file" type="file" class="custom-file-input" id="customFile" />
              <label class="custom-file-label" for="customFile">파일을 선택해 주세요.</label>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-auto mr-auto"></div>
          <div class="col-auto">
            <input class="btn btn-primary" type="submit" role="button" value="글쓰기" />
          </div>
        </div>
      </form>
    </div>
    <script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
    <script src="/webjars/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <script>
      $('.custom-file-input').on('change', function () {
        var fileName = $(this).val().split('\\').pop();
        $(this).siblings('.custom-file-label').addClass('selected').html(fileName);
      });
    </script>
  </body>
</html>