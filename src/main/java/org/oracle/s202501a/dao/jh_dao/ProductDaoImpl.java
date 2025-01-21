package org.oracle.s202501a.dao.jh_dao;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.jh_dto.ProductDto;
import org.oracle.s202501a.dto.jh_dto.ProductPriceDto;


import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
@RequiredArgsConstructor
public class ProductDaoImpl implements ProductDao {

    private final SqlSession sqlSession;

    @Override
    public List<ProductDto> ProdFindAll(ProductDto productDto) {
        try {
            return sqlSession.selectList("ProdFindAll", productDto);
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
    public List<ProductPriceDto> ProdDetails(long product_no) {
        try {
            return sqlSession.selectList("ProdDetails", product_no);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<ProductDto> ProdSearch(ProductDto productDto) {
        System.out.println("다오 임플 서치 내용 : " + productDto);
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

    @Override
    public void ProdDelete(long product_no) {
        try {
            sqlSession.update("ProdDelete", product_no);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void ProdStatus(List<ProductDto> productDtoList) {
        try {
            sqlSession.update("ProdStatus", productDtoList);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public int ProdTotal() {
        try {
            return sqlSession.selectOne("ProdTotal");
        }
        catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public int ProdSearchTotal(ProductDto productDto) {
        try {
            return sqlSession.selectOne("ProdSearchTotal", productDto);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<ProductDto> ProdFindProdNo(List<Long> productNos) {
        try {
            return sqlSession.selectList("ProdFindProdNo", productNos);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<ProductDto> getProdNoName() {
        try {
            return sqlSession.selectList("getProdNoName");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    // 페이징 새로

}
