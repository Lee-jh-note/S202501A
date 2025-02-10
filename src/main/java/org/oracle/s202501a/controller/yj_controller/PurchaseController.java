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

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("purchase")
public class PurchaseController {
	
	private final PurchaseService ps;
	
	// 세션과 연결된 UserService
	private final UserService f;
	
	// 발주 검색 (기간, 제품, 거래처, 담당자)
	@RequestMapping(value = "listPurchase")
	public String searchPurchase(Purchase purchase, Model model) {
		System.out.println("PurchaseController searchPurchase purchase-> " + purchase);
		// Purchase 전체 Cnt
		int totalPurchase = ps.searchTotalPurchase(purchase);
		System.out.println("PurchaseController searchPurchase totalPurchase-> " + totalPurchase);
		// 페이징,,
		Paging page = new Paging(totalPurchase, purchase.getCurrentPage());
		purchase.setStart(page.getStart()); // 시작시 1
		purchase.setEnd(page.getEnd());		//  15
		
		System.out.println("PurchaseController searchPurchase page-> " + page);

		List<Purchase> searchListPurchase = ps.searchListPurchase(purchase);
		System.out.println("PurchaseController searchPurchase searchListPurchase searchListPurchase.size()-> " + searchListPurchase.size());
		System.out.println("PurchaseController searchPurchase searchListPurchase-> " + searchListPurchase);
		
		model.addAttribute("searchKeyword", purchase);
		model.addAttribute("total", totalPurchase);
		model.addAttribute("listPurchase", searchListPurchase); // yj_views/listPurchase에서 listPurchase를 써서 forEach로 값들을 넣어줬기 때문에 "listPurchase" 맞춰줘야함
		model.addAttribute("page", page);
		
		return "yj_views/listPurchase";
	}
	

	// 발주 상세 조회 - 발주서 안에 제품이 여러개 들어가면서 상세화면도 바뀜
	@GetMapping(value = "detailPurchase")
	public String detailPurchase(Purchase purchase1, Model model) {
		System.out.println("PurchaseController detailPurchase start,,,");
		
		// 매입일자와 거래처번호(pk)로 상세조회 들어가기 위해 Map 사용
		Map<String, Object> params = new HashMap<>();
		params.put("purchase_date", purchase1.getPurchase_date());
		params.put("client_no", purchase1.getClient_no());
		System.out.println("PurchaseController params->"+params);
		// 구매 테이블 조회
		Purchase purchase = ps.detailPurchase(params);
		System.out.println("PurchaseController purchase purchase->"+purchase);
		// 구매 상세 테이블 조회
		List<Purchase> purchase_detail = ps.detailPurchaseDetail(params);
		System.out.println("PurchaseController purchase purchase_detail->"+purchase_detail);
		
		
		// 구매 테이블 값들을 purchase에 넣어줌
		model.addAttribute("purchase", purchase);
		// 구매 상세 테이블 값들을 purchase_detail에 넣어줌
		model.addAttribute("purchase_detail", purchase_detail);
		
		return "yj_views/detailPurchase";
	}

