package org.oracle.s202501a.dto.yj_dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Purchase_details {

	private String purchase_date;
	private int client_no;
	private int product_no;
	private int quantity;
	private int price;
	private String status;
	private int emp_no;
}
