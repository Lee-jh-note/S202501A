package org.oracle.s202501a.controller.rw_controller;

import java.io.IOException;

import org.oracle.s202501a.dto.rw_dto.SalesAll;
import org.oracle.s202501a.dto.rw_dto.SalesDetailsAll;
import org.oracle.s202501a.service.rw_service.SalesExcelService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class SalesExcelController {
	
	private final SalesExcelService salesExcelService;
    
	// 수주 조회 엑셀
    @GetMapping("excel/listSalesExcel")
    public ResponseEntity<byte[]> listSalesExcel(SalesAll sales) throws IOException {
    	System.out.println("SalesExcelController listSalesExcel 엑셀 검색조건 "+ sales);

        byte[] excelFile = salesExcelService.listSalesExcel(sales);

        // HTTP 응답 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=Sales_Order.xlsx");
        headers.add("Content-Type", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");

        // 엑셀 파일을 HTTP 응답으로 반환
        return ResponseEntity.ok()
                .headers(headers)
                .body(excelFile);
    }
    
    // 출고 예정 조회 엑셀
    @GetMapping("excel/listPreSalesDetailsExcel")
    public ResponseEntity<byte[]> listPreSalesDetailsExcel(SalesDetailsAll salesDetails) throws IOException {
    	System.out.println("SalesExcelController listPreSalesDetailsExcel 엑셀 검색조건 "+ salesDetails);

        byte[] excelFile = salesExcelService.listPreSalesDetailsExcel(salesDetails);

        // HTTP 응답 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=Planned_Receipts.xlsx");
        headers.add("Content-Type", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");

        // 엑셀 파일을 HTTP 응답으로 반환
        return ResponseEntity.ok()
                .headers(headers)
                .body(excelFile);
    }
    
    // 출고 조회 엑셀
    @GetMapping("excel/listGoSalesDetailsExcel")
    public ResponseEntity<byte[]> listGoSalesDetailsExcel(SalesDetailsAll salesDetails) throws IOException {
    	System.out.println("SalesExcelController listGoSalesDetailsExcel 엑셀 검색조건 "+ salesDetails);

        byte[] excelFile = salesExcelService.listGoSalesDetailsExcel(salesDetails);

        // HTTP 응답 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=Received.xlsx");
        headers.add("Content-Type", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");

        // 엑셀 파일을 HTTP 응답으로 반환
        return ResponseEntity.ok()
                .headers(headers)
                .body(excelFile);
    }
    
    // 출고 조회 엑셀
    @GetMapping("excel/listNoSalesDetailsExcel")
    public ResponseEntity<byte[]> listNoSalesDetailsExcel(SalesDetailsAll salesDetails) throws IOException {
    	System.out.println("SalesExcelController listNoSalesDetailsExcel 엑셀 검색조건 "+ salesDetails);

        byte[] excelFile = salesExcelService.listNoSalesDetailsExcel(salesDetails);

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



