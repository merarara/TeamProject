<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <link rel="stylesheet" href="/webjars/bootstrap/4.5.0/css/bootstrap.min.css" />
</head>
<body>
	
	
	
	
	 <div class="content_bx_st help_sch clfix">
        <div class="tit_zone">
            <strong class="tit">도움말 검색</strong>
            <p class="sub_copy">
                <b>검색으로 빠르게 도움말을 찾아보실 수 있습니다.</b>
            </p>
        </div>
        <div class="sch_input clfix">
            <input type="text" title="검색어를 입력해주세요" id="searchText"
                   placeholder="문장이 아닌 '단어'로 검색하세요 (특수문자 불가)" onfocus="this.placeholder=''" onblur="this.placeholder='문장이 아닌 \'단어\'로 검색하세요 (특수문자 불가)'">
            <a href="javascript:void(0)" class="btn_help_sch" id="searchButton">
                <img src="images/image1.gif" alt="검색">
            </a>
            <div class="tooltip2">
                <a href="javascript:_gotoChat('');"><u><span id="tooltip2_message"></span></u></a>
                <a href="javascript:void(0);" class="tooltip2_search"><img src="images/image2.png" width="13" height="13" alt="닫기"></a>
            </div>
        </div>
    </div>
	
	
	
	
	
	
	
	
	<div class="container">
      <table class="table">
        <thead class="thead-light">
          <tr class="text-center">
            <th scope="col">#</th>
            <th scope="col">제목</th>
            <th scope="col">작성자</th>
            <th scope="col">작성일</th>
            <th scope="col">작성일2</th>
          </tr>
        </thead>
        </table>
        
        
        
         <div class="row">
        <div class="col-auto mr-auto"></div>
        <div class="col-auto">
          <a class="btn btn-primary" href="/write" role="button">글쓰기</a>
        </div>
      </div>
    </div>
        
        
        
        
        </div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>