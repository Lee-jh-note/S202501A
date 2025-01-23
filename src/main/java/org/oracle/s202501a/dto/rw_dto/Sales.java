package org.oracle.s202501a.dto.rw_dto;

import lombok.Data;

@Data
// 수주 정보 (Sales 테이블 컬럼)
public class Sales {
	
	    private String sales_Date;        // 매출일자
	    private int client_No;         // 거래처코드
	    private String title;             // 제목
	    private int emp_No;				// 담당자코드
	    private String status;            // 상태
	    private String req_Delivery_Date; // 요청배송일
	    private String remarks;           // 비고
	   



}
