package com.project.springboot.pmservice;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.springboot.ppageinfo.MProductPageinfo;
import com.project.springboot.productdto.BOrderinfoDTO;
import com.project.springboot.productdto.OrderinfoDTO;
import com.project.springboot.productdto.PCountDTO;
import com.project.springboot.productdto.PSoldInfoDTO;
import com.project.springboot.productdto.ProductinfoDTO;
import com.project.springboot.productdto.ProductlistDTO;
import com.project.springboot.productdto.ReviewImageDTO;

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
    	
    	String searchword = req.getParameter("searchword");
    	String searchfield = req.getParameter("searchfield");
    	
    	try {
    		String sPage = req.getParameter("page");
    		nPage = Integer.parseInt(sPage);
    	} catch (Exception e) {}
    	
    	MProductPageinfo pinfo = pmdao.articleMPage(nPage, searchword, searchfield);
    	model.addAttribute("page", pinfo);
    	
    	nPage = pinfo.getCurPage();
    	
    	List<ProductlistDTO> plist = pmdao.searchPlist(nPage, searchword, searchfield);
    	List<PCountDTO> pcnt = pmdao.searchPcount();
    	
    	if (searchword != null && searchword != "") {
    		model.addAttribute("searchword", searchword);
    		model.addAttribute("searchfield", searchfield);
    	}
    	
    	model.addAttribute("plist", plist);
    	model.addAttribute("pcnt", pcnt);
    	
    	return "admin/searchProduct";
    }
    
    // 재고 삭제
    @ResponseBody
    @RequestMapping("/admin/deleteCount.do")
    public Map<String, String> deleteCnt (HttpServletRequest req) {
    	String barcode = req.getParameter("barcode");
    	int p_num = Integer.parseInt(req.getParameter("p_num"));
    	
    	Map<String, String> response = new HashMap<>();
    	
    	int result = pmdao.deleteCount(barcode, p_num);
    	
    	if (result == 1) {
    		response.put("status", "success");
    	} else {
    		response.put("status", "fail");
    	}
    	
    	return response;
    }
    
    // 바코드번호 가져오기
    @ResponseBody
    @RequestMapping("/admin/getBarcodes.do")
    public List<String> getBarcodes(HttpServletRequest req) {
    	int p_num = Integer.parseInt(req.getParameter("p_num"));
    	
    	List<String> barcodeList = pmdao.getBarcodeList(p_num);
    	
    	return barcodeList;
    }
    
    // 바코드번호 추가
    @ResponseBody
    @RequestMapping("/admin/addBarcode.do")
    public Map<String, String> addBarcode (HttpServletRequest req) {
    	int p_num = Integer.parseInt(req.getParameter("p_num"));
    	String barcode = req.getParameter("barcode");
    	
    	System.out.println(p_num);
    	System.out.println(barcode);
    	
    	int result = pmdao.addBarcode(p_num, barcode);
    	
    	Map<String, String> response = new HashMap<>();
    	
    	if (result == 1) {
    		response.put("status", "success");
    	} else {
    		response.put("status", "fail");
    	}
    	
    	return response;
    }
    
    // 판매관리 페이지 이동
    @RequestMapping("/admin/sellManage.do")
    public String sellManage(HttpServletRequest req, Model model) {
    	
    	int nPage = 1;
    	
    	String searchword = req.getParameter("searchword");
    	String searchfield = req.getParameter("searchfield");
    	String tab = req.getParameter("tab");
    	
    	if (tab == null) {
    		tab = "tab1";
    	}
    	
    	try {
    		String sPage = req.getParameter("page");
    		nPage = Integer.parseInt(sPage);
    	} catch (Exception e) {}
    	
    	MProductPageinfo pinfo = pmdao.articleSPage(nPage, searchword, searchfield, tab);
    	model.addAttribute("page", pinfo);
    	
    	nPage = pinfo.getCurPage();
    	
    	if (searchword != null && searchword != "") {
    		model.addAttribute("searchword", searchword);
    		model.addAttribute("searchfield", searchfield);
    	}
    	
    	List<OrderinfoDTO> list = pmdao.searchSList(nPage, searchword, searchfield, tab);
    	
    	List<BOrderinfoDTO> blist = new ArrayList<BOrderinfoDTO>();
    	List<PCountDTO> pclist = new ArrayList<PCountDTO>();
    	
    	List<PSoldInfoDTO> soldlist = new ArrayList<PSoldInfoDTO>();
    	if (tab != "tab1") {
    		soldlist = pmdao.getSoldInfo();
    	}
    	
    	if(!list.isEmpty()) {
    		blist = pmdao.getBOrder();
    		pclist = pmdao.searchPcount();
    		model.addAttribute("isOrder", "Yes");
    	} else {
    		model.addAttribute("isOrder","No");
    	}
    	
    	model.addAttribute("tab", tab);
    	model.addAttribute("pclist", pclist);
    	model.addAttribute("orderlist", list);
    	model.addAttribute("blist", blist);
    	model.addAttribute("soldlist", soldlist);
    	
    	return "admin/sellManage";
    }
    
    // 상품 결제 승인
    @ResponseBody
    @RequestMapping("/admin/confirmOrder.do")
    public Map<String, String> confirmOrder(HttpServletRequest req) {
    	
    	String[] barcodelist = req.getParameterValues("barcodelist[]");
    	String[] p_num = req.getParameterValues("p_num[]");
    	String m_num = req.getParameter("m_num");
    	
    	int result = 0;
    	Map<String, String> response = new HashMap<String, String>();
    	
    	for(int i = 0; i < barcodelist.length; i++) {
    		result = result + pmdao.confirmOrder(barcodelist[i], m_num, p_num[i]);
    	}
    	
    	for(String e: p_num) {
    		pmdao.updateCount(e);
    	}
    	
    	if (result >= 2) {
    		response.put("status", "success");
    	} else {
    		response.put("status", "fail");
    	}
    	
    	return response;
    }
    
    // 상품 주문상태 변경
    @ResponseBody
    @RequestMapping("/admin/doDelivery.do")
    public Map<String, String> doDelivery(HttpServletRequest req) {
    	String m_num = req.getParameter("m_num");
    	String status = req.getParameter("status");
    	
    	int result = pmdao.updateOrder(m_num, status);
    	
    	Map<String, String> response = new HashMap<String, String>();
    	
    	if (result == 1) { 
    		response.put("status", "success");
    	} else {
    		response.put("status", "fail");
    	}
    	
    	return response;
    }
    
    // 상품 주문상태 변경
    @ResponseBody
    @RequestMapping("/admin/doConfirmSell.do")
    public Map<String, String> doComfirmSell(HttpServletRequest req) {
    	String m_num = req.getParameter("m_num");
    	String status = req.getParameter("status");
    	
    	int result = pmdao.updateOrder(m_num, status);
    	
    	Map<String, String> response = new HashMap<String, String>();
    	
    	if (result == 1) { 
    		response.put("status", "success");
    	} else {
    		response.put("status", "fail");
    	}
    	
    	return response;
    }
    
    // 상품 추가
    @RequestMapping("/admin/doAddProduct.do")
    public String addProduct(@RequestParam(name = "listimg", required = false) MultipartFile listimg, ProductlistDTO pDTO, 
    		ProductinfoDTO pinfoDTO, @RequestParam(name = "imgsrcs", required = false) MultipartFile[] imgsrcs,
    		@RequestParam(name = "link_imgsrcs", required = false) String[] linkImgSrcs, HttpServletRequest req) {
    	
    	String p_imgsrcs = "";
    	
    	pinfoDTO.setP_name(pDTO.getP_name());
    	
    	// 상품 대표 이미지 파일업로드 추가
    	if (listimg != null) {
    		String path = "";
			String originalName = listimg.getOriginalFilename();
			String ext = originalName.substring(originalName.lastIndexOf('.'));
			String uuid = UUID.randomUUID().toString().replaceAll("-", "");
			String savedName = uuid + ext;
			
			pDTO.setP_listimg(savedName);
			
			try {
				path = ResourceUtils.getFile("classpath:static/productuploads/")
						.toPath().toString();
				File filePath = new File(path, savedName);
				listimg.transferTo(filePath);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	}
    	
    	// 직접 입력한상품 상세 이미지 정제
    	if (linkImgSrcs != null) {
    		for (int i = 0; i < linkImgSrcs.length; i++) {
        		if (i != (linkImgSrcs.length - 1)) {
        			p_imgsrcs += linkImgSrcs[i] + ",";
        		} else {
        			p_imgsrcs += linkImgSrcs[i];
        			pinfoDTO.setP_imgsrcs(p_imgsrcs);
        		}
        	}
    	} else {
    		// 파일 업로드 상세 이미지 정제 후 추가
    		String path = "";
    		for (int i = 0; i < imgsrcs.length; i++) {
    			MultipartFile f = imgsrcs[i];
    			String originalName = f.getOriginalFilename();
				String ext = originalName.substring(originalName.lastIndexOf('.'));
				String uuid = UUID.randomUUID().toString().replaceAll("-", "");
				String savedName = uuid + ext;
				
				if (i != imgsrcs.length - 1) {
					p_imgsrcs += savedName + ",";
				} else {
					p_imgsrcs += savedName;
					pinfoDTO.setP_imgsrcs(p_imgsrcs);
				}
				
				try {
					path = ResourceUtils.getFile("classpath:static/productuploads/")
							.toPath().toString();
					File filePath = new File(path, savedName);
					f.transferTo(filePath);
				} catch (Exception e) {
					e.printStackTrace();
				}
    		}
    	}
    	
    	int result = pmdao.addProduct(pDTO, pinfoDTO);
    	if (result == 2) {
    		System.out.println("성공");
    	} else {
    		System.out.println("실패");
    	}
    	return "redirect:/admin/adminPage.do?check=yes";
    }
}
