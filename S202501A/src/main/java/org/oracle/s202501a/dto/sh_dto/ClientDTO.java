package org.oracle.s202501a.dto.sh_dto;


import lombok.Data;

@Data
public class ClientDTO {
    private int client_No;        
    private int emp_No;           
    private String client_Name;      
    private int client_Type;      
    private String client_Ceo;       
    private String business_No;         
    private String client_Email;      
    private int client_Tel;          
    private int ceo_Tel;            
    private int client_Delete;   
    private String reg_Date;
    private String client_Type_Desc;
    
    // 조회용
    private String search;   	   private String keyword;
	private String pageNum;  
	private int start; 		 	   private int end;
    
	// Page 정보
	private String currentPage;
}
