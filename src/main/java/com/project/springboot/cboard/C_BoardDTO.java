package com.project.springboot.cboard;

import java.sql.Date;

import lombok.Data;

@Data
public class C_BoardDTO {
	
    private int C_num;
    private String C_title;
    private String C_content;
    private int C_visitcount;
    private Date C_postdate;
    private String U_ID;
    private String U_Nick;
    private String C_ofile;
    private String C_sfile;
    private int C_downcount;
    private int C_Commend;
       
}
