package org.oracle.s202501a.dao.jh_dao;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.jh_dto.ProductDto;
import org.oracle.s202501a.dto.jh_dto.ProductPriceDto;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class ProductDaoImpl implements ProductDao {

    private final SqlSession sqlSession;

    @Override
    public List<ProductDto> ProdFindAll() {
        try {
            return sqlSession.selectList("ProdFindAll");
        }
        catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }


    @Override
    public long CreateProd(ProductDto productDto) {
        try {
            return sqlSession.insert("CreateProd", productDto);
        }
            catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
            }
    }

    @Override
    public ProductPriceDto ProdDetails(long product_no) {
        try {
            return sqlSession.selectOne("ProdDetails", product_no);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<ProductDto> ProdSearch(ProductDto productDto) {
        try {
            return sqlSession.selectList("ProdSearch", productDto);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void ProdModify(ProductDto productDto) {
        try {
            sqlSession.update("ProdModify", productDto);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}
