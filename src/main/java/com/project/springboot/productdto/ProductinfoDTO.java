package com.project.springboot.productdto;

import lombok.Data;

/*
 select f.*, l.p_price, l.p_rdate, l.p_rating
   from product_info f, product_list l
  where f.p_num = l.p_num;
 테이블 join 사용 DTO
 */
@Data
public class ProductinfoDTO {
	private String os;
	private String monitor;
	private String cpu;
	private String ram;
	private String graphic;
	private String storage;
	private String network;
	private String video_io;
	private String terminal;
	private String add_ons;
	private String io;
	private String power;
	private String p_name;
	private String p_imgsrcs;
	private String hz;
	private String etc;
	private int p_num;
	private int p_price;
	private java.sql.Date p_rdate;
	private double p_rating;
	private String r_storage;
}
