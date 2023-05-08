package com.project.springboot.cboard;
 
import java.sql.Timestamp;
import java.util.List;

import org.springframework.stereotype.Component;

import com.project.springboot.afbService.aboardService;

import lombok.Data;
@Component
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
	private List<upDTO> files; // 파일 목록 추가
    public void setC_like(int c_num, aboardService asv) {
        this.c_like = asv.getLikeCount(c_num);
    }
}
