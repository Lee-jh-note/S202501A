package org.oracle.s202501a.repository.jh_repository;

import org.oracle.s202501a.entity.jh_entity.PriceHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PriceHistoryRepository extends JpaRepository<PriceHistory, Long> {

    @Query(value = "select * from " +
            "(SELECT h.PRICE_CODE,h.product_no, h.from_date, h.to_date, h.sale_or_purchase, h.price, h.reg_date, p.product_name, rownum rm " +
            "FROM product p " +
            "JOIN price_history h ON p.product_no = h.product_no " +
            "WHERE p.product_name like '%' || ?1 || '%' " +
            "and p.PRODUCT_DELETE = 0 " +
            "order by h.to_date desc, h.FROM_DATE desc )" +
            "WHERE rm between ?2 and ?3", nativeQuery = true)
    List<Object[]> findByProductName(String productName, int start, int end);

    @Query(value = "select count(*) from " +
            "(SELECT h.PRICE_CODE,h.product_no, h.from_date, h.to_date, h.sale_or_purchase, h.price, h.reg_date, p.product_name, rownum rm " +
            "FROM product p " +
            "JOIN price_history h ON p.product_no = h.product_no " +
            "WHERE p.product_name like '%' || ?1 || '%' " +
            "and p.PRODUCT_DELETE = 0 " +
            "order by h.to_date desc, h.FROM_DATE desc )", nativeQuery = true)
    int countByProductName(String productName);

    @Query(value = "select * from " +
            "(SELECT h.PRICE_CODE, h.product_no, h.from_date, h.to_date, h.sale_or_purchase, h.price, h.reg_date, p.product_name, rownum rm " +
            "FROM product p " +
            "JOIN price_history h ON p.product_no = h.product_no " +
            "WHERE 1=1 " +
            "AND p.product_name LIKE '%' || :product_name || '%' " +
            "AND h.sale_or_purchase = :sale_or_purchase " +
            "and p.PRODUCT_DELETE = 0 " +
            "order by h.TO_DATE desc, h.FROM_DATE desc ) " +
            "where rm between :start and :end ", nativeQuery = true)
    List<Object[]> findByProdNameType(@Param("product_name") String product_name,
                                      @Param("sale_or_purchase") Integer sale_or_purchase,
                                      @Param("start") int Start,
                                      @Param("end") int end);

    @Query(value = "select count(*) from " +
            "(SELECT h.PRICE_CODE, h.product_no, h.from_date, h.to_date, h.sale_or_purchase, h.price, h.reg_date, p.product_name " +
            "FROM product p " +
            "JOIN price_history h ON p.product_no = h.product_no " +
            "WHERE 1=1 " +
            "AND p.product_name LIKE '%' || :product_name || '%' " +
            "AND h.sale_or_purchase = :sale_or_purchase " +
            "and p.PRODUCT_DELETE = 0 ) ", nativeQuery = true)
    int countByProdNameType(@Param("product_name") String product_name, @Param("sale_or_purchase") Integer sale_or_purchase);

    @Query(value = "select * from" +
            "(SELECT h.PRICE_CODE, h.product_no, h.from_date, h.to_date, h.sale_or_purchase, h.price, h.reg_date, p.product_name, rownum rm " +
            "FROM product p " +
            "JOIN price_history h ON p.product_no = h.product_no " +
            "WHERE 1=1 " +
            "AND h.sale_or_purchase = :sale_or_purchase " +
            "and p.PRODUCT_DELETE = 0 " +
            "order by h.TO_DATE desc, h.FROM_DATE desc ) " +
            "where rm between :strat and :end", nativeQuery = true)
    List<Object[]> findByProdType(@Param("sale_or_purchase") Integer sale_or_purchase,
                                  @Param("start") int start, @Param("end") int end);

    @Query(value = "select count(*) from" +
            "(SELECT h.PRICE_CODE, h.product_no, h.from_date, h.to_date, h.sale_or_purchase, h.price, h.reg_date, p.product_name, rownum rm " +
            "FROM product p " +
            "JOIN price_history h ON p.product_no = h.product_no " +
            "WHERE 1=1 " +
            "AND h.sale_or_purchase = :sale_or_purchase " +
            "and p.PRODUCT_DELETE = 0) ", nativeQuery = true)
    int countByProdType(@Param("sale_or_purchase") Integer sale_or_purchase);


    @Modifying
    @Query(value = "update price_history" +
            " set to_date = to_char(sysdate-1, 'yy/mm/dd') " +
            " where product_no = ?1 " +
            " and to_date = '99/12/31'", nativeQuery = true)
    void ProdDelDateModify (long product_no);

    @Procedure(name = "price_prc")
    void price_prc(Long pProductNo, Integer pPrice, Integer pSalePur);

    @Query(value = "select count(*) " +
            " from price_history ", nativeQuery = true)
    int PriceTotal();

    @Query(value = "select price_code, PRODUCT_NO, FROM_DATE, TO_DATE, SALE_OR_PURCHASE, PRICE, REG_DATE, product_name " +
            "from ( " +
            "select PRICE_CODE, p.product_name, p.PRODUCT_NO, FROM_DATE, TO_DATE, SALE_OR_PURCHASE, PRICE, h.REG_DATE, rownum rm " +
            "from price_history h " +
            "join product p on p.product_no = h.product_no " +
            "where p.PRODUCT_DELETE = 0  " +
            "order by TO_DATE desc, h.FROM_DATE desc )" +
            "where rm between :start and :end", nativeQuery = true)
    List<Object[]> findAll(@Param("start") int start, @Param("end") int end);

}

