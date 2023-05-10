package com.project.springboot.cboard;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

import com.project.springboot.afbpageinfo.BpageInfo;
import com.project.springboot.member.UserDTO;
import com.project.springboot.member.UserService;

@Controller 
public class cboardController {
	
	private final Logger log = LoggerFactory.getLogger(getClass());
	@Autowired
	private cboardServiceImpl cboardService;
	
	@Autowired
	private MultipartResolver multipartResolver;
	
	//파일업로드 제한 용량(전체파일을 합친 용량) : 10M
	int size = 1024 * 1024 * 10; 
	
	//Mybatis 사용을 위해 자동주입
	@Autowired 
	IboardService asv;
	
	@Autowired
	private ReplyService replyService;
	
	@Autowired 
	UserService udao;
	
	//게시글  목록
	@RequestMapping("/cboard/cboardlist.do") 
	public String write(HttpServletRequest req, Model model) {
		
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
		model.addAttribute("cboardLists", asv.select(nPage, searchField, searchWord));	
		
		
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
	public String cboard3(cboardDTO cboardDto, MultipartFile[] user_file, 
			Model model, 
			MultipartHttpServletRequest req) { 
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String u_id = authentication.getName();
		
		int result = asv.insert(cboardDto); 
		
		if (!user_file[0].isEmpty()) {
			if (multipartResolver.isMultipart(req)) {
		        MultipartHttpServletRequest multipartRequest = multipartResolver.resolveMultipart(req);
		      //파일외 폼값을 받는다. MultipartHttpServletRequest객체를 사용.	
		        
		        int c_num = asv.uploadnum(cboardDto);
		        System.out.println(c_num);
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
					
					upDTO upDto = new upDTO();
					upDto.setC_num(c_num);
					upDto.setOfile(originalName);
					upDto.setSfile(savedName);
					
					asv.upload(upDto);
				}
				System.out.println("uploas폴더:"+ path);
		    } else {
		        // Multipart 요청이 아닌 경우 처리
		    }
		}
		
		if(result==1) System.out.println("게시글이 등록되었습니다.");
		
		return "redirect:/cboard/cboardlist.do"; 
	}

	
	//게시물 조회 
	@RequestMapping(value="/cboard/cboardview.do", method=RequestMethod.GET)
	public String cboard4(HttpServletRequest req, Model model) throws NumberFormatException, Exception {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String u_id = authentication.getName();
	    UserDTO udto = udao.selectOne(u_id);
		String c_num = req.getParameter("c_num");
		// 조회수 증가 처리
	    asv.updateVisitCount(c_num);
	    cboardDTO dto = asv.selectOne(c_num);
	    model.addAttribute("udto", udto);
	    model.addAttribute("cboardDto", dto);
	    
	    List<upDTO> upDto = asv.uploadview(Integer.parseInt(c_num));
	   //댓글조회 
	    List<ReplyVO> reply = null;
	    reply = replyService.list(Integer.parseInt(c_num));
	    model.addAttribute("reply", reply);
	    
	    for (upDTO e: upDto) {
	    	System.out.println(e.getSfile());
	    }
	    
	    model.addAttribute("upDto", upDto);
	    List<String> up = new ArrayList<String>();
	    
	    try {
			String path = ResourceUtils
				.getFile("classpath:static/uploads/").toPath().toString();

			File file = new File(path);
			File[] fileArray = file.listFiles();
			for(File f : fileArray){
				//저장된 파일명, 파일 용량을 Map에 저장한다. 
				up.add(f.getName());
			}
			model.addAttribute("file", up);		
		}
		catch (Exception e) {}
	    
	    return "cboard/cboardview";
	}
	
	//   상세보기 - post
	@RequestMapping(value="/cboard/cboardview.do", method=RequestMethod.POST)
	public String view(cboardDTO cboardDto) {
		return "cboard/cboardview";
	}

	//수정 페이지 
	@RequestMapping(value="/cboard/cboardedit.do", method=RequestMethod.GET)
	public String update(HttpServletRequest req, Model model, cboardDTO cboardDto) { 
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String u_id = authentication.getName();
	    UserDTO udto = udao.selectOne(u_id);
		String c_num = req.getParameter("c_num");
	    cboardDTO dto = asv.selectOne(c_num);
	    model.addAttribute("udto", udto);
	    // 게시물 번호를 통해 게시물 정보를 조회하여 fboardDto에 담아줌
	    model.addAttribute("cboardDto", dto);
	    
	    List<upDTO> upDto = asv.uploadview(Integer.parseInt(c_num));
	    
	    for (upDTO e: upDto) {
	    	System.out.println(e.getSfile());
	    }
	    
	    model.addAttribute("upDto", upDto);
	    List<String> up = new ArrayList<String>();
	    
	    try {
			String path = ResourceUtils
				.getFile("classpath:static/uploads/").toPath().toString();

			File file = new File(path);
			File[] fileArray = file.listFiles();
			for(File f : fileArray){
				//저장된 파일명, 파일 용량을 Map에 저장한다. 
				up.add(f.getName());
			}
			model.addAttribute("file", up);		
		}
		catch (Exception e) {}
	    
		return "cboard/cboardedit"; 
	} 
		
		
	
