package com.project.springboot.member;


import lombok.Data;

@Data
public class SnsDTO {
	private String email;
    private String nick;
    private String phone;
    private String zip;
    private String addr1;
    private String addr2;
}
