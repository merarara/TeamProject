package com.project.springboot.cboard;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class WriteController {

    @Value("${file.upload-dir}")
    String saveDirectory;

    @Autowired
    C_BoardDAO dao;

    @GetMapping("/cboard/Write.do")
    public String writeForm() {
        return "/cboard/Write";
    }

    @PostMapping("/cboard/Write.do")
    @Transactional
    public String write(C_BoardDTO dto, RedirectAttributes redirectAttrs) {
        try {
            dao.insertWrite(dto);
            return "redirect:/cboard/List.do";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttrs.addFlashAttribute("errorMessage", "첨부파일이 제한 용량을 초과합니다.");
            return "redirect:/cboard/Write.do";
        }
    }

    @GetMapping(value="/multiFileUpload.do")
    public String multiFileUpload1() {
        return "fileUploadForm";
    }

    @PostMapping(value="/multiFileUpload.do")
	@ResponseBody
	public String multiFileUpload2(MultipartFile[] user_file, Model model,
			MultipartHttpServletRequest req) {
		String title = req.getParameter("title");
		System.out.println("제목:"+ title);
		
		String path = "";
		for(MultipartFile f: user_file) {			
			String originaName = f.getOriginalFilename();
			String ext = originaName.substring(originaName.lastIndexOf('.'));
			String uuid = UUID.randomUUID().toString().replaceAll("-", "");
			String savedName = uuid + ext;
			try {
				path = ResourceUtils.getFile("classpath:static/uploads/")
						.toPath().toString();
				File filePath = new File(path, savedName);
				f.transferTo(filePath);
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
			System.out.println("uploads폴더:"+ path);
			
			return "파일업로드 완료..!!";
		}
		@RequestMapping(value="/fileList.do")
		public String upload4(HttpServletRequest req, Model model) {
			try {
				String path = ResourceUtils
						.getFile("classpath:static/uploads/").toPath().toString();
				Map<String, Integer> fileMap = new HashMap<String, Integer>();
				File file = new File(path);
				File[] fileArray = file.listFiles();
				for(File f : fileArray) {
					fileMap.put(f.getName(), (int)Math.ceil(f.length()/1024.0));
				}
				model.addAttribute("fileMap", fileMap);			
			} catch (Exception e) {	}
			return "fileList";
		}
		@RequestMapping("/download.do")
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
}
