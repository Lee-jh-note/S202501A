package org.oracle.s202501a.dto.yj_dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Purchase {
	// Purchase
	private String purchase_date;
	private int client_no;
	private String title;
	private int emp_no;
	private String status;
	private String req_delivery_date;
	private String remarks;
	
	// Clients - 필요한 정보 거래처이름
	private String client_name;
	
	// Emp - 필요한 정보 사원 이름
	private String emp_name;
	
	// purchase_details - 수량, 가격
	private int quantity;
	private int price;
	
	// product- 제품번호, 제품이름
	private int product_no;
	private String product_name;
	
	// price_history- 매입가 가져오기 위해 (매입매출구분, 가격)이 있어서 매입일 때의 가격을 가져오려면 sale_or_purchase가 1일때의 price를 가져와야함
	private int sale_or_purchase;
	// purchase_details에서 가격을 가져온게 있어서 일단 가격 필드는 안가져옴
	
	// 조회용
	private String search;
	private int product_count;	   private int total_quantity;
	private int total_price;
	private String startDate;	   private String endDate; 
	private int start; 		 	   private int end;
	// 페이징
	private String currentPage;
	
}
