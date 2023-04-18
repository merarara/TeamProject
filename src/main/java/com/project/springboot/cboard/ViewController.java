package com.project.springboot.cboard;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ViewController {
	@Autowired
	private C_BoardDAO dao;

	@GetMapping("/templates/view/{idx}")
	public ModelAndView view(@PathVariable("idx") String idx, HttpServletRequest request) {
		dao.updateVisitCount(idx);
		C_BoardDTO dto = dao.selectView(idx);
		
		dto.setContent(dto.getContent().replace("\r\n", "<br/>"));
		
		String ext=null, fileName=dto.getSfile();
		if(fileName!=null) {
			ext = fileName.substring(fileName.lastIndexOf(".")+1);			
		}
		String[] mineStr = {"png", "jpg", "gif", "bmp"};
		List<String> mimeList = Arrays.asList(mineStr);
		boolean isImage = false;
		if(mimeList.contains(ext)) {
			isImage = true;
		}
		request.setAttribute("isImage", isImage);
		request.setAttribute("dto", dto);
		return new ModelAndView("/resources/templates/view.html");
	}

}