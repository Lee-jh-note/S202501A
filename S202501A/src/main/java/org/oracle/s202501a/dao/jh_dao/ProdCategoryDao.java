package org.oracle.s202501a.dao.jh_dao;


import lombok.RequiredArgsConstructor;
import org.oracle.s202501a.dto.jh_dto.CategoriesDto;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import java.util.List;

@Component
public interface ProdCategoryDao {

    void ProdCateCreate(CategoriesDto categoriesDto);

    CategoriesDto ProdCateDetails(CategoriesDto categoriesDto);

    void ProdCateModify(CategoriesDto categoriesDto);

    void ProdCateDelete(CategoriesDto categoriesDto);

    List<CategoriesDto> topFindAll();

    List<CategoriesDto> midFindAll();
}
