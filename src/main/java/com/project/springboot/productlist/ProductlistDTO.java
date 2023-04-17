package com.project.springboot.productlist;

import lombok.Data;

@Data
public class ProductlistDTO {
	private String p_name;
	private int p_price;
	private String p_listimg;
	private String p_company;
	private int p_num;
	private double p_rating;
	private int p_count;
}
