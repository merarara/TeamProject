package com.project.springboot.fboard;

import java.time.format.DateTimeFormatter;
import lombok.Data;

@Data
public class fboardVO {
    private int f_num;
    private String u_id;
    private String u_nick;
    private String f_title;
    private String f_content;
    private String f_regdateStr;

    public fboardVO(fboardDTO dto) {
        this.f_num = dto.getF_num();
        this.u_id = dto.getU_id();
        this.u_nick = dto.getU_nick();
        this.f_title = dto.getF_title();
        this.f_content = dto.getF_content();
        this.f_regdateStr = dto.getF_regdate().toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }
}