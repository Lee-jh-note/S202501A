package org.oracle.s202501a.controller.rw_controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.oracle.s202501a.dto.rw_dto.Sales;
import org.oracle.s202501a.dto.rw_dto.SalesAll;
import org.oracle.s202501a.dto.rw_dto.SalesProduct;
import org.oracle.s202501a.service.rw_service.Paging;
import org.oracle.s202501a.service.rw_service.SalesService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
//@RequestMapping("/sales")
public class SalesController {

	private final SalesService salesService;

	// ============================================
	// 수주(Sales) 등록(Create)
	// ============================================

	// 수주서 등록 페이지로 이동 (거래처&제품 목록 제공)
	@GetMapping("/createSales")
	public String createSalesPage(Model model) {
		System.out.println("SalesController createSalesPage Start...");

		// 거래처 목록 조회(드롭다운)
		List<SalesAll> clientList = salesService.getClientList();
		// 제품 목록 조회(드롭다운)
		List<SalesProduct> productList = salesService.getProductList();

		log.debug("조회된 거래처 목록: {}", clientList);
		log.debug("조회된 제품 목록: {}", productList);

		// 조회된 데이터 모델에 추가
		model.addAttribute("clientList", clientList);
		model.addAttribute("productList", productList);

		// 수주서 등록 페이지로 이동
		return "rw_views/createSales";
	}
	
	   // 품목 선택 시 단가 자동 설정
	   @ResponseBody
	   @RequestMapping(value = "getProductPrice")
	   public int getProductPrice(SalesAll sales, Model model) {
	      System.out.println("SalesController getPrice product_no->"+sales.getProduct_No());
	      int productPrice = salesService.productPrice(sales.getProduct_No());
	      System.out.println("SalesController getPrice productPrice->"+productPrice);
	      return productPrice;
	   }

	// 수주서 등록 처리 (AJAX 요청)
	@PostMapping("/createSales")
	public ResponseEntity<Map<String, Object>> createSales(@RequestBody SalesAll sales) {
		log.info("수주 등록 요청: {}", sales);

		Map<String, Object> response = new HashMap<>();

		try {
			// 매출일자 오늘 날짜로 자동 설정
//	        sales.setSales_Date(LocalDate.now().toString());

			// 수주 기본 정보 저장(수주서 상단)
			int result = salesService.createSales(sales);

			if (result > 0 && sales.getProductList() != null) {
				// 수주 품목 정보 저장(수주서 하단)
				for (SalesProduct product : sales.getProductList()) {
					product.setSales_Date(sales.getSales_Date()); // 매출일자 연결
					product.setClient_No(sales.getClient_No()); // 거래처번호 연결
					salesService.insertSalesProduct(product); // 개별 품목 저장
				}
			}
			// 성공 응답 메시지
			response.put("status", "success");
			response.put("message", "수주서 등록 완료");

		} catch (Exception e) {
			log.error("수주 등록 오류: {}", e.getMessage(), e);
			// 실패 응답 메시지
			response.put("status", "fail");
			response.put("message", "수주서 등록 실패");
		}
		// JSON 응답 반환
		return ResponseEntity.ok(response);
	}

	// ============================================
	// 수주 목록 조회 (조회 기능)
	// ============================================

