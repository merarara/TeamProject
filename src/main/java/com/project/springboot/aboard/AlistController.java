package com.project.springboot.aboard;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AlistController {

	@RequestMapping("/aboard/aboard_home.do")
	public String home() {
		return "aboard/aboard_home";
	}
	
	@RequestMapping("/aboard/aboard_write.do")
	public String write() {
		return "aboard/aboard_write";
	}
	
	
}
