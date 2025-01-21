package org.oracle.s202501a.dao.jh_dao;

import org.apache.ibatis.annotations.*;
import org.oracle.s202501a.dto.jh_dto.ProductDto;
import org.oracle.s202501a.dto.jh_dto.ProductPriceDto;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;
import java.util.Objects;

@Component
public interface ProductDao {

    List<ProductDto> ProdFindAll(ProductDto productDto);

    long CreateProd(ProductDto productDto);

    List<ProductPriceDto> ProdDetails(long product_no);

    List<ProductDto> ProdSearch(ProductDto productDto);

    void ProdModify(ProductDto productDto);

    void ProdDelete(long product_no);

    void ProdStatus(List<ProductDto> productDtoList);

    int ProdTotal();

    int ProdSearchTotal(ProductDto productDto);


    List<ProductDto> ProdFindProdNo(List<Long> productNos);

    List<ProductDto> getProdNoName();
}
