package org.oracle.s202501a.service.rw_service;

import java.time.LocalDate;
import java.util.List;

import org.oracle.s202501a.dao.rw_dao.SalesDao;
import org.oracle.s202501a.dto.rw_dto.SalesAll;
import org.oracle.s202501a.dto.rw_dto.SalesDetails;
import org.oracle.s202501a.dto.rw_dto.SalesDetailsAll;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class SalesServiceImpl implements SalesService {

	private final SalesDao salesDao; 

	// =============================================================
	//                             등록
	// =============================================================

	// 수주 등록 (수주 정보 & 품목 정보)
	@Override
    public int createSales(SalesAll sales) {
        log.info("SalesServiceImpl createSales Start...");

        // 매출일자 자동 설정 - sales_date가 null인 경우 오늘 날짜로 설정)
        if (sales.getSales_date() == null) {
            sales.setSales_date(LocalDate.now().toString());
            log.info("매출일자 자동 설정: {}", sales.getSales_date());
        }

        try {
            // 수주 정보 저장 (SALES 테이블)
            int result = salesDao.createSales(sales);
            log.info("수주 등록 완료: {}", result);

            // 수주 품목 저장 (SALES_DETAILS 테이블)
            if (sales.getProductList() != null && !sales.getProductList().isEmpty()) {
                for (SalesDetails salesDetails : sales.getProductList()) {
                    // 수주 정보 등록 후 sales_date, client_no를 각 품목에 설정함
                	salesDetails.setSales_date(sales.getSales_date());
                	salesDetails.setClient_no(sales.getClient_no());
                    log.debug("수주 품목 저장 요청: {}", salesDetails);
                    
                    // 개별 품목 등록
                    int createSalesDetailResult = salesDao.createSalesDetails(salesDetails);
                    log.debug("수주 품목 등록 완료: {}", createSalesDetailResult);
                }
            } else {
                log.warn("등록할 수주 품목이 없습니다. (무시)");
            }
            // 최종 등록 결과 반환
            return result;
            
        } catch (Exception e) {
            log.error("createSales 실패: {}", e.getMessage(), e);
            throw e; // 예외 발생 시 트랜잭션 롤백
        }
    }
	
	// 거래처 목록 조회 (드롭다운)
	@Override
	public List<SalesAll> getClientList() {
		System.out.println("SalesServiceImpl getClientList Start...");

	    List<SalesAll> clientList = salesDao.getClientList();
	    log.debug("조회된 거래처 목록: {}", clientList);
	    
	    return clientList;
	}

	// 제품 목록 조회 (드롭다운)
	@Override
	public List<SalesDetailsAll> getProductList() {
		System.out.println("SalesServiceImpl getProductList Start...");

	    List<SalesDetailsAll> productList = salesDao.getProductList();
	    log.debug("조회된 제품 목록: {}", productList);
	    
	    return productList;
	}
	
	// 담당자 목록 조회 (드롭다운) -임시용
	@Override
	public List<SalesAll> getEmpList() {
		System.out.println("SalesServiceImpl getEmpList Start...");

	    List<SalesAll> empList = salesDao.getEmpList();
	    log.debug("조회된 담당자 목록: {}", empList);
	    
	    return empList;
	}
	
	// 품목 선택 시 단가 자동설정
	@Override
	public int getProductPrice(int product_no) {
		System.out.println("SalesServiceImpl getProductPrice Start...");

	    log.info("선택한 제품번호: product_no={}", product_no);
	    
	    int productPrice = salesDao.getProductPrice(product_no);	    
	    log.debug("조회된 제품 단가: {}", productPrice);
	    
	    return productPrice;
	}
	
	// 중복확인 (sales_date와 client_no 비교해서 같은 날짜에 같은 거래처 수주가 없는지 수주 등록 전 미리 확인)
    @Override
    public boolean checkDuplicateSales(String client_no, String sales_date) {
    	System.out.println("SalesServiceImpl checkDuplicateSales Start...");
    	
        log.debug("중복 체크 요청: client_no={}, sales_date={}", client_no, sales_date);

        // DAO에서 count 값이 1 이상이면 중복된 수주가 있음
        int count = salesDao.checkDuplicateSales(client_no, sales_date);
        boolean isDuplicate = count > 0;

        log.info("중복 여부 확인: {}", isDuplicate);
        
        return isDuplicate;
    }
	

	// =============================================================
	//                             조회
	// =============================================================

	// 수주 조회 (검색 조건 적용)
    @Override
    public List<SalesAll> listSales(SalesAll sales) {
    	System.out.println("SalesServiceImpl listSales Start...");
    	
        log.info("수주 조회 요청: {}", sales);

        // 수주 총 갯수 조회 (검색 조건 적용)
        int totalSales = salesDao.totalSales(sales);
        log.info("수주 총 갯수 조회 결과: {}", totalSales);
        
        // totalSales를 SalesAll객체에 저장 (페이징 처리를 위해)
        sales.setCount(totalSales);

        // 현재 페이지가 없으면 기본값 1로 설정
        if (sales.getCurrentPage() == null) {
        	sales.setCurrentPage("1");
        }
        // 페이징 설정
        Paging page = new Paging(totalSales, sales.getCurrentPage());
        sales.setStart(page.getStart());
        sales.setEnd(page.getEnd());
        log.info("페이징 적용: start={}, end={}, currentPage={}, totalPage={}", 
        		page.getStart(), page.getEnd(), page.getCurrentPage(), page.getTotalPage());

        // 수주 목록 조회
        List<SalesAll> listSales = salesDao.listSales(sales);
        log.info("수주 목록 조회 완료 (총{}건)", listSales.size());
        
        // 데이터 확인 (리스트가 없으면 빈 리스트 반환)
        if (listSales == null || listSales.isEmpty()) {
            log.warn("수주 조회 결과가 비어있음!");
            return List.of(); // 빈 리스트 반환
        }
        
        log.info("첫번째 데이터: {}", listSales.get(0)); // 첫번째 데이터 확인

        return listSales;
    }
    
	
	// 수주 정보 상세조회
	@Override
	public SalesAll infoSales(SalesAll sales) {
		System.out.println("SalesServiceImpl infoSales Start...");

	    log.info("수주 상세조회 요청: {}", sales);
	    
	    SalesAll infoSales = salesDao.infoSales(sales);
	    log.debug("조회된 수주 상세조회: {}", infoSales);
	    
	    return infoSales;
	}
	

	// 수주 품목 상세조회
	@Override
	public List<SalesDetailsAll> infoSalesDetails(SalesAll sales) {
		System.out.println("SalesServiceImpl infoProduct Start...");

	    log.info("수주 품목 조회 요청: {}", sales);
	    
	    List<SalesDetailsAll> infoSalesDetails = salesDao.infoSalesDetails(sales);
	    log.debug("조회된 수주 품목: {}", infoSalesDetails);

	    return infoSalesDetails;
	}
	
	
	
	// =============================================================
	//                             수정
	// =============================================================
	
	// 수주 수정 (처리 상태가 '대기'인 경우만 가능)
	@Override
    public int updateSales(SalesAll sales) {
        // 수주 정보 수정
        int result = salesDao.updateSales(sales);
        log.info("수주 정보 수정 완료: result={}", result);

        // 기존 수주 품목 삭제  
        // SalesDetails 객체에 매출일자와 거래처 번호 설정
        SalesDetails deleteDetails = new SalesDetails();
        deleteDetails.setSales_date(sales.getSales_date());
        deleteDetails.setClient_no(sales.getClient_no());
        
        // 기존 deleteSalesDetails 코드 재활용
        int deleteSalesDetailsCount = salesDao.deleteSalesDetails(deleteDetails);
        log.info("기존 수주 품목 삭제 완료: 삭제된 건수={}", deleteSalesDetailsCount);

        // 새 수주 품목 재등록  
        if (sales.getProductList() != null && !sales.getProductList().isEmpty()) {
            for (SalesDetails details : sales.getProductList()) {
                // 수주 정보 등록 후 매출일자와 거래처 번호 설정
            	details.setSales_date(sales.getSales_date());
            	details.setClient_no(sales.getClient_no());
            	
            	// 기존 createSalesDetails 코드 재활용
                int insResult = salesDao.createSalesDetails(details);
                log.debug("새 수주 품목 등록 완료: detailResult={}", insResult);
            }
        } else {
            log.warn("수정할 수주 품목이 없습니다.");
        }
        return result;
    }

//	// 수주 정보 수정 (처리 상태가 '대기'인 경우만 가능)
//	@Override
//	public int updateSales(SalesAll sales) {
//		System.out.println("SalesServiceImpl updateSales Start...");
//
//		log.info("수주 수정 요청: {}", sales);
//		
//	    // 상태 확인 (대기가 아닐 경우 수정 불가)
//	    if (sales == null || !"0".equals(sales.getStatus())) {
//	        throw new RuntimeException("수정할 수 없는 상태입니다. (처리 상태: " + (sales != null ? sales.getStatus() : "null") + ")");
//	    }
//
//	    // 수주 정보 업데이트
//	    int updateSales = salesDao.updateSales(sales);
//	    log.info("수주 수정 완료, updateSales={}", updateSales);
//
//	    return updateSales;
//	}
//
//
//	// 수주 품목 수정 (처리 상태가 '대기'인 경우만 가능) - 기존품목 삭제 후 재등록(기존 코드 재활용)
//	@Override
//	   public int updateSalesDetails(List<SalesDetails> salesDetailsList) {
//		System.out.println("SalesServiceImpl updateSalesDetails Start...");
//		
//		   if (salesDetailsList == null || salesDetailsList.isEmpty()) {
//		        log.warn("수정할 품목 정보 없음.");
//		        return 0;
//		    }
//
//		    // 삭제기준이 되는 정보 가져옴(첫번째 품목의 매출일자와 거래처정보를 기준으로 하기)
//		    SalesDetails firstDetail = salesDetailsList.get(0);
//		    SalesDetails deleteFilter = new SalesDetails();
//		    deleteFilter.setSales_Date(firstDetail.getSales_Date());
//		    deleteFilter.setClient_No(firstDetail.getClient_No());
//
//		    // 기존 품목 전부 삭제
//		    log.info("기존 품목 삭제 요청: {}", deleteFilter);
//		    salesDao.deleteSalesDetails(deleteFilter);
//
//		    // 새로운 품목 등록
//		    int insertCount = 0;
//		    for (SalesDetails details : salesDetailsList) {
//		        log.debug("새로운 품목 등록: {}", details);
//		        insertCount += salesDao.createSalesDetails(details);
//		    }
//
//		    log.info("수주 품목 수정 완료 (등록된 품목 개수: {})", insertCount);
//		    return insertCount;
//		}

	
	// =============================================================
	//                             삭제
	// =============================================================
	
	// 수주 삭제 (처리 상태가 '대기'인 경우만 가능) - 수주품목 먼저 삭제 후 수주정보 삭제
	@Override
	public int deleteSales(SalesAll sales) {
	    System.out.println("SalesServiceImpl deleteSales Start...");
	    
	    log.info("수주 삭제 요청: {}", sales);

	    // 상태 확인 (처리 상태가 '0'이 아닐 경우 삭제 불가) 
	    // 화면에서 처리상태 대기 아니면 삭제 버튼이 안보이도록 했지만, 백엔드에서도 이중 체크!
	    if (sales == null || !"0".equals(sales.getStatus())) {
	        throw new RuntimeException("수주 삭제 불가: 상태가 '대기'가 아닙니다 (처리 상태: " + (sales != null ? sales.getStatus() : "null") + ")");
	    }

	    // 삭제 대상 설정 (수주 품목 삭제하기 위해 SalesDetails 객체 생성)
	    SalesDetails deleteSalesDetails = new SalesDetails();
	    deleteSalesDetails.setSales_date(sales.getSales_date());
	    deleteSalesDetails.setClient_no(sales.getClient_no());

	    // 수주 품목 삭제
	    log.info("수주 품목 삭제 요청: {}", deleteSalesDetails);
	    int deleteSalesDetailsCount = salesDao.deleteSalesDetails(deleteSalesDetails);
	    log.info("수주 품목 삭제 완료 (deleteSalesDetailsCount={})", deleteSalesDetailsCount); // 삭제한 행 갯수 확인


	    // 수주 정보 삭제
	    log.info("수주 정보 삭제 요청: {}", sales);
	    int deleteSales = salesDao.deleteSales(sales);
	    
	    // 삭제 실패 시 예외 던지기
	    if (deleteSales < 1) {
	        throw new RuntimeException("수주 정보 삭제에 실패했습니다.");
	    }

	    log.info("수주 삭제 완료 (deleteSales={})", deleteSales);
	    
	    return deleteSales;
	}



}
