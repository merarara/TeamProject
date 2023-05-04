package com.project.springboot.aboard;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.springboot.afbService.IACommentService;
import com.project.springboot.afbpageinfo.BpageInfo;
import com.project.springboot.member.UserDTO;
import com.project.springboot.member.UserService;

@Controller
public class ACommentController {

	    @Autowired
	    private IACommentService acs;
	    
	    @Autowired
	    UserService udao;

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
			
			BpageInfo pinfo = acs.articlePage(nPage);
			model.addAttribute("page", pinfo);
			
	        List<ACommentDTO> acommentList = acs.selectAC(a_num);
	        model.addAttribute("acommentList", acommentList);
	        
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

	    // 댓글 수정
	    @PostMapping("/aboard/acomment/updateac.do")
	    public String updateAC(ACommentDTO acDto, HttpServletRequest req) {
	        acs.updateAC(acDto);
	        return "redirect:/aboard/aboardview.do?a_num=" + acDto.getA_num();
	    }

	    // 댓글 삭제
	    @PostMapping("/aboard/acomment/deleteac.do")
	    public String deleteAC(@RequestParam("ac_num") String ac_num, @RequestParam("a_num") String a_num) {
	        acs.deleteAC(ac_num);
	        return "redirect:/aboard/aboardview.do?a_num=" + a_num;
	    }
	 
}
