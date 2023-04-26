package com.project.springboot.cboard;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


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
	public void getList(Model model) throws Exception {
		
		List<C_BoardVO> list = null; 
		list = service.list();
		model.addAttribute("list", list);		 
	}
	
	// 게시물 작성
	@RequestMapping(value = "/write.do", method = RequestMethod.GET)
	public void getWirte() throws Exception {
		 
	}
	
	// 게시물 작성
	@RequestMapping(value = "/write.do", method = RequestMethod.POST)
	public String postWirte(C_BoardVO vo) throws Exception {
		 service.write(vo);
		 
		 return "redirect:/cboard/list";
	}
	
	// 게시물 조회
	@RequestMapping(value = "/view.do", method = RequestMethod.GET)
	public void getView(@RequestParam("c_num") int c_num, Model model) throws Exception {
		
		C_BoardVO vo = service.view(c_num);
		 
		model.addAttribute("view", vo);
		 
		
		// 댓글 조회
		List<C_ReplyVO> reply = null;
		reply = replyService.list(c_num);
		model.addAttribute("reply", reply);
		
	}
	
	// 게시물 수정
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void getModify(@RequestParam("c_num") int c_num, Model model) throws Exception {

		C_BoardVO vo = service.view(c_num);
		 
		model.addAttribute("view", vo);
	}
	
	// 게시물 수정
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String postModify(C_BoardVO vo) throws Exception {

		service.modify(vo);
		 
		 return "redirect:/view?c_num=" + vo.getC_num();
	}
	
	// 게시물 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String getDelete(@RequestParam("c_num") int c_num) throws Exception {
		
		service.delete(c_num);		

		return "redirect:/board/list";
	} 
	
	
	
	// 게시물 목록 + 페이징 추가
	@RequestMapping(value = "/listPage", method = RequestMethod.GET)
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
	@RequestMapping(value = "/listPageSearch", method = RequestMethod.GET)
	public void getListPageSearch(Model model, @RequestParam("num") int num, 
			@RequestParam(value = "searchType",required = false, defaultValue = "title") String searchType,
			@RequestParam(value = "keyword",required = false, defaultValue = "") String keyword
			) throws Exception {
	
		
		C_Page page = new C_Page();
		
		page.setNum(num);
		//page.setCount(service.count());		
		page.setCount(service.searchCount(searchType, keyword));
		
		// 검색 타입과 검색어
		//page.setSearchTypeKeyword(searchType, keyword);
		page.setSearchType(searchType);
		page.setKeyword(keyword);
				
		List<C_BoardVO> list = null; 
		//list = service.listPage(page.getDisplayPost(), page.getPostNum());
		list = service.listPageSearch(page.getDisplayPost(), page.getPostNum(), searchType, keyword);
		
		model.addAttribute("list", list);
		model.addAttribute("page", page);
		model.addAttribute("select", num);
		
		
		
	}


}
