package org.oracle.s202501a.service.rw_service;

import java.util.List;

import org.oracle.s202501a.dto.rw_dto.SalesAll;
import org.oracle.s202501a.dto.rw_dto.SalesDetailsAll;

public interface SalesService {

    // 등록
    int 					createSales(SalesAll sales); // 수주 등록 (수주 정보 + 품목 정보)
    List<SalesAll> 			getClientList(); // 거래처 목록 조회 (드롭다운)
    List<SalesDetailsAll> 	getProductList(); // 제품 목록 조회 (드롭다운)
    int 					getProductPrice(int product_No); // 품목 선택 시 단가 자동설정
	boolean 				checkDuplicateSales(String client_no, String sales_date); // 중복확인 (같은 날짜에 같은 거래처 여부 확인)


    // 조회
    List<SalesAll> 			listSales(SalesAll sales); // 수주 조회 (총 갯수 조회 포함) (검색 조건 적용)    
    SalesAll 			   	infoSales(SalesAll sales); // 수주 정보 상세조회
    List<SalesDetailsAll> 	infoSalesDetails(SalesAll sales); // 수주 품목 상세조회
    
    
    // 수정
    int 					updateSales(SalesAll sales); // 수주 수정 (수주 정보 + 품목 정보)

    
    // 삭제
	int 					deleteSales(SalesAll sales); // 수주 삭제 (수주 정보 + 품목 정보) (처리 상태가 '대기'인 경우만 가능)


}
