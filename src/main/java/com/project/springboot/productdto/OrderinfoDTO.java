package com.project.springboot.productdto;

import lombok.Data;

@Data
public class OrderinfoDTO {
	private String u_id;
	private String m_addr;
	private int p_num;
	private int m_price;
	private int m_qty;
	private String p_name;
	private int p_price;
	private int m_num;
	private java.sql.Date m_bdate;
	private String m_payment;
}
