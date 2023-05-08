package com.project.springboot.productdto;

import lombok.Data;

@Data
public class OrderinfoDTO {
	private int m_num;
	private String u_id;
	private String u_nick;
	private String m_addr;
	private int m_price;
	private int m_qty;
	private String m_payment; 
	private java.sql.Date m_bdate;
}
