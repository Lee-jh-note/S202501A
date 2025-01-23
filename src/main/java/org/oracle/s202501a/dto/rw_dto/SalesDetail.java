package org.oracle.s202501a.dto.rw_dto;

import lombok.Data;

@Data
public class SalesDetail {
	
    private String sales_Date;
    private int client_No;
    private int product_No;
    private int quantity; 
    private int price;
    private String status;
    private int emp_No;

    
    
	
	

}
