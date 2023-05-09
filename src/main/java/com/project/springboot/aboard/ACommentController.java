package com.project.springboot.aboard;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.springboot.afbService.IACommentService;
import com.project.springboot.member.UserDTO;
import com.project.springboot.member.UserService;

@Controller
public class ACommentController {

    @Autowired
    private IACommentService acs;
    
    @Autowired
    UserService udao;
    
    @Autowired
    private SqlSessionFactory sqlSessionFactory;

    // 댓글 목록 조회
    @GetMapping("/aboard/aboardview/aclist.do")
    public String getCommentList(ACommentDTO acDto, Model model, @RequestParam int a_num, HttpServletRequest req) {
    	
    	int curPage = 1;
		int nPage = 1;
		
		try
		{
			String sPage = req.getParameter("page");
			nPage = Integer.parseInt(sPage);
		}
		catch (Exception e)
		{
			
		}
		
        return "aboard/aboardview";
    }

    // 댓글 작성
    @PostMapping("/aboard/acomment/insertac.do")
    public String insertAC(ACommentDTO acDto, Model model) {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String u_id = authentication.getName();
		UserDTO udto = udao.selectOne(u_id);
		model.addAttribute("udto", udto);
		acDto.setU_id(u_id);
		String u_nick = udto.getU_nick();
		model.addAttribute("u_nick", u_nick);
		System.out.println(u_nick);
		acDto.setU_nick(u_nick);
        acs.insertAC(acDto);
        return "redirect:/aboard/aboardview.do?a_num=" + acDto.getA_num();
    }
    
    // 댓글 삭제
    @PostMapping("/aboard/acomment/deleteac.do")
    public String deleteAC(@RequestParam("ac_num") int ac_num, @RequestParam("a_num") String a_num, Model model, ACommentDTO acDto) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String u_id = authentication.getName();
        UserDTO udto = udao.selectOne(u_id);
        model.addAttribute("udto", udto);
        acDto.setU_id(u_id);
        System.out.println(u_id);
        Map<String, Object> params = new HashMap<>();
        params.put("ac_num", ac_num);
        params.put("u_id", u_id);
        
        if (acDto.getU_id().equals(u_id)) {
        	acs.deleteAC(params);
        }
        return "redirect:/aboard/aboardview.do?a_num=" + a_num;
    }
    
	// 좋아요 기능
    @PostMapping("/aboard/acomment/aclike.do") 
    public String addAcLike(HttpServletRequest req, HttpSession session, 
    		@RequestParam("ac_num") int ac_num) { 
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
    	String u_id = authentication.getName(); // 사용자 id 
    	int a_num = Integer.parseInt(req.getParameter("a_num"));
		  
		if (u_id == null) { 
			return "redirect:/auth/login.do"; 
		}
		
	    try {
	        acs.addAcLike(ac_num, u_id);
	    } catch (DuplicateKeyException e) {
	        // 이미 좋아요가 추가된 경우, 무시하고 계속 진행합니다.
	    }
		int ac_like = acs.getAcLikeCount(ac_num);
		return "redirect:/aboard/aboardview.do?a_num=" + a_num;

	}
    
	// 좋아요 취소 기능
	@PostMapping("/aboard/acomment/acunlike.do")
	public String removeAcLike(HttpServletRequest req, HttpSession session, 
			  @RequestParam("ac_num") int ac_num, @RequestParam("a_num") int a_num) { 
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
		String u_id = authentication.getName(); // 사용자 id 
	    if (u_id == null) { // 로그인하지 않은 경우 처리
	    	return "redirect:/user/login.do"; 
	    } else { // 좋아요 정보를 삭제한다.
		    acs.removeAcLike(ac_num, u_id); // 게시글의 좋아요 수를 갱신한다. int ac_like =
		    acs.getAcLikeCount(ac_num); 
		    return "redirect:/aboard/aboardview.do?a_num=" + a_num; 
	    } 
	}
		
}
