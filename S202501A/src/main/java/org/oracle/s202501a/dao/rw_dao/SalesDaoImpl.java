package org.oracle.s202501a.dao.rw_dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.rw_dto.SalesAll;
import org.oracle.s202501a.dto.rw_dto.SalesProduct;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository 
@RequiredArgsConstructor 
@Slf4j 
public class SalesDaoImpl implements SalesDao {

    private final SqlSession sqlSession; // MyBatis DB 연동

    // ============================================
    // 수주 등록 (등록 기능)
    // ============================================
    
    // 수주 등록 (기본 정보 저장)
    @Transactional
    @Override
    public int createSales(SalesAll sales) {
        log.info("수주 등록 요청: {}", sales);
        try {
            sqlSession.insert("createSales", sales);
            log.info("수주 정보 저장 완료: sales_Date={}, client_No={}", sales.getSales_Date(), sales.getClient_No());

            if (sales.getProductList() != null && !sales.getProductList().isEmpty()) {
                for (SalesProduct product : sales.getProductList()) {
                    product.setSales_Date(sales.getSales_Date());
                    product.setClient_No(sales.getClient_No());
                    sqlSession.insert("createSalesProduct", product);
                }
                log.info("품목 정보 저장 완료 - 개수: {}", sales.getProductList().size());
            } else {
                log.warn("등록할 품목이 없음 (무시)");
            }
            return 1;
        } catch (Exception e) {
            log.error("수주 등록 오류 발생: {}", e.getMessage(), e);
            throw new RuntimeException("수주 등록 중 오류 발생", e);
        }
    }

    
     // 개별 수주 품목 등록
    @Override
    public int insertSalesProduct(SalesProduct product) {
        log.info("수주 품목 등록 요청: {}", product);
        try {
            int result = sqlSession.insert("insertSalesProduct", product);
            log.info("수주 품목 등록 완료 (결과: {})", result);
            return result;
        } catch (Exception e) {
            log.error("수주 품목 등록 오류 발생: {}", e.getMessage(), e);
            return 0;
        }
    }
    
	   // 품목 선택 시 단가 자동 설정
    @Override
    public int productPrice(int product_no) {
       System.out.println("SalesDaoImpl productPrice start...");
       int productPrice = 0;
       try {
          System.out.println("SalesDaoImpl productPrice3 product_no->"+product_no);
          productPrice = sqlSession.selectOne("salesProductPrice",product_no);
          System.out.println("SalesDaoImpl productPrice productPrice->"+productPrice);
       } catch (Exception e) {
          System.out.println("SalesDaoImpl productPrice Exception->"+e.getMessage());
       }
       return productPrice;
    }

    // ============================================
    // 수주 목록 조회 (조회 기능)
    // ============================================
 
