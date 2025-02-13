package org.oracle.s202501a.controller.yj_controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.oracle.s202501a.dto.yj_dto.PurchaseDetailsAll;
import org.oracle.s202501a.service.sh_service.UserService;
import org.oracle.s202501a.service.yj_service.Paging;
import org.oracle.s202501a.service.yj_service.PurchaseDetailService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class PurchaseDetailController {
	private final PurchaseDetailService ps;
	
	// 세션과 연결된 UserService
	private final UserService f;
	
	// 입고 예정리스트 검색 (기간, 제품, 거래처, 담당자)
	@RequestMapping(value = "All/Logistics/listPurchaseDetailPlan")
	public String listPurchaseDetailPlan(PurchaseDetailsAll purchase_details, Model model) {

		// Purchase_details "대기" 검색 Cnt
		int searchTotalPurchaseDetailPlan = ps.searchTotalPurchaseDetailPlan(purchase_details);

		// 페이징,,
		Paging page = new Paging(searchTotalPurchaseDetailPlan, purchase_details.getCurrentPage());
		purchase_details.setStart(page.getStart()); // 시작시 1
		purchase_details.setEnd(page.getEnd());		//  15
		
		List<PurchaseDetailsAll> searchListPurchaseDetailPlan = ps.searchListPurchaseDetailPlan(purchase_details);
		
		// 검색하고 나서 그 키워드들이 남아있기를 원해서 넣음 jsp에는 value로 값들 넣어둠(검색조건에)
		model.addAttribute("searchKeyword", purchase_details);
		model.addAttribute("total", searchTotalPurchaseDetailPlan);
		model.addAttribute("listPurchaseDetailPlan", searchListPurchaseDetailPlan); // yj_views/listPurchase에서 listPurchase를 써서 forEach로 값들을 넣어줬기 때문에 "listPurchase" 맞춰줘야함
		model.addAttribute("page", page);
		
		return "yj_views/listPurchaseDetailPlan";
	}
	
	// 입고 예정리스트에서 상세로
	@GetMapping(value = "All/Logistics/detailPurchaseDetailPlan")
	public String detailPurchaseDetailPlan(PurchaseDetailsAll purchase_details, Model model) {
		
		// 매입일자와 거래처번호로 상세조회
		Map<String, Object> params = new HashMap<>();
		params.put("purchase_date", purchase_details.getPurchase_date());
		params.put("client_no", purchase_details.getClient_no());
//		System.out.println("PurchaseDetailController detailPurchaseDetailPlan params->"+params);
		
		EmpDTO dto = f.getSe();
		Long emp_no = dto.getEmp_No();
		String emp_name = dto.getEmpName();
		// 세션에서 가져온 담당자 - 현재 로그인 되어있는 담당자 - 입고 담당자
		model.addAttribute("emp_no", emp_no);
		model.addAttribute("emp_name", emp_name);
		
		// 정보 가져오기
		// 정보 가져올때 매입일자, 거래처이름, 담당자 이름 가져오고,
		PurchaseDetailsAll purchase_details1 = ps.detailPurchaseDetailPlan(params);
		// 물품은 여러개일 수 있으니까 리스트 형식으로 가져와야해서 한번 더
		List<PurchaseDetailsAll> purchase_details_list = ps.detailPurchaseDetailPlanList(params);
//		System.out.println("PurchaseDetailController detailPurchaseDetailPlan purchase_details1->"+purchase_details1);
		
		// 가져온 정보들 purchase_details에 넣어주기
		model.addAttribute("purchase_details",purchase_details1);
		model.addAttribute("purchase_details_list",purchase_details_list);
		
		return "yj_views/detailPurchaseDetailPlan";
	}
	
	// 입고 버튼 처리
    @PostMapping("Logistics/purchaseDetailStore")
    public String purchaseDetailStore(
            @RequestParam(value = "checked", required = false) int[] checked,
            @RequestParam("purchase_date") String[] purchaseDates,
            @RequestParam("client_no") int[] clientNos,
            @RequestParam("product_no") int[] productNos,
            // 입고처리를 해주면서, 입고 담당자도 입고 처리를 할 때 로그인 되어있는 사원의 이름와 번호로 입력되도록!! 입고 담당자~
            @RequestParam("emp_no") int currentNo,
            RedirectAttributes redirectAttributes) {

        try {
//        	throw new Exception("일부러 실패 테스트");
            List<Integer> checkedList = checked == null ? List.of() : Arrays.stream(checked).boxed().collect(Collectors.toList());
            boolean allChecked = true;

            for (int i = 0; i < purchaseDates.length; i++) {
                boolean isChecked = checkedList.contains(i);
                if (isChecked) {
                    // 입고. 구매상세 상태 2로 변경
                	ps.updatePurchaseDetailStatusManager(purchaseDates[i], clientNos[i], productNos[i], currentNo, 2);
                } else {
                    // 미입고. 구매상세 상태 1
                    ps.updatePurchaseDetailStatusManager(purchaseDates[i], clientNos[i], productNos[i], currentNo, 1);
                    allChecked = false;
                }
            }
            if(purchaseDates.length > 0){
                if(allChecked){
                    // 전부 체크됨 = 구매(완료) 상태 
                    ps.updatePurchaseStatus(purchaseDates[0], clientNos[0], 2);
                }else{
                    // 체크 안된게 있음 = 구매(부분입고) 상태
                    ps.updatePurchaseStatus(purchaseDates[0], clientNos[0], 1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "입고 처리 실패: " + e.getMessage());
        }
        return "redirect:/All/Logistics/listPurchaseDetailPlan";
    }
    
	// 미입고 조회에서 버튼 처리
    @PostMapping("Logistics/purchaseDetailRestore")
    public String purchaseDetailRestore(
            @RequestParam(value = "checked", required = false) int[] checked,
            @RequestParam("purchase_date") String[] purchaseDates,
            @RequestParam("client_no") int[] clientNos,
            @RequestParam("product_no") int[] productNos,
            @RequestParam("emp_no") int empNo, RedirectAttributes redirectAttributes) {

        try {
//        	throw new Exception("일부러 실패 테스트");
            List<Integer> checkedList = checked == null ? List.of() : Arrays.stream(checked).boxed().collect(Collectors.toList());
            boolean allChecked = true;

            for (int i = 0; i < purchaseDates.length; i++) {
                boolean isChecked = checkedList.contains(i);
                if (isChecked) {
                    // 입고. 구매상세 상태 2로 변경
                	ps.updatePurchaseDetailStatusManager(purchaseDates[i], clientNos[i], productNos[i], empNo, 2);
                } else {
                    // 미입고. 구매상세 상태 1
                    ps.updatePurchaseDetailStatusManager(purchaseDates[i], clientNos[i], productNos[i], empNo, 1);
                    allChecked = false;
                }
            }
            if(purchaseDates.length > 0){
                if(allChecked){
                    // 전부 체크됨 = 구매(완료) 상태 
                    ps.updatePurchaseStatus(purchaseDates[0], clientNos[0], 2);
                } // 기존 입고 처리 버튼에는 부분입고로 바꿔주는 코드가 else로 해서 있었는데 여기선 전부 체크된게 아닌이상 부분입고의 상태를 변경해 줄 일은 없어서 뺌
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "입고 처리 실패: " + e.getMessage());
        }
        return "redirect:/All/Logistics/listPurchaseDetailNo";
    }
	

	
	// 입고 조회 검색 (기간, 제품, 거래처, 담당자)("입고"니까 구매상세의 상태가 2인 값들만 들어와야함!!)
	@RequestMapping(value = "All/Logistics/listPurchaseDetail")
	public String searchPurchaseDetail(PurchaseDetailsAll purchase_details, Model model) {

		// Purchase_details "입고" 검색 Cnt
		int searchTotalPurchaseDetail = ps.searchTotalPurchaseDetail(purchase_details);
		
		// 페이징,,
		Paging page = new Paging(searchTotalPurchaseDetail, purchase_details.getCurrentPage());
		purchase_details.setStart(page.getStart()); // 시작시 1
		purchase_details.setEnd(page.getEnd());		//  15
		
		List<PurchaseDetailsAll> searchListPurchaseDetail = ps.searchListPurchaseDetail(purchase_details);
		
		// 검색하고 나서 그 키워드들이 남아있기를 원해서 넣음 jsp에는 value로 값들 넣어둠(검색조건에)
		model.addAttribute("searchKeyword", 			purchase_details);
		model.addAttribute("total", 					searchTotalPurchaseDetail);
		model.addAttribute("searchListPurchaseDetail", 	searchListPurchaseDetail);
		model.addAttribute("page", 						page);
		
		return "yj_views/listPurchaseDetail";
	}
	
	// 입고 조회의 상세 화면
	@GetMapping(value = "All/Logistics/detailPurchaseDetail")
	public String detailPurchaseDetail(PurchaseDetailsAll purchase_details, Model model) {
		System.out.println("PurchaseDetailController detailPurchaseDetail start,,");
		
		// 매입일자와 거래처번호로 상세조회
		Map<String, Object> params = new HashMap<>();
		params.put("purchase_date", purchase_details.getPurchase_date());
		params.put("client_no", purchase_details.getClient_no());
		
		// 정보 가져오기
		// 1. 매입일자, 거래처명, 담당자명
		PurchaseDetailsAll purchase_details1 = ps.detailPurchaseDetail(params);
		// 2. 물품에 대한 정보(리스트) 품목명, 단가, 수량
		List<PurchaseDetailsAll> purchase_details_list = ps.detailPurchaseDetailList(params);
		
		// 가져온 정보들 넣어주기
		model.addAttribute("purchase_details",purchase_details1);
		model.addAttribute("purchase_details_list",purchase_details_list);
		
		return "yj_views/detailPurchaseDetail";
	}
	

	// 미입고 조회 검색 (기간, 제품, 거래처, 담당자)("미입고"니까 구매상세의 상태가 1인 값들만 들어와야함!!)
	@RequestMapping(value = "All/Logistics/listPurchaseDetailNo")
	public String searchPurchaseDetailNo(PurchaseDetailsAll purchase_details, Model model) {
		// Purchase_details "미입고" 검색 Cnt
		int searchTotalPurchaseDetailNo = ps.searchTotalPurchaseDetailNo(purchase_details);
		// 페이징,,
		Paging page = new Paging(searchTotalPurchaseDetailNo, purchase_details.getCurrentPage());
		purchase_details.setStart(page.getStart()); // 시작시 1
		purchase_details.setEnd(page.getEnd());		//  15
		
		List<PurchaseDetailsAll> searchListPurchaseDetailNo = ps.searchListPurchaseDetailNo(purchase_details);
		
		model.addAttribute("total", searchTotalPurchaseDetailNo);
		model.addAttribute("searchListPurchaseDetailNo", searchListPurchaseDetailNo);
		model.addAttribute("page", page);
		
		return "yj_views/listPurchaseDetailNo";
	}
	
	// 미입고 조회의 상세 화면
	// 입고 조회의 데이터 불러오기 사용
	@GetMapping(value = "All/Logistics/detailPurchaseDetailNo")
	public String detailPurchaseDetailNo(PurchaseDetailsAll purchase_details, Model model) {
		
		// 매입일자와 거래처번호로 상세조회
		Map<String, Object> params = new HashMap<>();
		params.put("purchase_date", purchase_details.getPurchase_date());
		params.put("client_no", purchase_details.getClient_no());
		
		// 정보 가져오기
		// 1. 매입일자, 거래처명, 담당자명
		PurchaseDetailsAll purchase_details1 = ps.detailPurchaseDetailNo(params);
		// 2. 물품에 대한 정보(리스트) 품목명, 단가, 수량
		List<PurchaseDetailsAll> purchase_details_list = ps.detailPurchaseDetailNoList(params);
		
		// 가져온 정보들 넣어주기
		model.addAttribute("purchase_details",purchase_details1);
		model.addAttribute("purchase_details_list",purchase_details_list);
		
		return "yj_views/detailPurchaseDetailNo";
	}
		
	
}
