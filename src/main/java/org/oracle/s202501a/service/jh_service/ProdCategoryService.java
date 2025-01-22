package org.oracle.s202501a.service.jh_service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.dao.jh_dao.ProdCategoryDao;
import org.oracle.s202501a.dto.jh_dto.CategoriesDto;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
@Slf4j
@RequiredArgsConstructor
public class ProdCategoryService {

    private final ProdCategoryDao prodCategoryDao;

    public CategoriesDto ProdCateFindAll() {
        List<CategoriesDto> toplist = prodCategoryDao.topFindAll();
        List<CategoriesDto> midList = prodCategoryDao.midFindAll();
        CategoriesDto dto = new CategoriesDto();
        dto.setTopList(toplist);
        dto.setMidList(midList);
        return dto;

    }

    public void ProdCateCreate(CategoriesDto categoriesDto) {
        prodCategoryDao.ProdCateCreate(categoriesDto);
    }

    public CategoriesDto ProdCateDetails(CategoriesDto categoriesDto) {
        return prodCategoryDao.ProdCateDetails(categoriesDto);
    }


    public void ProdCateModify(CategoriesDto categoriesDto) {
        prodCategoryDao.ProdCateModify(categoriesDto);
    }

    public void ProdCateDelete(CategoriesDto categoriesDto) {
        prodCategoryDao.ProdCateDelete(categoriesDto);
    }
}
