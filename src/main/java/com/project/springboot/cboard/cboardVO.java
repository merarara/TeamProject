package com.project.springboot.cboard;

import java.time.format.DateTimeFormatter;

import lombok.Data;

@Data
public class cboardVO {
    private int c_num;
    private String u_id;
    private String u_nick;
    private String c_title;
    private String c_content;
    private String c_regdateStr;

    public cboardVO(cboardDTO dto) {
        this.c_num = dto.getC_num();
        this.u_id = dto.getU_id();
        this.u_nick = dto.getU_nick();
        this.c_title = dto.getC_title();
        this.c_content = dto.getC_content();
        this.c_regdateStr = dto.getC_regdate().toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }
}