package com.project.springboot.cboard;
 
import java.sql.Timestamp;

import lombok.Data;

@Data 
public class cboardDTO { 
	private int c_num; 
	private String u_id;
	private String u_nick; 
	private String c_title; 
	private String c_content;
	private int c_visitcount; 
	private Timestamp c_regdate; 
	private int c_like; // 추가됨
	
}
