package com.project.springboot.oauth2;

import lombok.Data;

@Data
public class SnsDTO {
    private Integer u_num;
    private String u_id;
    private String u_pw;
    private String u_name;
    private String u_nick;
    private String u_phone;
    private String u_zip;
    private String u_addr1;
    private String u_addr2;
    private String u_type;
    private String u_authority;
    private java.sql.Date u_reg;

    public SnsDTO(SessionUser sessionUser) {
        this.u_id = sessionUser.getEmail();
        this.u_name = sessionUser.getName();
        this.u_type = "sns";
    }
}
