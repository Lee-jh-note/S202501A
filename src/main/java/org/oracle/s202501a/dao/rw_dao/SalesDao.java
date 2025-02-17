package org.oracle.s202501a.dao.rw_dao;

import java.util.List;

import org.oracle.s202501a.dto.rw_dto.SalesAll;
import org.oracle.s202501a.dto.rw_dto.SalesDetails;
import org.oracle.s202501a.dto.rw_dto.SalesDetailsAll;

public interface SalesDao {

    // 등록
    int 					createSales(SalesAll sales); // 수주 정보 등록
    int 					createSalesDetails(SalesDetailsAll salesDetails); // 수주 품목 등록		
    List<SalesAll> 			getClientList(); // 거래처 목록 조회 (드롭다운)
    List<SalesDetailsAll> 	getProductList(); // 제품 목록 조회 (드롭다운)
	int 					getProductPrice(int product_No); // 품목 선택 시 단가 자동설정
	int 					checkDuplicateSales(String client_no, String sales_date); // 중복확인 (같은 날짜에 같은 거래처 여부 확인)

	
    // 조회
    int 					totalSales(SalesAll sales); // 수주 총 갯수 조회 (검색 조건 적용)
    List<SalesAll> 			listSales(SalesAll sales); // 수주 조회 (검색 조건 적용)    
    SalesAll 			   	infoSales(SalesAll sales); // 수주 정보 상세조회
    List<SalesDetailsAll> 	infoSalesDetails(SalesAll sales); // 수주 품목 상세조회

    
    // 수정
    int 					updateSales(SalesAll sales); // 수주 정보 수정
    // 품목 수정 				updateSalesDetails는 기존 코드 재활용 -> 삭제(deleteSalesDetails) 후 재등록(createSalesDetails)

    
    // 삭제
    int 					deleteSalesDetails(SalesDetails details); // 수주 품목 삭제 (처리 상태가 '대기'인 경우만 가능)
	int 					deleteSales(SalesAll sales); // 수주 정보 삭제 (처리 상태가 '대기'인 경우만 가능)

	
}
