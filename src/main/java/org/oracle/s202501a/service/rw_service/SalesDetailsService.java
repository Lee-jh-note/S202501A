package org.oracle.s202501a.service.rw_service;

import java.util.List;

import org.oracle.s202501a.dto.rw_dto.SalesDetailsAll;

public interface SalesDetailsService {

	// 출고 예정 (수주 상태: 대기)  
    List<SalesDetailsAll> 	listPreSalesDetails(SalesDetailsAll salesDetails); // 출고 예정 조회 (총 갯수 조회 포함) (검색 조건 적용)
    SalesDetailsAll 		infoPreSalesDetails(SalesDetailsAll salesDetails); // 출고 예정 상세조회
    List<SalesDetailsAll> 	infoPreSalesDetailsList(SalesDetailsAll salesDetails); // 출고 예정 품목 상세조회
    
    
    // 출고/미출고 처리 (상태 변경)
	boolean 				updateSalesStatus(int[] checked, String[] salesDates, int[] clientNos, int[] productNos, int emp_no); // 수주 상태 변경 (수주 + 수주상세)

    
    // 출고 (수주 상태: 출고)
    List<SalesDetailsAll> 	listGoSalesDetails(SalesDetailsAll salesDetails); // 출고 조회 (총 갯수 조회 포함) (검색 조건 적용)
    SalesDetailsAll 		infoGoSalesDetails(SalesDetailsAll salesDetails); // 출고 상세조회 
    List<SalesDetailsAll> 	infoGoSalesDetailsList(SalesDetailsAll salesDetails); // 출고 품목 상세조회 

    
    // 미출고 (수주 상태: 미출고)
    List<SalesDetailsAll> 	listNoSalesDetails(SalesDetailsAll salesDetails); // 미출고 조회 (총 갯수 조회 포함) (검색 조건 적용)
    SalesDetailsAll 		infoNoSalesDetails(SalesDetailsAll salesDetails); // 미출고 상세조회 
    List<SalesDetailsAll> 	infoNoSalesDetailsList(SalesDetailsAll salesDetails); // 미출고 품목 상세조회
	boolean 				updateNoSalesStatus(int[] productNos, String salesDate, int clientNo); // 미출고 상태 변경 (수주 + 수주상세)

    	
}
