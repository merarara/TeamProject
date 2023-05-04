package com.project.springboot.aboard;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class AupDTO {

	private int a_num;
	private String ofile;
	private String sfile;
	private Timestamp postdate;
}
