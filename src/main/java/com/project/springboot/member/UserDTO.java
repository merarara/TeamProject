package com.project.springboot.member;

import lombok.Data;

@Data
public class UserDTO {
	private Integer u_num;
	private String u_id;
	private String u_pw;
	private String u_name;
	private String u_nick;
	private String u_phone;
	private String u_email;
	private String u_zip;
	private String u_addr1;
	private String u_addr2;
	private String u_type;
}
