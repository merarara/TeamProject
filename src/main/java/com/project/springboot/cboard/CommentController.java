package com.project.springboot.cboard;

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

import com.project.springboot.afbpageinfo.BpageInfo;
import com.project.springboot.member.UserDTO;
import com.project.springboot.member.UserService;

@Controller
public class CommentController {

	    @Autowired
	    private ICommentService acs;
	    
	    @Autowired
	    UserService udao;

	    // 댓글 목록 조회
	    @GetMapping("/cboard/cboardview/clist.do")
	    public String getCommentList(CommentDTO Dto, Model model, @RequestParam int c_num, HttpServletRequest req) {
	    	
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
			
	        List<CommentDTO> acommentList = acs.selectC(c_num);
	        model.addAttribute("acommentList", acommentList);
	        
	        return "cboard/cboardview";
	    }

	    // 댓글 작성
	    @PostMapping("/cboard/acomment/insertC")
	    public String insertC(CommentDTO Dto, Model model) {
	    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			String u_id = authentication.getName();
			UserDTO udto = udao.selectOne(u_id);
			Dto.setU_id(u_id);
			String u_nick = udto.getU_nick();
			model.addAttribute("u_nick", u_nick);
	        acs.insertC(Dto);
	        return "redirect:/cboard/cboardview.do?c_num=" + Dto.getCc_num();
	    }

	    // 댓글 수정
	    @PostMapping("/cboard/acomment/updateC")
	    public String updateC(CommentDTO Dto, HttpServletRequest req) {
	        acs.updateC(Dto);
	        return "redirect:/cboard/cboardview.do?c_num=" + Dto.getCc_num();
	    }

	    // 댓글 삭제
	    @PostMapping("/cboard/acomment/deleteC")
	    public String deleteC(@RequestParam("cc_num") String cc_num, @RequestParam("c_num") String c_num) {
	        acs.deleteC(cc_num);
	        return "redirect:/cboard/cboardview.do?c_num=" + c_num;
	    }
}
