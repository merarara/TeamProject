package com.project.springboot.aboard;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.springboot.afbService.aboardService;
import com.project.springboot.member.UserDTO;
import com.project.springboot.member.UserService;

@Controller 
public class AboardController {
	
	//파일업로드 제한 용량(전체파일을 합친 용량) : 10M
	int size = 1024 * 1024 * 10; 

	//Mybatis 사용을 위해 자동주입
	@Autowired 
	aboardService asv;
	
	@Autowired 
	UserService udao;
	
	//회원 목록
	@RequestMapping("/aboard/aboardlist.do") 
	public String aboard1(HttpServletRequest req, Model model) {
		//DAO(Mapper)의 select() 메서드를 호출해서 회원목록을 인출
		model.addAttribute("aboardLists", asv.selectA()); 
		return "/aboard/aboardlist"; 
	}

	//공지사항 게시글 등록 - get방식인 경우 등록하기 페이지 진입
	@RequestMapping(value="/aboard/aboardwrite.do", method=RequestMethod.GET)
	public String aboard2(Model model) { 
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String u_id = authentication.getName(); 
		UserDTO udto = udao.selectOne(u_id);
		model.addAttribute("udto", udto);

		return "aboard/aboardwrite"; 
	}

	//post방식인 경우 입력한 FAQ 게시글을 DB처리
	@RequestMapping(value="/aboard/aboardwrite.do", method=RequestMethod.POST)
	public String aboard3(aboardDTO aboardDto) { 
		int result = asv.insertA(aboardDto); 
		if(result==1) System.out.println("게시글이 등록되었습니다.");
		
		return "redirect:/aboard/aboardlist.do"; 
	}
	
	@RequestMapping(value="/aboard/aboardview.do", method=RequestMethod.GET)
	public String aboard4(HttpServletRequest req, Model model) {
	    String a_num = req.getParameter("a_num");
	    aboardDTO dto = asv.selectOneA(a_num);
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
	    model.addAttribute("udto", udto);
	    
	    String a_num = req.getParameter("a_num");
	    
	    // 게시물 번호를 통해 게시물 정보를 조회하여 fboardDto에 담아줌
	    aboardDTO dto = asv.selectOneA(a_num);
	    model.addAttribute("aboardDto", dto);
	    
		return "/aboard/aboardedit"; 
	} 
	
	//post방식인 경우 레코드를 update
	@RequestMapping(value="/aboard/aboardedit.do", method=RequestMethod.POST)
	public String aboard7(aboardDTO aboardDto) { 
		int result = asv.updateA(aboardDto); 
		if(result==1) System.out.println("수정되었습니다."); 
		
		return "redirect:/aboard/aboardview.do"; 
	} 
	
	//회원정보 삭제. post방식으로 들어온 요청만 처리한다.
	@RequestMapping(value="/aboarddelete.do", method=RequestMethod.POST) 
	public String aboard8(aboardDTO aboardDto) { 
		int result = asv.deleteA(aboardDto);
		if(result==1) System.out.println("삭제되었습니다."); 
		return "redirect:list.do"; 
	} 
	
	//파일업로드 폼 매핑
		@GetMapping(value="/multiFileUpload.do")
		public String multiFileUpload1() {
			return "fileUploadForm";
		}

		//폼값처리 및 파일업로드
		/*
		multiFileUpload2(선택한 파일의 name속성을 기술, 
				Model객체 ,	MultipartHttpServletRequest객체)
		즉, file속성의 <input> 태그의 name속성을 통해 여러개의 파일을 
		배열형태로 받게된다. 
		 */
		@PostMapping(value="/multiFileUpload.do")
		@ResponseBody
		public String multiFileUpload2(MultipartFile[] user_file, 
				Model model, 
				MultipartHttpServletRequest req) {
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
					path = ResourceUtils.getFile("classpath:static/aUpload/")
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
			System.out.println("aUpload폴더:"+ path);
			
			return "파일업로드 완료..!!";
		} 
		
		@RequestMapping(value="/fileList.do")
		public String upload4(HttpServletRequest req, Model model) {
			try {
				String path = ResourceUtils
					.getFile("classpath:static/aUpload/").toPath().toString();
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
			
			return "fileList";
		}
		

		@RequestMapping("/download.do")
		public void downloadFile(HttpServletRequest req, 
				HttpServletResponse response) 
			throws Exception {

			String oriFile = req.getParameter("oriFile");
			String savedFile = req.getParameter("savedFile");
			
			String path = ResourceUtils
					.getFile("classpath:static/aUpload/").toPath().toString();
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