package org.oracle.s202501a.dao.yj_dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.yj_dto.Purchase;
import org.oracle.s202501a.dto.yj_dto.Purchase01;
import org.oracle.s202501a.dto.yj_dto.Purchase_details;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class PurchaseDaoImpl implements PurchaseDao {
	private final SqlSession session;

	// PurchaseServiceImpl totalPurchase- 발주 총 갯수
	@Override
	public int totalPurchase() {
		int totPurchaseCnt = 0;
		System.out.println("PurchaseDaoImpl totalPurchase start,,");
		try {
			totPurchaseCnt = session.selectOne("yjPurchaseTotal");
			System.out.println("PurchaseDaoImpl totalPurchase totPurchaseCnt->"+totPurchaseCnt);
		} catch (Exception e) {
			System.out.println("PurchaseDaoImpl totalPurchase e.getMessage()->"+e.getMessage());
		}
		
		return totPurchaseCnt;
	}

	// PurchaseServiceImpl listPurchase- 발주 조회 리스트
	@Override
	public List<Purchase> listPurchase(Purchase purchase) {
		List<Purchase> listPurchases = null;
		System.out.println("PurchaseDaoImpl listPurchase start,,");
		try {
			// 									MapperId- 내이름 붙여서 , 파라미터 - 안되면 다 붙이기
			listPurchases = session.selectList("org.oracle.s202501a.mapper.PurchaseMapper.yjListPurchase", purchase);
			System.out.println("ddddddddddddddddd"+purchase);
			System.out.println("PurchaseDaoImpl listPurchase listPurchases.size()->"+listPurchases.size());
		} catch (Exception e) {
			System.out.println("PurchaseDaoImpl listPurchase e.getMessage()->"+e.getMessage());
		}
		return listPurchases;
	}
	
	// PurchaseServiceImpl searchTotalPurchase- 발주 검색 총 갯수
	@Override
	public int searchTotalPurchase(Purchase purchase) {
		int searchTotalPurchase = 0;
		System.out.println("PurchaseDaoImpl searchTotalPurchase start,,");
		try {
			searchTotalPurchase = session.selectOne("yjSearchTotalPurchase",purchase);
			System.out.println("PurchaseDaoImpl searchTotalPurchase searchTotalPurchase->"+searchTotalPurchase);
		} catch (Exception e) {
			System.out.println("PurchaseDaoImpl searchTotalPurchase e.getMessage()->"+e.getMessage());
		}
		return searchTotalPurchase;
	}
	
	// PurchaseServiceImpl searchListPurchase- 발주 검색 리스트
	@Override
	public List<Purchase> searchListPurchase(Purchase purchase) {
		List<Purchase> searchListPurchase = null;
		System.out.println("PurchaseDaoImpl searchListPurchase start,,");
		try {
			searchListPurchase = session.selectList("yjSearchListPurchase", purchase);
		} catch (Exception e) {
			System.out.println("PurchaseDaoImpl searchListPurchase e.getMessage()->"+e.getMessage());
		}
		return searchListPurchase;
	}

	// PurchaseServiceImpl detailPurchase- 발주 상세화면
//	@Override
//	public Purchase detailPurchase(String title) {
//		System.out.println("PurchaseDaoImpl detailPurchase start,,,");
//		Purchase purchase = new Purchase();
//		try {
//			purchase = session.selectOne("yjPurchaseDetail", title);
//			System.out.println("PurchaseDaoImpl detailPurchase purchase->"+purchase);
//					
//		} catch (Exception e) {
//			System.out.println("PurchaseDaoImpl detailPurchase e.getMessage()->"+e.getMessage());
//		}
//		return purchase;
//	}
	
	// PurchaseServiceImpl detailPurchase- 발주 상세화면(구매테이블)
	// 구매에서 가져와야하는 값 - 제목, 매입일자, 요청배송일, 담당자, 거래처명, 비고, 수량
	@Override
	public Purchase detailPurchase(Map<String, Object> params) {
		System.out.println("PurchaseDaoImpl detailPurchase start,,");
		Purchase purchase = new Purchase();
		try {
			purchase = session.selectOne("yjDetailPurchase",params);
			System.out.println("PurchaseDaoImpl detailPurchase purchase->"+purchase);
		} catch (Exception e) {
			System.out.println("PurchaseDaoImpl detailPurchase e.getMessage()->"+e.getMessage());
		}
		return purchase;
	}

	// PurchaseServiceImpl detailPurchaseDetail- 발주 상세화면(구매상세테이블)
	// 구매상세에서 가져와야하는 값 - 매입일자, 거래처명, 품목명, 단가, 수량
	@Override
	public List<Purchase> detailPurchaseDetail(Map<String, Object> params) {
		System.out.println("PurchaseDaoImpl detailPurchaseDetail start,,");
		List<Purchase> purchase_detail = null;
		try {
			purchase_detail = session.selectList("yjDetailPurchaseDetail",params);
			System.out.println("PurchaseDaoImpl detailPurchaseDetail params->"+params);
			System.out.println("PurchaseDaoImpl detailPurchaseDetail purchase_detail->"+purchase_detail);
		} catch (Exception e) {
			System.out.println("PurchaseDaoImpl detailPurchaseDetail e.getMessage()->"+e.getMessage());
		}
		return purchase_detail;
	}

	// PurchaseServiceImpl에서 각각 넘어옴 - 담당자, 거래처, 제품 드롭다운
	@Override
	public List<Purchase> listManager() {
		List<Purchase> empList = null;
		System.out.println("PurchaseDaoImpl listManager start,,");
		try {
			empList = session.selectList("yjListManager");
		} catch (Exception e) {
			System.out.println("PurchaseDaoImpl listManager Exception->"+e.getMessage());
		}
		return empList;
	}
	// PurchaseServiceImpl에서 각각 넘어옴 - 담당자, 거래처, 제품 드롭다운
	@Override
	public List<Purchase> listClient() {
		List<Purchase> clientList = null;
		System.out.println("PurchaseDaoImpl listClient start,,");
		try {
			clientList = session.selectList("yjListClient");
		} catch (Exception e) {
			System.out.println("PurchaseDaoImpl listClient Exception->"+e.getMessage());
		}
		return clientList;
	}
	// PurchaseServiceImpl에서 각각 넘어옴 - 담당자, 거래처, 제품 드롭다운
	@Override
	public List<Purchase> listProduct() {
		List<Purchase> productList = null;
		System.out.println("PurchaseDaoImpl listProduct start,,");
		try {
			productList = session.selectList("yjListProduct");
		} catch (Exception e) {
			System.out.println("PurchaseDaoImpl listProduct Exception->"+e.getMessage());
		}
		return productList;
	}

	// PurchaseServiceImpl insertPurchase
	// 구매 insert
	@Override
	public int insertPurchase(Purchase01 purchase) {
		int insertPurchaseCnt = 0;
		System.out.println("PurchaseDaoImpl insertPurchase start,,");
		try {
			insertPurchaseCnt = session.insert("yjInsertPurchase", purchase);
		} catch (Exception e) {
			System.out.println("PurchaseDaoImpl insertPurchase Exception->"+e.getMessage());
		}
		return insertPurchaseCnt;
	}
	
	// 구매상세 insert
	@Override
	public int insertDetailPurchase(Purchase_details detail) {
		int insertDetailPurchaseCnt = 0;
		System.out.println("PurchaseDaoImpl insertDetailPurchase start,,");
		try {
			insertDetailPurchaseCnt = session.insert("yjInsertDetailPurchase", detail);
		} catch (Exception e) {
			System.out.println("PurchaseDaoImpl insertDetailPurchase Exception->"+e.getMessage());
		}
		return insertDetailPurchaseCnt;
	}

	// PurchaseServiceImpl productPrice- 단가 가져오기
	@Override
	public int productPrice(int product_no) {
		System.out.println("PurchaseDaoImpl productPrice start,,");
		int productPrice = 0;
		try {
			System.out.println("PurchaseDaoImpl productPrice3 product_no->"+product_no);
			productPrice = session.selectOne("yjProductPrice",product_no);
			System.out.println("PurchaseDaoImpl productPrice productPrice->"+productPrice);
		} catch (Exception e) {
			System.out.println("PurchaseDaoImpl productPrice Exception->"+e.getMessage());
		}
		return productPrice;
	}
	
	// 발주 정보 수정
	// PurchaseServiceImpl updatePurchase
	@Override
	public int updatePurchase(Purchase01 purchase) {
		int updatePurchaseCnt = 0;
		System.out.println("PurchaseDaoImpl updatePurchase start,,");
		try {
			updatePurchaseCnt = session.update("yjUpdatePurchase", purchase);
		} catch (Exception e) {
			System.out.println("PurchaseDaoImpl updatePurchase Exception->"+e.getMessage());
		}
		return updatePurchaseCnt;
	}
	
	@Override
	public int updateDetailPurchase(Purchase_details details) {
		int updateDetailPurchaseCnt = 0;
		System.out.println("PurchaseDaoImpl updateDetailPurchase start,,");
		try {
			updateDetailPurchaseCnt = session.update("yjUpdateDetailPurchase", details);
		} catch (Exception e) {
			System.out.println("PurchaseDaoImpl updateDetailPurchase Exception->"+e.getMessage());
		}
		return updateDetailPurchaseCnt;
	}

	// 발주 정보 삭제
	// PurchaseController deletePurchase
	@Override
	public int deletePurchaseDetail(Map<String, Object> params) { // 구매 상세 테이블
		int result1 = 0;
		try {
			result1 = session.delete("deletePurchase1", params);
		} catch (Exception e) {
			System.out.println("PurchaseDaoImpl deletePurchaseDetail Exception->"+e.getMessage());
		}
		return result1;
	}

	@Override
	public int deletePurchase(Map<String, Object> params) { // 구매 테이블
		int result2 = 0;
		try {
			result2 = session.delete("deletePurchase2", params);
		} catch (Exception e) {
			System.out.println("PurchaseDaoImpl deletePurchase Exception->"+e.getMessage());
		}
		return result2;
	}


}
