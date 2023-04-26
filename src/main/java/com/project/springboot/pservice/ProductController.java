package com.project.springboot.pservice;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.springboot.member.UserDTO;
import com.project.springboot.member.UserService;
import com.project.springboot.ppageinfo.PPageInfo;
import com.project.springboot.productdto.BascketOrderDTO;
import com.project.springboot.productdto.OrderinfoDTO;
import com.project.springboot.productdto.ProductBascketDTO;
import com.project.springboot.productdto.ProductinfoDTO;
import com.project.springboot.productdto.ProductlistDTO;
import com.project.springboot.productdto.ReviewDTO;
import com.project.springboot.productdto.ReviewImageDTO;

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
	    
	    UserDTO udto = udao.selectOne(u_id);
	    String bchk1 = pldao.buyCheck1(p_num);
	    String bchk2 = pldao.buyCheck2(p_num);
	    
	    List<ReviewDTO> rdto = pldao.GetReview(p_num);
	    List<ReviewImageDTO> ridto = pldao.getRevImgDao(p_num);
	    
	    System.out.println("u_id : " + u_id + "bchk1 : " + bchk1 + "bchk2 : " + bchk2);
	    
    	if (u_id.equals(bchk1) || u_id.equals(bchk2)) {
    		model.addAttribute("bchk", "ok");
    	} else {
    		model.addAttribute("bchk", "no");
    	}
    	
    	model.addAttribute("ridto", ridto);
    	model.addAttribute("rdto", rdto);
	    model.addAttribute("uinfo", udto);
		model.addAttribute("pinfo", dto);
		return "product/productinfo";
	}
	
	// 단품 결제 DB처리
	@RequestMapping(value = "/product/save_oinfo.do", method = RequestMethod.POST)
	public String save_order_info(OrderinfoDTO orderinfoDTO) {
		int result = pldao.insertOrder(orderinfoDTO);
		
		int result2 = pldao.update_SCount(orderinfoDTO.getP_num());
		
		return "redirect:product/productinfo.do";
	}
	
	// 장바구니 결제 DB처리
	@ResponseBody
	@RequestMapping(value = "/product/save_bascket_order.do", method = RequestMethod.POST)
	public Map<String, String> save_bascket_order(BascketOrderDTO bOrderDTO) {
		int result = pldao.insertBOrder(bOrderDTO);
		
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
		
		String o_num = pldao.checkO_Num(u_id);
		
		int result = 0;
		int result2;
		
		for (int i = 0; i < p_num.length; i++) {
			result = result + pldao.insertBOinfo(o_num, u_id, p_num[i], p_name[i], p_price[i], bo_qty[i]);
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
		
		int result = pldao.deleteABascket(u_id);
		
		return "redirect:/product/productbascket.do";
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
		
		int result = pldao.deleteBascket(b_num);
		
		Map<String, String> response = new HashMap<String, String>();
		if (result == 1) {
			response.put("status", "success");
		} else {
			response.put("status", "failure");
		}
		
		return response;
	}
	
	// 상품 리뷰 글
	@RequestMapping(value="/product/reviewUpload.do", method=RequestMethod.POST)
	public String reviewUpload(MultipartFile[] review_file, ReviewDTO rdto,
			MultipartHttpServletRequest req) {
		String path = "";
		
		System.out.println(rdto.getP_num());
		System.out.println(rdto.getP_content());
		System.out.println(rdto.getU_id());
		System.out.println(rdto.getR_rating());
		
		int ireview = pldao.insertReview(rdto);
		
		int r_num = pldao.checkRnum(rdto.getP_num(), rdto.getU_id());
		
		for (MultipartFile f: review_file) {
			System.out.println(f);
			String originalName = f.getOriginalFilename();
			System.out.println("originalName : " + originalName);
			String ext = originalName.substring(originalName.lastIndexOf('.'));
			String uuid = UUID.randomUUID().toString().replaceAll("-", "");
			String savedName = uuid + ext;
			System.out.println("savedName:" + savedName);
			
			try {
				path = ResourceUtils.getFile("classpath:static/revuploads")
						.toPath().toString();
				System.out.println("path : " + path);
				File filePath = new File(path, savedName);
				System.out.println("filePath : " + filePath);
				f.transferTo(filePath);
			} catch (Exception e) {
				e.printStackTrace();
			}
			ReviewImageDTO ridto = new ReviewImageDTO();
			ridto.setR_num(r_num);
			ridto.setP_num(rdto.getP_num());
			ridto.setR_ofile(originalName);
			ridto.setR_sfile(savedName);
			
			pldao.insertRImg(ridto);
		}
		
		return "redirect:/product/productinfo.do?p_num=" + rdto.getP_num();
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
