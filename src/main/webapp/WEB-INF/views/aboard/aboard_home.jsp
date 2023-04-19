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
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	 <h2>목록 보기(List)</h2>
    <!-- 검색폼 -->
    <!-- 아래와 같이 action속성이 정의되지 않으면 폼값은 현재 페이지로
    전송된다. 또한 method를 생략하면 get방식이 디폴트값으로 지정된다.  --> 
    <form method="get">  
    <table border="1" width="90%">
    <tr>
        <td align="center">
            <select name="searchField"> 
                <option value="title">제목</option> 
                <option value="content">내용</option>
            </select>
            <input type="text" name="searchWord" />
            <input type="submit" value="검색하기" />
        </td>
    </tr>   
    </table>
    </form>
    <!-- 게시물 목록 테이블(표) --> 
    <table border="1" width="90%">
        <!-- 각 칼럼의 이름 --> 
        <tr>
            <th width="10%">번호</th>
            <th width="50%">제목</th>
            <th width="15%">작성자</th>
            <th width="10%">조회수</th>
            <th width="15%">작성일</th>
        </tr>
        <!-- 목록의 내용 --> 

    </table>
    
	
	
	
	
	
	   <div class="row">
        <div class="col-auto mr-auto"></div>
        <div class="col-auto">
          <a class="btn btn-primary" href="/aboard/aboard_write.do" role="button">글쓰기</a>
        </div>
      </div>
    </div>
        
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>