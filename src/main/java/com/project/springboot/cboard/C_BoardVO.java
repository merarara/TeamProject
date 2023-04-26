package com.project.springboot.cboard;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
@Data
public class C_BoardVO {
	
/*
create table C_Board(
    C_num number not null,
    C_title varchar(50) not null,
    C_content varchar2(2000) not null,
    U_ID varchar(30) not null,
    C_postdate date default sysdate not null,
    C_visitcount number(6),
    primary key(C_num)
);
*/
	
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
