package org.oracle.s202501a.controller.yj_controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.oracle.s202501a.dto.yj_dto.PurchaseDetailsAll;
import org.oracle.s202501a.service.yj_service.Paging;
import org.oracle.s202501a.service.yj_service.PurchaseDetailService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
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
public class PurchaseDetailController {
	private final PurchaseDetailService ps;
	
	// 입고 예정 리스트("예정"이니까 상태가 0인 값들만 들어와야함. 매퍼에서 sql문 조절)
	@RequestMapping(value = "listPurchaseDetailPlan")
	public String listPurchaseDetailPlan(PurchaseDetailsAll purchase_details, Model model) {
		System.out.println("PurchaseDetailController listPurchaseDetailPlan start,,");
		
		// 페이징
		int totalPurchaseDetailPlan = ps.totalPurchaseDetailPlan();
		if (purchase_details.getCurrentPage() == null) purchase_details.setCurrentPage("1");
		Paging page = new Paging(totalPurchaseDetailPlan, purchase_details.getCurrentPage());
		
		purchase_details.setStart(page.getStart());
		purchase_details.setEnd(page.getEnd());
		
		List<PurchaseDetailsAll> listPurchaseDetailPlan = ps.listPurchaseDetailPlan(purchase_details);
		System.out.println("PurchaseDetailController listPurchaseDetailPlan listPurchaseDetailPlan.size()->"+listPurchaseDetailPlan.size());
		
		model.addAttribute("total",						totalPurchaseDetailPlan);
		model.addAttribute("listPurchaseDetailPlan", 	listPurchaseDetailPlan);
		model.addAttribute("page", 					page);	
		
		return "yj_views/listPurchaseDetailPlan";
	}
	
	// 입고 예정리스트 검색 (기간, 제품, 거래처, 담당자)
	@RequestMapping(value = "searchPurchaseDetailPlan")
	public String searchPurchaseDetailPlan(PurchaseDetailsAll purchase_details, Model model) {
		System.out.println("PurchaseDetailController searchPurchaseDetailPlan start,,");
		System.out.println("PurchaseDetailController searchPurchaseDetailPlan purchase_details ->" + purchase_details);
		// Purchase_details "대기" 검색 Cnt
		int searchTotalPurchaseDetailPlan = ps.searchTotalPurchaseDetailPlan(purchase_details);
		System.out.println("PurchaseController searchPurchaseDetailPlan searchTotalPurchaseDetailPlan ->" + searchTotalPurchaseDetailPlan);
		// 페이징,,
		Paging page = new Paging(searchTotalPurchaseDetailPlan, purchase_details.getCurrentPage());
		purchase_details.setStart(page.getStart()); // 시작시 1
		purchase_details.setEnd(page.getEnd());		//  15
		System.out.println("PurchaseDetailController searchPurchaseDetailPlan page ->"+page);
		
		List<PurchaseDetailsAll> searchListPurchaseDetailPlan = ps.searchListPurchaseDetailPlan(purchase_details);
		System.out.println("PurchaseDetailController searchPurchaseDetailPlan searchListPurchaseDetailPlan.size() ->" + searchListPurchaseDetailPlan.size());
		System.out.println("PurchaseDetailController searchPurchaseDetailPlan searchListPurchaseDetailPlan ->" + searchListPurchaseDetailPlan);
		
		// 검색하고 나서 그 키워드들이 남아있기를 원해서 넣음 jsp에는 value로 값들 넣어둠(검색조건에)
		model.addAttribute("searchKeyword", purchase_details);
		model.addAttribute("total", searchTotalPurchaseDetailPlan);
		model.addAttribute("listPurchaseDetailPlan", searchListPurchaseDetailPlan); // yj_views/listPurchase에서 listPurchase를 써서 forEach로 값들을 넣어줬기 때문에 "listPurchase" 맞춰줘야함
		model.addAttribute("page", page);
		
		return "yj_views/listSearchPurchaseDetailPlan";
	}
	
