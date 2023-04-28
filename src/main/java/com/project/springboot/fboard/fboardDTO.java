package com.project.springboot.fboard;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class fboardDTO {
	private int f_num;
	private String u_id;
	private String u_nick;
	private String f_title;
	private String f_content;
	private Timestamp f_regdate;
}

