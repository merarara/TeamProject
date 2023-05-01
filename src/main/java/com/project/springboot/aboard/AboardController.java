package com.project.springboot.aboard;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;

import com.project.springboot.afbService.IAboardService;
import com.project.springboot.afbpageinfo.BpageInfo;
import com.project.springboot.member.UserDTO;
import com.project.springboot.member.UserService;

@Controller 
public class AboardController {
	
	@Autowired
	private MultipartResolver multipartResolver;
	
	//파일업로드 제한 용량(전체파일을 합친 용량) : 10M
	int size = 1024 * 1024 * 10; 
	
	//Mybatis 사용을 위해 자동주입
	@Autowired 
	IAboardService asv;
	
	@Autowired 
	UserService udao;
	
	//회원 목록
	@RequestMapping("/aboard/aboardlist.do") 
	public String aboard1(HttpServletRequest req, Model model) {
		
		int curPage = 1;
		int nPage = 1;
		
		try
		{
			String sPage = req.getParameter("page");
			nPage = Integer.parseInt(sPage);
		}
		catch (Exception e)
		{
			
		}
		
		BpageInfo pinfo = asv.articlePage(nPage);
		model.addAttribute("page", pinfo);
		
		
		//DAO(Mapper)의 select() 메서드를 호출해서 회원목록을 인출 
		model.addAttribute("aboardLists", asv.selectA(nPage));		
		//DAO(Mapper)의 select() 메서드를 호출해서 회원목록을 인출
//		model.addAttribute("aboardLists", asv.selectA()); 
		return "/aboard/aboardlist"; 
	}
	
	@RequestMapping("/aboard/searchAboard.do")
	public String searchAboard(HttpServletRequest request, Model model) {

	    // 검색어와 검색 조건을 파라미터에서 가져옵니다.
	    String searchField = request.getParameter("searchField");
	    String searchWord = request.getParameter("searchWord");
	    
	    // 검색어와 검색 조건을 기준으로 게시글 목록을 조회합니다.
	    List<aboardDTO> aboardLists = asv.searchAboard(searchField, searchWord);
	    
	    // 조회된 게시글 목록을 모델에 담아서 화면으로 전달합니다.
	    model.addAttribute("aboardLists", aboardLists);
	    
	    // 검색 폼을 유지하기 위해 검색어와 검색 조건도 모델에 담아서 전달합니다.
	    model.addAttribute("searchField", searchField);
	    model.addAttribute("searchWord", searchWord);

	    return "/aboard/aboardlist";
	}

	//공지사항 게시글 등록 - get방식인 경우 등록하기 페이지 진입
	@RequestMapping(value="/aboard/aboardwrite.do", method=RequestMethod.GET)
	public String aboard2(Model model) { 
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String u_id = authentication.getName(); 
	    UserDTO udto = udao.selectOne(u_id);
	    model.addAttribute("udto", udto);

	    return "/aboard/aboardwrite"; 
	}

	//post방식인 경우 입력한 FAQ 게시글을 DB처리
	@RequestMapping(value="/aboard/aboardwrite.do", method=RequestMethod.POST)
	public String aboard3(aboardDTO aboardDto, MultipartFile[] user_file, 
			Model model, 
			MultipartHttpServletRequest req) { 
			
		if (multipartResolver.isMultipart(req)) {
			MultipartHttpServletRequest multipartRequest = multipartResolver.resolveMultipart(req);
			String a_title = multipartRequest.getParameter("a_title");
			System.out.println("제목:"+ a_title);
			
			String path = "";
			if (user_file != null) { // user_file이 null인 경우 처리
				for(MultipartFile f: user_file) {
					String originalName = f.getOriginalFilename();
					String ext = originalName.substring(
							originalName.lastIndexOf('.'));
					String uuid = UUID.randomUUID().toString().replaceAll("-", "");
					String savedName = uuid + ext;
					
					try {
						path = ResourceUtils.getFile("classpath:static/uploads/")
								.toPath().toString();
						
						File filePath = new File(path, savedName);
						
						f.transferTo(filePath);
					}
					catch (Exception e) {
						e.printStackTrace();
					}
				}
				System.out.println("uploads폴더:"+ path);
			}
			
			int result = asv.insertA(aboardDto); 
			if(result==1) System.out.println("게시글이 등록되었습니다.");
		} else {
			int result = asv.insertA(aboardDto); 
			if(result==1) System.out.println("게시글이 등록되었습니다.");
		}
		
		return "redirect:/aboard/aboardlist.do"; 
	}
	
