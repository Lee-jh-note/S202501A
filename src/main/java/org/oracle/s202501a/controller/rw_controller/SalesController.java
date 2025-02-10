package org.oracle.s202501a.controller.rw_controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.oracle.s202501a.dto.rw_dto.SalesAll;
import org.oracle.s202501a.dto.rw_dto.SalesDetailsAll;
import org.oracle.s202501a.service.rw_service.Paging;
import org.oracle.s202501a.service.rw_service.SalesService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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

	// =============================================================
	//                             등록
	// =============================================================

	// 수주 등록 페이지로 이동 (거래처 목록 & 제품 목록 & 담당자 목록(임시) 조회)
	@GetMapping("/createSales")
	public String createSalesPage(Model model) {
		System.out.println("SalesController createSalesPage Start...");

		// 거래처 목록 조회(드롭다운)
		List<SalesAll> clientList = salesService.getClientList();
		log.debug("조회된 거래처 목록: {}", clientList);
		// 제품 목록 조회(드롭다운)
		List<SalesDetailsAll> productList = salesService.getProductList();
		log.debug("조회된 제품 목록: {}", productList);
		// 담당자 목록 조회(드롭다운) - 임시용
		List<SalesAll> empList = salesService.getEmpList();
		log.debug("조회된 담당자 목록: {}", empList);

		// 조회된 데이터 모델에 추가
		model.addAttribute("clientList", clientList);
		model.addAttribute("productList", productList);
		model.addAttribute("empList", empList);

		// 수주 등록 페이지로 이동
		return "rw_views/createSales";
	}

	
	// 수주 등록 (수주 정보 & 품목 정보) - AJAX 요청
	@ResponseBody
	@PostMapping("/createSales")
	public Map<String, Object> createSales(@RequestBody SalesAll sales) {
		System.out.println("SalesController createSales Start...");

		log.info("수주 등록 요청: {}", sales);

		Map<String, Object> resultMap  = new HashMap<>();

		try {
			// 수주 정보 + 품목 등록
			int result = salesService.createSales(sales);

	        // 응답 메시지
	        if (result > 0) {
	            resultMap.put("status", "success");
	            resultMap.put("message", "수주서 등록 완료");
	        } else {
	            resultMap.put("status", "fail");
	            resultMap.put("message", "수주서 등록 실패");
	        }
	    } catch (Exception e) {
	        log.error("수주 등록 오류: {}", e.getMessage(), e);
	        resultMap.put("status", "fail");
	        resultMap.put("message", "수주서 등록 중 오류 발생");
	    }
		
		// JSON 응답 반환
		return resultMap;
	}

	// 제품 선택 시 단가 자동설정
	@ResponseBody
	@GetMapping("/getProductPrice")
	public int getProductPrice(@RequestParam("product_no") int product_no) {
		System.out.println("SalesController getProductPrice Start...");

		log.info("선택한 제품번호: product_no={}", product_no);
		
		int productPrice = salesService.getProductPrice(product_no);
		
		log.info("조회된 제품 단가: {}", productPrice);
		return productPrice;
	}
	
	// 중복확인 (sales_date와 client_no 비교해서 같은 날짜에 같은 거래처 수주가 없는지 수주 등록 전 미리 확인)
	@ResponseBody 
	@GetMapping("/checkDuplicateSales")
    public Map<String, Boolean> checkDuplicateSales(@RequestParam("client_no") String client_no, 
    												@RequestParam("sales_date") String sales_date) {
    	System.out.println("SalesController checkDuplicateSales Start...");
        
        log.debug("중복 체크 요청: client_no={}, sales_date={}", client_no, sales_date);

        boolean isDuplicate = salesService.checkDuplicateSales(client_no, sales_date);
        
        log.info("중복 여부 확인: {}", isDuplicate);

        // 결과 반환
        Map<String, Boolean> result = new HashMap<>();
        result.put("isDuplicate", isDuplicate); // JSON 응답
        
        log.info("중복 확인 결과: {}", isDuplicate);
        
        return result;
    }
    

	// =============================================================
	//                             조회
	// =============================================================
	
    // 수주 목록 조회 (검색 조건 적용)
    @GetMapping("/listSales")
    public String listSales(SalesAll sales, Model model) {
    	System.out.println("SalesController listSales Start...");
    	
        log.info("수주 목록 조회 요청: {}", sales);

        // 서비스에서 페이징 포함된 리스트 가져오기 (totalSales 값도 설정됨)
        List<SalesAll> listSales = salesService.listSales(sales);
        log.info("수주 목록 개수: {}", listSales.size());

        // totalSales를 sales에서 가져와서 사용
        Paging page = new Paging(sales.getCount(), sales.getCurrentPage());

        // 모델에 데이터 추가
        model.addAttribute("listSales", listSales);
        model.addAttribute("page", page); // 페이징 정보 추가
        model.addAttribute("params", sales); // 검색 조건 유지

        return "rw_views/listSales";
    }
	

	// 수주 상세 조회 (수주 정보 + 수주 품목 상세)
	@GetMapping("/infoSales")
	public String infoSales(SalesAll sales, Model model) {
		System.out.println("SalesController infoSales Start...");

        log.info("수주 상세조회 요청: {}", sales);

        // 서비스에서 수주 상세 정보 가져오기
	    SalesAll infoSales = salesService.infoSales(sales);

        // 서비스에서 수주 품목 목록 가져오기
	    List<SalesDetailsAll> infoSalesDetails = salesService.infoSalesDetails(sales);

	    // 모델에 데이터 추가
	    model.addAttribute("infoSales", infoSales);
	    model.addAttribute("infoSalesDetails", infoSalesDetails);

	    return "rw_views/infoSales";
	}

	// =============================================================
	//                             수정
	// =============================================================		
	
	// 수주 수정 페이지 이동 (처리 상태가 '대기'인 경우만 가능)
    @GetMapping("/updateSales")
    public String updateSalesPage(SalesAll sales, Model model) {
        log.info("updateSales 페이지 이동: {}", sales);

        // 수주 기본 정보 조회
        SalesAll infoSales = salesService.infoSales(sales);
        log.debug("조회된 infoSales: {}", infoSales);

        // 수주 상세 정보 조회
        List<SalesDetailsAll> infoSalesDetails = salesService.infoSalesDetails(sales);
        log.debug("조회된 infoSalesDetails: {}", infoSalesDetails);
        
		// 제품 목록 조회(드롭다운)
		List<SalesDetailsAll> productList = salesService.getProductList();
		log.debug("조회된 제품 목록: {}", productList);

        // 모델에 데이터 추가        
        model.addAttribute("infoSales", infoSales);
        model.addAttribute("infoSalesDetails", infoSalesDetails);
		model.addAttribute("productList", productList);

        return "rw_views/updateSales";
    }

	// 수주 정보 수정 (처리 상태가 '대기'인 경우만 가능)
	@ResponseBody
	@PostMapping("/updateSales")
	public Map<String, Object> updateSales(@RequestBody SalesAll sales) {
		System.out.println("SalesController updateSales Start...");

		log.info("수주 수정 요청: {}", sales);

	    Map<String, Object> resultMap = new HashMap<>();
	    
	    try {
	        int updateResult = salesService.updateSales(sales);

	        if (updateResult > 0) {
	            resultMap.put("status", "success");
	            resultMap.put("message", "수주 수정 성공");
	        } else {
	            resultMap.put("status", "fail");
	            resultMap.put("message", "수주 수정 실패");
	        }
	    } catch (Exception e) {
	        log.error("수주 수정 오류 발생: {}", e.getMessage(), e);
	        resultMap.put("status", "fail");
	        resultMap.put("message", "수정 중 오류 발생");
	    }

	    return resultMap;
	}
	


	// =============================================================
	//                             삭제
	// =============================================================

	// 수주 삭제 (처리 상태가 '대기'인 경우만 가능)- 품목 삭제 후 수주 정보 삭제
    @PostMapping("/deleteSales")
    public String deleteSales(SalesAll sales) {
    	System.out.println("SalesController deleteSales Start...");
    	
        try {
            // 수주 삭제 (수주 품목 먼저 삭제 후 수주 정보 삭제)
            int deleteSalesCount = salesService.deleteSales(sales);
    	    log.info("수주 삭제 완료 (deleteSalesCount={})", deleteSalesCount); 
    	    
            // 삭제가 성공하면 수주 목록 페이지로 리다이렉트
            return "redirect:/listSales";
            
        } catch (Exception e) {
            e.printStackTrace();
            
            // 에러 발생 시 에러 페이지로 이동 
            return "rw_views/errorPage";
        }
    }


    // 에러페이지 test
    @GetMapping("/errorPage")
    public String showErrorPage() {
        return "rw_views/errorPage";  
    }
    
}
