package org.oracle.s202501a.service.jh_service;

import org.oracle.s202501a.entity.jh_entity.PriceHistory;
import org.oracle.s202501a.model.jh_model.PriceHistoryModel;
import org.oracle.s202501a.model.jh_model.PriceHistoryProductModel;
import org.springframework.stereotype.Component;

import java.util.Date;


@Component
public class PriceHistoryMapper {


    public static PriceHistoryModel toModel(PriceHistory priceHistory) {
        return new PriceHistoryModel(priceHistory.getId(), priceHistory.getProduct_no()
                ,priceHistory.getFrom_date(), priceHistory.getTo_date(), priceHistory.getSale_or_purchase()
                , priceHistory.getPrice(), priceHistory.getReg_date());
    }
    public static PriceHistory toEntity(PriceHistoryModel priceHistoryModel) {
        return new PriceHistory(priceHistoryModel.getId(), priceHistoryModel.getProduct_no(),
                priceHistoryModel.getFrom_date(), priceHistoryModel.getTo_date(),
                priceHistoryModel.getSale_or_purchase(), priceHistoryModel.getPrice()
                , priceHistoryModel.getReg_date());
    }
    public static PriceHistoryProductModel toPriceProductFormObj(Object[] row) {
        Long id = (row[0] instanceof Long) ? (Long) row[0] : Long.valueOf((Integer) row[0]);
        Long product_no = (row[1] instanceof Long) ? (Long) row[1] : Long.valueOf((Integer) row[1]);
        String from_date = (String) row[2];
        String to_date = (String) row[3];
        int sale_or_purchase = (int) row[4];
        int price = (int) row[5];
        Date reg_date = (Date) row[6];
        String product_name = (String) row[7];

        // DTO 생성
        return new PriceHistoryProductModel(id, product_no, from_date, to_date,
                sale_or_purchase, price, reg_date, product_name);
    }
}
