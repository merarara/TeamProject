package com.project.springboot.cboard;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class WriteController {
    
    @Value("${file.upload-dir}")
    private String saveDirectory;
    
    @Autowired
    private C_BoardDAO dao;
    
    @GetMapping("/mvcboard/write")
    public String writeForm() {
        return "/14MVCBoard/Write";
    }
    
    @PostMapping("/mvcboard/write/do")
    public String write(C_BoardDTO dto, @RequestParam(name="ofile", required=false) MultipartFile multipartFile, RedirectAttributes redirectAttrs) {
        try {
            if(multipartFile != null && !multipartFile.isEmpty()) {
                String fileName = multipartFile.getOriginalFilename();
                String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
                String ext= fileName.substring(fileName.lastIndexOf("."));
                String newFileName = now + ext;
                File oldFile = new File(saveDirectory + File.separator + fileName); 
                File newFile = new File(saveDirectory + File.separator + newFileName); 
                oldFile.renameTo(newFile);
                dto.setOfile(fileName);
                dto.setSfile(newFileName);
            }
            dao.insertWrite(dto);
            return "redirect:/mvcboard/list";
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage", "첨부파일이 제한 용량을 초과합니다.");
            return "redirect:/mvcboard/write";
        }
    }
}
