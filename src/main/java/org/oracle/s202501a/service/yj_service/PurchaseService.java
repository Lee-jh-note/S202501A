package org.oracle.s202501a.service.yj_service;

import java.util.List;
import java.util.Map;

import org.oracle.s202501a.dto.yj_dto.Purchase;
import org.oracle.s202501a.dto.yj_dto.Purchase01;
import org.oracle.s202501a.dto.yj_dto.Purchase_details;

public interface PurchaseService {

	// PurchaseController의 searchPurchase searchTotalPurchase- 발주 검색 총 갯수
	int 				searchTotalPurchase(Purchase purchase);
	// PurchaseController의 searchPurchase searchListPurchase- 발주 검색 리스트
	List<Purchase> 		searchListPurchase(Purchase purchase);
	// PurchaseController의 detailPurchase- detailPurchase- 발주 상세화면
//	Purchase 			detailPurchase(String title);
	// PurchaseController의 detailPurchase- detailPurchase- 발주 상세화면(구매테이블)
	// 구매에서 가져와야하는 값 - 제목, 매입일자, 요청배송일, 담당자, 거래처명, 비고, 수량
	Purchase 			detailPurchase(Map<String, Object> params);
	// PurchaseController의 detailPurchase- detailPurchaseDetail- 발주 상세화면(구매상세테이블)
	// 구매상세에서 가져와야하는 값 - 매입일자, 거래처명, 품목명, 단가, 수량
	List<Purchase> 		detailPurchaseDetail(Map<String, Object> params);
	// PurchaseController의 insertFormPurchase 담당자, 거래처, 제품 드롭다운
//	List<Purchase> 		listManager();
	List<Purchase> 		listClient();
	List<Purchase> 		listProduct();
	// PurchaseController의 insertPurchase
	int 				insertPurchase(Purchase01 purchase);
	int 				insertDetailPurchase(Purchase_details detail);
	// PurchaseController의 getPrice
	int 				productPrice(int product_no);
	
	// 발주 정보 수정
	// PurchaseController updatePurchase
	int 				updatePurchase(Purchase01 purchase);
	int 				updateDetailPurchase(Purchase_details details);
	
	// 발주 정보 삭제
	// PurchaseController deletePurchase
	int 				deletePurchase(Map<String, Object> params); // 구매
	int 				deletePurchaseDetail(Map<String, Object> params); // 구매상세
}