	// 게시글 수정 메서드
	@RequestMapping(value="/cboard/cboardedit.do", method=RequestMethod.POST)
	public String update(@RequestParam("c_num") int c_num,cboardDTO cDto, MultipartFile[] user_file, 
	        Model model, 
	        MultipartHttpServletRequest req, HttpServletRequest request) {
	    
	    int result = asv.update(cDto); 
		
		if (user_file != null && !user_file[0].isEmpty()) {
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
			        
			        upDTO upDto = new upDTO();
			        upDto.setC_num(cDto.getC_num());
			        upDto.setOfile(originalName);
			        upDto.setSfile(savedName);
			        
			        asv.upload(upDto);
			    }
			    System.out.println("uploads폴더:"+ path);
			} else {
			    // Multipart 요청이 아닌 경우 처리
			}
		}
		
		String[] files = request.getParameterValues("file");
		if (files != null && files.length > 0) { // 체크된 첨부파일이 있을 경우
		    for (String f : files) {
		        String sfile = req.getParameter("sfile");
		        List<upDTO> fileList = asv.uploadview(c_num);
		        upDTO file = null;
		        if (fileList != null && !fileList.isEmpty()) {
		            file = fileList.get(0);
		        }
		        if (file != null) {
		            // 파일 경로를 가져옵니다.
		        	
		        try {
		        	for (upDTO e: fileList) {
			            String filePath = ResourceUtils.getFile("classpath:static/uploads").toPath().toString();
			            // 파일을 삭제합니다.
			            File deleteFile = new File(filePath, e.getSfile());
			            if (deleteFile.exists()) {
			                deleteFile.delete();
			            }
			        }
		        } catch (Exception e) {
		        	
		        }
		        // 파일 정보를 DB에서 삭제합니다.
		        asv.deleteFile(cDto.getC_num(), f);
		        }
		    }
		}
		
		if(result==1) System.out.println("수정되었습니다."); 
		
		return "redirect:/cboard/cboardview.do?c_num=" + cDto.getC_num();
	} 
	

	
	
