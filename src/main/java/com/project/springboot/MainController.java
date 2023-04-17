package com.project.springboot;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.springboot.ppageinfo.PPageInfo;
import com.project.springboot.productlist.ProductlistDTO;
import com.project.springboot.pservice.IPListDaoService;

@Controller
public class MainController {	
	
	@Autowired
	IPListDaoService pldao;
	
	int product_curPage = 1;
	
	@RequestMapping("/")
	public String home() {
		return "home";
	}
	
	@RequestMapping("/product/productlist.do")
	public String productlist1(HttpServletRequest req, Model model) {
		
		int nPage = 1;
		HttpSession session = req.getSession();
		
		if (session.getAttribute("cpage") != null)
		{
			product_curPage = (int)session.getAttribute("cpage");
		}
		
		try
		{
			String sPage = req.getParameter("page");
			nPage = Integer.parseInt(sPage);
		}
		catch (Exception e) {} 
		
		PPageInfo pinfo = pldao.articlePage(nPage);
		model.addAttribute("page", pinfo);
		
		nPage = pinfo.getCurPage();
		
		if (nPage == 0)
		{
			nPage = 1;
		}
		
		ArrayList<ProductlistDTO> dto = pldao.plist(nPage);
		
		session.setAttribute("cpage", nPage);
		
		model.addAttribute("plist", dto);
		
		return "product/productlist";
	}
}
