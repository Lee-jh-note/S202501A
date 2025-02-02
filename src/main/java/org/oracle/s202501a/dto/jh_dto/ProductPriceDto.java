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
public class ProductPriceDto {
    // product
    private Long product_no; // seq
    private String product_name;
    private String description;
    private int status; // 디
    private int category; //
    private int mid_category;
    private int product_delete; // 디
    private Date reg_date; // 디
    private int sale_or_purchase;

 //       select p.product_no, p.product_name, c.TITLE, c.content,
 //       p.status, p.reg_date, h.price, p.description,
 //       h.sale_or_purchase

    // price
    private int sale_price; // 첫 입력 ㅅ ㅣ구분 용도
    private int pur_price; // 첫 입력 시 구분 용도
    private int price; // 조회 용
//    private int category;

    //카테고리
    private String content;
    private String title;

}
