package org.oracle.s202501a.dao.rw_dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.rw_dto.SalesAll;
import org.oracle.s202501a.dto.rw_dto.SalesDetails;
import org.oracle.s202501a.dto.rw_dto.SalesDetailsAll;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class SalesDaoImpl implements SalesDao {

	private final SqlSession sqlSession; // MyBatis DB 연동

	// =============================================================
	//                             등록
	// =============================================================

	// 수주 정보 등록
	@Override
	public int createSales(SalesAll sales) {
		try {
			return sqlSession.insert("createSales", sales);
		} catch (Exception e) {
			log.error("createSales 실패: {}", e.getMessage(), e);
			throw e; // 예외를 다시 던짐 -> 서비스에서 받음 -> 트랜잭션 롤백
		}
	}

	// 수주 품목 등록 
	@Override
	public int createSalesDetails(SalesDetailsAll details) {
		try {
			return sqlSession.insert("createSalesDetails", details);
		} catch (Exception e) {
			log.error("createSalesDetails 실패: {}", e.getMessage(), e);
			throw e; // 예외 던짐
		}
	}

	// 거래처 목록 조회 (드롭다운)
	@Override
	public List<SalesAll> getClientList() {
		try {
			return sqlSession.selectList("getClientList");
		} catch (Exception e) {
			log.error("getClientList 실패: {}", e.getMessage(), e);
			return List.of(); // 빈 리스트 반환
		}
	}

	// 제품 목록 조회 (드롭다운)
	@Override
	public List<SalesDetailsAll> getProductList() {
		try {
			return sqlSession.selectList("getProductList");
		} catch (Exception e) {
			log.error("getProductList 실패: {}", e.getMessage(), e);
			return List.of(); // 빈 리스트 반환
		}
	}

//	// 담당자 목록 조회 (드롭다운) -임시용
//	@Override
//	public List<SalesAll> getEmpList() {
//		try {
//			return sqlSession.selectList("getEmpList");
//		} catch (Exception e) {
//			log.error("getEmpList 실패: {}", e.getMessage(), e);
//			return List.of(); // 빈 리스트 반환
//		}
//	}
	
	// 품목 선택 시 단가 자동설정
	@Override
	public int getProductPrice(int product_no) {
		try {
			return sqlSession.selectOne("getProductPrice", product_no);
		} catch (Exception e) {
			log.error("getProductPrice 실패: {}", e.getMessage(), e);
			throw e; // 예외 던짐
		}
	}
	
	// 중복확인 (sales_date와 client_no 비교해서 같은 날짜에 같은 거래처 수주가 없는지 수주 등록 전 미리 확인)
	@Override
	public int checkDuplicateSales(String client_no, String sales_date) {
	    try {
	        Map<String, Object> paramMap = new HashMap<>();
	        paramMap.put("client_no", client_no);
	        paramMap.put("sales_date", sales_date);

	        return sqlSession.selectOne("checkDuplicateSales", paramMap);
	    } catch (Exception e) {
	        log.error("checkDuplicateSales 실패: {}", e.getMessage(), e);
	        return 0; // 기본값 반환 (중복 없음)
	    }
	}



	
	// =============================================================
	//                             조회
	// =============================================================

	// 수주 총 갯수 조회 (검색 조건 적용)
	@Override
	public int totalSales(SalesAll sales) {
		try {
			return sqlSession.selectOne("totalSales", sales);
		} catch (Exception e) {
			log.error("totalSales 오류 발생: {}", e.getMessage(), e);
			return 0; // 기본값 반환
		}
	}

	// 수주 조회 (검색 조건 적용)
	@Override
	public List<SalesAll> listSales(SalesAll sales) {
		try {
			return sqlSession.selectList("listSales", sales);
		} catch (Exception e) {
			log.error("listSales 오류 발생: {}", e.getMessage(), e);
			return List.of(); // 빈 리스트 반환
		}
	}

	// 수주 정보 상세조회
	@Override
	public SalesAll infoSales(SalesAll sales) {
		try {
			return sqlSession.selectOne("infoSales", sales);
		} catch (Exception e) {
			log.error("infoSales 오류 발생: {}", e.getMessage(), e);
			return null; // 널 반환(데이터가 단건이라)
		}
	}

	// 수주 품목 상세조회
	@Override
	public List<SalesDetailsAll> infoSalesDetails(SalesAll sales) {
		try {
			return sqlSession.selectList("infoSalesDetails", sales);
		} catch (Exception e) {
			log.error("infoSalesDetails 오류 발생: {}", e.getMessage(), e);
			return List.of(); // 빈 리스트 반환
		}
	}


	// =============================================================
	//                             수정
	// =============================================================

	// 수주 정보 수정 (처리 상태가 '대기'인 경우만 가능)
	@Override
	public int updateSales(SalesAll sales) {
		try {
			return sqlSession.update("updateSales", sales);
		} catch (Exception e) {
			log.error("updateSales 오류 발생: {}", e.getMessage(), e);
			throw e; // 예외 던짐
		}
	}

	// 수주 품목 수정 (처리 상태가 '대기'인 경우만 가능) - 기존품목 삭제 후 재등록(기존 코드 재활용)

	
	
	// =============================================================
	//                             삭제
	// =============================================================
	
	// 수주 품목 삭제
	@Override
	public int deleteSalesDetails(SalesDetails details) {
		try {
			return sqlSession.delete("deleteSalesDetails", details);
		} catch (Exception e) {
			log.error("deleteSalesDetails 실패: {}", e.getMessage(), e);
			throw e; // 예외 던짐
		}
	}

	// 수주 정보 삭제 (처리 상태가 '대기'인 경우만 가능) - 수주품목 먼저 삭제 후 수주정보 삭제
	@Override
	public int deleteSales(SalesAll sales) {
		try {
			return sqlSession.delete("deleteSales", sales);
		} catch (Exception e) {
			log.error("deleteSales 실패: {}", e.getMessage(), e);
			throw e; // 예외 던짐
		}
	}

}
