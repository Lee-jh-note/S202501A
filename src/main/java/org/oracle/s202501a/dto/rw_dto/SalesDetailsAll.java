package org.oracle.s202501a.dto.rw_dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
// 수주 상세 정보 (조인 결과, 추가 데이터 포함)
public class SalesDetailsAll {
	
	// Sales_Details 테이블 (판매 상세)
    private String sales_date; // 매출일자
    private int client_no; // 거래처 코드
    private int product_no; // 제품번호
    private int quantity; // 수량
    private int price; // 단가
    private String status; // 상태
    private int emp_no; // 직원(담당자) 번호

    // Sales 테이블
    private String req_delivery_date; // 요청배송일
    
    // Product 테이블 (수주 품목 정보)    
    private String product_name; // 제품명
    
    // 	private int sale_or_purchase; 판매상세 dto에만????
	
    // Clients 테이블
    private String client_name; // 거래처명
    
    // Emp 테이블
    private String emp_name; // 담당자    
	
    // 검색 필터
    private String startDate; // 조회 시작일
    private String endDate; // 조회 종료일  

    // 페이징
    private int start; // 시작 번호
    private int end; // 끝 번호
    private String currentPage; // 현재 페이지      

    // 조회용
    private int count; // 상품수
    private int totalQuantity; // 총수량
    private int totalPrice;	// 총금액 (단가 * 수량)

}
