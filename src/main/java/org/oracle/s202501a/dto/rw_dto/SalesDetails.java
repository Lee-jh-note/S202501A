package org.oracle.s202501a.dto.rw_dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
// 수주의 개별 품목들 (Sales_Details 테이블 컬럼들)
public class SalesDetails {
	
    private String sales_date;
    private int client_no;
    private int product_no;
    private int quantity; 
    private int price;
    private String status;
    private int emp_no;


}
