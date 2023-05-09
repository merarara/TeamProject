package com.project.springboot.productdto;

import lombok.Data;

@Data
public class PSoldInfoDTO {
	private int m_num;
	private int p_num;
	private String p_barcode;
	private java.sql.Date p_sdate;
}
