package com.project.springboot.member;

import lombok.Data;

@Data
public class UserDTO {
	private Integer U_Num;
	private String U_Id;
	private String U_Pw;
	private String U_Name;
	private String U_Nick;
	private String U_Phone;
	private String U_Email;
	private String U_Zip;
	private String U_Addr1;
	private String U_Addr2;
	private String U_Type;
}
