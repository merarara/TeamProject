package com.project.springboot.aboard;
 
import java.sql.Timestamp;

import com.project.springboot.afbService.aboardService;

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
	private int a_like = 0; // 초기값 0으로 설정
	
	// Getter와 Setter 메소드 추가
    public int getA_num() {
        return a_num;
    }

    public void setA_num(int a_num) {
        this.a_num = a_num;
    }
    
    // getLikeCount 메서드 호출 결과로 a_like 필드 설정
    public void setA_like(int a_num, aboardService asv) {
        this.a_like = asv.getLikeCount(a_num);
    }
    
    private boolean isLiked;

    public boolean getIsLiked() {
        return isLiked;
    }

    public void setIsLiked(boolean isLiked) {
        this.isLiked = isLiked;
    }
}
