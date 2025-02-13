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

    public CategoriesDto prodCateFindAll() {
        List<CategoriesDto> toplist = prodCategoryDao.topFindAll();
        List<CategoriesDto> midList = prodCategoryDao.midFindAll();
        CategoriesDto dto = new CategoriesDto();
        dto.setTopList(toplist);
        dto.setMidList(midList);
        return dto;

    }

    public void prodCateCreate(String newMidCategory, String newTopCategory) {
        CategoriesDto dto = new CategoriesDto();
        dto.setTitle(newTopCategory);
        dto.setContent(newMidCategory);
        prodCategoryDao.ProdCateCreate(dto);
        System.out.println(dto);
    }

    public CategoriesDto prodCateDetails(CategoriesDto categoriesDto) {
        if (categoriesDto.getMid_category() == 0) {
            return prodCategoryDao.findByTop(categoriesDto);
        }
        return prodCategoryDao.ProdCateDetails(categoriesDto);
    }


    public void prodCateModify(CategoriesDto categoriesDto) {

        prodCategoryDao.ProdCateModify(categoriesDto);
    }

    public void prodCateDelete(CategoriesDto categoriesDto) {

        prodCategoryDao.ProdCateDelete(categoriesDto);
        prodCategoryDao.CateDelProdUpdate(categoriesDto);
    }

    public void addMidCategory(String category, String newSubCategory) {

    }

    public void prodCateCreateMid(CategoriesDto dto) {
//        System.out.println("서비스 :" + dto);
        prodCategoryDao.ProdCateCreate(dto);
    }

    public List<CategoriesDto> findMidListByTop(String topCategory) {

      return prodCategoryDao.findMidListByTop(topCategory);
    }
}
