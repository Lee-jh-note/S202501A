package org.oracle.s202501a.dto.yj_dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Purchase01 {
	// Purchase
	private String purchase_date;
	private int client_no;
	private String title;
	private int emp_no;
	private String status;
	private String req_delivery_date;
	private String remarks;
	
	
	
}