	// 수주 목록 조회 (검색 포함)
	@RequestMapping(value = "listSales")
	public String listSales(SalesAll sales, Model model) {
		log.info("listSales 조회 요청: {}", sales);

		// 오늘 날짜 기본값 설정
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(new Date());

		if (sales.getStartDate() == null || sales.getStartDate().trim().isEmpty()) {
			sales.setStartDate(today);
		}
		if (sales.getEndDate() == null || sales.getEndDate().trim().isEmpty()) {
			sales.setEndDate(today);
		}

		log.debug("조회기간: {} ~ {}", sales.getStartDate(), sales.getEndDate());
		log.debug("거래처명: {}", sales.getClient_Name());
		log.debug("처리상태: {}", sales.getStatus());

		// 전체 데이터 개수 조회
		int totalSales = salesService.totalSales(sales);

		// 페이징 처리
		Paging page = new Paging(totalSales, sales.getCurrentPage());
		sales.setStart(page.getStart());
		sales.setEnd(page.getEnd());

		log.debug("Paging 설정: start={}, end={}", sales.getStart(), sales.getEnd());

		// 수주 목록 조회
		List<SalesAll> listSales = salesService.listSales(sales);
		log.info("조회된 수주 개수: {}", listSales.size());

		model.addAttribute("totalSales", totalSales);
		model.addAttribute("listSales", listSales);
		model.addAttribute("page", page);
		model.addAttribute("sales", sales);

		return "rw_views/listSales";
	}

	// ============================================
	// 수주 상세 조회 (상세조회 기능)
	// ============================================

	// 수주 상세 조회
	@GetMapping("/infoSales")
	public String infoSales(@RequestParam("sales_Date") String sales_Date, @RequestParam("client_No") int client_No,
			Model model) {
		log.info("infoSales 조회 시작: sales_Date={}, client_No={}", sales_Date, client_No);

		SalesAll infoSales = salesService.getInfoSales(sales_Date, client_No);
		List<SalesProduct> salesProduct = salesService.getSalesProduct(sales_Date, client_No);

		if (infoSales == null) {
			log.warn("infoSales 데이터 없음!");
		}
		if (salesProduct == null || salesProduct.isEmpty()) {
			log.warn("salesProduct 데이터 없음!");
		}

		model.addAttribute("infoSales", infoSales);
		model.addAttribute("SalesProduct", salesProduct);

		return "rw_views/infoSales";
	}

	// ============================================
	// 수주 수정 (수정 기능)
	// ============================================

	// 수주 수정 페이지 이동
	@GetMapping("/updateSales")
	public String updateSalesPage(@RequestParam("sales_Date") String sales_Date,
			@RequestParam("client_No") int client_No, Model model) {
		log.info("updateSales 페이지 진입: sales_Date={}, client_No={}", sales_Date, client_No);

		SalesAll infoSales = salesService.getInfoSales(sales_Date, client_No);
		List<SalesProduct> salesProduct = salesService.getSalesProduct(sales_Date, client_No);

		log.debug("조회된 infoSales: {}", infoSales);
		log.debug("조회된 salesProduct: {}", salesProduct);

		model.addAttribute("infoSales", infoSales);
		model.addAttribute("salesProduct", salesProduct);

		return "rw_views/updateSales";
	}

	// 수주 수정 처리
	@PostMapping("/updateSales")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> updateSales(@RequestBody SalesAll sales) {
		log.info("수주 수정 요청: {}", sales);

		Map<String, Object> response = new HashMap<>();
		int updateResult = salesService.updateSales(sales);

		if (updateResult > 0) {
			response.put("status", "success");
			response.put("message", "수주 수정 성공");
		} else {
			response.put("status", "fail");
			response.put("message", "수주 수정 실패");
		}

		return ResponseEntity.ok(response);
	}

	// ============================================
	// 수주 삭제 (삭제 기능)
	// ============================================

	// 수주 삭제
//    @PostMapping("/deleteSales")
//    @ResponseBody
//    public ResponseEntity<Map<String, Object>> deleteSales(@RequestParam("sales_Date") String sales_Date,
//                                                           @RequestParam("client_No") int client_No) {
//        log.info("수주 삭제 요청: sales_Date={}, client_No={}", sales_Date, client_No);
//
//        int deleteResult = salesService.deleteSales(sales_Date, client_No);
//        Map<String, Object> response = new HashMap<>();
//
//        response.put("status", deleteResult > 0 ? "success" : "fail");
//        response.put("message", deleteResult > 0 ? "수주 삭제 성공" : "수주 삭제 실패");
//
//        return ResponseEntity.ok(response);
//    }
}
