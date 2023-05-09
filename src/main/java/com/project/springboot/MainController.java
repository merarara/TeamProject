package com.project.springboot;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.springboot.aboard.aboardDTO;
import com.project.springboot.productdto.ProductlistDTO;
import com.project.springboot.pservice.IPListDaoService;

@Controller
public class MainController {	
	
	@Autowired
	IPListDaoService pldao;
	
	@RequestMapping("/")
	public String home() {
		return "redirect:/home.do";
	}

	// 홈으로 이동하는 맵핑
	@RequestMapping("/home.do")
	public String goHome(Model model, HttpSession session) {
		List<ProductlistDTO> plist = pldao.homeProduct();
		List<aboardDTO> nlist = pldao.getNotice();
		
		model.addAttribute("plist", plist);
		model.addAttribute("nlist", nlist);
		
		return "home";
	}
}

