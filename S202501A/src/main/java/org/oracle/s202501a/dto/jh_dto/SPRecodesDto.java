package org.oracle.s202501a.dto.jh_dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class SPRecodesDto {

    private String yymmdd;
    private Long product_no;
    private int sale_or_purchase;
    private int quantity;
    private int price;
    private Long emp_no;
    private Date reg_date;

    // 조인,,,
    private String emp_name;
    private String product_name;
    private String title;

    // 페이징
    private String currentPage;
    private String pageNum;
    private int start;
    private int end;

    // 화면에 출력하기 위한 내용
//    private int saleTotalPrice; // 총 판매 금액
    private int saleQuantity; // 총 판매 수량
    private int salePrice;   // 판매단가
//    private int purTotalPrice; // 총 구매 금액
    private int purQuantity; // 총 구매 수량
    private int purPrice; // 구매 단가
}
