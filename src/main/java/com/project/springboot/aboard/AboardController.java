package com.project.springboot.aboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.springboot.jdbc.ABoard_Service;

@Controller
public class AboardController {

	@Autowired
	ABoard_Service dao;
	
	@RequestMapping("/aboard/aboard_main.do")
	public String aboard_main(Model model) {
		model.addAttribute("ABoardList", dao.select());
		return "aboard/aboard_main";
	}
}
	
	