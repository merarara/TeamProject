package com.project.springboot.cboard;

import java.sql.Date;

public class C_BoardDTO {
    private String C_num; 
    private String U_ID;
    private String C_title;
    private String C_content;
    private Date C_postdate;
    private String C_ofile; 
    private String C_sfile;
    private int C_downcount;
    private String C_pass;
    private int C_visitcount;
    
	public String getC_num() {
		return C_num;
	}
	public void setC_num(String c_num) {
		C_num = c_num;
	}
	public String getU_ID() {
		return U_ID;
	}
	public void setU_ID(String u_ID) {
		U_ID = u_ID;
	}
	public String getC_title() {
		return C_title;
	}
	public void setC_title(String c_title) {
		C_title = c_title;
	}
	public String getC_content() {
		return C_content;
	}
	public void setC_content(String c_content) {
		C_content = c_content;
	}
	public Date getC_postdate() {
		return C_postdate;
	}
	public void setC_postdate(Date c_postdate) {
		C_postdate = c_postdate;
	}
	public String getC_ofile() {
		return C_ofile;
	}
	public void setC_ofile(String c_ofile) {
		C_ofile = c_ofile;
	}
	public String getC_sfile() {
		return C_sfile;
	}
	public void setC_sfile(String c_sfile) {
		C_sfile = c_sfile;
	}
	public int getC_downcount() {
		return C_downcount;
	}
	public void setC_downcount(int c_downcount) {
		C_downcount = c_downcount;
	}
	public String getC_pass() {
		return C_pass;
	}
	public void setC_pass(String c_pass) {
		C_pass = c_pass;
	}
	public int getC_visitcount() {
		return C_visitcount;
	}
	public void setC_visitcount(int c_visitcount) {
		C_visitcount = c_visitcount;
	}
    
}

    