package com.project.springboot.faq;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.springboot.jdbc.FBoard_DTO;
import com.project.springboot.jdbc.FBoard_Service;

@Controller
public class FlistController {

	@Autowired
	FBoard_Service dao;
	
	@RequestMapping("/faq/faq_main.do")
	public String faq_main(Model model) {
		model.addAttribute("FBoardList", dao.select());
		return "faq/faq_main";
	}
	
	@RequestMapping("/faq/faq_modify.do")
	public String faq_modify() {
		return "faq/faq_modify";
	}
	
	@RequestMapping(value="/faq/faq_regist.do", method=RequestMethod.GET)
	public String member1() {				 
		return "faq/faq_regist";       
	}
	//post방식인 경우 입력한 회원정보를 DB처리  
	@RequestMapping(value="/faq/faq_regist.do", method=RequestMethod.POST)
	public String member6(FBoard_DTO fBoardDTO) {
		int result = dao.insert(fBoardDTO);
		if(result==1) System.out.println("입력되었습니다.");
//		return "redirect:faq/faq_main.do";  
		return "redirect:faq_main.do";   
	}

	@RequestMapping(value="/faq/faq_edit.do", method=RequestMethod.GET)
	public String member3(FBoard_DTO fBoardDTO, Model model) {		
		fBoardDTO = dao.selectOne(fBoardDTO);
		model.addAttribute("dto", fBoardDTO);		
		return "faq/faq_edit";       
	}
	//post방식인 경우 레코드를 update 
	@RequestMapping(value="/faq/faq_edit.do", method=RequestMethod.POST)
	public String member7(FBoard_DTO fBoardDTO) {		
		int result = dao.update(fBoardDTO);
		if(result==1) System.out.println("수정되었습니다.");
		return "redirect:faq_main.do";          
	}

	@RequestMapping(value="/faq/faq_delete.do", method=RequestMethod.GET)
	public String member4(HttpServletRequest req) {
		int f_num = Integer.parseInt(req.getParameter("f_num"));
		int result = dao.delete(f_num);
		if(result==1) System.out.println("삭제되었습니다.");
		return "redirect:faq_main.do";    
	}	
	
}
