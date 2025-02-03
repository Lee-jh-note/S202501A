package org.oracle.s202501a.dto.jh_dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;

@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class ProdCatePagingDto {

    List<ProductDto> productList;
    List<CategoriesDto> CategoriesList;
    private PagingJH pagingJH;

}
