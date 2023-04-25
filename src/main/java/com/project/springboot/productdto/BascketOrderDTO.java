package com.project.springboot.productdto;

import lombok.Data;

@Data
public class BascketOrderDTO {
	private String u_id;
	private String o_addr;
	private int o_price;
	private int o_qty;
}
