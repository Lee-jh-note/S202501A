package org.oracle.s202501a.controller.rw_controller;

import java.util.Arrays;
import java.util.List;

import org.oracle.s202501a.dto.rw_dto.SalesDetailsAll;
import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.oracle.s202501a.service.rw_service.Paging;
import org.oracle.s202501a.service.rw_service.SalesDetailsService;
import org.oracle.s202501a.service.sh_service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class SalesDetailsController {
	
    private final SalesDetailsService salesDetailsService;
	private final UserService userService;


	// =============================================================
	//                             출고 예정
	// =============================================================

    // 출고 예정 조회 (검색 조건 적용)
    @GetMapping("All/Logistics/listPreSalesDetails")
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
    @GetMapping("All/Logistics/infoPreSalesDetails")
    public String infoPreSalesDetails(SalesDetailsAll salesDetails, Model model) {
    	System.out.println("SalesDetailsController infoPreSalesDetails Start...");
    	
        log.info("출고 예정 상세조회 요청: {}", salesDetails);

        // 서비스에서 출고 상세 정보 가져오기
        SalesDetailsAll infoPreSalesDetails = salesDetailsService.infoPreSalesDetails(salesDetails);

        // 서비스에서 출고 품목 목록 가져오기
        List<SalesDetailsAll> infoPreSalesDetailsList = salesDetailsService.infoPreSalesDetailsList(salesDetails);

		// 세션에서 가져온 담당자 (현재 로그인 되어있는 직원) - 출고담당자
		EmpDTO dto = userService.getSe();
		Long emp_no = dto.getEmp_No();
		String emp_name = dto.getEmpName();
		
        // 모델에 데이터 추가
        model.addAttribute("infoPreSalesDetails", infoPreSalesDetails);
        model.addAttribute("infoPreSalesDetailsList", infoPreSalesDetailsList);
		model.addAttribute("emp_no",emp_no);
		model.addAttribute("emp_name",emp_name);
		
        return "rw_views/infoPreSalesDetails";
    }

    
	// =============================================================
	//                      출고/미출고 처리 (상태 변경)
	// =============================================================
     
    // 수주 상태 변경 (수주 상태 + 수주상세 상태)
    @PostMapping("Logistics/updateSalesStatus")
    public String updateSalesStatus(@RequestParam(value = "checked", required = false) int[] checked,
						            @RequestParam("sales_date") String[] salesDates,
						            @RequestParam("client_no") int[] clientNos,
						            @RequestParam("product_no") int[] productNos,
						            @RequestParam("emp_no") int emp_no) {
    	System.out.println("SalesDetailsController updateSalesStatus Start...");
    	    	
        log.info("업데이트 요청: sales_date={}, client_no={}, productNos={}, emp_no={}",
        		salesDates, clientNos, productNos, emp_no);

        try {
            boolean success = salesDetailsService.updateSalesStatus(checked, salesDates, clientNos, productNos, emp_no);
            if (success) {
                return "redirect:/All/Logistics/listPreSalesDetails";
            } else {
                return "rw_views/errorPage";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "rw_views/errorPage";
        }
    }
    
   
    
//    @PostMapping("Logistics/updateSalesStatus")
//    public String updateSalesStatus(@RequestParam("status") int[] statuses,  // 라디오 버튼에서 넘어온 상태값 반영
//						            @RequestParam("sales_date") String[] salesDates,
//						            @RequestParam("client_no") int[] clientNos,
//						            @RequestParam("product_no") int[] productNos,
//						            @RequestParam("emp_no") int emp_no) {
//    	System.out.println("SalesDetailsController updateSalesStatus Start...");
//    	    	
//        log.info("업데이트 요청: sales_date={}, client_no={}, productNos={}, emp_no={}",
//        		salesDates, clientNos, productNos, emp_no);
//
//        try {
//            boolean success = salesDetailsService.updateSalesStatus(statuses, salesDates, clientNos, productNos, emp_no);
//            if (success) {
//                return "redirect:/listPreSalesDetails";
//            } else {
//                return "rw_views/errorPage";
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            return "rw_views/errorPage";
//        }
//    }
    
    
	// =============================================================
	//                             출고
	// =============================================================
    
    // 출고 조회 (검색 조건 적용)
    @GetMapping("All/Logistics/listGoSalesDetails")
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
    @GetMapping("All/Logistics/infoGoSalesDetails")
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
    @GetMapping("All/Logistics/listNoSalesDetails")
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
    @GetMapping("All/Logistics/infoNoSalesDetails")
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
    
    
    // 미출고 상태 변경 (수주 상태 + 수주상세 상태)
    @PostMapping("Logistics/updateNoSalesStatus")
    public String updateNoSalesStatus(
    	    @RequestParam(value = "product_no", required = false) int[] productNos,
    	    @RequestParam("sales_date") String salesDate,       // 단일 값으로
    	    @RequestParam("client_no") int clientNo             // 단일 값으로
    	) {
    	    log.info("업데이트 요청: sales_date={}, client_no={}, productNos={}",
    	             salesDate, clientNo, productNos);

    	    try {
    	        boolean success = salesDetailsService.updateNoSalesStatus(productNos, salesDate, clientNo);
    	        if (success) {
    	            return "redirect:/All/Logistics/listNoSalesDetails";
    	        } else {
    	            log.warn("출고 처리 실패: 선택된 품목 없음");
    	            return "rw_views/errorPage";
    	        }
    	    } catch (Exception e) {
    	        log.error("출고 처리 중 오류 발생", e);
    	        return "rw_views/errorPage";
    	    }
    }
}
    


