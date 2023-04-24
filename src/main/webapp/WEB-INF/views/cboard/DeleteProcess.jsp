<%@ page import="com.project.springboot.cboard.C_BoardDAO"%> 
<%@ page import="com.project.springboot.cboard.C_BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%
// 게시물의 일련번호를 받은 후 기존 게시물을 가져온다.
int c_num = Integer.parseInt(request.getParameter("c_num"));

C_BoardDTO dto = new C_BoardDTO();
C_BoardDAO dao = (C_BoardDAO) application.getAttribute("c_boardDAO");
dto = dao.selectView(c_num);

// 세션 영역에 저장된 회원 아이디를 가져온다.
String sessionId = (String) session.getAttribute("u_id");

int delResult = 0;
// 세션의 아이디와 게시물의 아이디가 일치하면 작성자 본인이므로..
if (sessionId.equals(dto.getU_id())) {
    // 게시물을 삭제한다.
    dao.deleteWrite(c_num);
    delResult = 1; // 삭제 성공 시 1을 반환하도록 함.
    
    if (delResult == 1) {
        // 게시물이 삭제되면 목록(리스트)로 이동한다.
        response.sendRedirect("c_list.do");
    } else {
        // 삭제에 실패하면 뒤로 이동한다.
        out.println("<script>");
        out.println("alert('삭제에 실패하였습니다.');");
        out.println("history.back();");
        out.println("</script>");
    }
} else {
    // 작성자 본인이 아니면 삭제할 수 없다.
    out.println("<script>");
    out.println("alert('본인만 삭제할 수 있습니다.');");
    out.println("history.back();");
    out.println("</script>");
    return;
}

%>
