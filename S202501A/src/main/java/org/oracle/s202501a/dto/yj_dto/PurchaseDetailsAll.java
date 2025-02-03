package org.oracle.s202501a.dto.yj_dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PurchaseDetailsAll {

	private String purchase_date;
	private int client_no;
	private int product_no;
	private int quantity;
	private int price;
	private String status;
	private int emp_no;
	
	private String req_delivery_date;
	
	// clients - 거래처 이름
	private String client_name;
	
	// emp - 사원 이름
	private String emp_name;
	
	// product - 제품 이름
	private String product_name;
	
	// 조회용
	private String search;
	private int product_count;	   private int total_quantity;
	private int total_price;
	private String startDate;	   private String endDate;
	private int start; 		 	   private int end;
	// 페이징
	private String currentPage;
}
