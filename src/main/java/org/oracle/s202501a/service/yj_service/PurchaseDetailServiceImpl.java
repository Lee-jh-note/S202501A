package org.oracle.s202501a.service.yj_service;

import java.util.List;
import java.util.Map;

import org.oracle.s202501a.dao.yj_dao.PurchaseDetailDao;
import org.oracle.s202501a.dto.yj_dto.Purchase;
import org.oracle.s202501a.dto.yj_dto.PurchaseDetailsAll;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class PurchaseDetailServiceImpl implements PurchaseDetailService {
	private final PurchaseDetailDao pd;
	
	// 입고 예정 리스트("예정"이니까 상태가 0인 값들만 들어와야함. 매퍼에서 sql문 조절)
	// PurchaseDetailController listPurchaseDetail
	@Override
	public int totalPurchaseDetailPlan() {
		System.out.println("PurchaseDetailServiceImpl totalPurchaseDetailPlan start,,,");
		int totalPurchaseDetailPlanCnt = pd.totalPurchaseDetailPlan();
		System.out.println("PurchaseDetailServiceImpl totalPurchaseDetailPlan totPurchasePlanCnt->" + totalPurchaseDetailPlanCnt);
		
		return totalPurchaseDetailPlanCnt;
	}

	// PurchaseDetailController listPurchaseDetail
	@Override
	public List<PurchaseDetailsAll> listPurchaseDetailPlan(PurchaseDetailsAll purchase_details) {
		List<PurchaseDetailsAll> listPurchaseDetailPlan = null;
		System.out.println("PurchaseDetailServiceImpl listPurchaseDetailPlan start,,");
		listPurchaseDetailPlan = pd.listPurchaseDetailPlan(purchase_details);
		System.out.println("PurchaseDetailServiceImpl listPurchaseDetailPlan listPurchaseDetailPlan.size()->"+listPurchaseDetailPlan.size());
		
		return listPurchaseDetailPlan;
	}

	// 입고 예정리스트 검색 (기간, 제품, 거래처, 담당자)
	// PurchaseDetailController searchPurchaseDetail
	@Override
	public int searchTotalPurchaseDetailPlan(PurchaseDetailsAll purchase_details) {
		System.out.println("PurchaseDetailServiceImpl searchTotalPurchaseDetail start,,");
		int searchTotalPurchaseDetailPlan = pd.searchTotalPurchaseDetailPlan(purchase_details);
		System.out.println("PurchaseDetailServiceImpl searchTotalPurchaseDetailPlan searchTotalPurchaseDetailPlan->"+searchTotalPurchaseDetailPlan);
		return searchTotalPurchaseDetailPlan;
	}

	// PurchaseDetailController searchPurchaseDetail
	@Override
	public List<PurchaseDetailsAll> searchListPurchaseDetailPlan(PurchaseDetailsAll purchase_details) {
		List<PurchaseDetailsAll> searchListPurchaseDetailPlan = null;
		searchListPurchaseDetailPlan = pd.searchListPurchaseDetailPlan(purchase_details);
		System.out.println("PurchaseDetailServiceImpl searchListPurchaseDetailPlan searchListPurchaseDetailPlan.size()->"+searchListPurchaseDetailPlan.size());
		System.out.println("PurchaseDetailServiceImpl searchListPurchaseDetailPlan searchListPurchaseDetail->"+searchListPurchaseDetailPlan);
		
		return searchListPurchaseDetailPlan;
	}
	
	// 입고 예정 리스트의 상세
	// PurchaseDetailController detailPurchaseDetailPlan
	@Override
	public PurchaseDetailsAll detailPurchaseDetailPlan(Map<String, Object> params) {
		System.out.println("PurchaseDetailServiceImpl detailPurchaseDetailPlan start,,");
		PurchaseDetailsAll purchase_details = null;
		purchase_details = pd.detailPurchaseDetailPlan(params);
		System.out.println("PurchaseDetailServiceImpl detailPurchaseDetailPlan purchase_details->"+purchase_details);
		
		return purchase_details;
	}
	@Override
	public List<PurchaseDetailsAll> detailPurchaseDetailPlanList(Map<String, Object> params) {
		System.out.println("PurchaseDetailServiceImpl detailPurchaseDetailPlanList start,,");
		List<PurchaseDetailsAll> purchase_details_list = null;
		purchase_details_list = pd.detailPurchaseDetailPlanList(params);
		return purchase_details_list;
	}
	
	// PurchaseDetailController purchaseDetailStore
	// 입고버튼- 구매 상태 변경
	@Override
	public boolean updatePurchaseStatus(String purchaseDate, int clientNo, int status) {
		System.out.println("PurchaseDetailServiceImpl updatePurchaseStatus 구매일자"+ purchaseDate +"거래처번호"+ clientNo +"상태"+ status);
		int result = pd.updatePurchaseStatus(purchaseDate, clientNo, status);
		return result > 0; // 업데이트 성공 여부
	}
	
	// 입고버튼- 구매상세 상태 변경
	@Override
	public boolean updatePurchaseDetailStatus(String purchaseDate, int clientNo, int productNo, int status) {
		System.out.println("PurchaseDetailServiceImpl updatePurchaseDetailStatus 구매일자"+ purchaseDate +"거래처번호"+ clientNo +"품목번호"+ productNo +"상태"+ status);
		int result = pd.updatePurchaseDetailStatus(purchaseDate, clientNo, productNo, status);
		return result > 0; // 업데이트 성공 여부
	}
	
	
	
	// 입고 조회("입고"니까 상태가 2인 값들만 들어와야함!)
	// PurchaseDetailController listPurchaseDetail
	@Override
	public int totalPurchaseDetail() {
		System.out.println("PurchaseDetailServiceImpl totalPurchaseDetail start,,,");
		int totalPurchaseDetailCnt = pd.totalPurchaseDetail();
		System.out.println("PurchaseDetailServiceImpl totalPurchase totPurchaseCnt->" + totalPurchaseDetailCnt);
		
		return totalPurchaseDetailCnt;
	}
	@Override
	public List<PurchaseDetailsAll> listPurchaseDetail(PurchaseDetailsAll purchase_details) {
		List<PurchaseDetailsAll> listPurchaseDetail = null;
		System.out.println("PurchaseDetailServiceImpl listPurchaseDetail start,,");
		listPurchaseDetail = pd.listPurchaseDetail(purchase_details);
		System.out.println("PurchaseDetailServiceImpl listPurchaseDetail listPurchaseDetail.size()->"+listPurchaseDetail.size());
		
		return listPurchaseDetail;
	}

	// 입고 조회 검색
	// PurchaseDetailController searchPurchaseDetail
	@Override
	public int searchTotalPurchaseDetail(PurchaseDetailsAll purchase_details) {
		System.out.println("PurchaseDetailServiceImpl searchTotalPurchaseDetail start,,");
		int searchTotalPurchaseDetail = pd.searchTotalPurchaseDetail(purchase_details);
		System.out.println("PurchaseDetailServiceImpl searchTotalPurchase searchTotalPurchaseDetail->"+searchTotalPurchaseDetail);
		return searchTotalPurchaseDetail;
	}
	@Override
	public List<PurchaseDetailsAll> searchListPurchaseDetail(PurchaseDetailsAll purchase_details) {
		List<PurchaseDetailsAll> searchListPurchaseDetail = null;
		searchListPurchaseDetail = pd.searchListPurchaseDetail(purchase_details);
		System.out.println("PurchaseDetailServiceImpl searchListPurchase searchListPurchaseDetail.size()->"+searchListPurchaseDetail.size());
		System.out.println("PurchaseDetailServiceImpl searchListPurchase searchListPurchaseDetail->"+searchListPurchaseDetail);
		
		return searchListPurchaseDetail;
	}

	
	// 입고 조회의 상세 - 미입고도
	// PurchaseDetailController detailPurchaseDetail
	@Override
	public PurchaseDetailsAll detailPurchaseDetail(Map<String, Object> params) {
		System.out.println("PurchaseDetailServiceImpl detailPurchaseDetail start,,");
		PurchaseDetailsAll purchase_details = null;
		purchase_details = pd.detailPurchaseDetail(params);
		System.out.println("PurchaseDetailServiceImpl detailPurchaseDetail purchase_details-> " + purchase_details);
		
		return purchase_details;
	}
	@Override
	public List<PurchaseDetailsAll> detailPurchaseDetailList(Map<String, Object> params) {
		System.out.println("PurchaseDetailServiceImpl detailPurchaseDetail start,,");
		List<PurchaseDetailsAll> purchase_details_list = null;
		purchase_details_list = pd.detailPurchaseDetailList(params);
		System.out.println("PurchaseDetailServiceImpl detailPurchaseDetail purchase_details_list-> " + purchase_details_list);
		
		return purchase_details_list;
	}

	// 미입고 조회 리스트
	// PurchaseDetailController searchPurchaseDetailNo
	@Override
	public int totalPurchaseDetailNo() {
		System.out.println("PurchaseDetailServiceImpl totalPurchaseDetailNo start,,,");
		int totalPurchaseDetailNoCnt = pd.totalPurchaseDetailNo();
		System.out.println("PurchaseDetailServiceImpl totalPurchaseDetailNo totalPurchaseDetailNoCnt->" + totalPurchaseDetailNoCnt);
		
		return totalPurchaseDetailNoCnt;
	}
	@Override
	public List<PurchaseDetailsAll> listPurchaseDetailNo(PurchaseDetailsAll purchase_details) {
		List<PurchaseDetailsAll> listPurchaseDetailNo = null;
		System.out.println("PurchaseDetailServiceImpl listPurchaseDetailNo start,,");
		listPurchaseDetailNo = pd.listPurchaseDetailNo(purchase_details);
		System.out.println("PurchaseDetailServiceImpl listPurchaseDetailNo listPurchaseDetailNo.size()->"+listPurchaseDetailNo.size());
		
		return listPurchaseDetailNo;
	}
	
	// 미입고 조회 검색
	// PurchaseDetailController searchPurchaseDetailNo
	@Override
	public int searchTotalPurchaseDetailNo(PurchaseDetailsAll purchase_details) {
		System.out.println("PurchaseDetailServiceImpl searchTotalPurchaseDetailNo start,,");
		int searchTotalPurchaseDetailNo = pd.searchTotalPurchaseDetailNo(purchase_details);
		System.out.println("PurchaseDetailServiceImpl searchTotalPurchaseDetailNo searchTotalPurchaseDetailNo->"+searchTotalPurchaseDetailNo);
		return searchTotalPurchaseDetailNo;
	}
	@Override
	public List<PurchaseDetailsAll> searchListPurchaseDetailNo(PurchaseDetailsAll purchase_details) {
		List<PurchaseDetailsAll> searchListPurchaseDetailNo = null;
		searchListPurchaseDetailNo = pd.searchListPurchaseDetailNo(purchase_details);
		System.out.println("PurchaseDetailServiceImpl searchListPurchaseDetailNo searchListPurchaseDetailNo.size()->"+searchListPurchaseDetailNo.size());
		System.out.println("PurchaseDetailServiceImpl searchListPurchaseDetailNo searchListPurchaseDetailNo->"+searchListPurchaseDetailNo);
		
		return searchListPurchaseDetailNo;
	}

}
