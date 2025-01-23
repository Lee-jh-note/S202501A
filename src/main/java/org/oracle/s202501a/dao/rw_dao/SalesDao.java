package org.oracle.s202501a.dao.rw_dao;

import java.util.List;

import org.oracle.s202501a.dto.rw_dto.SalesAll;
import org.oracle.s202501a.dto.rw_dto.SalesProduct;

public interface SalesDao {

    // 등록
    int 					createSales(SalesAll sales); // 수주 정보 저장
    int 					insertSalesProduct(SalesProduct product); // 수주 품목 저장
	int 					productPrice(int product_no);

    // 조회
    int 					totalSales(SalesAll sales); // 전체 수주 수 조회
    List<SalesAll> 			listSales(SalesAll sales); // 수주 목록 조회
    List<SalesAll> 			getClientList(); // 거래처 목록 조회
    List<SalesProduct> 		getProductList(); // 품목 목록 조회

    // 상세조회
    SalesAll 				infoSales(String sales_Date, int client_No); // 수주 상세 정보 조회
    List<SalesProduct> 		getSalesProduct(String sales_Date, int client_No); // 수주 품목 조회

    // 수정
    int 					updateSales(SalesAll sales); // 수주 정보 수정
    
    String 					getClientNameByNo(int client_No); // 거래처번호 → 거래처명
    String 					getProductNameByNo(int product_No); // 품목번호 → 품목명
    String 					getEmpNameByNo(int emp_No); // 담당자번호 → 담당자명
	
    



    
//	void 					deleteSales(String sales_Date, int client_No);

}
