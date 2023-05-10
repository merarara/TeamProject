package com.project.springboot.pservice;

import java.io.File;
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
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.springboot.member.UserDTO;
import com.project.springboot.member.UserService;
import com.project.springboot.pbservice.IPBascketDaoService;
import com.project.springboot.ppageinfo.PPageInfo;
import com.project.springboot.productdto.ProductinfoDTO;
import com.project.springboot.productdto.ProductlistDTO;
import com.project.springboot.productdto.ReviewDTO;
import com.project.springboot.productdto.ReviewImageDTO;
import com.project.springboot.prservice.IPReviewDaoService;

@Controller
public class ProductController {
	
	@Autowired
	IPListDaoService pldao;
	
	@Autowired
	IPReviewDaoService prdao;
	
	@Autowired
	IPBascketDaoService pbdao;
	
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
	    
	    // 로그인한 사용자 구매 체크
	    UserDTO udto = udao.selectOne(u_id);
	    String bchk = pldao.buyCheck(p_num, u_id);
	    
	    String bascketCheck = pldao.bascketCheck(u_id);
	    
	    System.out.println(bascketCheck);
	    
	    model.addAttribute("bascketCheck", bascketCheck);
	    // 리뷰 글
	    List<ReviewDTO> rdto = prdao.GetReview(p_num);
	    
	    List<ReviewImageDTO> ridto = new ArrayList<ReviewImageDTO>();
	    
	    if (rdto.size() != 0) {
	    	// 리뷰 이미지
		    ridto = prdao.getRevImgDao(p_num);
	    }
	   
	    
	    String rchk = "no";
	    
	    for (ReviewDTO rd: rdto) {
	    	if (rd.getU_id().equals(u_id)) {
	    		rchk = "yes";
	    	}
	    }
	    
	    // 리뷰 작성자 체크 정보
	    model.addAttribute("rchk", rchk);
	    
	    List<String> filepath = new ArrayList<String>();
	    try {
	    	String path = ResourceUtils
	    			.getFile("classpath:static/revuploads/").toPath().toString();
	    	File file = new File(path);
	    	File[] fileArray = file.listFiles();
	    	
	    	for (File f : fileArray) {
	    		filepath.add(f.getName());
	    	}
	    	model.addAttribute("file", filepath);
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
	    
    	if (u_id.equals(bchk)) {
    		model.addAttribute("bchk", "ok");
    	} else {
    		model.addAttribute("bchk", "no");
    	}
    	
    	// 리뷰 이미지
    	model.addAttribute("ridto", ridto);
    	
    	// 리뷰 내용
    	if (rdto.size() != 0) {
        	model.addAttribute("rdto", rdto);
    	} else {
    		model.addAttribute("reviewNo", "Yes");
    	}
    	// 유저 정보
	    model.addAttribute("uinfo", udto);
	    // 상품 정보
		model.addAttribute("pinfo", dto);
		return "product/productinfo";
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
