package com.project.springboot.aboard;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import com.project.springboot.afbService.IACommentService;
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
	IACommentService acs;
	
	@Autowired 
	UserService udao;
	
	//공지사항 게시글 목록
	@RequestMapping("/aboard/aboardlist.do") 
	public String aboard1(HttpServletRequest req, Model model) {
		
		int curPage = 1;
		int nPage = 1;
		
	    // 검색어와 검색 조건을 파라미터에서 가져옵니다.
	    String searchField = req.getParameter("searchField");
	    String searchWord = req.getParameter("searchWord");
	    
	    // 검색 폼을 유지하기 위해 검색어와 검색 조건도 모델에 담아서 전달합니다.
	    model.addAttribute("searchField", searchField);
	    model.addAttribute("searchWord", searchWord);
		
		try
		{
			String sPage = req.getParameter("page");
			nPage = Integer.parseInt(sPage);
		}
		catch (Exception e)
		{
			
		}
		
		BpageInfo pinfo = asv.articlePage(nPage, searchField, searchWord);
		model.addAttribute("page", pinfo);
		
		//DAO(Mapper)의 select() 메서드를 호출해서 회원목록을 인출 
		model.addAttribute("aboardLists", asv.selectA(nPage, searchField, searchWord));	
		
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

	// 공지사항 게시글 등록 - post방식인 경우 입력한 FAQ 게시글을 DB처리
	@RequestMapping(value="/aboard/aboardwrite.do", method=RequestMethod.POST)
	public String aboard3(aboardDTO aboardDto, MultipartFile[] user_file, 
			Model model, 
			MultipartHttpServletRequest req) { 
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String u_id = authentication.getName();
		
		int result = asv.insertA(aboardDto); 
		int a_num = asv.uploadnum(aboardDto);
		if (!user_file[0].isEmpty()) {
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
					
					AupDTO aupDto = new AupDTO();
					aupDto.setA_num(a_num);
					aupDto.setOfile(originalName);
					aupDto.setSfile(savedName);
					
					asv.upload(aupDto);
				}
				System.out.println("aUpload폴더:"+ path);
		    } else {
		        // Multipart 요청이 아닌 경우 처리
		    }
		}
		
		if(result==1) System.out.println("게시글이 등록되었습니다.");
		
		return "redirect:/aboard/aboardlist.do"; 
	}

	// 공지사항 상세글 - get방식
	@RequestMapping(value="/aboard/aboardview.do", method=RequestMethod.GET)
	public String aboard4(HttpServletRequest req, Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String u_id = authentication.getName();
	    UserDTO udto = udao.selectOne(u_id);
		String a_num = req.getParameter("a_num");
		
		// 조회수 증가 처리
		 asv.updateVisitCount(a_num);
	    
	    aboardDTO dto = asv.selectOneA(a_num);
	    model.addAttribute("udto", udto);
	    model.addAttribute("aboardDto", dto);
	    
	    List<ACommentDTO> acList = acs.selectAnum(a_num);
	    model.addAttribute("acList", acList);
	    
	    List<AupDTO> aupDto = asv.uploadview(Integer.parseInt(a_num));
	    
	    for (AupDTO e: aupDto) {
	    	System.out.println(e.getSfile());
	    }
	    
	    
	    model.addAttribute("aupDto", aupDto);
	    List<String> aup = new ArrayList<String>();
	    
	    try {
			String path = ResourceUtils
				.getFile("classpath:static/aUpload/").toPath().toString();

			File file = new File(path);
			File[] fileArray = file.listFiles();
			for(File f : fileArray){
				//저장된 파일명, 파일 용량을 Map에 저장한다. 
				aup.add(f.getName());
			}
			model.addAttribute("file", aup);		
		}
		catch (Exception e) {}
	    
	    return "aboard/aboardview";
	}

	
	// 공지사항 상세보기 - post
	@RequestMapping(value="/aboard/aboardview.do", method=RequestMethod.POST)
	public String aboard5(aboardDTO aboardDto) {
		return "aboard/aboardview";
	}
	
	
	// 공지사항 게시글 수정 페이지 - get방식
	@RequestMapping(value="/aboard/aboardedit.do", method=RequestMethod.GET)
	public String aboard6(HttpServletRequest req, Model model, aboardDTO aboardDto) { 
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String u_id = authentication.getName();
	    UserDTO udto = udao.selectOne(u_id);
		String a_num = req.getParameter("a_num");
	    aboardDTO dto = asv.selectOneA(a_num);
	    model.addAttribute("udto", udto);
	    // 게시물 번호를 통해 게시물 정보를 조회하여 fboardDto에 담아줌
	    model.addAttribute("aboardDto", dto);
	    
	    List<AupDTO> aupDto = asv.uploadview(Integer.parseInt(a_num));
	    
	    for (AupDTO e: aupDto) {
	    	System.out.println(e.getSfile());
	    }
	    
	    model.addAttribute("aupDto", aupDto);
	    List<String> aup = new ArrayList<String>();
	    
	    try {
			String path = ResourceUtils
				.getFile("classpath:static/aUpload/").toPath().toString();

			File file = new File(path);
			File[] fileArray = file.listFiles();
			for(File f : fileArray){
				//저장된 파일명, 파일 용량을 Map에 저장한다. 
				aup.add(f.getName());
			}
			model.addAttribute("file", aup);		
		}
		catch (Exception e) {}
	    
		return "aboard/aboardedit"; 
	} 
	
	// 공지사항 게시글 수정 페이지 - post방식인 경우 레코드를 update
	@RequestMapping(value="/aboard/aboardedit.do", method=RequestMethod.POST)
	public String aboard7(aboardDTO aboardDto, MultipartFile[] user_file, 
			Model model, 
			MultipartHttpServletRequest req, HttpServletRequest request) {
		int a_num = Integer.parseInt(req.getParameter("a_num"));
		aboardDto = asv.selectOneA(String.valueOf(a_num));
		
		
		if (!user_file[0].isEmpty()) {
			if (multipartResolver.isMultipart(req)) {
			    MultipartHttpServletRequest multipartRequest = multipartResolver.resolveMultipart(req);
			    //파일외 폼값을 받는다. MultipartHttpServletRequest객체를 사용.	
			    a_num = asv.uploadnum(aboardDto);
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
			        
			        AupDTO aupDto = new AupDTO();
			        aupDto.setA_num(a_num);
			        aupDto.setOfile(originalName);
			        aupDto.setSfile(savedName);
			        
			        asv.upload(aupDto);
			    }
			    System.out.println("aUpload폴더:"+ path);
			} else {
			    // Multipart 요청이 아닌 경우 처리
			}
		}
		
		String[] files = request.getParameterValues("file");
		if (files != null && files.length > 0) { // 체크된 첨부파일이 있을 경우
		    for (String f : files) {
		        String sfile = req.getParameter("sfile");
		        List<AupDTO> fileList = asv.uploadview(a_num);
		        AupDTO file = null;
		        if (fileList != null && !fileList.isEmpty()) {
		            file = fileList.get(0);
		        }
		        if (file != null) {
		            // 파일 경로를 가져옵니다.
		        	
		        try {
		        	for (AupDTO e: fileList) {
			            String filePath = ResourceUtils.getFile("classpath:static/aUpload").toPath().toString();
			            // 파일을 삭제합니다.
			            File deleteFile = new File(filePath, e.getSfile());
			            if (deleteFile.exists()) {
			                deleteFile.delete();
			            }
			        }
		        } catch (Exception e) {
		        	
		        }
		        // 파일 정보를 DB에서 삭제합니다.
		        asv.deleteFile(a_num, f);
		        }
		    }
		}
		int result = asv.updateA(aboardDto); 
		if(result==1) {
			
			System.out.println("수정되었습니다."); 
		}
		
		return "redirect:/aboard/aboardedit.do?a_num=" + aboardDto.getA_num(); 
	} 
	
	// 공지사항 게시글 삭제 기능
	@RequestMapping(value="/aboard/aboarddelete.do", method=RequestMethod.GET)
	public String deleteA(@RequestParam("a_num") String a_num, Model model, aboardDTO aboardDto) {
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String u_id = authentication.getName();
	    UserDTO udto = udao.selectOne(u_id);
	    model.addAttribute("udto", udto);
	    aboardDto.setU_id(u_id);
	    System.out.println(u_id);
	    Map<String, Object> params = new HashMap<>();
	    params.put("a_num", a_num);
	    params.put("u_id", u_id);
	    asv.deleteFileAll(a_num);
	    asv.deleteAcAll(a_num);
	    int result = asv.deleteA(params);

	    if (result == 1) {
	        System.out.println("삭제되었습니다.");
	    }
	    return "redirect:/aboard/aboardlist.do";
	}
	
	// 첨부파일 다운로드
	@RequestMapping("/aboard/download.do")
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
	
	// 좋아요 기능
	@PostMapping("/aboard/like.do")
	public String addLike(HttpServletRequest req, HttpSession session) {
	    int a_num = Integer.parseInt(req.getParameter("a_num"));
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String u_id = authentication.getName();

	    if (u_id == null) {
	        return "redirect:/auth/login.do";
	    }

	    try {
	        asv.addLike(a_num, u_id);
	    } catch (DuplicateKeyException e) {
	        // 이미 좋아요가 추가된 경우, 무시하고 계속 진행합니다.
	    }
	    
	    int a_like = asv.getLikeCount(a_num);
	    return "redirect:/aboard/aboardview.do?a_num=" + a_num;
	}
	 
	// 싫어요 기능
	@PostMapping("/aboard/unlike.do")
	public String removeLike(HttpServletRequest req, HttpSession session) {
		int a_num = Integer.parseInt(req.getParameter("a_num"));
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String u_id = authentication.getName(); // 사용자 id
	    if (u_id == null) {
	    	// 로그인하지 않은 경우 처리
	         return "redirect:/user/login.do";
	    } else {
	        // 좋아요 정보를 삭제한다.
	        asv.removeLike(a_num, u_id);
	        // 게시글의 좋아요 수를 갱신한다.
	        int a_like = asv.getLikeCount(a_num);
	        return "redirect:/aboard/aboardview.do?a_num=" + a_num;
	    }
	}
	
	@PostMapping("/aboard/checkLike.do")
	@ResponseBody
	public boolean checkLike(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    int a_num = Integer.parseInt(request.getParameter("a_num"));
	    String u_id = (String) request.getSession().getAttribute("userId");

	    boolean result = asv.checkLike(a_num, u_id);

	    return result;
	}
	
}
	