	// 입고 예정리스트에서 상세로
	@GetMapping(value = "detailPurchaseDetailPlan")
	public String detailPurchaseDetailPlan(PurchaseDetailsAll purchase_details, Model model) {
		System.out.println("PurchaseDetailController detailPurchaseDetailPlan start,,");
		
		// 매입일자와 거래처번호로 상세조회
		Map<String, Object> params = new HashMap<>();
		params.put("purchase_date", purchase_details.getPurchase_date());
		params.put("client_no", purchase_details.getClient_no());
		System.out.println("PurchaseDetailController detailPurchaseDetailPlan params->"+params);
		
		// 정보 가져오기
		// 정보 가져올때 매입일자, 거래처이름, 담당자 이름 가져오고,
		PurchaseDetailsAll purchase_details1 = ps.detailPurchaseDetailPlan(params);
		// 물품은 여러개일 수 있으니까 리스트 형식으로 가져와야해서 한번 더
		List<PurchaseDetailsAll> purchase_details_list = ps.detailPurchaseDetailPlanList(params);
		System.out.println("PurchaseDetailController detailPurchaseDetailPlan purchase_details1->"+purchase_details1);
		
		// 가져온 정보들 purchase_details에 넣어주기
		model.addAttribute("purchase_details",purchase_details1);
		model.addAttribute("purchase_details_list",purchase_details_list);
		
		return "yj_views/detailPurchaseDetailPlan";
	}
	
