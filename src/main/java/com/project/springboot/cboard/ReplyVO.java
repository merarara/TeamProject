package com.project.springboot.cboard;

import java.util.Date;

public class ReplyVO {
	
	/*
	CREATE TABLE c_reply (
    c_rno       NUMBER(10)      NOT NULL,
    c_num       NUMBER(10)      NOT NULL,
    u_id        VARCHAR2(30)    NOT NULL,
    c_content   CLOB            NOT NULL,
    c_regDate   TIMESTAMP       DEFAULT SYSDATE NOT NULL,
    PRIMARY KEY(c_rno, c_num),
    CONSTRAINT fk_c_board_c_num FOREIGN KEY(c_num) REFERENCES c_board(c_num)
);
	*/
	
	private int c_rno;
	private int c_num;
	private String u_id;
	private String c_content;
	private Date c_regDate;
	

	public int getC_rno() {
		return c_rno;
	}
	public void setC_Rno(int c_rno) {
		this.c_rno = c_rno;
	}
	public int getC_num() {
		return c_num;
	}
	public void setC_Num(int c_num) {
		this.c_num = c_num;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getC_content() {
		return c_content;
	}
	public void setC_content(String c_content) {
		this.c_content = c_content;
	}
	public Date getC_regDate() {
		return c_regDate;
	}
	public void setC_regDate(Date c_regDate) {
		this.c_regDate = c_regDate;
	}
}
