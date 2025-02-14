package org.oracle.s202501a.dao.rw_dao;

import java.util.List;

import org.oracle.s202501a.dto.rw_dto.SalesDetailsAll;

public interface SalesDetailsDao {

	// 출고 예정 (수주 상태: 대기)  
    int 					totalPreSalesDetails(SalesDetailsAll salesDetails); // 출고 예정 총 갯수 조회 (검색 조건 적용)
    List<SalesDetailsAll> 	listPreSalesDetails(SalesDetailsAll salesDetails); // 출고 예정 조회 (검색 조건 적용)
    SalesDetailsAll 		infoPreSalesDetails(SalesDetailsAll salesDetails); // 출고 예정 상세조회
    List<SalesDetailsAll> 	infoPreSalesDetailsList(SalesDetailsAll salesDetails); // 출고 예정 품목 상세조회
    
    
    // 출고/미출고 처리(상태 변경)
    int 					updateSalesStatus(String sales_date, int client_no, int status); // 수주 상태 변경
    int 					updateSalesDetailsStatus(String sales_date, int client_no, int product_no, int emp_no, int status); // 수주상세 상태 변경

    
    // 출고 (수주 상태: 출고)
    int 					totalGoSalesDetails(SalesDetailsAll salesDetails); // 출고 총 갯수 조회 (검색 조건 적용)
    List<SalesDetailsAll> 	listGoSalesDetails(SalesDetailsAll salesDetails); // 출고 조회 (검색 조건 적용)
    SalesDetailsAll 		infoGoSalesDetails(SalesDetailsAll salesDetails); // 출고 상세조회 
    List<SalesDetailsAll>  	infoGoSalesDetailsList(SalesDetailsAll salesDetails); // 출고 품목 상세조회 

    
    // 미출고 (수주 상태: 미출고)
    int 					totalNoSalesDetails(SalesDetailsAll salesDetails); // 미출고 총 갯수 조회 (검색 조건 적용)
    List<SalesDetailsAll> 	listNoSalesDetails(SalesDetailsAll salesDetails); // 미출고 조회 (검색 조건 적용)
    SalesDetailsAll 		infoNoSalesDetails(SalesDetailsAll salesDetails); // 미출고 상세조회 
    List<SalesDetailsAll>  	infoNoSalesDetailsList(SalesDetailsAll salesDetails); // 미출고 품목 상세조회 
    int 					updateNoSalesStatus(String sales_date, int client_no, int status); // 미출고 수주 상태 변경
    int 					updateNoSalesDetailsStatus(String sales_date, int client_no, int product_no, int status); // 미출고 품목 상태 변경

    
}

	
