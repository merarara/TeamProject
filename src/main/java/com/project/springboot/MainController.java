package com.project.springboot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.springboot.productlist.IProductlistService;

@Controller
public class MainController {	
	
	@Autowired
	IProductlistService plistdao;
	
	@RequestMapping("/")
	public String home() {
		return "home";
	}
	
	@RequestMapping("/product/productlist.do")
	public String productlist1(Model model) {
		
		model.addAttribute("plist", plistdao.productlist_allsch());
		return "product/productlist";
	}
}
