package org.oracle.s202501a.controller.rw_controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.oracle.s202501a.dto.rw_dto.Sales;
import org.oracle.s202501a.dto.rw_dto.SalesAll;
import org.oracle.s202501a.dto.rw_dto.SalesDetailsAll;
import org.oracle.s202501a.service.rw_service.Paging;
import org.oracle.s202501a.service.rw_service.SalesDetailsService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class SalesDetailsController {
	
    private final SalesDetailsService salesDetailsService;

	// =============================================================
	//                             출고 예정
	// =============================================================

    // 출고 예정 조회 (검색 조건 적용)
    @GetMapping("/listPreSalesDetails")
    public String listPreSalesDetails(SalesDetailsAll salesDetails, Model model) {
    	System.out.println("SalesDetailsController listPreSalesDetails Start...");
    	
        log.info("출고 예정 리스트 조회 요청: {}", salesDetails);

        // 서비스에서 페이징 포함된 리스트 가져오기 (totalPreSalesDetails 값도 설정됨)
        List<SalesDetailsAll> listPreSalesDetails = salesDetailsService.listPreSalesDetails(salesDetails);
        log.info("출고 예정 리스트 개수: {}", listPreSalesDetails.size());

        // totalPreSalesDetails를 salesDetails에서 가져와서 사용
        Paging page = new Paging(salesDetails.getCount(), salesDetails.getCurrentPage());

        // 모델에 데이터 추가
        model.addAttribute("listPreSalesDetails", listPreSalesDetails);
        model.addAttribute("page", page); // 페이징 정보 추가
        model.addAttribute("params", salesDetails); // 검색 조건 유지

        return "rw_views/listPreSalesDetails";
    }

    // 출고 예정 상세조회 (출고예정 정보 + 출고예정 품목 상세)
    @GetMapping("/infoPreSalesDetails")
    public String infoPreSalesDetails(SalesDetailsAll salesDetails, Model model) {
    	System.out.println("SalesDetailsController infoPreSalesDetails Start...");
    	
        log.info("출고 예정 상세조회 요청: {}", salesDetails);

        // 서비스에서 출고 상세 정보 가져오기
        SalesDetailsAll infoPreSalesDetails = salesDetailsService.infoPreSalesDetails(salesDetails);

        // 서비스에서 출고 품목 목록 가져오기
        List<SalesDetailsAll> infoPreSalesDetailsList = salesDetailsService.infoPreSalesDetailsList(salesDetails);

        // 모델에 데이터 추가
        model.addAttribute("infoPreSalesDetails", infoPreSalesDetails);
        model.addAttribute("infoPreSalesDetailsList", infoPreSalesDetailsList);

        return "rw_views/infoPreSalesDetails";
    }

    
	// =============================================================
	//                      출고/미출고 처리 (상태 변경)
	// =============================================================

//    // 수주 상태 변경
//    @PostMapping("updateSalesStatus")
//    public String updateSalesStatus(@RequestBody Sales sales) {
//    	System.out.println("SalesDetailsController updateSalesStatus Start...");
//    	
//    	salesDetailsService.updateSalesStatus(sales);
//        return "redirect:/listPreSalesDetails";
//    }
//    
//    // 수주상세 상태 변경
//    @PostMapping("updateSalesDetailsStatus")
//    public String updateSalesDetailsStatus(@RequestParam("salesDetailId") int salesDetailId, @RequestParam("status") int status) {
//    	salesDetailsService.updateSalesDetailsStatus(salesDetailId, status);
//        return "redirect:/infoSalesDetails";
//    }
    
//    @PostMapping("/updatePreSalesDetails")
//    public String updatePreSalesDetails(HttpServletRequest request) {
//        // 공통 수주(헤더) 정보 추출
//        String salesDate = request.getParameter("sales_date");
//        int clientNo = Integer.parseInt(request.getParameter("client_no"));
//        String overallStatus = request.getParameter("overallStatus");
//        
//        // 수주(헤더) 상태 업데이트
//        SalesAll sales = new SalesAll();
//        sales.setSales_date(salesDate);
//        sales.setClient_no(clientNo);
//        sales.setStatus(overallStatus);
//        salesDetailsService.updateSalesStatus(sales);
//        
//        // 각 품목(수주상세) 상태 업데이트
//        String[] productNos = request.getParameterValues("product_no");
//        String[] detailStatuses = request.getParameterValues("detailStatus");
//        
//        if (productNos != null && detailStatuses != null 
//                && productNos.length == detailStatuses.length) {
//            for (int i = 0; i < productNos.length; i++) {
//                SalesDetailsAll detail = new SalesDetailsAll();
//                detail.setSales_date(salesDate);
//                detail.setClient_no(clientNo);
//                // product_no는 정수형이므로 파싱
//                detail.setProduct_no(Integer.parseInt(productNos[i]));
//                detail.setStatus(detailStatuses[i]);
//                salesDetailsService.updateSalesDetailsStatus(detail);
//            }
//        }
//        
//        // 업데이트 후 상세조회 화면으로 리다이렉트
//        return "redirect:/infoPreSalesDetails?sales_date=" + salesDate + "&client_no=" + clientNo;
//    }

//    @PostMapping("/updateSalesStatus")
//    public String updateSalesStatus(
//            @ModelAttribute SalesAll sales,                  // 헤더 정보 (SalesAll DTO)
//            @RequestParam("product_no") int[] productNos,       // 각 품목의 제품번호 배열
//            @RequestParam("salesDetailsStatus") String[] detailStatuses) { // 각 품목의 상태 배열 ("출고", "미출고")
//        
//        boolean updateSuccess = salesDetailsService.updateSalesStatus(sales, productNos, detailStatuses);
//        
//        if (updateSuccess) {
//            return "redirect:/infoPreSalesDetails?sales_date=" + sales.getSales_date() 
//                   + "&client_no=" + sales.getClient_no();
//        } else {
//            return "error";
//        }
//    }
    // 단일 엔드포인트: 폼 전송으로 전달된 헤더와 각 품목의 정보를 받아 서비스의 복합메서드 호출
    @PostMapping("/updateSalesStatus")
    public String updateSalesStatus(
            @ModelAttribute SalesAll sales,                  // 헤더 정보 (SalesAll DTO)
            @RequestParam("product_no") int[] productNos,       // 각 품목의 제품번호 배열
            @RequestParam("salesDetailsStatus") String[] detailStatuses) { // 각 품목의 상태 배열 ("출고", "미출고")
        
        boolean updateSuccess = salesDetailsService.updateSalesStatus(sales, productNos, detailStatuses);
        
        if (updateSuccess) {
            return "redirect:/infoSalesDetails?sales_date=" + sales.getSales_date() 
                   + "&client_no=" + sales.getClient_no();
        } else {
            return "error";
        }
    }


    
    
	// =============================================================
	//                             출고
	// =============================================================
    
    // 출고 조회 (검색 조건 적용)
    @GetMapping("/listGoSalesDetails")
    public String listGoSalesDetails(SalesDetailsAll salesDetails, Model model) {
    	System.out.println("SalesDetailsController listGoSalesDetails Start...");
    	
        log.info("출고 리스트 조회 요청: {}", salesDetails);

        // 서비스에서 페이징 포함된 리스트 가져오기 (totalGoSalesDetails 값도 설정됨)
        List<SalesDetailsAll> listGoSalesDetails = salesDetailsService.listGoSalesDetails(salesDetails);
        log.info("출고 리스트 개수: {}", listGoSalesDetails.size());

        // totalGoSalesDetails를 salesDetails에서 가져와서 사용
        Paging page = new Paging(salesDetails.getCount(), salesDetails.getCurrentPage());

        // 모델에 데이터 추가
        model.addAttribute("listGoSalesDetails", listGoSalesDetails);
        model.addAttribute("page", page); // 페이징 정보 추가
        model.addAttribute("params", salesDetails); // 검색 조건 유지

        return "rw_views/listGoSalesDetails";
    }
    
    
    // 출고 상세조회 (출고 정보 + 출고 품목 상세)
    @GetMapping("/infoGoSalesDetails")
    public String infoGoSalesDetails(SalesDetailsAll salesDetails, Model model) {
    	System.out.println("SalesDetailsController infoGoSalesDetails Start...");
    	
        log.info("출고 상세조회 요청: {}", salesDetails);

        // 서비스에서 출고 상세 정보 가져오기
        SalesDetailsAll infoGoSalesDetails = salesDetailsService.infoGoSalesDetails(salesDetails);

        // 서비스에서 출고 품목 목록 가져오기
        List<SalesDetailsAll> infoGoSalesDetailsList = salesDetailsService.infoGoSalesDetailsList(salesDetails);

        // 모델에 데이터 추가
        model.addAttribute("infoGoSalesDetails", infoGoSalesDetails);
        model.addAttribute("infoGoSalesDetailsList", infoGoSalesDetailsList);

        return "rw_views/infoGoSalesDetails";
    }

    
	// =============================================================
	//                             미출고
	// =============================================================

    // 미출고 조회 (검색 조건 적용)
    @GetMapping("/listNoSalesDetails")
    public String listNoSalesDetails(SalesDetailsAll salesDetails, Model model) {
    	System.out.println("SalesDetailsController listNoSalesDetails Start...");
    	
        log.info("미출고 리스트 조회 요청: {}", salesDetails);

        // 서비스에서 페이징 포함된 리스트 가져오기 (totalNoSalesDetails 값도 설정됨)
        List<SalesDetailsAll> listNoSalesDetails = salesDetailsService.listNoSalesDetails(salesDetails);
        log.info("미출고 리스트 개수: {}", listNoSalesDetails.size());

        // totalNoSalesDetails를 salesDetails에서 가져와서 사용
        Paging page = new Paging(salesDetails.getCount(), salesDetails.getCurrentPage());

        // 모델에 데이터 추가
        model.addAttribute("listNoSalesDetails", listNoSalesDetails);
        model.addAttribute("page", page); // 페이징 정보 추가
        model.addAttribute("params", salesDetails); // 검색 조건 유지

        return "rw_views/listNoSalesDetails";
    }
    
    // 미출고 상세조회 (미출고 정보 + 미출고 품목 상세)
    @GetMapping("/infoNoSalesDetails")
    public String infoNoSalesDetails(SalesDetailsAll salesDetails, Model model) {
    	System.out.println("SalesDetailsController infoNoSalesDetails Start...");
    	
        log.info("미출고 상세조회 요청: {}", salesDetails);

        // 서비스에서 미출고 상세 정보 가져오기
        SalesDetailsAll infoNoSalesDetails = salesDetailsService.infoNoSalesDetails(salesDetails);

        // 서비스에서 미출고 품목 목록 가져오기
        List<SalesDetailsAll> infoNoSalesDetailsList = salesDetailsService.infoNoSalesDetailsList(salesDetails);

        // 모델에 데이터 추가
        model.addAttribute("infoNoSalesDetails", infoNoSalesDetails);
        model.addAttribute("infoNoSalesDetailsList", infoNoSalesDetailsList);

        return "rw_views/infoNoSalesDetails";
    }

}
