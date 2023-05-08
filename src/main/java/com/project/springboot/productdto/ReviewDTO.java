package com.project.springboot.productdto;

import lombok.Data;

@Data
public class ReviewDTO {
	private int r_num;
	private int p_num;
	private String u_id;
	private String u_nick;
	private String p_content;
	private java.sql.Date r_date;
	private double r_rating;
	private int r_good;
}