	/*
	 * //공지사항 게시글 등록 - get방식인 경우 등록하기 페이지 진입
	 * 
	 * @RequestMapping(value="/aboard/aboardwrite.do", method=RequestMethod.GET)
	 * public String aboard2(Model model) { Authentication authentication =
	 * SecurityContextHolder.getContext().getAuthentication(); String u_id =
	 * authentication.getName(); UserDTO udto = udao.selectOne(u_id);
	 * model.addAttribute("udto", udto);
	 * 
	 * return "/aboard/aboardwrite"; }
	 * 
	 * //post방식인 경우 입력한 FAQ 게시글을 DB처리
	 * 
	 * @RequestMapping(value="/aboard/aboardwrite.do", method=RequestMethod.POST)
	 * public String aboard3(aboardDTO aboardDto) { int result =
	 * asv.insertA(aboardDto); if(result==1) System.out.println("게시글이 등록되었습니다.");
	 * 
	 * return "redirect:/aboard/aboardlist.do"; }
	 */
	
	@RequestMapping(value="/aboard/aboardview.do", method=RequestMethod.GET)
	public String aboard4(HttpServletRequest req, Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String u_id = authentication.getName();
	    UserDTO udto = udao.selectOne(u_id);
		String a_num = req.getParameter("a_num");
	    aboardDTO dto = asv.selectOneA(a_num);
	    model.addAttribute("udto", udto);
	    model.addAttribute("aboardDto", dto);
	    return "aboard/aboardview";
	}
	
	@RequestMapping(value="/aboard/aboardview.do", method=RequestMethod.POST)
	public String aboard5(aboardDTO aboardDto) {
		return "aboard/aboardview";
	}
	
	
	//get방식인 경우 FAQ게시판 수정 페이지
	@RequestMapping(value="/aboard/aboardedit.do", method=RequestMethod.GET)
	public String aboard6(HttpServletRequest req, Model model) { 
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String u_id = authentication.getName();
	    UserDTO udto = udao.selectOne(u_id);
		String a_num = req.getParameter("a_num");
	    aboardDTO dto = asv.selectOneA(a_num);
	    model.addAttribute("udto", udto);
	    // 게시물 번호를 통해 게시물 정보를 조회하여 fboardDto에 담아줌
	    model.addAttribute("aboardDto", dto);
	    
		return "aboard/aboardedit"; 
	} 
	
	//post방식인 경우 레코드를 update
	@RequestMapping(value="/aboard/aboardedit.do", method=RequestMethod.POST)
	public String aboard7(aboardDTO aboardDto, HttpServletRequest req) {
		String a_num = req.getParameter("a_num");
		int result = asv.updateA(aboardDto); 
		if(result==1) System.out.println("수정되었습니다."); 
		
		return "redirect:/aboard/aboardedit.do?a_num=" + aboardDto.getA_num(); 
	} 
	
	@RequestMapping(value="/aboard/aboarddelete.do", method=RequestMethod.GET)
	public String deleteA(@RequestParam("a_num") String a_num) {
	    int result = asv.deleteA(a_num);
	    if (result == 1) {
	      System.out.println("삭제되었습니다.");
	    }
	    return "redirect:/aboard/aboardlist.do";
	}
	
	@RequestMapping("/download.do")
	public void downloadFile(HttpServletRequest req, 
			HttpServletResponse response) 
		throws Exception {

		String oriFile = req.getParameter("oriFile");
		String savedFile = req.getParameter("savedFile");
		
		String path = ResourceUtils
				.getFile("classpath:static/uploads/").toPath().toString();
		File file = new File(path + File.separator + savedFile);

	    try {
	    	FileInputStream fis = new FileInputStream(file);
	        BufferedInputStream bis = new BufferedInputStream(fis);
	        OutputStream out = response.getOutputStream();
	        		
	        response.addHeader("Content-Disposition", 
	        	"attachment;filename=\""+
	        		java.net.URLEncoder.encode(oriFile, "utf-8") +"\"");
	        response.setContentLength((int)file.length());

	        int read = 0;
	        while((read = bis.read()) != -1) {
	            out.write(read);
	        }
	    } 
	    catch(IOException e) {
	        e.printStackTrace();
	    }
	}
	
}