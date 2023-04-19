package com.project.springboot.jdbc;

import lombok.Data;

@Data
public class ABoard_DTO {
	private Integer a_num;
	private String a_title;
	private String a_content;
	private Integer a_visitcount;
	private java.sql.Date a_postdate;
	private String u_id;
	private String u_nick;
	private Integer a_commend;
}