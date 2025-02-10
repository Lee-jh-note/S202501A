package org.oracle.s202501a.service.rw_service;

import java.util.List;

import org.oracle.s202501a.dao.rw_dao.SalesDetailsDao;
import org.oracle.s202501a.dto.rw_dto.SalesAll;
import org.oracle.s202501a.dto.rw_dto.SalesDetailsAll;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class SalesDetailsServiceImpl implements SalesDetailsService {
	
    private final SalesDetailsDao salesDetailsDao;

	// =============================================================
	//                             출고 예정
	// =============================================================


    // 출고 예정 조회 (검색 조건 적용)
    @Override
    public List<SalesDetailsAll> listPreSalesDetails(SalesDetailsAll salesDetails) {
    	System.out.println("SalesDetailsServiceImpl listPreSalesDetails Start...");
    	
        log.info("출고 예정 조회 요청: {}", salesDetails);

        // 출고 예정 총 갯수 조회 (검색 조건 적용)
        int totalPreSalesDetails = salesDetailsDao.totalPreSalesDetails(salesDetails);
        log.info("출고 예정 총 갯수 조회 결과: {}", totalPreSalesDetails);
        
        // totalPreSalesDetails를 SalesDetailsAll객체에 저장 (페이징 처리를 위해)
        salesDetails.setCount(totalPreSalesDetails);

        // 현재 페이지가 없으면 기본값 1로 설정
        if (salesDetails.getCurrentPage() == null) {
            salesDetails.setCurrentPage("1");
        }
        // 페이징 설정
        Paging page = new Paging(totalPreSalesDetails, salesDetails.getCurrentPage());
        salesDetails.setStart(page.getStart());
        salesDetails.setEnd(page.getEnd());
        log.info("페이징 적용: start={}, end={}", salesDetails.getStart(), salesDetails.getEnd());

        // 출고 예정 목록 조회
        List<SalesDetailsAll> listPreSalesDetails = salesDetailsDao.listPreSalesDetails(salesDetails);
        log.info("출고 예정 목록 조회 완료 (총{}건)", listPreSalesDetails.size());
        
        // 데이터 확인 (리스트가 없으면 빈 리스트 반환)
        if (listPreSalesDetails == null || listPreSalesDetails.isEmpty()) {
            log.warn("출고 예정 조회 결과가 비어있음!");
            return List.of(); // 빈 리스트 반환
        }
        log.info("첫번째 데이터: {}", listPreSalesDetails.get(0)); // 첫번째 데이터 확인
        
        return listPreSalesDetails;
    }

    // 출고 예정 상세조회
	@Override
	public SalesDetailsAll infoPreSalesDetails(SalesDetailsAll salesDetails) {
		System.out.println("SalesServiceImpl infoPreSalesDetails Start...");

	    log.info("출고 예정 상세조회 요청: {}", salesDetails);
	    
        SalesDetailsAll infoPreSalesDetails = salesDetailsDao.infoPreSalesDetails(salesDetails);
	    log.debug("조회된 출고 예정 상세 조회: {}", infoPreSalesDetails);

	    return infoPreSalesDetails;
	}
    
    // 출고 예정 품목 상세조회 
    @Override
    public List<SalesDetailsAll> infoPreSalesDetailsList(SalesDetailsAll salesDetails) {
    	System.out.println("SalesServiceImpl infoPreSalesDetailsList Start...");

	    log.info("출고 예정 품목 조회 요청: {}", salesDetails);
	    
        List<SalesDetailsAll> infoPreSalesDetailsList = salesDetailsDao.infoPreSalesDetailsList(salesDetails);
	    log.debug("조회된 출고 예정 품목: {}", infoPreSalesDetailsList);
	   
	    return infoPreSalesDetailsList;
    }

    
	// =============================================================
	//                      출고/미출고 처리 (상태 변경)
	// =============================================================
    
//    // 수주 상태 변경
//    @Override
//    public int updateSalesStatus(SalesAll sales) {
//        log.info("수주 상태 변경 시작: {}", sales);
//        salesDetailsDao.updateSalesStatus(sales);
//        log.info("수주 상태 변경 완료: {}", sales);
//		return 0;
//    }
//    
//    // 수주상세 상태 변경
//    @Override
//    public int updateSalesDetailsStatus(SalesDetailsAll salesDetails) {
//        log.info("출고 상태 변경 시작...");
//        boolean allShipped = true;
//
//        for (SalesDetailsAll details : salesDetailsList) {
//            salesDetailsDao.updateSalesDetailsStatus(details);
//            log.info("출고 상태 업데이트 완료: {}", details);
//
//            // 하나라도 미출고면 전체 상태는 '부분 출고'가 됨
//            if (!"출고".equals(details.getStatus())) {
//                allShipped = false;
//            }
//        }
//
//        // 전체 수주 상태 업데이트 (부분 출고 / 전체 출고)
//        if (!salesDetailsList.isEmpty()) {
//            SalesDetailsAll firstItem = salesDetailsList.get(0);
//            String newStatus = allShipped ? "전체출고" : "부분출고";
//            firstItem.setStatus(newStatus);
//            updateSalesStatus(firstItem);
//        }
//    }
    

    
    @Override
    public boolean updateSalesStatus(SalesAll sales, int[] productNos, String[] detailStatuses) {
        int detailUpdateCount = 0;
        boolean allShipped = true;  // 모든 품목이 "출고" 상태인지 체크
        
        if (productNos != null && detailStatuses != null && productNos.length == detailStatuses.length) {
            for (int i = 0; i < productNos.length; i++) {
                SalesDetailsAll detail = new SalesDetailsAll();
                // 헤더의 공통 정보 설정
                detail.setSales_date(sales.getSales_date());
                detail.setClient_no(sales.getClient_no());
                // 각 품목의 정보
                detail.setProduct_no(productNos[i]);
                detail.setStatus(detailStatuses[i]);  // "출고" 또는 "미출고"
                
                // 수주상세 업데이트 호출
                detailUpdateCount += salesDetailsDao.updateSalesDetailsStatus(detail);
                
                // 하나라도 "출고"가 아니라면 전체는 모두 출고된 것이 아님
                if (!"출고".equals(detailStatuses[i])) {
                    allShipped = false;
                }
            }
        }
        
        // 헤더 상태 결정: 모든 품목이 "출고"이면 "출고완료", 그렇지 않으면 "부분출고"
        if (allShipped) {
            sales.setStatus("출고완료");
        } else {
            sales.setStatus("부분출고");
        }
        
        // 헤더(수주) 업데이트 호출
        int headerUpdateCount = salesDetailsDao.updateSalesStatus(sales);
        
        // 전체 업데이트가 성공했는지 반환
        return (headerUpdateCount > 0) && (productNos != null && detailUpdateCount == productNos.length);
    }




	// =============================================================
	//                             출고
	// =============================================================

    // 출고 조회 (검색 조건 적용)
    @Override
    public List<SalesDetailsAll> listGoSalesDetails(SalesDetailsAll salesDetails) {
    	System.out.println("SalesDetailsServiceImpl listGoSalesDetails Start...");
    	
        log.info("출고 조회 요청: {}", salesDetails);

        // 출고 총 갯수 조회 (검색 조건 적용)
        int totalGoSalesDetails = salesDetailsDao.totalGoSalesDetails(salesDetails);
        log.info("출고 총 갯수 조회 결과: {}", totalGoSalesDetails);
        
        // totalGoSalesDetails를 SalesDetailsAll객체에 저장 (페이징 처리를 위해)
        salesDetails.setCount(totalGoSalesDetails);

        // 현재 페이지가 없으면 기본값 1로 설정
        if (salesDetails.getCurrentPage() == null) {
            salesDetails.setCurrentPage("1");
        }
        // 페이징 설정
        Paging page = new Paging(totalGoSalesDetails, salesDetails.getCurrentPage());
        salesDetails.setStart(page.getStart());
        salesDetails.setEnd(page.getEnd());
        log.info("페이징 적용: start={}, end={}", salesDetails.getStart(), salesDetails.getEnd());

        // 출고 목록 조회
        List<SalesDetailsAll> listGoSalesDetails = salesDetailsDao.listGoSalesDetails(salesDetails);
        log.info("출고 목록 조회 완료 (총{}건)", listGoSalesDetails.size());
        
        // 데이터 확인 (리스트가 없으면 빈 리스트 반환)
        if (listGoSalesDetails == null || listGoSalesDetails.isEmpty()) {
            log.warn("출고 조회 결과가 비어있음!");
            return List.of(); // 빈 리스트 반환
        }
        log.info("첫번째 데이터: {}", listGoSalesDetails.get(0)); // 첫번째 데이터 확인
        
        return listGoSalesDetails;
    }

    // 출고 상세조회
	@Override
	public SalesDetailsAll infoGoSalesDetails(SalesDetailsAll salesDetails) {
		System.out.println("SalesServiceImpl infoGoSalesDetails Start...");

	    log.info("출고 상세조회 요청: {}", salesDetails);
	    
        SalesDetailsAll infoGoSalesDetails = salesDetailsDao.infoGoSalesDetails(salesDetails);
	    log.debug("조회된 출고 상세 조회: {}", infoGoSalesDetails);

	    return infoGoSalesDetails;
	}
    
    // 출고 품목 상세조회 
    @Override
    public List<SalesDetailsAll> infoGoSalesDetailsList(SalesDetailsAll salesDetails) {
    	System.out.println("SalesServiceImpl infoGoSalesDetailsList Start...");

	    log.info("출고 품목 조회 요청: {}", salesDetails);
	    
        List<SalesDetailsAll> infoGoSalesDetailsList = salesDetailsDao.infoGoSalesDetailsList(salesDetails);
	    log.debug("조회된 출고 품목: {}", infoGoSalesDetailsList);
	   
	    return infoGoSalesDetailsList;
    }


    
	// =============================================================
	//                             미출고
	// =============================================================

    // 미출고 조회 (검색 조건 적용)
    @Override
    public List<SalesDetailsAll> listNoSalesDetails(SalesDetailsAll salesDetails) {
    	System.out.println("SalesDetailsServiceImpl listNoSalesDetails Start...");
    	
        log.info("미출고 조회 요청: {}", salesDetails);

        // 미출고 총 갯수 조회 (검색 조건 적용)
        int totalNoSalesDetails = salesDetailsDao.totalNoSalesDetails(salesDetails);
        log.info("미출고 총 갯수 조회 결과: {}", totalNoSalesDetails);
        
        // totalNoSalesDetails를 SalesDetailsAll객체에 저장 (페이징 처리를 위해)
        salesDetails.setCount(totalNoSalesDetails);

        // 현재 페이지가 없으면 기본값 1로 설정
        if (salesDetails.getCurrentPage() == null) {
            salesDetails.setCurrentPage("1");
        }
        // 페이징 설정
        Paging page = new Paging(totalNoSalesDetails, salesDetails.getCurrentPage());
        salesDetails.setStart(page.getStart());
        salesDetails.setEnd(page.getEnd());
        log.info("페이징 적용: start={}, end={}", salesDetails.getStart(), salesDetails.getEnd());

        // 미출고 목록 조회
        List<SalesDetailsAll> listNoSalesDetails = salesDetailsDao.listNoSalesDetails(salesDetails);
        log.info("미출고 목록 조회 완료 (총{}건)", listNoSalesDetails.size());
        
        // 데이터 확인 (리스트가 없으면 빈 리스트 반환)
        if (listNoSalesDetails == null || listNoSalesDetails.isEmpty()) {
            log.warn("미출고 조회 결과가 비어있음!");
            return List.of(); // 빈 리스트 반환
        }
        log.info("첫번째 데이터: {}", listNoSalesDetails.get(0)); // 첫번째 데이터 확인
        
        return listNoSalesDetails;
    }

    // 미출고 상세조회
	@Override
	public SalesDetailsAll infoNoSalesDetails(SalesDetailsAll salesDetails) {
		System.out.println("SalesServiceImpl infoNoSalesDetails Start...");

	    log.info("미출고 상세조회 요청: {}", salesDetails);
	    
        SalesDetailsAll infoNoSalesDetails = salesDetailsDao.infoNoSalesDetails(salesDetails);
	    log.debug("조회된 미출고 상세 조회: {}", infoNoSalesDetails);

	    return infoNoSalesDetails;
	}
    
    // 미출고 품목 상세조회 
    @Override
    public List<SalesDetailsAll> infoNoSalesDetailsList(SalesDetailsAll salesDetails) {
    	System.out.println("SalesServiceImpl infoNoSalesDetailsList Start...");

	    log.info("미출고 품목 조회 요청: {}", salesDetails);
	    
        List<SalesDetailsAll> infoNoSalesDetailsList = salesDetailsDao.infoNoSalesDetailsList(salesDetails);
	    log.debug("조회된 미출고 품목: {}", infoNoSalesDetailsList);
	   
	    return infoNoSalesDetailsList;
    }












}
