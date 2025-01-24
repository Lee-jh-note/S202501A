package org.oracle.s202501a.dao.jh_dao;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.jh_dto.ClosingDto;
import org.oracle.s202501a.dto.jh_dto.InventoryDto;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class InventoryDaoImpl implements InventoryDao {

    private final SqlSession sqlSession;


    @Override
    public List<InventoryDto> SearchInvenList(InventoryDto inventoryDto) {
        try {
            return sqlSession.selectList("SearchInvenList", inventoryDto);

        }catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void OptimalModify(InventoryDto inventoryDto) {
        try {
            sqlSession.update("OptimalModify", inventoryDto);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void ProdDelQuantModify(Long product_no) {
        try {
            sqlSession.update("ProdDelQuantModify", product_no) ;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }


    @Override
    public int SearchCount(InventoryDto inventoryDto) {
        try {
            return sqlSession.selectOne("SearchCount", inventoryDto);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void invenCreate(InventoryDto inventoryDto) {
        try {
            sqlSession.insert("invenCreate", inventoryDto);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void closing(ClosingDto dto) {
        try {
            sqlSession.update("closing", dto);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public int closingCheck(String yymm) {
        try {
            return sqlSession.selectOne("closingCheck", yymm);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    public InventoryDto InvenFindByProdName(Long prodNo) {
        try {
            return sqlSession.selectOne("InvenFindByProdName", prodNo);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

//    @Override
//    public void QuantityModify(InventoryDto dto) {
//        try {
//            sqlSession.update("QuantityModify", dto);
//        } catch (Exception e) {
//            e.printStackTrace();
//            throw new RuntimeException(e);
//        }
//    }
}
