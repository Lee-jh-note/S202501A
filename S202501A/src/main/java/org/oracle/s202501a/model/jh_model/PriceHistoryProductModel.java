package org.oracle.s202501a.model.jh_model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class PriceHistoryProductModel {

    // PriceHistoryModel
    private Long id; // seq
    private Long product_no;
    private String from_date;// 디폴트
    private String to_date; // 디폴트
    private int sale_or_purchase; // 넘
    private int price; // 넘
    private int category;
    private Date reg_date; // 디폴트

    // product
    private String product_name;

    public PriceHistoryProductModel(Long id, Long product_no, String from_date, String to_date,
                                    int sale_or_purchase, int price, Date reg_date, String product_name) {
        this.id = id;
        this.product_no = product_no;
        this.from_date = from_date;
        this.to_date = to_date;
        this.sale_or_purchase = sale_or_purchase;
        this.price = price;
        this.reg_date = reg_date;
        this.product_name = product_name;
    }

//    public PriceHistoryProductModel(Long id, String product_name, Long product_no, String from_date, String to_date,
//                                    int sale_or_purchase, int price, int category, Date reg_date) {
//        this.id = id;
//        this.product_no = product_no;
//        this.from_date = from_date;
//        this.to_date = to_date;
//        this.sale_or_purchase = sale_or_purchase;
//        this.price = price;
//        this.category = category;
//        this.reg_date = reg_date;
//        this.product_name = product_name;
//    }

}
