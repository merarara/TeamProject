package com.project.springboot.cboard;

import java.sql.Timestamp;

import com.project.springboot.afbService.ACommentService;

import lombok.Data;

@Data
public class CommentDTO {
	private int c_num;
	private int cc_num;
	private String u_id;
	private String u_nick; 
	private String cc_comment;
	private Timestamp cc_regdate; 
	private int cc_like = 0; // 초기값 0으로 설정
	
    // getLikeCount 메서드 호출 결과로 c_like 필드 설정
    public void setc_like(int c_num, ACommentService acs) {
        this.cc_like = acs.getLikeCount(c_num);
    }
}
