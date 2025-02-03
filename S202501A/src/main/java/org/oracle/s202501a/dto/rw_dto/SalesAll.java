package org.oracle.s202501a.dto.rw_dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
// 수주 전체 정보(조인 결과, 추가 데이터 포함)
public class SalesAll {
	
    private String sales_Date;        // 매출일자
    private int client_No;         // 거래처코드
    private String title;             // 제목
    private int emp_No;				// 담당자 코드
    private String status;            // 상태
    private String req_Delivery_Date; // 요청배송일
    private String remarks;			// 비고
    
    // 품목 정보 관련 (세부 필드는 SalesProduct dto에 넣음)
    private List<SalesProduct> salesProduct; // 수주 개별 품목
    private List<SalesProduct> productList; // 전체 품목 리스트

    private int product_No;     // 제품번호 
    private String product_Name;// 제품명
    private int price;          // 단가
    private int quantity;       // 수량
    
    // 검색 필터
    private String startDate;  // 조회 시작일
    private String endDate;    // 조회 종료일  

    // 페이징
    private int start;                // 시작 번호
    private int end;                  // 끝 번호
    private String currentPage;       // 현재 페이지    

    // 참조 데이터
    private String client_Name;			// 거래처명
    private String emp_Name;            // 담당자         

    // 상품수 총수량 총금액 (목록 조회용)
    private int count;					// 상품수
    private int totalQuantity;    		// 총수량
    private int totalPrice;				// 총금액 (단가 * 수량)

	}
    
    





    
    

    
    

    


   


