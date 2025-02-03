package org.oracle.s202501a.service.yj_service;

import java.util.List;
import java.util.Map;

import org.oracle.s202501a.dao.yj_dao.PurchaseDao;
import org.oracle.s202501a.dto.yj_dto.Purchase;
import org.oracle.s202501a.dto.yj_dto.Purchase01;
import org.oracle.s202501a.dto.yj_dto.Purchase_details;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class PurchaseServiceImpl implements PurchaseService {
	
	private final PurchaseDao pd;

	// PurchaseController의 listPurchase- totalPurchase- 발주 총 갯수
	@Override
	public int totalPurchase() {
		System.out.println("PurchaseServiceImpl totalPurchase start,,");
		int totPurchaseCnt = pd.totalPurchase();
		System.out.println("PurchaseServiceImpl totalPurchase totPurchaseCnt->"+totPurchaseCnt);
		
		return totPurchaseCnt;
	}

	// PurchaseController의 listPurchase- listPurchase- 발주 조회 리스트
	@Override
	public List<Purchase> listPurchase(Purchase purchase) {
		List<Purchase> listPurchases = null;
		System.out.println("PurchaseServiceImpl listPurchase start,,");
		listPurchases = pd.listPurchase(purchase);
		System.out.println("ddddddddddddddddd"+purchase);
		System.out.println("PurchaseServiceImpl listPurchase listPurchases.size()->"+listPurchases.size());
		
		return listPurchases;
	}
	
	// PurchaseController의 searchPurchase searchTotalPurchase- 발주 검색 총 갯수
	@Override
	public int searchTotalPurchase(Purchase purchase) {
		System.out.println("PurchaseServiceImpl searchTotalPurchase start,,");
		int searchTotalPurchase = pd.searchTotalPurchase(purchase);
		System.out.println("PurchaseServiceImpl searchTotalPurchase searchTotalPurchase->"+searchTotalPurchase);
		return searchTotalPurchase;
	}
	
	// PurchaseController의 searchPurchase searchListPurchase- 발주 검색 리스트
	@Override
	public List<Purchase> searchListPurchase(Purchase purchase) {
		List<Purchase> searchListPurchase = null;
		searchListPurchase = pd.searchListPurchase(purchase);
		System.out.println("PurchaseServiceImpl searchListPurchase searchListPurchase.size()->"+searchListPurchase.size());
		System.out.println("PurchaseServiceImpl searchListPurchase searchListPurchase->"+searchListPurchase);
		
		return searchListPurchase;
	}

	// PurchaseController의 detailPurchase- detailPurchase- 발주 상세화면
//	@Override
//	public Purchase detailPurchase(String title) {
//		System.out.println("PurchaseServiceImpl detailPurchase start,,,");
//		Purchase purchase = null;
//		purchase = pd.detailPurchase(title);
//		return purchase;
//	}

	// PurchaseController의 detailPurchase- detailPurchase- 발주 상세화면(구매테이블)
	// 구매에서 가져와야하는 값 - 제목, 매입일자, 요청배송일, 담당자, 거래처명, 비고, 수량
	@Override
	public Purchase detailPurchase(Map<String, Object> params) {
		System.out.println("PurchaseServiceImpl detailPurchase start,,,");
		Purchase purchase = null;
		purchase = pd.detailPurchase(params);
		System.out.println("PurchaseServiceImpl detailPurchase purchase->"+purchase);
		
		return purchase;
	}

	// PurchaseController의 detailPurchase- detailPurchaseDetail- 발주 상세화면(구매상세테이블)
	// 구매상세에서 가져와야하는 값 - 매입일자, 거래처명, 품목명, 단가, 수량
	@Override
	public List<Purchase> detailPurchaseDetail(Map<String, Object> params) {
		System.out.println("PurchaseServiceImpl detailPurchaseDetail start,,,");
		List<Purchase> purchase_detail = null;
		purchase_detail = pd.detailPurchaseDetail(params);
		System.out.println("PurchaseServiceImpl detailPurchaseDetail purchase_detail->"+purchase_detail);
		
		return purchase_detail;
	}

	// PurchaseController의 insertFormPurchase - 담당자, 거래처, 제품 드롭다운
//	@Override
//	public List<Purchase> listManager() {
//		List<Purchase> empList = null;
//		System.out.println("PurchaseServiceImpl listManager start,,");
//		empList = pd.listManager();
//		System.out.println("PurchaseServiceImpl listManager empList.size()->"+empList.size());
//		return empList;
//	}
	// PurchaseController의 insertFormPurchase - 담당자, 거래처, 제품 드롭다운
	@Override
	public List<Purchase> listClient() {
		List<Purchase> clientList = null;
		System.out.println("PurchaseServiceImpl listClient start,,");
		clientList = pd.listClient();
		System.out.println("PurchaseServiceImpl listClient empList.size()->"+clientList.size());
		return clientList;
	}
	// PurchaseController의 insertFormPurchase - 담당자, 거래처, 제품 드롭다운
	@Override
	public List<Purchase> listProduct() {
		List<Purchase> productList = null;
		System.out.println("PurchaseServiceImpl listProduct start,,");
		productList = pd.listProduct();
		System.out.println("PurchaseServiceImpl listProduct empList.size()->"+productList.size());
		return productList;
	}

	// PurchaseController의 insertPurchase
	@Override
	public int insertPurchase(Purchase01 purchase) {
		int insertPurchaseCnt = 0;
		insertPurchaseCnt = pd.insertPurchase(purchase);
		System.out.println("PurchaseServiceImpl insertPurchase insertPurchaseCnt->"+insertPurchaseCnt);
		return insertPurchaseCnt;
	}

	@Override
	public int insertDetailPurchase(Purchase_details detail) {
		int insertDetailPurchaseCnt = 0;
		insertDetailPurchaseCnt = pd.insertDetailPurchase(detail);
		System.out.println("PurchaseServiceImpl insertDetailPurchase insertDetailPurchaseCnt->"+insertDetailPurchaseCnt);
		return insertDetailPurchaseCnt;
	}

	// PurchaseController의 getPrice
	@Override
	public int productPrice(int product_no) {
		System.out.println("PurchaseServiceImpl productPrice start,,,");
		int productPrice = 0;
		productPrice = pd.productPrice(product_no);
		System.out.println("PurchaseServiceImpl productPrice->"+productPrice);
		return productPrice;
	}
	
	// 발주 정보 수정
	// PurchaseController updatePurchase
	// 구매 데이터 먼저
	@Override
	public int updatePurchase(Purchase01 purchase) {
		int updatePurchaseCnt = 0;
		updatePurchaseCnt = pd.updatePurchase(purchase);
		System.out.println("PurchaseServiceImpl updatePurchase updatePurchaseCnt->"+updatePurchaseCnt);
		return updatePurchaseCnt;
	}
	
	// 구매상세도
	@Override
	public int updateDetailPurchase(Purchase_details details) {
		int updateDetailPurchaseCnt = 0;
		updateDetailPurchaseCnt = pd.updateDetailPurchase(details);
		System.out.println("PurchaseServiceImpl insertDetailPurchase insertDetailPurchaseCnt->"+updateDetailPurchaseCnt);
		return updateDetailPurchaseCnt;
	}

	// 발주 정보 삭제
	// PurchaseController deletePurchase
	// 구매상세 먼저 삭제하기 - 연결되어있어서
	@Override
	public int deletePurchaseDetail(Map<String, Object> params) { //구매
		System.out.println("PurchaseServiceImpl deletePurchase start,,");
		int result1 = 0;
		result1 = pd.deletePurchaseDetail(params);
		return result1;
	}
	// 그 다음에 구매 삭제
	@Override
	public int deletePurchase(Map<String, Object> params) { //구매
		System.out.println("PurchaseServiceImpl deletePurchaseDetail start,,");
		int result2 = 0;
		result2 = pd.deletePurchase(params);
		return result2;
	}
	



	
}
