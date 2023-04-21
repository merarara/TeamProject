package com.project.springboot.commboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.springboot.jdbc.ABoard_Comment_Service;

@Controller
public class CommboardController {

	@Autowired
	ABoard_Comment_Service dao;
	
	@RequestMapping("/aboard/aboard_main_detail.do")
	public String aboard_main_comment(Model model) {
		model.addAttribute("ABoardCommentList", dao.select());
		return "aboard/aboard_main_detail";
	}
}