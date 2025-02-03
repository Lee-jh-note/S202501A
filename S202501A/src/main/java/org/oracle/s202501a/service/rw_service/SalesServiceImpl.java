package org.oracle.s202501a.service.rw_service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import org.oracle.s202501a.dao.rw_dao.SalesDao;
import org.oracle.s202501a.dto.rw_dto.SalesAll;
import org.oracle.s202501a.dto.rw_dto.SalesProduct;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class SalesServiceImpl implements SalesService {

	private final SalesDao salesDao; // SalesDao 주입 (DB 관련 작업)

	// ============================================
	// 수주 등록 (등록 기능)
	// ============================================

	// 수주 등록 (기본 정보 + 품목 정보)
	@Override
	@Transactional
	public int createSales(SalesAll sales) {
		log.info("수주 등록 요청: {}", sales);

		// 1. 매출일자 자동 설정 (현재 날짜)
		sales.setSales_Date(LocalDate.now().toString());

		// 2. 수주 정보 저장
		int result = salesDao.createSales(sales);
		log.info("수주 등록 완료 (result={})", result);

		// 3. 수주 품목 저장
		for (SalesProduct product : sales.getProductList()) {
			product.setSales_Date(sales.getSales_Date());
			log.debug("수주 품목 저장: {}", product);
			salesDao.insertSalesProduct(product);
		}

		return result;
	}

	// 개별 수주 품목 등록
	@Override
	public int insertSalesProduct(SalesProduct product) {
		log.info("수주 품목 등록 요청: {}", product);
		int result = salesDao.insertSalesProduct(product);
		log.info("수주 품목 등록 완료 (result={})", result);
		return result;
	}

	   // 품목 선택 시 단가 자동 설정
	@Override
	public int productPrice(int product_no) {
		System.out.println("SalesServiceImpl productPrice start...");
		int productPrice = 0;
		productPrice = salesDao.productPrice(product_no);
		System.out.println("SalesServiceImpl productPrice->" + productPrice);
		return productPrice;
	}

	// ============================================
	// 수주 목록 조회 (조회 기능)
	// ============================================

	// 총 수주 개수 조회 (검색 조건 포함)
	@Override
	public int totalSales(SalesAll sales) {
		log.info("총 수주 개수 조회 요청: {}", sales);

		// 오늘 날짜 기본값 설정
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(new Date());

		if (sales.getStartDate() == null || sales.getStartDate().isEmpty()) {
			sales.setStartDate(today);
		}
		if (sales.getEndDate() == null || sales.getEndDate().isEmpty()) {
			sales.setEndDate(today);
		}

		log.debug("최종 검색 조건 - 조회기간: {} ~ {}", sales.getStartDate(), sales.getEndDate());

		int totalSales = salesDao.totalSales(sales);
		log.info("총 수주 개수: {}", totalSales);

		return totalSales;
	}

	// 수주 목록 조회 (검색 조건 적용)
	@Override
	public List<SalesAll> listSales(SalesAll sales) {
		log.info("수주 목록 조회 요청: {}", sales);

		// 전체 데이터 개수 조회
		int totalSales = this.totalSales(sales);

		// 페이징 설정
		if (sales.getCurrentPage() == null)
			sales.setCurrentPage("1");
		Paging page = new Paging(totalSales, sales.getCurrentPage());
		sales.setStart(page.getStart());
		sales.setEnd(page.getEnd());

		log.debug("Paging 정보 - start: {}, end: {}, currentPage: {}, totalPage: {}", page.getStart(), page.getEnd(),
				page.getCurrentPage(), page.getTotalPage());

		// 수주 목록 조회
		List<SalesAll> salesList = salesDao.listSales(sales);

		if (salesList == null || salesList.isEmpty()) {
			log.warn("조회된 데이터 없음 (빈 리스트 반환)");
			return List.of();
		}

		log.info("조회된 수주 개수: {}", salesList.size());
		return salesList;
	}

	// ============================================
	// 수주 상세 조회 (상세조회 기능)
	// ============================================

	// 특정 수주의 상세 정보 조회
	@Override
	public SalesAll getInfoSales(String sales_Date, int client_No) {
		log.info("수주 상세 조회 요청: sales_Date={}, client_No={}", sales_Date, client_No);
		SalesAll infoSales = salesDao.infoSales(sales_Date, client_No);
		log.debug("수주 상세 조회 결과: {}", infoSales);
		return infoSales;
	}

	// 특정 수주의 품목 목록 조회
	@Override
	public List<SalesProduct> getSalesProduct(String sales_Date, int client_No) {
		log.info("수주 품목 목록 조회 요청: sales_Date={}, client_No={}", sales_Date, client_No);
		List<SalesProduct> salesProduct = salesDao.getSalesProduct(sales_Date, client_No);
		log.debug("조회된 수주 상품 목록: {}", salesProduct);
		return salesProduct;
	}

	// ============================================
	// 수주 수정 (수정 기능)
	// ============================================

	// 수주 수정
	@Override
	@Transactional
	public int updateSales(SalesAll sales) {
		log.info("수주 수정 요청: {}", sales);
		int updateResult = salesDao.updateSales(sales);
		log.info("수주 수정 완료, result={}", updateResult);
		return updateResult;
	}

	// ============================================
	// 거래처 및 품목 정보 조회 (드롭다운용)
	// ============================================

	// 거래처 번호(client_No)로 거래처 이름 조회
	@Override
	public String getClientNameByNo(int client_No) {
		log.debug("거래처 이름 조회 요청: client_No={}", client_No);
		return salesDao.getClientNameByNo(client_No);
	}

	// 품목 번호(product_No)로 품목 이름 조회
	@Override
	public String getProductNameByNo(int product_No) {
		log.debug("품목 이름 조회 요청: product_No={}", product_No);
		return salesDao.getProductNameByNo(product_No);
	}

	// 담당자 번호(emp_No)로 담당자 이름 조회
	@Override
	public String getEmpNameByNo(int emp_No) {
		log.debug("담당자 이름 조회 요청: emp_No={}", emp_No);
		return salesDao.getEmpNameByNo(emp_No);
	}

	// 모든 거래처 목록 조회
	@Override
	public List<SalesAll> getClientList() {
		log.info("전체 거래처 목록 조회 요청");
		List<SalesAll> clientList = salesDao.getClientList();
		log.debug("조회된 거래처 목록: {}", clientList);
		return clientList;
	}

	// 모든 품목 목록 조회
	@Override
	public List<SalesProduct> getProductList() {
		log.info("전체 품목 목록 조회 요청");
		List<SalesProduct> productList = salesDao.getProductList();
		log.debug("조회된 품목 목록: {}", productList);
		return productList;
	}
}
