package com.project.springboot.aboard;

import java.time.format.DateTimeFormatter;

import lombok.Data;

@Data
public class aboardVO {
    private int a_num;
    private String u_id;
    private String u_nick;
    private String a_title;
    private String a_content;
    private String a_regdateStr;

    public aboardVO(aboardDTO dto) {
        this.a_num = dto.getA_num();
        this.u_id = dto.getU_id();
        this.u_nick = dto.getU_nick();
        this.a_title = dto.getA_title();
        this.a_content = dto.getA_content();
        this.a_regdateStr = dto.getA_regdate().toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }
}