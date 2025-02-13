package org.oracle.s202501a.dao.rw_dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.rw_dto.SalesDetailsAll;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class SalesDetailsDaoImpl implements SalesDetailsDao {
	
    private final SqlSession sqlSession;

	// ====================================================================================
	//                             		출고 예정
	// ====================================================================================

    // 출고 예정 총 갯수 조회 (검색 조건 적용)
    @Override
    public int totalPreSalesDetails(SalesDetailsAll salesDetails) {
        try {
            return sqlSession.selectOne("totalPreSalesDetails", salesDetails);
        } catch (Exception e) {
            log.error("totalPreSalesDetails 오류 발생: {}", e.getMessage(), e);
            return 0; // 기본값 반환
        }
    }

    // 출고 예정 조회 (검색 조건 적용)
    @Override
    public List<SalesDetailsAll> listPreSalesDetails(SalesDetailsAll salesDetails) {
        try {
            return sqlSession.selectList("listPreSalesDetails", salesDetails);
        } catch (Exception e) {
            log.error("listPreSalesDetails 오류 발생: {}", e.getMessage(), e);
            return List.of(); // 빈 리스트 반환
        }
    }

    // 출고 예정 상세조회
	@Override
	public SalesDetailsAll infoPreSalesDetails(SalesDetailsAll salesDetails) {
        try {
            return sqlSession.selectOne("infoPreSalesDetails", salesDetails);
        } catch (Exception e) {
            log.error("infoPreSalesDetails 오류 발생: {}", e.getMessage(), e);
            return null; // 널 반환
        }
	}
    
    // 출고 예정 품목 상세조회
    @Override
    public List<SalesDetailsAll> infoPreSalesDetailsList(SalesDetailsAll salesDetails) {
        try {
            return sqlSession.selectList("infoPreSalesDetailsList", salesDetails);
        } catch (Exception e) {
            log.error("infoPreSalesDetailsList 오류 발생: {}", e.getMessage(), e);
            return List.of(); // 빈 리스트 반환
        }
    }

	// ====================================================================================
	//                             	출고/미출고 처리 (상태 변경)
	// ====================================================================================

    // 수주 상태 변경
    @Override
    public int updateSalesStatus(String sales_date, int client_no, int status) {
        var params = Map.of(
                "sales_date", sales_date,
                "client_no", client_no,
                "status", status
        );
        try {
            return sqlSession.update("updateSalesStatus", params);
        } catch (Exception e) {
            log.error("updateSalesStatus 오류 발생: {}", e.getMessage(), e);
            return 0; // 기본값 반환
        }
    }

    // 수주상세 상태 변경
    @Override
    public int updateSalesDetailsStatus(String sales_date, int client_no, int product_no, int emp_no, int status) {
        var params = Map.of(
                "sales_date", sales_date,
                "client_no", client_no,
                "product_no", product_no,
                "emp_no", emp_no,
                "status", status
        );
        try {
            return sqlSession.update("updateSalesDetailsStatus", params);
        } catch (Exception e) {
            log.error("updateSalesDetailsStatus 오류 발생: {}", e.getMessage(), e);
            return 0; // 기본값 반환
        }
    }


    
	// ====================================================================================
	//                             			출고
	// ====================================================================================
    
    // 출고 총 갯수 조회 (검색 조건 적용)
    @Override
    public int totalGoSalesDetails(SalesDetailsAll salesDetails) {
        try {
            return sqlSession.selectOne("totalGoSalesDetails", salesDetails);
        } catch (Exception e) {
            log.error("totalGoSalesDetails 오류 발생: {}", e.getMessage(), e);
            return 0; // 기본값 반환
        }
    }

    // 출고 조회 (검색 조건 적용)
    @Override
    public List<SalesDetailsAll> listGoSalesDetails(SalesDetailsAll salesDetails) {
        try {
            return sqlSession.selectList("listGoSalesDetails", salesDetails);
        } catch (Exception e) {
            log.error("listGoSalesDetails 오류 발생: {}", e.getMessage(), e);
            return List.of(); // 빈 리스트 반환
        }
    }

    // 출고 상세조회
	@Override
	public SalesDetailsAll infoGoSalesDetails(SalesDetailsAll salesDetails) {
        try {
            return sqlSession.selectOne("infoGoSalesDetails", salesDetails);
        } catch (Exception e) {
            log.error("infoGoSalesDetails 오류 발생: {}", e.getMessage(), e);
            return null; // 널 반환
        }
	}
	
    // 출고 품목 상세조회 
    @Override
    public List<SalesDetailsAll> infoGoSalesDetailsList(SalesDetailsAll salesDetails) {
        try {
            return sqlSession.selectList("infoGoSalesDetailsList", salesDetails);
        } catch (Exception e) {
            log.error("infoGoSalesDetailsList 오류 발생: {}", e.getMessage(), e);
            return List.of(); // 빈 리스트 반환
        }
    }
    
	
	// ====================================================================================
	//                             			미출고
	// ====================================================================================

    // 미출고 총 갯수 조회 (검색 조건 적용)
    @Override
    public int totalNoSalesDetails(SalesDetailsAll salesDetails) {
        try {
            return sqlSession.selectOne("totalNoSalesDetails", salesDetails);
        } catch (Exception e) {
            log.error("totalNoSalesDetails 오류 발생: {}", e.getMessage(), e);
            return 0; // 기본값 반환
        }
    }

    // 미출고 조회 (검색 조건 적용)
    @Override
    public List<SalesDetailsAll> listNoSalesDetails(SalesDetailsAll salesDetails) {
        try {
            return sqlSession.selectList("listNoSalesDetails", salesDetails);
        } catch (Exception e) {
            log.error("listNoSalesDetails 오류 발생: {}", e.getMessage(), e);
            return List.of(); // 빈 리스트 반환
        }
    }
    
    // 미출고 상세조회
	@Override
	public SalesDetailsAll infoNoSalesDetails(SalesDetailsAll salesDetails) {
        try {
            return sqlSession.selectOne("infoNoSalesDetails", salesDetails);
        } catch (Exception e) {
            log.error("infoNoSalesDetails 오류 발생: {}", e.getMessage(), e);
            return null; // 널 반환
        }
	}
	
    // 미출고 품목 상세조회
    @Override
    public List<SalesDetailsAll> infoNoSalesDetailsList(SalesDetailsAll salesDetails) {
        try {
            return sqlSession.selectList("infoNoSalesDetailsList", salesDetails);
        } catch (Exception e) {
            log.error("infoNoSalesDetailsList 오류 발생: {}", e.getMessage(), e);
            return List.of(); // 빈 리스트 반환
        }
    }
    
    // 미출고 상태 변경
    @Override
    public int updateNoSalesStatus(String sales_date, int client_no, int status) {
        var params = Map.of(
                "sales_date", sales_date,
                "client_no", client_no,
                "status", status
        );
        try {
            return sqlSession.update("updateNoSalesStatus", params);
        } catch (Exception e) {
            log.error("updateNoSalesStatus 오류 발생: {}", e.getMessage(), e);
            return 0; // 기본값 반환
        }
    }

    // 미출고 품목 상태 변경
    @Override
    public int updateNoSalesDetailsStatus(String sales_date, int client_no, int product_no, int status) {
        var params = Map.of(
                "sales_date", sales_date,
                "client_no", client_no,
                "product_no", product_no,
                "status", status
        );
        try {
            return sqlSession.update("updateNoSalesDetailsStatus", params);
        } catch (Exception e) {
            log.error("updateNoSalesDetailsStatus 오류 발생: {}", e.getMessage(), e);
            return 0; // 기본값 반환
        }
    }

    
}
