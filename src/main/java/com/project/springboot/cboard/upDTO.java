package com.project.springboot.cboard;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class upDTO {

	private int c_num;
	private String ofile;
	private String sfile;
	private Timestamp postdate;
}
