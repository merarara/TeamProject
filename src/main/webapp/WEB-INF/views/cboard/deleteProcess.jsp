<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    request.setCharacterEncoding("UTF-8");
    String c_num = request.getParameter("c_num");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 삭제 처리</title>
</head>
<body>
    
    <%
        // DB 연결 등 필요한 처리 수행
        // 게시물 삭제 처리
        
        // 삭제 성공 시
        response.sendRedirect("/cboard/list.do");
    %>
    
</body>
</html>