	// 입고 버튼 처리
    @PostMapping("/purchaseDetailStore")
    public String purchaseDetailStore(
            @RequestParam(value = "checked", required = false) int[] checked,
            @RequestParam("purchase_date") String[] purchaseDates,
            @RequestParam("client_no") int[] clientNos,
            @RequestParam("product_no") int[] productNos) {

        try {
            List<Integer> checkedList = checked == null ? List.of() : Arrays.stream(checked).boxed().collect(Collectors.toList());
            boolean allChecked = true;

            for (int i = 0; i < purchaseDates.length; i++) {
                boolean isChecked = checkedList.contains(i);
                boolean updateStatusSuccess;
                if (isChecked) {
                    // 입고. 구매상세 상태 2로 변경
                	updateStatusSuccess = ps.updatePurchaseDetailStatus(purchaseDates[i], clientNos[i], productNos[i], 2);
                    if (updateStatusSuccess) {
                        System.out.println("PurchaseDetailController purchaseDetailStore 입고 성공: " + purchaseDates[i] + " " + clientNos[i] + " " + productNos[i] + 2);
                    } else {
                        System.err.println("PurchaseDetailController purchaseDetailStore 입고 실패: " + purchaseDates[i] + " " + clientNos[i] + " " + productNos[i] + 2);
                    }
                } else {
                    // 미입고. 구매상세 상태 1
                    updateStatusSuccess  = ps.updatePurchaseDetailStatus(purchaseDates[i], clientNos[i], productNos[i], 1);
                    if (updateStatusSuccess) {
                        System.out.println("PurchaseDetailController purchaseDetailStore 미입고 성공: " + purchaseDates[i] + " " + clientNos[i] + " " + productNos[i]);
                    } else {
                        System.err.println("PurchaseDetailController purchaseDetailStore 미입고 실패: " + purchaseDates[i] + " " + clientNos[i] + " " + productNos[i]);
                    }
                    allChecked = false;
                }
            }
            if(purchaseDates.length > 0){
            	boolean updateDetailStatusSuccess;
                if(allChecked){
                    // 전부 체크됨 = 구매(완료) 상태 
                    updateDetailStatusSuccess = ps.updatePurchaseStatus(purchaseDates[0], clientNos[0], 2);
                    if (updateDetailStatusSuccess) {
                        System.out.println("PurchaseDetailController purchaseDetailStore 구매 업데이트 완료 -------------"+purchaseDates[0]+""+ clientNos[0]+""+ 2);
                    } else {
                        System.err.println("PurchaseDetailController purchaseDetailStore 구매 업데이트 완료 실패 -------------"+purchaseDates[0]+""+ clientNos[0]+""+ 2);
                    }
                }else{
                    // 체크 안된게 있음 = 구매(부분입고) 상태
                    updateDetailStatusSuccess = ps.updatePurchaseStatus(purchaseDates[0], clientNos[0], 1);
                    if (updateDetailStatusSuccess) {
                        System.out.println("PurchaseDetailController purchaseDetailStore 구매 업데이트 부분입고 -------------"+purchaseDates[0]+""+ clientNos[0]+""+ 2);
                    } else {
                        System.err.println("PurchaseDetailController purchaseDetailStore 구매 업데이트 부분입고 실패 -------------"+purchaseDates[0]+""+ clientNos[0]+""+ 2);
                    }
                }
            }
            return "redirect:/listPurchaseDetailPlan";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
	
	// 입고 조회("입고"니까 구매상세의 상태가 2인 값들만 들어와야함!!)
	@RequestMapping(value = "listPurchaseDetail")
	public String listPurchaseDetail(PurchaseDetailsAll purchase_details, Model model) {
		System.out.println("PurchaseDetailController listPurchaseDetail start,,");
		
		// 페이징
		int totalPurchaseDetail = ps.totalPurchaseDetail();
		if (purchase_details.getCurrentPage() == null) purchase_details.setCurrentPage("1");
		Paging page = new Paging(totalPurchaseDetail, purchase_details.getCurrentPage());
		
		purchase_details.setStart(page.getStart());
		purchase_details.setEnd(page.getEnd());
		
		List<PurchaseDetailsAll> listPurchaseDetail = ps.listPurchaseDetail(purchase_details);
		System.out.println("PurchaseDetailController listPurchaseDetail listPurchaseDetail.size()->"+listPurchaseDetail.size());
		
		model.addAttribute("total",					totalPurchaseDetail);
		model.addAttribute("listPurchaseDetail", 	listPurchaseDetail);
		model.addAttribute("page", 					page);	
		
		return "yj_views/listPurchaseDetail";
	}
	
	// 입고 조회 검색 (기간, 제품, 거래처, 담당자)
	@RequestMapping(value = "searchPurchaseDetail")
	public String searchPurchaseDetail(PurchaseDetailsAll purchase_details, Model model) {
		System.out.println("PurchaseDetailController searchPurchaseDetail start,,");
		System.out.println("PurchaseDetailController searchPurchaseDetail purchase_details->" + purchase_details);
		// Purchase_details "입고" 검색 Cnt
		int searchTotalPurchaseDetail = ps.searchTotalPurchaseDetail(purchase_details);
		System.out.println("PurchaseDetailController searchPurchaseDetail searchTotalPurchaseDetail->" + searchTotalPurchaseDetail);
		// 페이징,,
		Paging page = new Paging(searchTotalPurchaseDetail, purchase_details.getCurrentPage());
		purchase_details.setStart(page.getStart()); // 시작시 1
		purchase_details.setEnd(page.getEnd());		//  15
		System.out.println("PurchaseDetailController searchPurchase page->"+page);
		
		List<PurchaseDetailsAll> searchListPurchaseDetail = ps.searchListPurchaseDetail(purchase_details);
		System.out.println("PurchaseDetailController searchPurchaseDetail searchListPurchase searchListPurchase.size()" + searchListPurchaseDetail.size());
		System.out.println("PurchaseDetailController searchPurchaseDetail searchListPurchaseDetail->" + searchListPurchaseDetail);
		
		// 검색하고 나서 그 키워드들이 남아있기를 원해서 넣음 jsp에는 value로 값들 넣어둠(검색조건에)
		model.addAttribute("searchKeyword", 			purchase_details);
		model.addAttribute("total", 					searchTotalPurchaseDetail);
		model.addAttribute("searchListPurchaseDetail", 	searchListPurchaseDetail);
		model.addAttribute("page", 						page);
		
		return "yj_views/listSearchPurchaseDetail";
	}
	
	// 입고 조회의 상세 화면
	@GetMapping(value = "detailPurchaseDetail")
	public String detailPurchaseDetail(PurchaseDetailsAll purchase_details, Model model) {
		System.out.println("PurchaseDetailController detailPurchaseDetail start,,");
		
		// 매입일자와 거래처번호로 상세조회
		Map<String, Object> params = new HashMap<>();
		params.put("purchase_date", purchase_details.getPurchase_date());
		params.put("client_no", purchase_details.getClient_no());
		System.out.println("PurchaseDetailController detailPurchaseDetail params-> " + params);
		
		// 정보 가져오기
		// 1. 매입일자, 거래처명, 담당자명
		PurchaseDetailsAll purchase_details1 = ps.detailPurchaseDetail(params);
		// 2. 물품에 대한 정보(리스트) 품목명, 단가, 수량
		List<PurchaseDetailsAll> purchase_details_list = ps.detailPurchaseDetailList(params);
		System.out.println("PurchaseDetailController detailPurchaseDetailPlan purchase_details1->"+purchase_details1);
		System.out.println("PurchaseDetailController detailPurchaseDetailPlan purchase_details_list->"+purchase_details_list);
		
		// 가져온 정보들 넣어주기
		model.addAttribute("purchase_details",purchase_details1);
		model.addAttribute("purchase_details_list",purchase_details_list);
		
		return "yj_views/detailPurchaseDetail";
	}
	
	// 미입고 조회("미입고"니까 구매상세의 상태가 1인 값들만 들어와야함!!)
	@RequestMapping(value = "listPurchaseDetailNo")
	public String listPurchaseDetailNo(PurchaseDetailsAll purchase_details, Model model) {
		System.out.println("PurchaseDetailController listPurchaseDetailNo start,,");
		
		// 페이징
		int totalPurchaseDetailNo = ps.totalPurchaseDetailNo();
		if (purchase_details.getCurrentPage() == null) purchase_details.setCurrentPage("1");
		Paging page = new Paging(totalPurchaseDetailNo, purchase_details.getCurrentPage());
		
		purchase_details.setStart(page.getStart());
		purchase_details.setEnd(page.getEnd());
		
		List<PurchaseDetailsAll> listPurchaseDetailNo = ps.listPurchaseDetailNo(purchase_details);
		System.out.println("PurchaseDetailController listPurchaseDetailNo listPurchaseDetailNo.size()->"+listPurchaseDetailNo.size());
		
		// 검색하고 나서 그 키워드들이 남아있기를 원해서 넣음 jsp에는 value로 값들 넣어둠(검색조건에)
		model.addAttribute("searchKeyword", 		purchase_details);
		model.addAttribute("total",					totalPurchaseDetailNo);
		model.addAttribute("listPurchaseDetailNo", 	listPurchaseDetailNo);
		model.addAttribute("page", 					page);	
		
		return "yj_views/listPurchaseDetailNo";
	}
	
	// 미입고 조회 검색 (기간, 제품, 거래처, 담당자)
	@RequestMapping(value = "searchPurchaseDetailNo")
	public String searchPurchaseDetailNo(PurchaseDetailsAll purchase_details, Model model) {
		System.out.println("PurchaseDetailController searchPurchaseDetailNo start,,");
		System.out.println("PurchaseDetailController searchPurchaseDetailNo purchase_details->" + purchase_details);
		// Purchase_details "미입고" 검색 Cnt
		int searchTotalPurchaseDetailNo = ps.searchTotalPurchaseDetailNo(purchase_details);
		System.out.println("PurchaseDetailController searchPurchaseDetailNo searchTotalPurchaseDetailNo->" + searchTotalPurchaseDetailNo);
		// 페이징,,
		Paging page = new Paging(searchTotalPurchaseDetailNo, purchase_details.getCurrentPage());
		purchase_details.setStart(page.getStart()); // 시작시 1
		purchase_details.setEnd(page.getEnd());		//  15
		System.out.println("PurchaseDetailController searchPurchaseDetailNo page->"+page);
		
		List<PurchaseDetailsAll> searchListPurchaseDetailNo = ps.searchListPurchaseDetailNo(purchase_details);
		System.out.println("PurchaseDetailController searchPurchaseDetailNo searchListPurchase searchListPurchaseNo.size()" + searchListPurchaseDetailNo.size());
		System.out.println("PurchaseDetailController searchPurchaseDetailNo searchListPurchaseDetailNo->" + searchListPurchaseDetailNo);
		
		model.addAttribute("total", searchTotalPurchaseDetailNo);
		model.addAttribute("searchListPurchaseDetailNo", searchListPurchaseDetailNo);
		model.addAttribute("page", page);
		
		return "yj_views/listSearchPurchaseDetailNo";
	}
	
	// 미입고 조회의 상세 화면
	// 입고 조회의 데이터 불러오기 사용
	@GetMapping(value = "detailPurchaseDetailNo")
	public String detailPurchaseDetailNo(PurchaseDetailsAll purchase_details, Model model) {
		System.out.println("PurchaseDetailController detailPurchaseDetailNo start,,");
		
		// 매입일자와 거래처번호로 상세조회
		Map<String, Object> params = new HashMap<>();
		params.put("purchase_date", purchase_details.getPurchase_date());
		params.put("client_no", purchase_details.getClient_no());
		System.out.println("PurchaseDetailController detailPurchaseDetailNo params-> " + params);
		
		// 정보 가져오기
		// 1. 매입일자, 거래처명, 담당자명
		PurchaseDetailsAll purchase_details1 = ps.detailPurchaseDetail(params);
		// 2. 물품에 대한 정보(리스트) 품목명, 단가, 수량
		List<PurchaseDetailsAll> purchase_details_list = ps.detailPurchaseDetailList(params);
		System.out.println("PurchaseDetailController detailPurchaseDetailNo purchase_details1->"+purchase_details1);
		System.out.println("PurchaseDetailController detailPurchaseDetailNo purchase_details_list->"+purchase_details_list);
		
		// 가져온 정보들 넣어주기
		model.addAttribute("purchase_details",purchase_details1);
		model.addAttribute("purchase_details_list",purchase_details_list);
		
		return "yj_views/detailPurchaseDetailNo";
	}
		
	
}
