package org.oracle.s202501a.dto.ny_dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class Board {
    private Long board_No;
    private Long emp_No; 
    private Timestamp modifiedDate;
    private String content;
    private Timestamp createdDate;
    private String title;
    private int board_Category;
    private int comment_Group;
    private int comment_Indent;
    private int comment_Step;
    private int hits;
    private String emp_Name; 
    
	// 조회용
	private String search;   	   private String keyword;
	private String pageNum;  
	private int start; 		 	   private int end;
	// Page 정보
	private String currentPage;
       
    
}
