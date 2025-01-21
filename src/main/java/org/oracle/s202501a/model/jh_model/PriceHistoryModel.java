package org.oracle.s202501a.model.jh_model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PriceHistoryModel {

    private Long id; // seq
    private Long product_no; // 줌
    private String from_date; // 디
    private String to_date; // 디
    private int sale_or_purchase;     // 넘
    private int price; // 넘
    private int category; // 줌
    private Date reg_date; // 디

    // db 들어가기전 구분
    private Integer sale_price; // 기본 0
    private Integer pur_price; // 기본 0

    //페이징 처리
    private String currentPage;

    private String pageNum;
    private int start;
    private int end;


    public PriceHistoryModel(Long id, Long productNo, String fromDate, String toDate, int saleOrPurchase, int price, int category, Date regDate) {
        this.id = id;
        this.product_no = productNo;
        this.from_date = fromDate;
        this.to_date = toDate;
        this.sale_or_purchase = saleOrPurchase;
        this.price = price;
        this.category = category;
        this.reg_date = regDate;

    }
}
