package com.project.springboot.productdto;

import lombok.Data;

@Data
public class BOrderinfoDTO {
	private int m_num;
	private String u_id;
	private String u_nick;
	private int p_num;
	private String p_name;
	private int p_price;
	private int bo_qty;
}
