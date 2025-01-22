package org.oracle.s202501a.service.yj_service;

import java.util.List;
import java.util.Map;

import org.oracle.s202501a.dto.yj_dto.Purchase;
import org.oracle.s202501a.dto.yj_dto.PurchaseDetailsAll;

public interface PurchaseDetailService {
	
	// 입고 예정 리스트("예정"이니까 상태가 0인 값들만 들어와야함. 매퍼에서 sql문 조절)
	// PurchaseDetailController listPurchaseDetailPlan
	int totalPurchaseDetailPlan();
	List<PurchaseDetailsAll> listPurchaseDetailPlan(PurchaseDetailsAll purchase_details);
	
	// 입고 예정리스트 검색 (기간, 제품, 거래처, 담당자)
	// PurchaseDetailController searchPurchaseDetailPlan
	int searchTotalPurchaseDetailPlan(PurchaseDetailsAll purchase_details);
	List<PurchaseDetailsAll> searchListPurchaseDetailPlan(PurchaseDetailsAll purchase_details);
	
	// 입고 예정 리스트의 상세
	// PurchaseDetailController detailPurchaseDetailPlan
	PurchaseDetailsAll detailPurchaseDetailPlan(Map<String, Object> params);
	List<PurchaseDetailsAll> detailPurchaseDetailPlanList(Map<String, Object> params);
	
	// 구매상세- 미입고 상태 업데이트
	// 구매- 부분입고 혹은 입고로 상태 업데이트
	boolean updatePurchaseStatus(String string, int i, int j);
	boolean updatePurchaseDetailStatus(String string, int i, int j, int k);
	

	// 입고 조회 리스트
	// PurchaseDetailController listPurchaseDetail
	int totalPurchaseDetail();
	List<PurchaseDetailsAll> listPurchaseDetail(PurchaseDetailsAll purchase_details);
	
	// 입고 조회의 검색
	// PurchaseDetailController searchPurchaseDetail
	int searchTotalPurchaseDetail(PurchaseDetailsAll purchase_details);
	List<PurchaseDetailsAll> searchListPurchaseDetail(PurchaseDetailsAll purchase_details);
	
	// 입고 조회의 상세- 미입고도
	// PurchaseDetailController detailPurchaseDetail
	PurchaseDetailsAll detailPurchaseDetail(Map<String, Object> params);
	List<PurchaseDetailsAll> detailPurchaseDetailList(Map<String, Object> params);
	
	
	// 미입고 조회 리스트
	// PurchaseDetailController listPurchaseDetailNo
	int totalPurchaseDetailNo();
	List<PurchaseDetailsAll> listPurchaseDetailNo(PurchaseDetailsAll purchase_details);
	
	// 미입고 조회 검색
	// PurchaseDetailController searchPurchaseDetailNo
	int searchTotalPurchaseDetailNo(PurchaseDetailsAll purchase_details);
	List<PurchaseDetailsAll> searchListPurchaseDetailNo(PurchaseDetailsAll purchase_details);


}
