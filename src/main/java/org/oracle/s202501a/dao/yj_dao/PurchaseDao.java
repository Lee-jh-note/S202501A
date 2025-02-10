package org.oracle.s202501a.dao.yj_dao;

import java.util.List;
import java.util.Map;

import org.oracle.s202501a.dto.yj_dto.Purchase;
import org.oracle.s202501a.dto.yj_dto.Purchase01;
import org.oracle.s202501a.dto.yj_dto.Purchase_details;

public interface PurchaseDao {

	// PurchaseServiceImpl searchTotalPurchase- 발주 검색 총 갯수
	int 			searchTotalPurchase(Purchase purchase);
	// PurchaseServiceImpl searchListPurchase- 발주 검색 리스트
	List<Purchase> 	searchListPurchase(Purchase purchase);
	// PurchaseServiceImpl detailPurchase- 발주 상세화면
//	Purchase 		detailPurchase(String title);
	// PurchaseServiceImpl detailPurchase- 발주 상세화면(구매테이블)
	// 구매에서 가져와야하는 값 - 제목, 매입일자, 요청배송일, 담당자, 거래처명, 비고, 수량
	Purchase 		detailPurchase(Map<String, Object> params);
	// PurchaseServiceImpl detailPurchaseDetail- 발주 상세화면(구매상세테이블)
	// 구매상세에서 가져와야하는 값 - 매입일자, 거래처명, 품목명, 단가, 수량
	List<Purchase> detailPurchaseDetail(Map<String, Object> params);
	// PurchaseServiceImpl listManager,listClient,listProduct  - 담당자, 거래처, 제품 드롭다운
//	List<Purchase> listManager();
	List<Purchase> listClient();
	List<Purchase> listProduct();
	// PurchaseServiceImpl insertPurchase
	int 			insertPurchase(Purchase01 purchase);
	int 			insertDetailPurchase(Purchase_details detail);
	// PurchaseServiceImpl productPrice
	int				productPrice(int product_no);
	
	// 발주 정보 수정
	// PurchaseServiceImpl updatePurchase
	int 			updatePurchase(Purchase01 purchase);
	int 			updateDetailPurchase(Purchase_details details);
	
	// 발주 정보 삭제
	// PurchaseController deletePurchase
	int 			deletePurchase(Map<String, Object> params); // 구매테이블
	int 			deletePurchaseDetail(Map<String, Object> params); // 구매상세 테이블

}
