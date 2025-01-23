package org.oracle.s202501a.dto.rw_dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
// 수주 품목 정보 (Sales_Detail과 Product 테이블 컬럼 참조)
public class SalesProduct {
	
    private String sales_Date;  // 매출일자 (참조키)
    private int client_No;      // 거래처코드 (참조키)
    private int product_No;     // 제품번호 (참조키)
    private String product_Name;// 제품명
    private int price;          // 단가
    private int quantity;       // 수량
    private int totalPrice;     // 총금액 (단가 * 수량)
}
