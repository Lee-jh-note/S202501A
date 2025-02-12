package org.oracle.s202501a.dao.jh_dao;


import org.oracle.s202501a.dto.jh_dto.CategoriesDto;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface ProdCategoryDao {

    void ProdCateCreate(CategoriesDto categoriesDto);

    CategoriesDto ProdCateDetails(CategoriesDto categoriesDto);

    void ProdCateModify(CategoriesDto categoriesDto);

    void ProdCateDelete(CategoriesDto categoriesDto);

    List<CategoriesDto> topFindAll();

    List<CategoriesDto> midFindAll();

    CategoriesDto findByTop(CategoriesDto categoriesDto);

    void CateDelProdUpdate(CategoriesDto categoriesDto);

    List<CategoriesDto> findMidListByTop(String topCategory);
}
