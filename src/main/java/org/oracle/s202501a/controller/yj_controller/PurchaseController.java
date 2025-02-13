package org.oracle.s202501a.controller.yj_controller;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.oracle.s202501a.dto.sh_dto.EmpDTO;
import org.oracle.s202501a.dto.yj_dto.Purchase;
import org.oracle.s202501a.dto.yj_dto.Purchase01;
import org.oracle.s202501a.dto.yj_dto.PurchaseData;
import org.oracle.s202501a.dto.yj_dto.Purchase_details;
import org.oracle.s202501a.service.sh_service.UserService;
import org.oracle.s202501a.service.yj_service.Paging;
import org.oracle.s202501a.service.yj_service.PurchaseService;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class PurchaseController {
	
	private final PurchaseService ps;
	
	// 세션과 연결된 UserService
	private final UserService f;
	
	// 발주 검색 (기간, 제품, 거래처, 담당자)
	@RequestMapping(value = "All/Sales/listPurchase")
	public String searchPurchase(Purchase purchase, Model model) {
		// Purchase 전체 Cnt
		int totalPurchase = ps.searchTotalPurchase(purchase);
		// 페이징,,
		Paging page = new Paging(totalPurchase, purchase.getCurrentPage());
		purchase.setStart(page.getStart()); // 시작시 1
		purchase.setEnd(page.getEnd());		//  15

		List<Purchase> searchListPurchase = ps.searchListPurchase(purchase);
		
		model.addAttribute("searchKeyword", purchase);
		model.addAttribute("total", totalPurchase);
		model.addAttribute("listPurchase", searchListPurchase); // yj_views/listPurchase에서 listPurchase를 써서 forEach로 값들을 넣어줬기 때문에 "listPurchase" 맞춰줘야함
		model.addAttribute("page", page);
		
		return "yj_views/listPurchase";
	}
	

	// 발주 상세 조회 - 발주서 안에 제품이 여러개 들어가면서 상세화면도 바뀜
	@GetMapping(value = "All/Sales/detailPurchase")
	public String detailPurchase(Purchase purchase1, Model model) {
		
		// 매입일자와 거래처번호(pk)로 상세조회 들어가기 위해 Map 사용
		Map<String, Object> params = new HashMap<>();
		params.put("purchase_date", purchase1.getPurchase_date());
		params.put("client_no", purchase1.getClient_no());
//		System.out.println("PurchaseController params->"+params);
		// 구매 테이블 조회
		Purchase purchase = ps.detailPurchase(params);
//		System.out.println("PurchaseController purchase purchase->"+purchase);
		// 구매 상세 테이블 조회
		List<Purchase> purchase_detail = ps.detailPurchaseDetail(params);
//		System.out.println("PurchaseController purchase purchase_detail->"+purchase_detail);
		
		// 구매 테이블 값들을 purchase에 넣어줌
		model.addAttribute("purchase", purchase);
		// 구매 상세 테이블 값들을 purchase_detail에 넣어줌
		model.addAttribute("purchase_detail", purchase_detail);
		
		return "yj_views/detailPurchase";
	}

	@RequestMapping(value = "Sales/insertFormPurchase")
	public String insertFormPurchase(Model model) {
		
		// 제목은 입력, 매입일자는 sysdate, 담당자는 드롭다운(emp_name), 거래처는 드롭다운(client_name), 요청배송일 입력
		// 비고 입력, 품목명 드롭다운(product_name), 단가는 품목명 선택하면 끌고와지게,,, 수량 입력, 총금액은 단가 * 수량
		
		EmpDTO dto = f.getSe();
		Long emp_no = dto.getEmp_No();
		String emp_name = dto.getEmpName();
	    model.addAttribute("emp_no", emp_no);
	    model.addAttribute("emp_name", emp_name);
		
		// 거래처 드롭다운
		List<Purchase> clientList = ps.listClient();
		model.addAttribute("clientList", clientList);
		
		// 품목명 드롭다운
		List<Purchase> productList = ps.listProduct();
		model.addAttribute("productList", productList);
		
		// 발주일자- sysdate 넣기
	    String sysdate = java.time.LocalDate.now().toString();
	    model.addAttribute("sysdate", sysdate);
				
		// 단가..? 는 뷰에서 ajax로 실행 -> PurchaseController의 getPrice 사용
		return "yj_views/insertFormPurchase";
	}
	
	
	// 바꾼 insert
	// insertFormPurchase의 function insertPurchase()
	@ResponseBody
	@PostMapping(value = "Sales/insertPurchaseAll") // 새로운 URL
	@Transactional
	public Map<String, Object> insertPurchaseAll(@RequestBody PurchaseData purchaseData) {

	    Map<String, Object> resultMap = new HashMap<>();

	    try {
	        Purchase01 purchase = purchaseData.getPurchase();
	        List<Purchase_details> purchaseDetails = purchaseData.getPurchaseDetails();

	        int insertPurchaseCnt = ps.insertPurchase(purchase);
	        if (insertPurchaseCnt <= 0) throw new Exception("insertPurchaseCnt <= 0 : insert 실패");

	        // 구매상세는 List(여러개의 정보가 한번에)
	        for (Purchase_details details : purchaseDetails) {
	            // purchase 테이블에 insert 후 생성된 키 값(필요한 정보 - 거래처코드, 매입일자) 가져와야함
	            details.setPurchase_date(purchase.getPurchase_date()); // 매입일자
	            details.setClient_no(purchase.getClient_no()); // 거래처코드
	            int insertPurchaseDetailCnt = ps.insertDetailPurchase(details);
	            if (insertPurchaseDetailCnt <= 0) throw new Exception("insertPurchaseDetailCnt <= 0 : insert 실패");
	        }
	        resultMap.put("success", true);
	        return resultMap;
	    } catch (Exception e) {
	        resultMap.put("success", false);
	        resultMap.put("message", e.getMessage());
	        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly(); // 롤백해주기- 구매만 들어갔을 수도 있어서
	        return resultMap;
	    }
	}

	// 발주 입력 화면에서 물품에 따른 매입가를 보여주기 위한 ajax
	@ResponseBody
	@RequestMapping(value = "Sales/getPrice")
	public int getPrice(Purchase purchase, Model model) {
		int productPrice = ps.productPrice(purchase.getProduct_no());
		return productPrice;
	}
	
	// 매입일자와 거래처코드 중복확인 버튼(insert할때) 2
	@ResponseBody // ajax를 json으로 보내기
	@GetMapping(value = "Sales/confirm")
	public Map<String, Object> confirm(Purchase purchase1) {

	    Map<String, Object> params = new HashMap<>();
	    params.put("purchase_date", purchase1.getPurchase_date());
	    params.put("client_no", purchase1.getClient_no());
	    Purchase purchase = ps.detailPurchase(params);

	    Map<String, Object> response = new HashMap<>();

	    if (purchase != null) {
//	        System.out.println("PurchaseController confirm 거래처명과 매입일자 중복된.. ");
	        response.put("isDuplicate", true); 
	    } else {
//	        System.out.println("PurchaseController confirm 거래처명과 매입일자 중복 안됨.. ");
	        response.put("isDuplicate", false); 
	    }

	    return response;
	}
	
	// 발주 수정 - 상태가 0일때만 수정 가능
	@GetMapping(value = "Sales/updateFormPurchase")
	public String updateFormPurchase(Purchase purchase1, Model model) {
		
		// 매입일자와 거래처번호(pk)로 수정화면 들어가기 위해 Map 사용
		Map<String, Object> params = new HashMap<>();
		params.put("purchase_date", purchase1.getPurchase_date());
		params.put("client_no", purchase1.getClient_no());
//		System.out.println("PurchaseController updateFormPurchase params->"+params);
		
		// 구매 테이블 조회
		Purchase purchase = ps.detailPurchase(params);
//		System.out.println("PurchaseController purchase purchase->"+purchase);
		
		// 구매 상세 테이블 조회
		List<Purchase> purchase_detail = ps.detailPurchaseDetail(params);
//		System.out.println("PurchaseController purchase purchase_detail->"+purchase_detail);
		
		// 업데이트 폼에도 드롭다운 형식이 있어야함		
		// 품목명 드롭다운
		List<Purchase> productList = ps.listProduct();
		model.addAttribute("productList", productList);

		// 요청 배송일 앞부분만 받기
		purchase.setReq_delivery_date(purchase.getReq_delivery_date().substring(0, 10));
		
		// 구매 테이블 값들을 purchase에 넣어줌
		model.addAttribute("purchase", purchase);
		// 구매 상세 테이블 값들을 purchase_detail에 넣어줌
		model.addAttribute("purchase_detail", purchase_detail);


		return "yj_views/updateFormPurchase";
	}
	

	
	@ResponseBody
	@PostMapping(value = "Sales/updatePurchase")
	@Transactional
	public Map<String, Object> updatePurchase(@RequestBody PurchaseData purchaseData) {

	    Map<String, Object> resultMap = new HashMap<>();
	    Map<String, Object> params = new HashMap<>();

	    try {
	    	// Purchase01과 List<Purchase_details> 각각 받아온 정보 넣어주기
	        Purchase01 purchase = purchaseData.getPurchase();
	        List<Purchase_details> purchaseDetails = purchaseData.getPurchaseDetails();

	        // Purchase는 단일 정보니까 원래 하던대로 그냥 수정
	        int updatePurchaseCnt = ps.updatePurchase(purchase);
	        if (updatePurchaseCnt <= 0) throw new Exception("updatePurchaseCnt <= 0 : update 실패");

	        
	        // 구매상세는 List(여러개의 정보가 한번에)
	        // 어떤 건 삭제되고 어떤건 등록됨. // 구매상세 관련 정보 전부 삭제하고 다시 insert,,, 
	        // 1. 삭제
	        // 매입일자와 거래처번호(pk)로 삭제하기 위해 Map 사용
 			params.put("purchase_date", purchase.getPurchase_date());
 			params.put("client_no", purchase.getClient_no());
 			
	        int deleteDetailPurchaseCnt= ps.deletePurchaseDetail(params);
	        if (deleteDetailPurchaseCnt <= 0) throw new Exception("deleteDetailPurchaseCnt <= 0 : update 전에 삭제 실패");
	        
	        for (Purchase_details details : purchaseDetails) {
	            // purchase 테이블에 insert 후 생성된 키 값(필요한 정보 - 거래처코드, 매입일자) 가져와야함
	            details.setPurchase_date(purchase.getPurchase_date()); // 매입일자
	            details.setClient_no(purchase.getClient_no()); // 거래처코드
	            int updateDetailPurchaseCnt = ps.insertDetailPurchase(details);
	            if (updateDetailPurchaseCnt <= 0) throw new Exception("updateDetailPurchaseCnt <= 0 : update 실패");
	        }
	        resultMap.put("success", true);
	        return resultMap;
	    } catch (Exception e) {
	        resultMap.put("success", false);
	        resultMap.put("message", e.getMessage());
	        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly(); // 롤백해주기- 구매만 들어갔을 수도 있어서
	        return resultMap;
	    }
	}

	// 발주 정보 삭제
	@Transactional
	@RequestMapping(value = "Sales/deletePurchase")
	public String deletePurchase(Purchase01 purchase, Model model, RedirectAttributes redirectAttributes) {
		
		Map<String, Object> params = new HashMap<>();
		try {
//			throw new Exception("일부러 삭제 실패 테스트");
			// 매입일자와 거래처번호(pk)로 삭제하기 위해 Map 사용
			params.put("purchase_date", purchase.getPurchase_date());
			params.put("client_no", purchase.getClient_no());
			System.out.println("PurchaseController deletePurchase params->"+params);
			
			// 구매 상세 삭제
			int deleteDetailCount = ps.deletePurchaseDetail(params);
	        if (deleteDetailCount <= 0) throw new Exception("deleteDetailCount <= 0 : 구매 상세 삭제 실패(client_no: " + purchase.getClient_no() + ", purchase_date: " + purchase.getPurchase_date() + ")");
	        
	        // 구매 정보 삭제
	        int deletePurchaseCount  = ps.deletePurchase(params);
	        if (deletePurchaseCount <= 0) throw new Exception("deletePurchaseCount <= 0 : 구매 정보 삭제 실패(client_no: " + purchase.getClient_no() + ", purchase_date: " + purchase.getPurchase_date() + ")");

			
		} catch (Exception e) {
	        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly(); // 롤백해주기- 구매만 삭제되었을 수 있어서
	        redirectAttributes.addFlashAttribute("errorMessage", "삭제 실패: " + e.getMessage());
		}
		return "redirect:/All/Sales/listPurchase";
	}
	
	

}
