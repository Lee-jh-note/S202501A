package org.oracle.s202501a.dto.jh_dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.oracle.s202501a.model.jh_model.PriceHistoryProductModel;

import java.util.List;

@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class PricePagingDto {
    private List<PriceHistoryProductModel> list;
    private PagingJH page;

}
