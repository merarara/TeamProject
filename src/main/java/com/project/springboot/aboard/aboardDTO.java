package com.project.springboot.aboard;
 
import java.sql.Timestamp;

import lombok.Data;

@Data 
public class aboardDTO { 
	private int a_num; 
	private String u_id;
	private String u_nick; 
	private String a_title; 
	private String a_content;
	private int a_visitcount; 
	private Timestamp a_regdate; 
	
	 // Getter와 Setter 메소드 추가
    public int getA_num() {
        return a_num;
    }

    public void setA_num(int a_num) {
        this.a_num = a_num;
    }
}
