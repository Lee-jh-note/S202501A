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
public class InventoryDto {

    private String yymm; // 년월
    private Long product_no; // 제품코드
    private int stock_type; // 0 : 기초 1 : 기말
    private int quantity;
    private int optimal_quantity;
    private Date reg_date;

    // 가격 구분
    private int pur_price;
    private int sale_price;

    // 기초 기말 구분
    private int beginning;
    private int closing;

    //페이징 처리
    private String currentPage;

    private String pageNum;
    private int start;
    private int end;


    private String product_name;

    private String content;
    private String title;
}
