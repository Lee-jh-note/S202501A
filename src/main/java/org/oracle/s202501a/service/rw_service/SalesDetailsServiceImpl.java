package org.oracle.s202501a.service.rw_service;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.oracle.s202501a.dao.rw_dao.SalesDetailsDao;
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
    
    // 수주 상태 변경 (수주 상태 + 수주상세 상태)
    @Override
    public boolean updateSalesStatus(int[] checked, String[] salesDates, int[] clientNos, int[] productNos, int emp_no) {
        System.out.println("SalesServiceImpl updateSalesStatus Start...");

        List<Integer> checkedList = checked == null ? List.of() 
                : Arrays.stream(checked).boxed().collect(Collectors.toList());
        
        // 모든 품목이 출고 상태인지 확인(수주 상태를 수주상세 상태에 따라 결정하니까)
        boolean allChecked = true; 

        for (int i = 0; i < salesDates.length; i++) {
            boolean isChecked = checkedList.contains(i);
            int status = isChecked ? 2 : 1; // 2: 출고, 1: 미출고
            
            // 수주상세 상태 업데이트        
            int result = salesDetailsDao.updateSalesDetailsStatus(salesDates[i], clientNos[i], productNos[i], emp_no, status);

            if (result <= 0) {
                throw new RuntimeException("수주상세 상태 업데이트 실패: " + productNos[i]);
            }
            
            // 상태가 출고(2)가 아닌 경우
            if (!isChecked) {
                allChecked = false;
            }
        }  

        // 수주 상태 결정: 모든 품목이 출고이면 2(완료), 아니면 1(부분출고)
        int salesStatus = allChecked ? 2 : 1; // 
        
        // 수주 상태 업데이트 실행
        int updateSalesCount = salesDetailsDao.updateSalesStatus(salesDates[0], clientNos[0], salesStatus);
        log.info("수주 상태 변경 완료: {}", updateSalesCount);

        if (updateSalesCount <= 0) {
            throw new RuntimeException("수주 상태 업데이트 실패");
        }

        return true;
    }
   

    

//    @Override
//    public boolean updateSalesStatus(int[] statuses, String[] salesDates, int[] clientNos, int[] productNos, int emp_no) {
//        System.out.println("SalesServiceImpl updateSalesStatus Start...");
//        
//        log.info("수주 상태 변경 요청: salesDates={}, clientNos={}, productNos={}, emp_no={}, statuses={}",
//                 Arrays.toString(salesDates), Arrays.toString(clientNos), Arrays.toString(productNos), emp_no, Arrays.toString(statuses));
//
//        // 모든 품목이 출고 상태인지 확인 (수주 상태를 결정하는 데 필요)
//        boolean allShipped = true; 
//
//        for (int i = 0; i < salesDates.length; i++) {
//            int status = statuses[i]; // 라디오 버튼을 통해 받은 상태값 그대로 사용 (1: 미출고, 2: 출고)
//
//            // 수주 상세 상태 업데이트 (품목별 상태를 DB에 반영)
//            int result = salesDetailsDao.updateSalesDetailsStatus(salesDates[i], clientNos[i], productNos[i], emp_no, status);
//
//            if (result <= 0) {
//                throw new RuntimeException("수주상세 상태 업데이트 실패: " + productNos[i]);
//            }
//
//            // 하나라도 미출고(1) 상태가 있으면 전체 수주 상태를 '부분출고(1)'로 설정
//            if (status != 2) {
//                allShipped = false;
//            }
//        }
//
//        // 모든 품목이 출고(2) 상태이면, 전체 수주 상태도 '출고 완료(2)'로 설정
//        int salesStatus = allShipped ? 2 : 1; 
//
//        // 수주 상태 업데이트 실행 (전체 상태 반영)
//        int updateSalesCount = salesDetailsDao.updateSalesStatus(salesDates[0], clientNos[0], salesStatus);
//        log.info("수주 상태 변경 완료: {}", updateSalesCount);
//
//        if (updateSalesCount <= 0) {
//            throw new RuntimeException("수주 상태 업데이트 실패");
//        }
//
//        return true;
//    }


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

    // 미출고 상태 변경 (수주 상태 + 수주상세 상태)
    @Override
    public boolean updateNoSalesStatus(int[] productNos, String salesDate, int clientNo) {
        log.info("SalesServiceImpl updateNoSalesStatus Start...");

        // 선택된 품목이 하나도 없으면 false 반환(실패 처리)
        if (productNos == null || productNos.length == 0) {
            return false;
        }

        // (1) 체크된 품목들을 출고(2)로 업데이트
        for (int productNo : productNos) {
            int result = salesDetailsDao.updateNoSalesDetailsStatus(salesDate, clientNo, productNo, 2);
            if (result <= 0) {
                log.error("미출고 → 출고 처리 실패: 제품번호={}", productNo);
                throw new RuntimeException("출고 처리 실패: " + productNo);
            }
        }

        // (2) 출고 상태 결정(모든 품목이 출고됐는지 확인하는 로직이 필요하면 추가)
        boolean allChecked = true; // 예시로 전부 출고라고 가정
        int salesStatus = allChecked ? 2 : 1;

        // (3) 수주 상태 업데이트
        int updateNoSalesCount = salesDetailsDao.updateNoSalesStatus(salesDate, clientNo, salesStatus);
        log.info("수주 상태 변경 완료: {}", updateNoSalesCount);

        if (updateNoSalesCount <= 0) {
            throw new RuntimeException("수주 상태 업데이트 실패");
        }

        return true;
    }



}
