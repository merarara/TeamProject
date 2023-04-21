package com.project.springboot.cboard;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ViewController {
	@Autowired
	C_BoardDAO dao;
	
	@RequestMapping(value = "/cboard/View.do/{c_num}", method = RequestMethod.GET)
	public ModelAndView view(@PathVariable("c_num") int c_num, HttpServletRequest request) {
		dao.updatec_visitcount(c_num);
		C_BoardDTO dto = dao.selectView(c_num);
		
		dto.setC_content(dto.getC_content().replace("\r\n", "<br/>"));
		
		String ext=null, fileName=dto.getC_ofile();
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
		
		return new ModelAndView("cboard/View");
	}


}