     // 전체 수주 개수 조회 (검색 조건 포함)
    @Override
    public int totalSales(SalesAll sales) {
        log.info("총 수주 개수 조회 요청: {}", sales);
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("startDate", sales.getStartDate());
            paramMap.put("endDate", sales.getEndDate());
            paramMap.put("clientName", 
                (sales.getClient_Name() != null && !sales.getClient_Name().trim().isEmpty()) ? "%" + sales.getClient_Name().trim() + "%" : null);
            paramMap.put("status", (sales.getStatus() != null && !sales.getStatus().isEmpty()) ? sales.getStatus() : null);

            log.debug("totalSales SQL 조건: {}", paramMap);
            int totalSales = sqlSession.selectOne("totalSales", paramMap);
            log.info("총 수주 개수: {}", totalSales);
            return totalSales;
        } catch (Exception e) {
            log.error("totalSales 오류 발생: {}", e.getMessage(), e);
            return 0;
        }
    }

     // 수주 목록 조회 (검색 조건 적용)
    @Override
    public List<SalesAll> listSales(SalesAll sales) {
        log.info("수주 목록 조회 요청: {}", sales);
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("startDate", sales.getStartDate());
            paramMap.put("endDate", sales.getEndDate());
            paramMap.put("clientName", 
                (sales.getClient_Name() != null && !sales.getClient_Name().trim().isEmpty()) ? "%" + sales.getClient_Name().trim() + "%" : null);
            paramMap.put("status", (sales.getStatus() != null && !sales.getStatus().isEmpty()) ? sales.getStatus() : null);
            paramMap.put("start", sales.getStart());
            paramMap.put("end", sales.getEnd());

            log.debug("listSales SQL 조건: {}", paramMap);
            List<SalesAll> salesList = sqlSession.selectList("listSales", paramMap);
            log.info("수주 목록 조회 결과 개수: {}", salesList.size());

            return salesList;
        } catch (Exception e) {
            log.error("listSales 오류 발생: {}", e.getMessage(), e);
            return null;
        }
    }

    // ============================================
    //  수주 상세 조회 (상세조회 기능)
    // ============================================
    
    // 특정 수주의 상세 정보 조회
    @Override
    public SalesAll infoSales(String sales_Date, int client_No) {
        log.info("수주 상세 조회 요청: sales_Date={}, client_No={}", sales_Date, client_No);
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("sales_Date", sales_Date);
            paramMap.put("client_No", client_No);

            SalesAll infoSales = sqlSession.selectOne("infoSales", paramMap);
            log.info("수주 상세 조회 결과: {}", infoSales);
            return infoSales;
        } catch (Exception e) {
            log.error("infoSales 오류 발생: {}", e.getMessage(), e);
            return null;
        }
    }

    // ============================================
    //  수주 수정 (수정 기능)
    // ============================================

    // 수주 수정
    @Override
    public int updateSales(SalesAll sales) {
        log.info("수주 수정 요청: {}", sales);
        try {
            int result = sqlSession.update("updateSales", sales);
            log.info("수주 수정 완료 (결과: {})", result);
            return result;
        } catch (Exception e) {
            log.error("updateSales 오류 발생: {}", e.getMessage(), e);
            return 0;
        }
    }

    // ============================================
    //  거래처 및 품목 정보 조회 (드롭다운용)
    // ============================================
    
    // 거래처 목록 
    @Override
    public List<SalesAll> getClientList() {
        log.info("전체 거래처 목록 조회 요청");
        return sqlSession.selectList("getClientList");
    }

    // 제품 목록
    @Override
    public List<SalesProduct> getProductList() {
        log.info("전체 품목 목록 조회 요청");
        return sqlSession.selectList("getProductList");
    }

    // 거래처 번호->이름(where절에서 번호pk로 조건걸어서 이름 찾을때/변환필요할떄)
    @Override
    public String getClientNameByNo(int client_No) {
        log.info("거래처 이름 조회 요청: client_No={}", client_No);
        return sqlSession.selectOne("getClientNameByNo", client_No);
    }
    
    // 제품 번호->이름
    @Override
    public String getProductNameByNo(int product_No) {
        log.info("품목 이름 조회 요청: product_No={}", product_No);
        return sqlSession.selectOne("getProductNameByNo", product_No);
    }
    
    // 담당자 번호->이름
    @Override
    public String getEmpNameByNo(int emp_No) {
        log.info("담당자 이름 조회 요청: emp_No={}", emp_No);
        return sqlSession.selectOne("getEmpNameByNo", emp_No);
    }

    // 수주 품목 조회 (수주 상세, 수정 시 사용)
    @Override
    public List<SalesProduct> getSalesProduct(String sales_Date, int client_No) {
        log.info("SalesDaoImpl getSalesProduct Start...");
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("sales_Date", sales_Date);
            paramMap.put("client_No", client_No);

            List<SalesProduct> salesProductList = sqlSession.selectList("getSalesProduct", paramMap);
            log.info("SalesDaoImpl getSalesProduct 결과 -> {}", salesProductList);
            return salesProductList;
        } catch (Exception e) {
            log.error("getSalesProduct 오류: {}", e.getMessage(), e);
            return null;
        }
    }
	}

