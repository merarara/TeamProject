package com.project.springboot.fboard;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.springboot.afbService.fboardService;
import com.project.springboot.member.UserDTO;
import com.project.springboot.member.UserService;

@Controller
public class fboardController {
	
	//Mybatis 사용을 위해 자동주입
	@Autowired
	@Qualifier("fboardService")
	fboardService fdao;

	@Autowired
	UserService udao;
	
	//회원 목록
	@RequestMapping("/fboard/fboardlist.do")
	public String fboard1(HttpServletRequest request, Model model) {

		//DAO(Mapper)의 select() 메서드를 호출해서 회원목록을 인출 
		model.addAttribute("fboardLists", fdao.selectF());		
		return "/fboard/fboardlist";       
	}
	
	@RequestMapping("/fboard/searchFboard.do")
	public String searchFboard(HttpServletRequest request, Model model) {

	    // 검색어와 검색 조건을 파라미터에서 가져옵니다.
	    String searchField = request.getParameter("searchField");
	    String searchWord = request.getParameter("searchWord");
	    
	    // 검색어와 검색 조건을 기준으로 게시글 목록을 조회합니다.
	    List<fboardDTO> fboardLists = fdao.searchFboard(searchField, searchWord);
	    
	    // 조회된 게시글 목록을 모델에 담아서 화면으로 전달합니다.
	    model.addAttribute("fboardLists", fboardLists);
	    
	    // 검색 폼을 유지하기 위해 검색어와 검색 조건도 모델에 담아서 전달합니다.
	    model.addAttribute("searchField", searchField);
	    model.addAttribute("searchWord", searchWord);

	    return "/fboard/fboardlist";
	}

	//FAQ 게시글 등록 - get방식인 경우 등록하기 페이지 진입	
	@RequestMapping(value="/fboard/fboardwrite.do", method=RequestMethod.GET)
	public String fboard2(Model model) {		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String u_id = authentication.getName();
	    UserDTO udto = udao.selectOne(u_id);
	    model.addAttribute("udto", udto);

		return "fboard/fboardwrite";
	}
	
	//post방식인 경우 입력한 FAQ 게시글을 DB처리  
	@RequestMapping(value="/fboard/fboardwrite.do", method=RequestMethod.POST)
	public String fboard3(fboardDTO fboardDto) {
		int result = fdao.insertF(fboardDto);
		if(result==1) System.out.println("게시글이 등록되었습니다.");
		
		return "redirect:/fboard/fboardlist.do";       
	}
	
	//get방식인 경우 FAQ게시판 수정 페이지
	@RequestMapping(value="/fboard/fboardedit.do", method=RequestMethod.GET)
	public String fboard4(HttpServletRequest req, Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String u_id = authentication.getName();
	    UserDTO udto = udao.selectOne(u_id);
	    model.addAttribute("udto", udto);
	    
	    String f_num = req.getParameter("f_num");
	    
	    // 게시물 번호를 통해 게시물 정보를 조회하여 fboardDto에 담아줌
	    fboardDTO dto = fdao.selectOneF(f_num);
	    model.addAttribute("fboardDto", dto);
	    
		return "fboard/fboardedit";       
	}
	
	//post방식인 경우 레코드를 update 
	@RequestMapping(value="/fboard/fboardedit.do", method=RequestMethod.POST)
	public String fboard5(fboardDTO fboardDto, HttpServletRequest req) {
	    String f_num = req.getParameter("f_num");
	    int result = fdao.updateF(fboardDto);
	    if(result==1) System.out.println("수정되었습니다.");
	    return "redirect:/fboard/fboardedit.do?f_num=" + fboardDto.getF_num();          
	}
	
	
	//회원정보 삭제. post방식으로 들어온 요청만 처리한다.
	@RequestMapping(value="/fboard/fboarddelete.do", method=RequestMethod.POST)
	public String fboard6(fboardDTO fboardDto) {
		System.out.println("delete");
		int result = fdao.deleteF(fboardDto);
		if(result==1) System.out.println("삭제되었습니다.");
		return "redirect:/fboard/fboardlist.do";    
	}	
}