	@RequestMapping(value = "insertFormPurchase")
	public String insertFormPurchase(Model model) {
		System.out.println("PurchaseController insertFormPurchase start,,,");
		
		// 제목은 입력, 매입일자는 sysdate, 담당자는 드롭다운(emp_name), 거래처는 드롭다운(client_name), 요청배송일 입력
		// 비고 입력, 품목명 드롭다운(product_name), 단가는 품목명 선택하면 끌고와지게,,, 수량 입력, 총금액은 단가 * 수량
		
		EmpDTO dto = f.getSe();
		Long emp_no = dto.getEmp_No();
		String emp_name = dto.getEmpName();
	    model.addAttribute("emp_no", emp_no);
	    model.addAttribute("emp_name", emp_name);
		
		// 담당자 드롭다운 - 기존 방법. 근데 담당자는 선택하는게 아니라 지금 로그인 되어있는 사원으로 이름이 떠야함. 따라서 session 사용으로 변경
//		List<Purchase> empList = ps.listManager();
//		model.addAttribute("empList", empList);
		
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
	
	// 기존 insert 방법
//	// insertFormPurchase.jsp에서 구매 테이블 insert를 할 때 ajax로 해서 넘어옴
//	@ResponseBody
//	@PostMapping(value = "insertPurchase")
//	@Transactional
//	public Map<String, Object> insertPurchase(@RequestBody Purchase01 purchase){
//		System.out.println("PurchaseController insertPurchase start,,");
//		
//		Map<String, Object> resultMap = new HashMap<>();
//		
//		try {
//			// ajax에서 데이터 잘 넘어왔는지 확인
//			System.out.println("PurchaseController insertPurchase purchase->"+purchase);
//
//			// 구매 테이블 insert 하기. 실패하면 구매 테이블 등록 실패 메시지,,
//			int insertPurchaseCnt = ps.insertPurchase(purchase);
//			if(insertPurchaseCnt <= 0) throw new Exception("insertPurchaseCnt <= 0 : insert 실패");
//
//			resultMap.put("success", true);
//			return resultMap;
//		} catch (Exception e) {
//			resultMap.put("success", false);
//			resultMap.put("message", e.getMessage());
//			return resultMap;
//		}
//	}
//	
//	// insertFormPurchase.jsp에서 insertPurchase를 성공하고 나면 구매 상세도 등록하기 위해 insertDetailPurchase로 넘어옴
//	@ResponseBody
//	@PostMapping(value = "insertDetailPurchase")
//	@Transactional
//	public Map<String, Object> insertDetailPurchase(@RequestBody List<Purchase_details> purchase_details){
//		System.out.println("PurchaseController insertDetailPurchase start,,");
//		
//		Map<String, Object> resultMap = new HashMap<>();
//		
//		try {
//			// ajax에서 데이터 잘 넘어왔는지 확인
//			System.out.println("PurchaseController insertDetailPurchase purchase_details->" + purchase_details); 
//			
//			for (Purchase_details details : purchase_details) {
//				int insertPurchaseDetailCnt = ps.insertDetailPurchase(details);
//				if (insertPurchaseDetailCnt <= 0) throw new Exception("insertPurchaseDetailCnt <= 0 : insert 실패");
//			}
//			
//			resultMap.put("success", true);
//			return resultMap;
//		} catch (Exception e) {
//			resultMap.put("success", false);
//			resultMap.put("message", e.getMessage());
//			return resultMap;
//		}		
//	}
	
	// 바꾼 insert
	// insertFormPurchase의 function insertPurchase()
	@ResponseBody
	@PostMapping(value = "insertPurchaseAll") // 새로운 URL
	@Transactional
	public Map<String, Object> insertPurchaseAll(@RequestBody PurchaseData purchaseData) {
	    System.out.println("PurchaseController insertPurchaseAll start,,");

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
	@RequestMapping(value = "getPrice")
	public int getPrice(Purchase purchase, Model model) {
		System.out.println("PurchaseController getPrice product_no->"+purchase.getProduct_no());
		int productPrice = ps.productPrice(purchase.getProduct_no());
		System.out.println("PurchaseController getPrice productPrice->"+productPrice);
		return productPrice;
	}
	
	// 매입일자와 거래처코드 중복확인 버튼(insert할때)1
//	@GetMapping(value = "confirm")
//	public String confirm(Purchase purchase1, Model model) {
//		System.out.println("PurchaseController confirm start,,");
//		
//		Map<String, Object> params = new HashMap<>();
//		params.put("purchase_date", purchase1.getPurchase_date());
//		params.put("client_no", purchase1.getClient_no());
//		Purchase purchase = ps.detailPurchase(params);
//		
//		model.addAttribute("purchase_date", purchase1.getPurchase_date());
//		model.addAttribute("client_no", purchase1.getClient_no());
//		
//		if (purchase !=null) {
//			System.out.println("PurchaseController confirm 거래처명과 매입일자 중복된.. ");
//			model.addAttribute("msg","거래처명과 매입일자가 동일한 발주서가 있습니다");			
//		} else {
//			System.out.println("PurchaseController confirm 거래처명과 매입일자 중복 안됨.. ");
//			model.addAttribute("msg","거래처명과 매입일자 사용 가능");
//		}
//		
//		return "forward:insertFormPurchase";
//	}
	
	// 매입일자와 거래처코드 중복확인 버튼(insert할때) 2
	@ResponseBody // ajax를 json으로 보내기
	@GetMapping(value = "confirm")
	public Map<String, Object> confirm(Purchase purchase1) {
	    System.out.println("PurchaseController confirm start,,");

	    Map<String, Object> params = new HashMap<>();
	    params.put("purchase_date", purchase1.getPurchase_date());
	    params.put("client_no", purchase1.getClient_no());
	    Purchase purchase = ps.detailPurchase(params);

	    Map<String, Object> response = new HashMap<>();

	    if (purchase != null) {
	        System.out.println("PurchaseController confirm 거래처명과 매입일자 중복된.. ");
	        response.put("isDuplicate", true); 
	    } else {
	        System.out.println("PurchaseController confirm 거래처명과 매입일자 중복 안됨.. ");
	        response.put("isDuplicate", false); 
	    }

	    return response;
	}
	
	// 발주 수정 - 상태가 0일때만 수정 가능
	@GetMapping(value = "updateFormPurchase")
	public String updateFormPurchase(Purchase purchase1, Model model) {
		System.out.println("PurchaseController updateFormPurchase start,,");
		
		// 매입일자와 거래처번호(pk)로 수정화면 들어가기 위해 Map 사용
		Map<String, Object> params = new HashMap<>();
		params.put("purchase_date", purchase1.getPurchase_date());
		params.put("client_no", purchase1.getClient_no());
		System.out.println("PurchaseController updateFormPurchase params->"+params);
		
		// 구매 테이블 조회
		Purchase purchase = ps.detailPurchase(params);
		System.out.println("PurchaseController purchase purchase->"+purchase);
		
//		// 상태 확인 (DB 조회 후)
//		if (purchase == null) {
//		    System.out.println("PurchaseController updateFormPurchase: 해당 발주 정보가 존재하지 않음 purchase->"+purchase);
//		    model.addAttribute("errorMessage", "해당 발주 정보를 찾을 수 없습니다.");
//		    return "yj_views/errorPage";
//		} else if (!"0".equals(purchase.getStatus())) {
//		    System.out.println("PurchaseController updateFormPurchase: 상태가 0이 아님 purchase.getStatus()->"+purchase.getStatus());
//		    model.addAttribute("errorMessage", "수정할 수 없는 상태입니다. 상태가 0인 발주서만 수정 가능합니다.");
//		    return "yj_views/errorPage";
//		}
		
		// 구매 상세 테이블 조회
		List<Purchase> purchase_detail = ps.detailPurchaseDetail(params);
		System.out.println("PurchaseController purchase purchase_detail->"+purchase_detail);
		
		// 업데이트 폼에도 드롭다운 형식이 있어야함		
		// 품목명 드롭다운
		List<Purchase> productList = ps.listProduct();
		System.out.println("PurchaseController updateFormPurchase productList.size()->"+productList.size());
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
	@PostMapping(value = "updatePurchase")
	@Transactional
	public Map<String, Object> updatePurchase(@RequestBody PurchaseData purchaseData) {
	    System.out.println("PurchaseController updatePurchase start,,");
	    System.out.println("PurchaseController updatePurchase purchaseData->"+purchaseData);

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
	        // 어떤 건 삭제되고 어떤건 등록됨. // 구매상세 관련 정보 전부 삭제하고 다시 insert,,, 하는걸로 일단,,,,
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
	@RequestMapping(value = "deletePurchase")
	public String deletePurchase(Purchase01 purchase, Model model) {
		System.out.println("PurchaseController deletePurchase start");
		System.out.println("PurchaseController deletePurchase purchase->"+purchase);
//		System.out.println("PurchaseController deletePurchase  purchase.getStatus()->"+ purchase.getStatus());
		
		Map<String, Object> params = new HashMap<>();
		try {
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

			return "redirect:listPurchase";
			
		} catch (Exception e) {
	        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly(); // 롤백해주기- 구매만 삭제되었을 수 있어서
	        model.addAttribute("errorMessage", "삭제 실패: " + e.getMessage());
			return "yj_views/errorPage";
		}
	}
	
	

}
