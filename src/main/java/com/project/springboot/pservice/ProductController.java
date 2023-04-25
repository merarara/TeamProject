package com.project.springboot.pservice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.springboot.member.UserDTO;
import com.project.springboot.member.UserService;
import com.project.springboot.ppageinfo.PPageInfo;
import com.project.springboot.productdto.OrderinfoDTO;
import com.project.springboot.productdto.ProductBascketDTO;
import com.project.springboot.productdto.ProductinfoDTO;
import com.project.springboot.productdto.ProductlistDTO;

@Controller
public class ProductController {
	
	@Autowired
	IPListDaoService pldao;
	
	@Autowired
	UserService udao;
	
	int product_curPage = 1;
	
	// 상품리스트
	@RequestMapping("/product/productlist.do")
	public String productlist1(HttpServletRequest req, Model model) {
		
		int nPage = 1;
		
		String searchfield = req.getParameter("searchfield");
		String searchword = req.getParameter("searchword");
		String type = req.getParameter("type");
		String selected = req.getParameter("selected");
		
		try
		{
			String sPage = req.getParameter("page");
			nPage = Integer.parseInt(sPage);
		}
		catch (Exception e) {} 
		
		PPageInfo pinfo = pldao.articlePage(nPage, searchfield, searchword, type, selected);
		model.addAttribute("page", pinfo);
		
		nPage = pinfo.getCurPage();
		
		ArrayList<ProductlistDTO> dto = pldao.plist(nPage, searchfield ,searchword, type, selected);
		
		if (searchfield != null && searchword != null) {
			model.addAttribute("searchfield", searchfield);
			model.addAttribute("searchword", searchword);
			model.addAttribute("type", type);
		}
		
		if (selected != null) {
			model.addAttribute("selected", selected);
		}
		
		model.addAttribute("plist", dto);
		
		return "product/productlist";
	}
	
	// 상품가이드 이동
	@RequestMapping("/product/buyguide/guide1.do")
	public String guide1() {
		return "product/buyguide/guide1";
	}
	
	// 상품 상세페이지 이동
	@RequestMapping("/product/productinfo.do")
	public String pinfo1(HttpServletRequest req, Model model) {
		int p_num = Integer.parseInt(req.getParameter("p_num"));
		
		ProductinfoDTO dto = pldao.viewpinfo(p_num);
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String u_id = authentication.getName(); // 사용자 id
		
	    UserDTO udto = udao.selectone(u_id);
	    
	    model.addAttribute("uinfo", udto);
		model.addAttribute("pinfo", dto);
		return "product/productinfo";
	}
	
	// 결제 DB처리
	@RequestMapping(value = "/product/save_oinfo.do", method = RequestMethod.POST)
	public String save_order_info(OrderinfoDTO orderinfoDTO) {
		int result = pldao.insertOrder(orderinfoDTO);
		
		return "redirect:product/productinfo.do";
	}
	
	// 장바구니 추가
	@ResponseBody
	@RequestMapping(value = "/product/add_bascket.do", method=RequestMethod.POST)
	public Map<String, String> add_bascket(ProductBascketDTO bascketDTO) {
		int result = pldao.add_bascket(bascketDTO);
		
		Map<String, String> response = new HashMap<String, String>();
		if (result == 1) {
			response.put("status", "success");
		} else {
			response.put("status", "failure");
		}
		
		return response;
	}
	
	// 장바구니 페이지
	@RequestMapping("/product/productbascket.do")
	public String showBascket (Model model) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String u_id = authentication.getName();
		
	    List<ProductBascketDTO> list = pldao.get_bascketList(u_id);
	    
	    UserDTO udto = udao.selectone(u_id);
	    
	    model.addAttribute("uinfo", udto);
	    model.addAttribute("blist", list);
	    
		return "product/productbascket";
	}
	
	@ResponseBody
	@RequestMapping(value = "/product/deletebascket.do", method=RequestMethod.POST)
	public Map<String, String> deleteBascket (HttpServletRequest req) {
		int b_num = Integer.parseInt(req.getParameter("b_num"));
		
		int result = pldao.deleteBascket(b_num);
		
		Map<String, String> response = new HashMap<String, String>();
		if (result == 1) {
			response.put("status", "success");
		} else {
			response.put("status", "failure");
		}
		
		return response;
	}
	
	// 검색 자동완성 기능
	@ResponseBody
	@RequestMapping(value="/product/wordSearchShow.do", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public String wordSearchShow(HttpServletRequest request) {

		String searchfield = request.getParameter("searchfield");
		String searchword = request.getParameter("searchword");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchfield", searchfield);
		paraMap.put("searchword", searchword);
		
		List<String> wordList = pldao.wordSearchShow(paraMap);
		JSONArray jsonArr = new JSONArray(); 
			if(wordList != null) {
				for(String word : wordList) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("word", word);			
					jsonArr.add(jsonObj);
				}
			}
		return jsonArr.toString();
	}
}
