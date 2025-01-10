package org.oracle.s202501a.dao.jh_dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.oracle.s202501a.dto.jh_dto.ProductDto;
import org.oracle.s202501a.dto.jh_dto.ProductPriceDto;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface ProductDao {

    List<ProductDto> ProdFindAll();
    long CreateProd(ProductDto productDto);
    ProductPriceDto ProdDetails(long product_no);
    List<ProductDto> ProdSearch(ProductDto productDto);
    void ProdModify(ProductDto productDto);


}
