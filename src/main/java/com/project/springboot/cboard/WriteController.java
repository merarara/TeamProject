package com.project.springboot.cboard;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class WriteController {
    
    @Value("${file.upload-dir}")
    String saveDirectory;
    
    @Autowired
    C_BoardDAO dao;
    
    @GetMapping("/cboard/Write")
    public String writeForm() {
        return "/cboard/Write";
    }
    
    @GetMapping("/cboard/Write.do")
    @Transactional
    public String write(C_BoardDTO dto, @RequestParam(name="c_ofile", required=false) MultipartFile multipartFile, RedirectAttributes redirectAttrs) {
        try {
            if(multipartFile != null && !multipartFile.isEmpty()) {
                String fileName = multipartFile.getOriginalFilename();
                String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
                String ext= fileName.substring(fileName.lastIndexOf("."));
                String newFileName = now + ext;
                File oldFile = new File(saveDirectory + File.separator + fileName); 
                File newFile = new File(saveDirectory + File.separator + newFileName); 
                oldFile.renameTo(newFile);
                dto.setC_ofile(fileName);
                dto.setC_sfile(newFileName);
            }
            dao.insertWrite(dto);
            return "redirect:/cboard/List";
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage", "첨부파일이 제한 용량을 초과합니다.");
            return "redirect:/cboard/Write";
        }
    }

}
