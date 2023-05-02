package com.project.springboot.aboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.springboot.afbService.IACommentService;

@Controller
@RequestMapping("/aboard/acomment")
public class ACommentController {

	    @Autowired
	    private IACommentService acs;

	    // 댓글 목록 조회
	    @GetMapping("/aboard/acomment/list.do")
	    public String getCommentList(Model model, @RequestParam int a_num) {
	        List<ACommentDTO> acommentList = acs.getCommentList(a_num);
	        model.addAttribute("acommentList", acommentList);
	        return "aboard/comment_list";
	    }

	    // 댓글 작성
	    @PostMapping("/aboard/accomment/acwrite.do")
	    public String writeComment(ACommentDTO acDto) {
	        acs.writeComment(acDto);
	        return "redirect:/aboard/aboardview.do?a_num=" + acDto.getA_num();
	    }

	    // 댓글 수정
	    @PostMapping("/aboard/acomment/acmodify.do")
	    public String modifyComment(ACommentDTO acDto) {
	        acs.modifyComment(acDto);
	        return "redirect:/aboard/aboardview.do?a_num=" + acDto.getA_num();
	    }

	    // 댓글 삭제
	    @PostMapping("/aboard/acomment/acdelete.do")
	    public String deleteComment(@RequestParam int c_num, @RequestParam int a_num) {
	        acs.deleteComment(c_num);
	        return "redirect:/aboard/aboardview.do?a_num=" + a_num;
	    }
}
