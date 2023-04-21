package com.project.springboot.jdbc;

import lombok.Data;

@Data
public class ABoard_Comment_DTO {

	private String u_nick;
	private String comm_content;
	private java.sql.Date comm_postdate;
	private int comm_num;
	private String u_id;
	private int a_commend;
	
}
