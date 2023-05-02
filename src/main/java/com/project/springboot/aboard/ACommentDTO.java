package com.project.springboot.aboard;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ACommentDTO {
	private int a_num;
	private int ac_num;
	private String u_id;
	private String u_nick; 
	private String ac_comment;
	private Timestamp ac_regdate; 
	private int a_like = 0; // 초기값 0으로 설정
}
