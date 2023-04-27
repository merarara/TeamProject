package com.project.springboot.member;

import lombok.Data;

@Data
public class UserDTO {
    private Integer u_num;
    private String u_id;
    private String u_pw;
    private String u_name;
    private String u_nick;
    // 입력된 전화번호를 하나의 문자열로 저장할 변수
    private String u_phone; 
    private String u_phone1;
    private String u_phone2;
    private String u_phone3;
    private String u_email;
    private String u_zip;
    private String u_addr1;
    private String u_addr2;
    private String u_type;
    private java.sql.Date u_reg;
    private String u_authority;

    // 입력받은 각 필드에 입력 값 합침
	public void setU_phone(String u_phone) {
	    this.u_phone = u_phone;
	    // 입력된 전화번호를 '-'으로 분리하여 변수에 저장합니다.
	    String[] phoneArr = u_phone.split("-");
	    this.u_phone1 = phoneArr[0];
	    this.u_phone2 = phoneArr[1];
	    this.u_phone3 = phoneArr[2];
	}
	
	public String getU_phone() {
	    // '-'으로 연결하여 하나의 문자열로 반환합니다.
	    return u_phone1 + "-" + u_phone2 + "-" + u_phone3;
	
	}
	
	
}