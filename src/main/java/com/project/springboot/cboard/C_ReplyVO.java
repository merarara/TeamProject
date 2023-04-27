package com.project.springboot.cboard;

import java.util.Date;

import lombok.Data;
@Data
public class C_ReplyVO {
	
	/*
	CREATE TABLE C_Reply (
    C_rno         NUMBER(10)         NOT NULL,
    C_num         NUMBER(10)         NOT NULL,
    U_ID      VARCHAR2(30)       NOT NULL,
    C_content     CLOB               NOT NULL,
    C_postdate     TIMESTAMP(6)       DEFAULT SYSTIMESTAMP NOT NULL,
    PRIMARY KEY(C_rno, C_num),
    FOREIGN KEY(C_num) REFERENCES C_Board(C_num)
);

CREATE SEQUENCE C_Reply_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER C_Reply
BEFORE INSERT ON C_Reply
FOR EACH ROW
BEGIN
    SELECT C_Reply_seq.NEXTVAL INTO :NEW.C_rno FROM DUAL;
END;

	*/
	
	private int c_rno;
	private int c_num;
	private String u_id;
	private String c_content;
	private Date c_postdate;
	

	
}
