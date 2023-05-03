package com.project.springboot.aboard;

import java.sql.Timestamp;

import org.apache.ibatis.annotations.Param;

import com.project.springboot.afbService.ACommentService;
import com.project.springboot.afbService.aboardService;

import lombok.Data;

@Data
public class ACommentDTO {
	private int a_num;
	private int ac_num;
	private String u_id;
	private String u_nick; 
	private String ac_comment;
	private Timestamp ac_regdate; 
	private int ac_like = 0; // 초기값 0으로 설정
	
    // getLikeCount 메서드 호출 결과로 a_like 필드 설정
    public void setA_like(int a_num, ACommentService acs) {
        this.ac_like = acs.getLikeCount(a_num);
    }
}
