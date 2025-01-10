package org.oracle.s202501a.repository.jh_repository;

import org.oracle.s202501a.entity.jh_entity.PriceHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PriceHistoryRepository extends JpaRepository<PriceHistory, Long> {

    @Query(value = "SELECT h.PRICE_CODE,h.product_no, h.from_date, h.to_date, h.sale_or_purchase, h.price, h.reg_date, p.product_name " +
            "FROM product p " +
            "JOIN price_history h ON p.product_no = h.product_no " +
            "WHERE p.product_name = ?1", nativeQuery = true)
    List<Object[]> findByProductName(String productName);

    @Query(value = "SELECT h.PRICE_CODE, h.product_no, h.from_date, h.to_date, h.sale_or_purchase, h.price, h.reg_date, p.product_name " +
            "FROM product p " +
            "JOIN price_history h ON p.product_no = h.product_no " +
            "WHERE 1=1 " +
            "AND p.product_name = :product_name " +
            "AND h.sale_or_purchase = :sale_or_purchase", nativeQuery = true)
    List<Object[]> findByProdNameType(@Param("product_name") String product_name, @Param("sale_or_purchase") Integer sale_or_purchase);

    @Query(value = "SELECT h.PRICE_CODE, h.product_no, h.from_date, h.to_date, h.sale_or_purchase, h.price, h.reg_date, p.product_name " +
            "FROM product p " +
            "JOIN price_history h ON p.product_no = h.product_no " +
            "WHERE 1=1 " +
            "AND h.sale_or_purchase = :sale_or_purchase", nativeQuery = true)
    List<Object[]> findByProdType(@Param("sale_or_purchase") Integer sale_or_purchase);


    @Procedure(name = "price_prc")
    void price_prc(Long pProductNo, Integer pPrice, Integer pSalePur);

}

