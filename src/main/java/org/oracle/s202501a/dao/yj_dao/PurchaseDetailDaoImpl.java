package org.oracle.s202501a.dao.yj_dao;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.yj_dto.PurchaseDetailsAll;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class PurchaseDetailDaoImpl implements PurchaseDetailDao {
	private final SqlSession session;
	
	// 입고 예정리스트 검색 (기간, 제품, 거래처, 담당자)("예정"이니까 상태가 0인 값들만 들어와야함. 매퍼에서 sql문 조절)
	// PurchaseDetailServiceImpl searchTotalPurchaseDetail- 입고 검색 총 갯수
	@Override
	public int searchTotalPurchaseDetailPlan(PurchaseDetailsAll purchase_details) {
		int searchTotalPurchaseDetailPlan = 0;
		System.out.println("PurchaseDetailDaoImpl searchTotalPurchase start,,");
		try {
			searchTotalPurchaseDetailPlan = session.selectOne("yjSearchTotalPurchaseDetailPlan", purchase_details);
			System.out.println("PurchaseDetailDaoImpl searchTotalPurchaseDetailPlan searchTotalPurchaseDetailPlan->"+searchTotalPurchaseDetailPlan);
		} catch (Exception e) {
			System.out.println("PurchaseDetailDaoImpl searchTotalPurchaseDetailPlan e.getMessage()->"+e.getMessage());
		}
		return searchTotalPurchaseDetailPlan;
	}
	
	// PurchaseDetailServiceImpl searchListPurchaseDetail- 입고 검색 리스트
	@Override
	public List<PurchaseDetailsAll> searchListPurchaseDetailPlan(PurchaseDetailsAll purchase_details) {
		List<PurchaseDetailsAll> searchListPurchaseDetailPlan = null;
		System.out.println("PurchaseDetailDaoImpl searchListPurchaseDetailPlan start,,");
		try {
			searchListPurchaseDetailPlan = session.selectList("yjSearchListPurchaseDetailPlan", purchase_details);
		} catch (Exception e) {
			System.out.println("PurchaseDetailDaoImpl searchListPurchaseDetailPlan e.getMessage()->"+e.getMessage());
		}
		return searchListPurchaseDetailPlan;
	}
	
	// 입고예정리스트의 상세조회 화면
	// PurchaseDetailServiceImpl detailPurchaseDetailPlan
	@Override
	public PurchaseDetailsAll detailPurchaseDetailPlan(Map<String, Object> params) {
		System.out.println("PurchaseDetailDaoImpl detailPurchaseDetailPlan start,,");
		PurchaseDetailsAll purchase_details = new PurchaseDetailsAll();
		try {
			purchase_details = session.selectOne("yjDetailPurchaseDetailPlan", params);
			System.out.println("PurchaseDetailDaoImpl detailPurchaseDetailPlan purchase_details->"+purchase_details);
		} catch (Exception e) {
			System.out.println("PurchaseDetailDaoImpl detailPurchaseDetailPlan e.getMessage()->"+e.getMessage());
		}
		return purchase_details;
	}
	@Override
	public List<PurchaseDetailsAll> detailPurchaseDetailPlanList(Map<String, Object> params) {
		System.out.println("PurchaseDetailDaoImpl detailPurchaseDetailPlanList start,,");
		List<PurchaseDetailsAll> purchase_details_list = null;
		try {
			purchase_details_list = session.selectList("yjDetailPurchaseDetailPlanList", params);
			System.out.println("PurchaseDetailDaoImpl detailPurchaseDetailPlanList purchase_details_list->"+purchase_details_list);
		} catch (Exception e) {
			System.out.println("PurchaseDetailDaoImpl detailPurchaseDetailPlanList e.getMessage()->"+e.getMessage());
		}
		return purchase_details_list;
	}
	
	// 입고버튼- 구매 상태 변경
	//PurchaseDetailServiceImpl updatePurchaseStatus
	@Override
	public int updatePurchaseStatus(String purchaseDate, int clientNo, int status) {
		System.out.println("PurchaseDetailDaoImpl updatePurchaseStatus 구매일자"+ purchaseDate +"거래처번호"+ clientNo + "상태"+ status);
		int result = 0;
		var params = Map.of(
				"purchaseDate", purchaseDate,
				"clientNo", clientNo,
				"status", status
				);
		result = session.update("yjUpdatePurchaseStatus", params);
		return result;
	}
	
	// 입고버튼- 구매상세 상태 변경
	@Override
	public int updatePurchaseDetailStatusManager(String purchaseDate, int clientNo, int productNo, int currentNo, int status) {
		System.out.println("PurchaseDetailDaoImpl updatePurchaseDetailStatus 구매일자"+ purchaseDate +"거래처번호"+ clientNo +"품목번호"+ productNo +"담당자"+ currentNo+ "상태"+ status);
		int result = 0;
		var params = Map.of(
				"purchaseDate", purchaseDate,
				"clientNo", clientNo,
				"productNo", productNo,
				"currentNo", currentNo,
				"status", status
				);
		result = session.update("yjUpdatePurchaseDetailStatus", params);
		return result;
	}
	
	
	
	// 입고 조회 검색("입고"니까 상태가 0인 값들만 들어와야함. 매퍼에서 sql문 조절)
	// PurchaseDetailServiceImpl searchTotalPurchaseDetail- 입고 검색 총 갯수
	@Override
	public int searchTotalPurchaseDetail(PurchaseDetailsAll purchase_details) {
		int searchTotalPurchaseDetail = 0;
		System.out.println("PurchaseDetailDaoImpl searchTotalPurchase start,,");
		try {
			searchTotalPurchaseDetail = session.selectOne("yjSearchTotalPurchaseDetail", purchase_details);
			System.out.println("PurchaseDetailDaoImpl searchTotalPurchase searchTotalPurchase->"+searchTotalPurchaseDetail);
		} catch (Exception e) {
			System.out.println("PurchaseDetailDaoImpl searchTotalPurchase e.getMessage()->"+e.getMessage());
		}
		return searchTotalPurchaseDetail;
	}
	// PurchaseDetailServiceImpl searchListPurchaseDetail- 입고 검색 리스트
	@Override
	public List<PurchaseDetailsAll> searchListPurchaseDetail(PurchaseDetailsAll purchase_details) {
		List<PurchaseDetailsAll> searchListPurchaseDetail = null;
		System.out.println("PurchaseDetailDaoImpl searchListPurchase start,,");
		try {
			searchListPurchaseDetail = session.selectList("yjSearchListPurchaseDetail", purchase_details);
		} catch (Exception e) {
			System.out.println("PurchaseDetailDaoImpl searchListPurchaseDetail e.getMessage()->"+e.getMessage());
		}
		return searchListPurchaseDetail;
	}

	
	// 입고 조회 상세
	// PurchaseDetailServiceImpl detailPurchaseDetail
	@Override
	public PurchaseDetailsAll detailPurchaseDetail(Map<String, Object> params) {
		System.out.println("PurchaseDetailDaoImpl detailPurchaseDetail start,,");
		PurchaseDetailsAll purchase_details = new PurchaseDetailsAll();
		try {
			purchase_details = session.selectOne("yjDetailPurchaseDetails",params);
			System.out.println("PurchaseDetailDaoImpl detailPurchaseDetail purchase_details-> " + purchase_details);
		} catch (Exception e) {
			System.out.println("PurchaseDetailDaoImpl detailPurchaseDetail e.getMessage()->"+e.getMessage());
		}
		return purchase_details;
	}

	@Override
	public List<PurchaseDetailsAll> detailPurchaseDetailList(Map<String, Object> params) {
		List<PurchaseDetailsAll> purchase_details_list = null;
		try {
			purchase_details_list = session.selectList("yjDetailPurchaseDetailLists", params);
			System.out.println("PurchaseDetailDaoImpl detailPurchaseDetailList purchase_details_list-> " + purchase_details_list);
		} catch (Exception e) {
			System.out.println("PurchaseDetailDaoImpl detailPurchaseDetailList e.getMessage()->"+e.getMessage());
		}
		return purchase_details_list;
	}



	// 미입고 조회 검색
	// PurchaseDetailServiceImpl searchTotalPurchaseDetailNo
	@Override
	public int searchTotalPurchaseDetailNo(PurchaseDetailsAll purchase_details) {
		int searchTotalPurchaseDetailNo = 0;
		System.out.println("PurchaseDetailDaoImpl searchTotalPurchaseDetailNo start,,");
		try {
			searchTotalPurchaseDetailNo = session.selectOne("yjSearchTotalPurchaseDetailNo", purchase_details);
			System.out.println("PurchaseDetailDaoImpl searchTotalPurchaseDetailNo searchTotalPurchaseDetailNo->"+searchTotalPurchaseDetailNo);
		} catch (Exception e) {
			System.out.println("PurchaseDetailDaoImpl searchTotalPurchaseDetailNo e.getMessage()->"+e.getMessage());
		}
		return searchTotalPurchaseDetailNo;
	}

	@Override
	public List<PurchaseDetailsAll> searchListPurchaseDetailNo(PurchaseDetailsAll purchase_details) {
		List<PurchaseDetailsAll> searchListPurchaseDetailNo = null;
		System.out.println("PurchaseDetailDaoImpl searchListPurchaseDetailNo start,,");
		try {
			searchListPurchaseDetailNo = session.selectList("yjSearchListPurchaseDetailNo", purchase_details);
		} catch (Exception e) {
			System.out.println("PurchaseDetailDaoImpl searchListPurchaseDetailNo e.getMessage()->"+e.getMessage());
		}
		return searchListPurchaseDetailNo;
	}
	
	// 미입고 조회 상세
	// PurchaseDetailServiceImpl detailPurchaseDetail
	@Override
	public PurchaseDetailsAll detailPurchaseDetailNo(Map<String, Object> params) {
		System.out.println("PurchaseDetailDaoImpl detailPurchaseDetail start,,");
		PurchaseDetailsAll purchase_details = new PurchaseDetailsAll();
		try {
			purchase_details = session.selectOne("yjDetailPurchaseDetailsNo",params);
			System.out.println("PurchaseDetailDaoImpl detailPurchaseDetail purchase_details-> " + purchase_details);
		} catch (Exception e) {
			System.out.println("PurchaseDetailDaoImpl detailPurchaseDetail e.getMessage()->"+e.getMessage());
		}
		return purchase_details;
	}

	@Override
	public List<PurchaseDetailsAll> detailPurchaseDetailNoList(Map<String, Object> params) {
		List<PurchaseDetailsAll> purchase_details_list = null;
		try {
			purchase_details_list = session.selectList("yjDetailPurchaseDetailNoLists", params);
			System.out.println("PurchaseDetailDaoImpl detailPurchaseDetailList purchase_details_list-> " + purchase_details_list);
		} catch (Exception e) {
			System.out.println("PurchaseDetailDaoImpl detailPurchaseDetailList e.getMessage()->"+e.getMessage());
		}
		return purchase_details_list;
	}


	

}
