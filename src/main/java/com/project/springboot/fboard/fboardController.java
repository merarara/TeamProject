package com.project.springboot.fboard;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
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
	fboardService fdao;
	
	@Autowired
	UserService udao;
	
	//회원 목록
	@RequestMapping("/fboard/fboardlist.do")
	public String fboard1(HttpServletRequest request, Model model) {
		int count = fdao.selectCount(); // 게시물 총 개수
		int pagePerCount = 5; // 한 페이지에 보여질 게시물 수
		int totalPage = (int) Math.ceil((double) count / pagePerCount); // 총 페이지 수
		int pageNum = 1; // 현재 페이지 번호
		if (request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		int startRow = (pageNum - 1) * pagePerCount + 1; // 시작 게시물 번호
		int endRow = pageNum * pagePerCount; // 끝 게시물 번호
		
		model.addAttribute("fboardLists", fdao.selectFboardListByRange(startRow, endRow)); // 현재 페이지에 보여줄 게시물 목록
		model.addAttribute("totalPage", totalPage); // 총 페이지 수
		model.addAttribute("currentPage", pageNum); // 현재 페이지 번호

		// 페이지 그룹에 대한 정보 계산
		int pageGroupSize = 5; // 페이지 그룹의 크기
		int startPageGroup = (int) Math.floor((double) (pageNum - 1) / pageGroupSize) * pageGroupSize + 1; // 페이지 그룹의 시작 페이지 번호
		int endPageGroup = startPageGroup + pageGroupSize - 1; // 페이지 그룹의 끝 페이지 번호
		if (endPageGroup > totalPage) { // 마지막 페이지 그룹의 끝 페이지 번호가 총 페이지 수를 넘으면 안됨
			endPageGroup = totalPage;
		}

		model.addAttribute("startPageGroup", startPageGroup); // 페이지 그룹의 시작 페이지 번호
		model.addAttribute("endPageGroup", endPageGroup); // 페이지 그룹의 끝 페이지 번호
		
		//DAO(Mapper)의 select() 메서드를 호출해서 회원목록을 인출 
//		model.addAttribute("fboardLists", fdao.selectF());		
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
