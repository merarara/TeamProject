package com.project.springboot.aboard;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.springboot.jdbc.ABoard_Comment_DTO;
import com.project.springboot.jdbc.ABoard_Comment_Service;
import com.project.springboot.jdbc.ABoard_DTO;
import com.project.springboot.jdbc.ABoard_Service;

@Controller
public class AboardController {

	@Autowired
	ABoard_Service dao;
	@Autowired
	ABoard_Comment_Service dao2;
	
	@RequestMapping("/aboard/aboard_main.do")
	public String aboard_main(Model model) {
		
		
	model.addAttribute("ABoardList", dao.select());
		return "aboard/aboard_main";
	}
	
	@RequestMapping(value="/aboard/aboard_regist.do", method=RequestMethod.GET)
	public String member11() {				 
		return "aboard/aboard_regist";       
	}
	//post방식인 경우 입력한 회원정보를 DB처리  
	@RequestMapping(value="/aboard/aboard_regist.do", method=RequestMethod.POST)
	public String member16(ABoard_DTO aBoardDTO) {
		int result = dao.insert(aBoardDTO);
		if(result==1) System.out.println("입력되었습니다.");
//		return "redirect:faq/faq_main.do";  
		return "redirect:aboard_main.do";   
	}

	@RequestMapping(value="/aboard/aboard_main_detail.do", method=RequestMethod.GET)
	public String member26(HttpServletRequest req, Model model) {
		int a_num = Integer.parseInt(req.getParameter("a_num"));
		ABoard_DTO dto = dao.view(a_num);
		model.addAttribute("ABoardList2", dto);
		
		
		List<ABoard_Comment_DTO> commentDto = dao2.select2(a_num);
	    model.addAttribute("commentList", commentDto);
		
//		return "redirect:faq/faq_main.do";  
		return "aboard/aboard_main_detail";   
	}

	@RequestMapping(value="/aboard/aboard_edit.do", method=RequestMethod.GET)
	public String member23(ABoard_DTO aBoardDTO, Model model) {		
		aBoardDTO = dao.selectOne(aBoardDTO);
		model.addAttribute("dto", aBoardDTO);		
		return "aboard/aboard_edit";       
	}
	//post방식인 경우 레코드를 update 
	@RequestMapping(value="/aboard/aboard_edit.do", method=RequestMethod.POST)
	public String member27(ABoard_DTO aBoardDTO) {		
		int result = dao.update(aBoardDTO);
		if(result==1) System.out.println("수정되었습니다.");
		return "redirect:aboard_main.do";          
	}
	
	@RequestMapping(value="/aboard/aboard_delete.do", method=RequestMethod.GET)
	public String member24(HttpServletRequest req) {
		int a_num = Integer.parseInt(req.getParameter("a_num"));
		int result = dao.delete(a_num);
		if(result==1) System.out.println("삭제되었습니다.");
		return "redirect:aboard_main.do";    
	}	

}
	