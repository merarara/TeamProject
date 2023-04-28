package com.project.springboot.pmservice;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.springboot.ppageinfo.MProductPageinfo;
import com.project.springboot.productdto.PCountDTO;
import com.project.springboot.productdto.ProductlistDTO;

@Controller
public class PManagerController {
	
	@Autowired
	IPManagerDaoService pmdao;
	
	int product_curPage = 1;
	
	// ADMIN 재고관리
    @GetMapping("/admin/productManagement.do")
    public String productManagement(Model model) {
    	
    	return "/admin/productManagement";
    }
    
    // 전체제고관리 맵핑 
  	@RequestMapping("/admin/totalProduct.do")
  	public String totalProduct() {
  		System.out.println(5);
  		return "/admin/totalProduct";
  	}
    
    
    // 재고 검색
    @RequestMapping("/admin/searchProduct.do")
    public String searchProduct (HttpServletRequest req, Model model) {
    	
    	int nPage = 1;
    	
    	try {
    		String sPage = req.getParameter("page");
    		nPage = Integer.parseInt(sPage);
    	} catch (Exception e) {}
    	
    	MProductPageinfo pinfo = pmdao.articleMPage(nPage);
    	model.addAttribute("page", pinfo);
    	
    	nPage = pinfo.getCurPage();
    	
    	List<ProductlistDTO> plist = pmdao.searchPlist(nPage);
    	List<PCountDTO> pcnt = pmdao.searchPcount();
    	
    	model.addAttribute("plist", plist);
    	model.addAttribute("pcnt", pcnt);
    	
    	return "admin/searchProduct";
    }
}
