package org.oracle.s202501a.dto.rw_dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
// 수주 정보 (Sales 테이블 컬럼)
public class Sales {
	
    private String sales_date; // 매출일자
    private int client_no; // 거래처 코드
    private String title; // 제목
    private String status; // 상태
    private String req_delivery_date; // 요청배송일
    private String remarks; // 비고
    private int emp_no; // 직원(담당자) 번호
	   


}
