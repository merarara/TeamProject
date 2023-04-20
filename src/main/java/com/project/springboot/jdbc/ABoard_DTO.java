package com.project.springboot.jdbc;

import lombok.Data;

@Data
public class ABoard_DTO {
	private int a_num;
	private String a_title;
	private String a_content;
	private int a_visitcount;
	private java.sql.Date a_postdate;
	private String u_id;
	private String u_nick;
	private int a_commend;
}