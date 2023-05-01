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
}