//	//게시판 수정 
//	@RequestMapping(value = "/cboard/cboardedit.do", method = RequestMethod.POST)
//	public String update(cboardDTO cboardDto, MultipartFile[] user_file, 
//	    @RequestParam(value = "delete_files", required = false) String[] filesToDelete, 
//	    Model model, HttpServletRequest req) {
//	    int c_num = cboardDto.getC_num();
//	    int result = asv.update(cboardDto, user_file);
//	    
//	    // 기존 첨부파일 정보 가져오기
//	    List<upDTO> existingFiles =asv.getFile(c_num);
//
//	    // 새로운 첨부 파일 추가
//	    if (user_file != null && user_file.length > 0) {
//	        String path = "";
//	        try {
//	            path = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();
//	        } catch (Exception e) {
//	            e.printStackTrace();
//	        }
//	        for (MultipartFile f : user_file) {
//	            String originalName = f.getOriginalFilename();
//	            String ext = originalName.substring(originalName.lastIndexOf('.'));
//	            String uuid = UUID.randomUUID().toString().replaceAll("-", "");
//	            String savedName = uuid + ext;
//	            try {
//	                File filePath = new File(path, savedName);
//	                f.transferTo(filePath);
//	            } catch (Exception e) {
//	                e.printStackTrace();
//	            }
//	            upDTO upDto = new upDTO();
//	            upDto.setC_num(c_num);
//	            upDto.setOfile(originalName);
//	            upDto.setSfile(savedName);
//	            asv.deleteUploadBySfile(upDto); // DB에 추가
//
//	            // 파일 목록에 추가
//	            cboardDto.getFiles().add(upDto);
//	        }
//	    }
//	    
//	 // 첨부 파일 삭제
//	    if (existingFiles != null && existingFiles.size() > 0) {
//	        String path = "";
//	        try {
//	            path = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();
//	        } catch (IOException e) {
//	            e.printStackTrace();
//	        }
//	        for (upDTO fileToDelete : existingFiles) {
//	            if (cboardDto.getFiles().stream().noneMatch(file -> file.getSfile().equals(fileToDelete.getSfile()))) {
//	                String filePath = path + "/" + fileToDelete.getSfile();
//	                File deleteFile = new File(filePath);
//	                if (deleteFile.delete()) {
//	                    System.out.println(filePath + " 파일이 삭제되었습니다.");
//	                } else {
//	                    System.out.println(filePath + " 파일 삭제에 실패하였습니다.");
//	                }
//	                cboardDto.getFiles().removeIf(file -> file.getC_num() == fileToDelete.getC_num()); // 파일 목록에서 삭제
//	                asv.deleteUploadBySfile(fileToDelete.getC_num());
//	                
//	                
//	            }
//	        }
//	    }
//	    return "redirect:/cboard/cboardview.do?c_num=" + c_num;
//	}


	
	// 게시글 삭제 기능
	@RequestMapping(value="/cboard/cboarddelete.do", method=RequestMethod.GET)
	public String delete(@RequestParam("c_num") String c_num) {
	    int result = asv.delete(c_num);
	    if (result == 1) {
	        System.out.println("삭제되었습니다.");
	    }
	    return "redirect:/cboard/cboardlist.do";
	}
	
	
	// 첨부파일 다운로드
	@RequestMapping("/cboard/download.do")
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
//	
//	// 좋아요 기능
//	@PostMapping("/cboard/like.do")
//	public String addLike(HttpServletRequest req, HttpSession session) {
//	    int c_num = Integer.parseInt(req.getParameter("c_num"));
//	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//	    String u_id = authentication.getName(); // 사용자 id
//
//	    if (u_id == null) {
//	        return "redirect:/auth/login.do";
//	    }
//
//	    boolean isLiked = asv.checkLiked(c_num, u_id);
//
//	    if (!isLiked) { // 좋아요를 누르지 않은 경우에만 등록
//	        int result = asv.addLike(c_num, u_id);
//	        if (result == 1) {
//	            int c_like = asv.getLikeCount(c_num);
//	            return "redirect:/cboard/cboardview.do?c_num=" + c_num;
//	        }
//	    }
//
//	    return "redirect:/cboard/cboardview.do?c_num=" + c_num;
//	}
	 
	// 좋아요 기능
	@PostMapping("/cboard/like.do")
	public String addLike(HttpServletRequest req, HttpSession session, Model model) {
	    int c_num = Integer.parseInt(req.getParameter("c_num"));
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String u_id = authentication.getName();

	    if (u_id == null) {
	        return "redirect:/auth/login.do";
	    }

	    try {
	        asv.insertLike(c_num, u_id);
	    } catch (DuplicateKeyException e) {
	        // 이미 좋아요가 추가된 경우, 무시하고 계속 진행합니다.
	    }

	    // 좋아요 개수 추가
	    asv.addlike(c_num);

	    // 수정된 좋아요 개수를 가져와서 모델에 추가합니다.
	    int c_like = asv.getLikeCount(c_num);
	    cboardDTO dto = asv.selectOne(c_num);
	    dto.setC_like(c_like);
	    model.addAttribute("cboardDto", dto);

	    return "redirect:/cboard/cboardview.do?c_num=" + c_num;
	}

		 
		// 싫어요 기능
		@PostMapping("/cboard/unlike.do")
		public String removeLike(HttpServletRequest req, HttpSession session, Model model) {
			int c_num = Integer.parseInt(req.getParameter("c_num"));
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	        String u_id = authentication.getName(); // 사용자 id
		    if (u_id == null) {
		    	// 로그인하지 않은 경우 처리
		         return "redirect:/user/login.do";
		    } else {
		        // 좋아요 정보를 삭제한다.
		    	asv.minlike(c_num);
		        // 게시글의 좋아요 수를 갱신한다.
		        int c_like = asv.getLikeCount(c_num);
			    cboardDTO dto = asv.selectOne(c_num);
			    dto.setC_like(c_like);
			    model.addAttribute("cboardDto", dto);
			    
		        return "redirect:/cboard/cboardview.do?c_num=" + c_num;
		    }
		}
		
		@PostMapping("/cboard/checkLike.do")
		@ResponseBody
		public boolean checkLike(HttpServletRequest request, HttpServletResponse response) throws Exception {
		    int c_num = Integer.parseInt(request.getParameter("c_num"));
		    String u_id = (String) request.getSession().getAttribute("userId");

		    boolean result = asv.checkLike(c_num, u_id);

		    return result;
		}


		

}
	