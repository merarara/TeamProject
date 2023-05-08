package com.project.springboot.pbservice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.project.springboot.productdto.OrderinfoDTO;
import com.project.springboot.productdto.ProductBascketDTO;
import com.project.springboot.pservice.IPListDaoService;

@Controller
public class PBascketController {
	
	@Autowired
	IPBascketDaoService pbdao;
	
	@Autowired
	IPListDaoService pldao;
	
	@Autowired
	UserService udao;
	
	// 단품 결제 DB처리
	@RequestMapping(value = "/product/save_oinfo.do", method = RequestMethod.POST)
	public Map<String, String> save_order_info(OrderinfoDTO dto, HttpServletRequest req) {
		String p_num = req.getParameter("p_num");
		String p_name = req.getParameter("p_name");
		String p_price = req.getParameter("p_price");
		String m_qty = req.getParameter("m_qty");
		
		int result = pbdao.insertOrder(dto);
		
		Map<String, String> response = new HashMap<String, String>();
		
		String m_num = pbdao.checkM_Num(dto.getU_id());
		pbdao.insertBOinfo(m_num, dto.getU_id(), dto.getU_nick(), p_num, p_name, p_price, m_qty);
		
		int result2 = pldao.update_SCount(Integer.parseInt(p_num));
		
		if (result + result2 > 1) {
			response.put("status", "success");
		} else {
			response.put("status", "fail");
		}
		
		return response;
	}
	
	// 장바구니 결제 DB처리
	@ResponseBody
	@RequestMapping(value = "/product/save_bascket_order.do", method = RequestMethod.POST)
	public Map<String, String> save_bascket_order(OrderinfoDTO orderinfoDTO) {
		int result = pbdao.insertOrder(orderinfoDTO);
		
		Map<String, String> response = new HashMap<String, String>();
		if (result == 1) {
			response.put("status", "success");
		} else {
			response.put("status", "fail");
		}
		
		return response;
	}
	
	// 장바구니 결제 상세 DB처리
	@ResponseBody
	@RequestMapping(value = "/product/save_bascket_oinfo.do", method = RequestMethod.POST)
	public Map<String, String> save_bascket_oinfo(HttpServletRequest req) {
		String u_id = req.getParameter("u_id");
		String[] p_num = req.getParameterValues("p_num[]");
		String[] p_name = req.getParameterValues("p_name[]");
		String[] p_price = req.getParameterValues("p_price[]");
		String[] bo_qty = req.getParameterValues("bo_qty[]");
		String u_nick = req.getParameter("u_nick");
		
		String m_num = pbdao.checkM_Num(u_id);
		
		int result = 0;
		int result2;
		
		for (int i = 0; i < p_num.length; i++) {
			result = result + pbdao.insertBOinfo(m_num, u_id, u_nick, p_num[i], p_name[i], p_price[i], bo_qty[i]);
			result2 = pldao.update_SCount(Integer.parseInt(p_num[i]));
		}
		
		System.out.println(result);
		Map<String, String> response = new HashMap<String, String>();
		
		if (result > 1) {
			response.put("status", "success");
		} else {
			response.put("status", "fail");
		}
		
		return response;
	}
	
	// 장바구니 결제 후 장바구니 삭제
	@RequestMapping("/product/bascketdeleteAll.do")
	public String deleteBascketAll(HttpServletRequest req) {
		String u_id = req.getParameter("u_id");
		
		int result = pbdao.deleteABascket(u_id);
		
		return "redirect:/product/productbascket.do";
	}
	
	// 장바구니 추가
	@ResponseBody
	@RequestMapping(value = "/product/add_bascket.do", method=RequestMethod.POST)
	public Map<String, String> add_bascket(ProductBascketDTO bascketDTO) {
		int result = pbdao.add_bascket(bascketDTO);
		
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
		
	    List<ProductBascketDTO> list = pbdao.get_bascketList(u_id);
	    
	    UserDTO udto = udao.selectOne(u_id);
	    
	    model.addAttribute("uinfo", udto);
	    model.addAttribute("blist", list);
	    
		return "product/productbascket";
	}
	
	// 장바구니 삭제
	@ResponseBody
	@RequestMapping(value = "/product/deletebascket.do", method=RequestMethod.POST)
	public Map<String, String> deleteBascket (HttpServletRequest req) {
		int b_num = Integer.parseInt(req.getParameter("b_num"));
		
		int result = pbdao.deleteBascket(b_num);
		
		Map<String, String> response = new HashMap<String, String>();
		if (result == 1) {
			response.put("status", "success");
		} else {
			response.put("status", "failure");
		}
		
		return response;
	}
}
