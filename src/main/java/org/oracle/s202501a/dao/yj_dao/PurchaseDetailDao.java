package org.oracle.s202501a.dao.yj_dao;

import java.util.List;
import java.util.Map;

import org.oracle.s202501a.dto.yj_dto.PurchaseDetailsAll;

public interface PurchaseDetailDao {

	// 입고 예정리스트 검색 (기간, 제품, 거래처, 담당자)("예정"이니까 상태가 0인 값들만 들어와야함. 매퍼에서 sql문 조절)
	// PurchaseDetailServiceImpl searchTotalPurchaseDetailPlan
	int 							searchTotalPurchaseDetailPlan(PurchaseDetailsAll purchase_details);
	// PurchaseDetailServiceImpl searchListPurchaseDetailPlan
	List<PurchaseDetailsAll> 		searchListPurchaseDetailPlan(PurchaseDetailsAll purchase_details);
	
	// 입고 예정 리스트의 상세 화면
	// PurchaseDetailServiceImpl detailPurchaseDetailPlan
	PurchaseDetailsAll 				detailPurchaseDetailPlan(Map<String, Object> params);
	List<PurchaseDetailsAll> 		detailPurchaseDetailPlanList(Map<String, Object> params);
	
	// 입고 버튼- 구매 상태 처리
	//PurchaseDetailServiceImpl updatePurchaseStatus
	int 							updatePurchaseStatus(String purchaseDate, int clientNo, int status);
	// 입고 버튼- 구매 상세 상태 처리
	int 							updatePurchaseDetailStatusManager(String purchaseDate, int clientNo, int productNo, int currentNo, int status);
	
	
	// 입고 조회 검색
	// PurchaseDetailServiceImpl searchTotalPurchaseDetail
	int 							searchTotalPurchaseDetail(PurchaseDetailsAll purchase_details);
	List<PurchaseDetailsAll> 		searchListPurchaseDetail(PurchaseDetailsAll purchase_details);
	
	// 입고 조회 상세
	// PurchaseDetailServiceImpl detailPurchaseDetail
	PurchaseDetailsAll 				detailPurchaseDetail(Map<String, Object> params);
	List<PurchaseDetailsAll> 		detailPurchaseDetailList(Map<String, Object> params);
	
	

	// 미입고 조회 검색
	// PurchaseDetailServiceImpl searchTotalPurchaseDetailNo
	int 							searchTotalPurchaseDetailNo(PurchaseDetailsAll purchase_details);
	List<PurchaseDetailsAll> 		searchListPurchaseDetailNo(PurchaseDetailsAll purchase_details);
	// 미입고 상세
	PurchaseDetailsAll detailPurchaseDetailNo(Map<String, Object> params);
	List<PurchaseDetailsAll> detailPurchaseDetailNoList(Map<String, Object> params);
	
}
