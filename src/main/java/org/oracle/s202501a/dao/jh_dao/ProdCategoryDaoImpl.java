package org.oracle.s202501a.dao.jh_dao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.jh_dto.CategoriesDto;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
@Slf4j
public class ProdCategoryDaoImpl implements ProdCategoryDao {

    private final SqlSession sqlSession;

    @Override
    public void ProdCateCreate(CategoriesDto categoriesDto) {
        try {
            sqlSession.insert("ProdCateCreate", categoriesDto);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public CategoriesDto ProdCateDetails(CategoriesDto categoriesDto) {
        try {
            return sqlSession.selectOne("ProdCateDetails", categoriesDto);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void ProdCateModify(CategoriesDto categoriesDto) {
        try {
            sqlSession.update("ProdCateModify", categoriesDto);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void ProdCateDelete(CategoriesDto categoriesDto) {
        try {
            sqlSession.delete("ProdCateDelete", categoriesDto);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<CategoriesDto> topFindAll() {
        try {
           return sqlSession.selectList("topFindAll");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<CategoriesDto> midFindAll() {
        try {
            return sqlSession.selectList("midFindAll");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public CategoriesDto findByTop(CategoriesDto categoriesDto) {
        try {
            return sqlSession.selectOne("findByTop", categoriesDto);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void CateDelProdUpdate(CategoriesDto categoriesDto) {
        try {
            sqlSession.update("CateDelProdUpdate", categoriesDto);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}
