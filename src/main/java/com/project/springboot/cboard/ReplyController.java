package com.project.springboot.cboard;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.springboot.member.UserDTO;
import com.project.springboot.member.UserService;

@Controller
public class ReplyController {
	
	@Autowired
    UserService udao;
	
	@Autowired
	cboardService cs;
	
	@Autowired
	private ReplyService replyService;
	
	@Autowired 
	IboardService asv;
	
	@Autowired
	private cboardDTO cdto;
	
	//댓글조회 
		@RequestMapping(value = "/cboard/list.do", method = RequestMethod.GET)
		public String getReplyList(Model model, @RequestParam("c_num") int c_num) throws Exception {
		    
		    
		    
		    return "/cboard/cboardview";
		}
	//댓글작성 
	@RequestMapping(value = "/cboard/write.do", method = RequestMethod.POST)
	public String postWrite(HttpServletRequest req, ReplyVO vo, Model model) throws Exception {
		int c_num = Integer.parseInt(req.getParameter("c_num"));
		System.out.println(c_num);
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String u_id = authentication.getName();
	    UserDTO udto = udao.selectOne(u_id);
	    cboardDTO dto = asv.selectOne(c_num);
	    model.addAttribute("cboardDto", dto);
	    model.addAttribute("u_nick", udto.getU_nick());
	    vo.setU_id(udto.getU_nick());
	    vo.setC_Num(c_num);
	    replyService.write(vo);
	    
	    return "redirect:/cboard/cboardview.do?c_num=" + vo.getC_num();
	}






	
//	// 댓글 작성
//	@RequestMapping(value = "/cboard/write.do", method = RequestMethod.POST)
//	public String postWrite(@RequestParam("c_num") String c_numStr, 
//	                        @RequestParam("c_rno") String c_rnoStr, 
//	                        @RequestParam("c_content") String c_content, 
//	                        Model model) throws Exception {
//	    // c_num, c_rno 값 변환
//	    int c_num = Integer.parseInt(c_numStr);
//	    int c_rno = Integer.parseInt(c_rnoStr);
//	    
//	    // ReplyVO 객체 생성 및 설정
//	    ReplyVO vo = new ReplyVO();
//	    vo.setc_num(c_num);
//	    vo.setc_rno(c_rno);
//	    vo.setc_content(c_content);
//	    
//	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//	    String u_id = authentication.getName();
//	    UserDTO udto = udao.selectOne(u_id);
//	    model.addAttribute("u_nick", udto.getU_nick());
//	    vo.setu_id(udto.getU_nick());
//	    
//	    // cboardDAO의 selectOne() 메소드가 Integer 타입을 매개변수로 받도록 수정
//	    cboardDTO cdto = cs.selectOne(c_num);
//	    model.addAttribute("cdto", cdto);
//
//	    return "redirect:/cboard/view?c_num=" + c_num;
//	}











	
		
	// 댓글 단일 조회 (수정 페이지)
	@RequestMapping(value = "/cboard/replymodify", method = RequestMethod.GET)
	public void getMofidy(@RequestParam("c_num") int c_num, @RequestParam("c_rno") int c_rno, Model model) throws Exception {
		
		ReplyVO vo = new ReplyVO();
		vo.setC_Num(c_num);
		vo.setC_Rno(c_rno);
		
		ReplyVO reply = replyService.replySelect(vo);
		 
		model.addAttribute("reply", reply);		 
	}
	
	
	
	// 댓글 수정
	@RequestMapping(value = "/cboard/replymodify", method = RequestMethod.POST)
	public String postModify(ReplyVO vo, @RequestParam("c_num") int c_num) throws Exception {

		replyService.modify(vo);
		 
		return "redirect:/cboard/cboardview.do?c_num=" + c_num;
	}
	
	
	// 댓글 삭제
	
}
