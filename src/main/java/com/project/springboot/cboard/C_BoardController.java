package com.project.springboot.cboard;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.springboot.cservice.C_BoardService;
import com.project.springboot.cservice.C_ReplyService;

@Controller
@RequestMapping("/cboard/*")
public class C_BoardController {
		
	@Autowired
	private C_BoardService service;
	
	@Autowired
	private C_ReplyService replyService;

	// 게시물 목록
	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public void getList(Model model, @RequestParam("num") int num) throws Exception {
		
		List<C_BoardVO> list = null; 
		list = service.list();
		model.addAttribute("list", list);	
		
		
		C_Page page = new C_Page();
		
		page.setNum(num);
		page.setCount(service.count());		
		
		List<C_BoardVO> listPage = null; 
		listPage = service.listPage(page.getDisplayPost(), page.getPostNum());
		
		model.addAttribute("listPage", listPage);					
		model.addAttribute("page", page);		
		model.addAttribute("select", num);
	}
	
	// 게시물 작성
	@RequestMapping(value = "/write.do", method = RequestMethod.GET)
	public void getWirte() throws Exception {
		 
	}
	
	@PostMapping(value="/write.do")
	public String postWrite(C_BoardVO vo, MultipartHttpServletRequest req) throws Exception {
	    // 첨부 파일이 있을 경우 파일 저장 처리
	    MultipartFile file = vo.getC_file();
	    if (file != null && !file.isEmpty()) {
	        // 파일 이름 생성 (오늘 날짜로 변경)
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
	        String today = dateFormat.format(new Date());
	        String originalFileName = file.getOriginalFilename();
	        String fileName = today + "_" + originalFileName;

	        // 파일 저장 경로 설정
	        String uploadDir = req.getSession().getServletContext().getRealPath("/uploads/");
	        String filePath = uploadDir + fileName;

	        // 파일 저장
	        file.transferTo(new File(filePath));

	        // C_BoardVO에 파일 정보 저장
	        vo.setC_ofile(originalFileName);
	        vo.setC_sfile(filePath);
	        
	        //게시글 작성
	        service.write(vo);
	        return "redirect:/cboard/list.do";
	    }
	    return null;
	}


	// 게시물 조회
	@RequestMapping(value = "/view.do", method = RequestMethod.GET)
	public void getView(@RequestParam("c_num") int c_num, Model model) throws Exception {
		 
	//이미지 표
	try {
			String fileName = service.c_sfile(c_num);
	        String path = ResourceUtils.getFile("classpath:static/uploads/" + fileName).toPath().toString();
	        Map<String, Integer> fileMap = new HashMap<String, Integer>();

	        File file = new File(path);
	        File[] fileArray = file.listFiles();
	        for(File f : fileArray){
	            //저장된 파일명, 파일 용량을 Map에 저장한다. 
	            fileMap.put(f.getName(), (int)Math.ceil(f.length()/1024.0));
	        }
	        model.addAttribute("fileMap", fileMap);        
	    } catch (Exception e) {}
		
	    // 게시물 조회
	    C_BoardVO vo = service.view(c_num);
	    model.addAttribute("view", vo);
	    
	    // 게시물 방문자 수 증가
	    service.updateVisitCount(c_num);
	    
	    // 댓글 조회
	    List<C_ReplyVO> reply = null;
	    reply = replyService.list(c_num);
	    model.addAttribute("reply", reply);
	}
		
	//다운로드 파일
	@RequestMapping("/download.do")
	public void downloadFile(HttpServletRequest req, HttpServletResponse response) throws Exception {

	    String oriFile = req.getParameter("oriFile");
	    String savedFile = req.getParameter("savedFile");
	    
	    String path = req.getServletContext().getRealPath("/uploads");
	    File file = new File(path + File.separator + savedFile);

	    try {
	        FileInputStream fis = new FileInputStream(file);
	        BufferedInputStream bis = new BufferedInputStream(fis);
	        OutputStream out = response.getOutputStream();
	                    
	        response.addHeader("Content-Disposition", "attachment;filename=\"" + 
	            java.net.URLEncoder.encode(oriFile, "utf-8") + "\"");
	        response.setContentLength((int) file.length());

	        int read = 0;
	        while ((read = bis.read()) != -1) {
	            out.write(read);
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}
	
	// 게시물 수정
	@RequestMapping(value = "/modify.do", method = RequestMethod.GET)
	public void getModify(@RequestParam("c_num") int c_num, Model model) throws Exception {

		C_BoardVO vo = service.view(c_num);
		 
		model.addAttribute("view.do", vo);
	}
	
	// 게시물 수정
	@RequestMapping(value = "/modify.do", method = RequestMethod.POST)
	public String postModify(C_BoardVO vo) throws Exception {

		service.modify(vo);
		 
		 return "redirect:/cboard/view.do?c_num=" + vo.getC_num();
	}
	
	// 게시물 삭제
	@RequestMapping(value = "/delete.do", method = RequestMethod.GET)
	public String getDelete(@RequestParam("c_num") int c_num) throws Exception {
		
		service.delete(c_num);		

		return "redirect:/list.do";
	} 
	
	
	
	// 게시물 목록 + 페이징 추가
	@RequestMapping(value = "/listPage.do", method = RequestMethod.GET)
	public void getListPage(Model model, @RequestParam("num") int num) throws Exception {

		
		C_Page page = new C_Page();
		
		page.setNum(num);
		page.setCount(service.count());		
		
		List<C_BoardVO> list = null; 
		list = service.listPage(page.getDisplayPost(), page.getPostNum());
		
		model.addAttribute("list", list);					
		model.addAttribute("page", page);		
		model.addAttribute("select", num);
		
		
	}


	
	// 게시물 목록 + 페이징 추가 + 검색
	@RequestMapping(value = "/listPageSearch.do", method = RequestMethod.GET)
	public void getListPageSearch(Model model, @RequestParam("num") int num, 
			@RequestParam(value = "searchType",required = false, defaultValue = "title") String searchType,
			@RequestParam(value = "keyword",required = false, defaultValue = "") String keyword
			) throws Exception {
	
		
		C_Page page = new C_Page();
		
		page.setNum(num);
		page.setCount(service.searchCount(searchType, keyword));
		
		page.setSearchType(searchType);
		page.setKeyword(keyword);
				
		List<C_BoardVO> list = null; 
		list = service.listPageSearch(page.getDisplayPost(), page.getPostNum(), searchType, keyword);
		
		model.addAttribute("list", list);
		model.addAttribute("page", page);
		model.addAttribute("select", num);
		
		
		
	}
	@GetMapping(value="/multiFileUpload.do")
	public String multiFileUpload1() {
		return "list.do";
	}
		
		

}
