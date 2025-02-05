package org.oracle.s202501a.dao.jh_dao;

import org.oracle.s202501a.dto.jh_dto.ClosingDto;
import org.oracle.s202501a.dto.jh_dto.InventoryDto;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface InventoryDao {

    List<InventoryDto> SearchInvenList(InventoryDto inventoryDto);
    void OptimalModify(InventoryDto inventoryDto);
    void ProdDelQuantModify(Long product_no);

    int SearchCount(InventoryDto inventoryDto);

    void invenCreate(InventoryDto inventoryDto);

    void closing(ClosingDto dto);

    int closingCheck(String yymm);

    InventoryDto InvenFindByProdName(Long prodNo);

    InventoryDto findStockByProdStock(Long prodNo, int stock);

    void quantityModify(InventoryDto inventoryDto);

    int dayClosing(ClosingDto dto);

//    void QuantityModify(InventoryDto dto);
}
