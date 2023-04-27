package com.project.springboot.cboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.springboot.cservice.C_ReplyService;



@Controller
@RequestMapping("/reply/*")
public class C_ReplyController {

	@Autowired
	private C_ReplyService replyService;
	
	// 댓글 조회
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void getList(@RequestParam("c_num") int c_num, Model model) throws Exception {
	    List<C_ReplyVO> replyList = replyService.replyList(c_num);
	    model.addAttribute("replyList", replyList);
	}

	
	// 댓글 작성
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String postWirte(C_ReplyVO vo) throws Exception {
		
		replyService.write(vo);
		
		return "redirect:/cboard/view.do?c_num=" + vo.getC_num();
	}
	
		
	// 댓글 단일 조회 (수정 페이지)
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void getMofidy(@RequestParam("c_num") int c_num, @RequestParam("c_rno") int c_rno, Model model) throws Exception {
		
		C_ReplyVO vo = new C_ReplyVO();
		vo.setC_num(c_num);
		vo.setC_rno(c_rno);
		
		C_ReplyVO reply = replyService.replySelect(vo);
		 
		model.addAttribute("reply", reply);		 
	}
	
	
	
	// 댓글 수정
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String postModify(C_ReplyVO vo) throws Exception {

		replyService.modify(vo);
		 
		return "redirect:/cboard/view.do?c_num=" + vo.getC_num();
	}
	
	
	// 댓글 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String postDelete(C_ReplyVO vo) throws Exception{
	    replyService.delete(vo);
	    return "redirect:/cboard/view.do?c_num=" + vo.getC_num();
	}


}
