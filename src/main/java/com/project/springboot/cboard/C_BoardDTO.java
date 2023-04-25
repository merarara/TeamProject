package com.project.springboot.cboard;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class C_BoardDTO {
	
    private int c_num;
    private String c_title;
    private String c_content;
    private int c_visitcount;
    private Date c_postdate;
    private String u_id;
    private MultipartFile c_file;
    private String c_ofile;
    private String c_sfile;
    private int c_downcount;
    private int c_commend;
    
}
