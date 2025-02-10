package org.oracle.s202501a.controller.yj_controller;

import java.io.IOException;

import org.oracle.s202501a.dto.yj_dto.Purchase;
import org.oracle.s202501a.dto.yj_dto.PurchaseDetailsAll;
import org.oracle.s202501a.service.yj_service.PurchaseExcelService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class PurchaseExcelController {
	private final PurchaseExcelService ps;
    
    // 발주 검색 결과 엑셀 다운로드
    @GetMapping("excel/purchaseSearchExcel")
    public ResponseEntity<byte[]> purchaseSearchExcel(Purchase purchase) throws IOException {
    	System.out.println("PurchaseExcelController purchaseSearchExcel 엑셀 검색조건 "+ purchase);

        byte[] excelFile = ps.purchaseSearchExcel(purchase);

        // HTTP 응답 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=Purchase_Order.xlsx");
        headers.add("Content-Type", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");

        // 엑셀 파일을 HTTP 응답으로 반환
        return ResponseEntity.ok()
                .headers(headers)
                .body(excelFile);
    }
    
    // 입고 예정 리스트 엑셀 다운로드
    @GetMapping("excel/purchaseDetailPlanExcel")
    public ResponseEntity<byte[]> purchaseDetailPlanExcel(PurchaseDetailsAll purchase_details) throws IOException {
    	System.out.println("PurchaseExcelController purchaseDetailPlanExcel 엑셀 검색조건 "+ purchase_details);

        byte[] excelFile = ps.purchaseDetailPlanExcel(purchase_details);

        // HTTP 응답 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=Planned_Receipts.xlsx");
        headers.add("Content-Type", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");

        // 엑셀 파일을 HTTP 응답으로 반환
        return ResponseEntity.ok()
                .headers(headers)
                .body(excelFile);
    }
    
    // 입고 조회 엑셀 다운로드
    @GetMapping("excel/purchaseDetailExcel")
    public ResponseEntity<byte[]> purchaseDetailExcel(PurchaseDetailsAll purchase_details) throws IOException {
    	System.out.println("PurchaseExcelController purchaseDetailExcel 엑셀 검색조건 "+ purchase_details);

        byte[] excelFile = ps.purchaseDetailExcel(purchase_details);

        // HTTP 응답 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=Received.xlsx");
        headers.add("Content-Type", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");

        // 엑셀 파일을 HTTP 응답으로 반환
        return ResponseEntity.ok()
                .headers(headers)
                .body(excelFile);
    }
    
    // 미입고 조회 엑셀 다운로드
    @GetMapping("excel/purchaseDetailNoExcel")
    public ResponseEntity<byte[]> purchaseDetailNoExcel(PurchaseDetailsAll purchase_details) throws IOException {
    	System.out.println("PurchaseExcelController purchaseDetailNoExcel 엑셀 검색조건 "+ purchase_details);

        byte[] excelFile = ps.purchaseDetailNoExcel(purchase_details);

        // HTTP 응답 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=Unreceived.xlsx");
        headers.add("Content-Type", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");

        // 엑셀 파일을 HTTP 응답으로 반환
        return ResponseEntity.ok()
                .headers(headers)
                .body(excelFile);
    }
    

}
