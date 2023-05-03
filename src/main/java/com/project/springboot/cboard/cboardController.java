package com.project.springboot.cboard;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;

import com.project.springboot.afbpageinfo.BpageInfo;
import com.project.springboot.member.UserDTO;
import com.project.springboot.member.UserService;

@Controller 
public class cboardController {
	
	@Autowired
	private MultipartResolver multipartResolver;
	
	//파일업로드 제한 용량(전체파일을 합친 용량) : 10M
	int size = 1024 * 1024 * 10; 
	
	//Mybatis 사용을 위해 자동주입
	@Autowired 
	IboardService asv;
	
	@Autowired 
	UserService udao;
	
	//게시글  목록
	@RequestMapping("/cboard/cboardlist.do") 
	public String cboard(HttpServletRequest req, Model model) {
		
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
		model.addAttribute("cboardLists", asv.select(nPage));		
		//DAO(Mapper)의 select() 메서드를 호출해서 회원목록을 인출
//		model.addAttribute("cboardLists", asv.selectA()); 
		return "/cboard/cboardlist"; 
	}
	
	@RequestMapping("/cboard/searchcboard.do")
	public String searchcboard(HttpServletRequest request, Model model) {

	    // 검색어와 검색 조건을 파라미터에서 가져옵니다.
	    String searchField = request.getParameter("searchField");
	    String searchWord = request.getParameter("searchWord");
	    
	    // 검색어와 검색 조건을 기준으로 게시글 목록을 조회합니다.
	    List<cboardDTO> cboardLists = asv.searchboard(searchField, searchWord);
	    
	    // 조회된 게시글 목록을 모델에 담아서 화면으로 전달합니다.
	    model.addAttribute("cboardLists", cboardLists);
	    
	    // 검색 폼을 유지하기 위해 검색어와 검색 조건도 모델에 담아서 전달합니다.
	    model.addAttribute("searchField", searchField);
	    model.addAttribute("searchWord", searchWord);

	    return "/cboard/cboardlist";
	}

	//get방식인 경우 등록하기 페이지 진입
	@RequestMapping(value="/cboard/cboardwrite.do", method=RequestMethod.GET)
	public String write(Model model) { 
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String u_id = authentication.getName(); 
		UserDTO udto = udao.selectOne(u_id);
		model.addAttribute("udto", udto);

		return "/cboard/cboardwrite"; 
	}

	//post방식인 경우 입력한 게시글을 DB처리
	@RequestMapping(value="/cboard/cboardwrite.do", method=RequestMethod.POST)
	public String write(cboardDTO cboardDto, MultipartFile[] user_file, 
			Model model, 
			MultipartHttpServletRequest req) { 
		
		if (multipartResolver.isMultipart(req)) {
	        MultipartHttpServletRequest multipartRequest = multipartResolver.resolveMultipart(req);
	      //파일외 폼값을 받는다. MultipartHttpServletRequest객체를 사용.	
			String title = req.getParameter("title");
			System.out.println("제목:"+ title);
			
			//파일을 처리한다. 
			String path = "";
			for(MultipartFile f: user_file) {
				//전송된 원본파일명을 얻어온다. 
				String originalName = f.getOriginalFilename();
				//파일명에서 확장자를 잘라낸다. 
				String ext = originalName.substring(
						originalName.lastIndexOf('.'));
				//범용고유식별자를 통해 파일명으로 사용할 문자열 생성
				String uuid = UUID.randomUUID().toString().replaceAll("-", "");
				//문자열을 결합하여 새로운 파일명을 생성한다.
				String savedName = uuid + ext;
				
				try {
					//디렉토리의 물리적 경로
					path = ResourceUtils.getFile("classpath:static/uploads/")
							.toPath().toString();
					//경로와 파일명을 통해 File객체를 생성
					File filePath = new File(path, savedName);
					//해당 경로에 파일을 전송한다. 
					f.transferTo(filePath);
				}
				catch (Exception e) {
					e.printStackTrace();
				}
			}
			System.out.println("uploads폴더:"+ path);
	    } else {
	        // Multipart 요청이 아닌 경우 처리
	    }
		int result = asv.insert(cboardDto); 
		
		
		
		
		if(result==1) System.out.println("게시글이 등록되었습니다.");
		
		return "redirect:/cboard/cboardlist.do"; 
	}
	
	
	@RequestMapping(value="/cboard/cboardview.do", method=RequestMethod.GET)
	public String cboard4(HttpServletRequest req, Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String u_id = authentication.getName();
	    UserDTO udto = udao.selectOne(u_id);
		String c_num = req.getParameter("c_num");
		// 조회수 증가 처리
	    asv.updateVisitCount(c_num);
	    cboardDTO dto = asv.selectOne(c_num);
	    model.addAttribute("udto", udto);
	    model.addAttribute("cboardDto", dto);
	    
	    try {
			String path = ResourceUtils
				.getFile("classpath:static/uploads/").toPath().toString();
			Map<String, Integer> fileMap = new HashMap<String, Integer>();

			File file = new File(path);
			File[] fileArray = file.listFiles();
			for(File f : fileArray){
				//저장된 파일명, 파일 용량을 Map에 저장한다. 
				fileMap.put(f.getName(), (int)Math.ceil(f.length()/1024.0));
			}
			model.addAttribute("fileMap", fileMap);		
		}
		catch (Exception e) {}
		
	    return "cboard/cboardview";
	}
	
	@RequestMapping(value="/cboard/cboardview.do", method=RequestMethod.POST)
	public String cboard5(cboardDTO cboardDto) {
		return "cboard/cboardview";
	}
	
	
	//get방식인 경우 게시판 수정 페이지
	@RequestMapping(value="/cboard/cboardedit.do", method=RequestMethod.GET)
	public String cboard6(HttpServletRequest req, Model model) { 
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String u_id = authentication.getName();
	    UserDTO udto = udao.selectOne(u_id);
		String c_num = req.getParameter("c_num");
	    cboardDTO dto = asv.selectOne(c_num);
	    model.addAttribute("udto", udto);
	    // 게시물 번호를 통해 게시물 정보를 조회하여 boardDto에 담아줌
	    model.addAttribute("cboardDto", dto);
	    
		return "cboard/cboardedit"; 
	} 
	
	//post방식인 경우 레코드를 update
	@RequestMapping(value="/cboard/cboardedit.do", method=RequestMethod.POST)
	public String cboard7(cboardDTO cboardDto, HttpServletRequest req) {
		String c_num = req.getParameter("c_num");
		int result = asv.update(cboardDto); 
		if(result==1) System.out.println("수정되었습니다."); 
		
		return "redirect:/cboard/cboardedit.do?c_num=" + cboardDto.getC_num(); 
	} 
	
	@RequestMapping(value="/cboard/cboarddelete.do", method=RequestMethod.GET)
	public String deleteA(@RequestParam("c_num") String c_num) {
	    int result = asv.delete(c_num);
	    if (result == 1) {
	      System.out.println("삭제되었습니다.");
	    }
	    return "redirect:/cboard/cboardlist.do";
	}
	
	@RequestMapping("cdownload.do")
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
	// 좋아요 기능
	@RequestMapping(value = "/cboard/toggleLike.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> toggleLike(@RequestParam("c_num") int c_num, HttpSession session) {

	    UserDTO user = (UserDTO)session.getAttribute("user");
	    if(user == null) {
	        Map<String, Object> result = new HashMap<String, Object>();
	        result.put("loginRequired", true);
	        return result;
	    }

	    Map<String, Object> result = asv.toggleLike(c_num, user.getU_id());

	    return result;
	}

}
	