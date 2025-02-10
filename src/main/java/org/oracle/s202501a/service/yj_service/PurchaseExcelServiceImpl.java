package org.oracle.s202501a.service.yj_service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.oracle.s202501a.dto.yj_dto.Purchase;
import org.oracle.s202501a.dto.yj_dto.PurchaseDetailsAll;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class PurchaseExcelServiceImpl implements PurchaseExcelService {
	
	private final PurchaseService purchaseService;
	
	private final PurchaseDetailService purchaseDetailService;
	
	// 발주 검색 결과 엑셀 생성
	// 검색 키워드가 있는 것들은 jsp에서 param으로 값들 전달, purchase로 받기
	@Override
	public byte[] purchaseSearchExcel(Purchase purchase) throws IOException {
		
		purchase.setStart(1);
		purchase.setEnd(999999);
		System.out.println("PurchaseExcelServiceImpl purchaseSearchExcel 엑셀 검색조건 "+ purchase);
		
		
		List<Purchase> searchPurchaseList = purchaseService.searchListPurchase(purchase);
		
        return generatePurchaseExcel(searchPurchaseList, "발주 검색 결과");
	}
	
	
	// 발주 엑셀 공통 - 매입일자, 제목, 거래처명, 담당자, 상품수, 총수량, 총금액, 상태, 요청배송일
    private byte[] generatePurchaseExcel(List<Purchase> purchases, String sheetName) throws IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet(sheetName);

        // 엑셀 헤더 생성
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("매입일자");
        headerRow.createCell(1).setCellValue("제목");
        headerRow.createCell(2).setCellValue("거래처명");
        headerRow.createCell(3).setCellValue("담당자");
        headerRow.createCell(4).setCellValue("상품수");
        headerRow.createCell(5).setCellValue("총수량");
        headerRow.createCell(6).setCellValue("총금액");
        headerRow.createCell(7).setCellValue("상태");
        headerRow.createCell(8).setCellValue("요청배송일");
        
        System.out.println("PurchaseExcelServiceImpl generateExcel purchases->"+purchases);

        // 엑셀 데이터 생성
        for (int i = 0; i < purchases.size(); i++) {
            Row dataRow = sheet.createRow(i + 1);
            Purchase p = purchases.get(i);
            dataRow.createCell(0).setCellValue(p.getPurchase_date());
            dataRow.createCell(1).setCellValue(p.getTitle());
            dataRow.createCell(2).setCellValue(p.getClient_name());
            dataRow.createCell(3).setCellValue(p.getEmp_name());
            dataRow.createCell(4).setCellValue(p.getProduct_count());
            dataRow.createCell(5).setCellValue(p.getTotal_quantity());
            dataRow.createCell(6).setCellValue(p.getTotal_price());
            dataRow.createCell(7).setCellValue(p.getStatus());
            dataRow.createCell(8).setCellValue(p.getReq_delivery_date().substring(0, 10));
        }

        // 열 너비 자동 조정
        for (int colIndex = 0; colIndex <= 8; colIndex++) {
            sheet.autoSizeColumn(colIndex);
        }

        // 엑셀 파일 생성
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        workbook.write(outputStream);
        workbook.close();

        return outputStream.toByteArray();
    }
    

	// PurchaseExcelController  ResponseEntity<byte[]> purchaseDetailPlanExcel(PurchaseDetailsAll purchase_details) - 입고예정 엑셀
    // 매입일자, 거래처명, 발주 담당자, 상품수, 총수량, 총금액, 상태, 요청배송일
	@Override
	public byte[] purchaseDetailPlanExcel(PurchaseDetailsAll purchase_details) throws IOException {
		
		purchase_details.setStart(1);
		purchase_details.setEnd(999999);
		
		
		List<PurchaseDetailsAll> purchaseDetailPlan = purchaseDetailService.searchListPurchaseDetailPlan(purchase_details);
		
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("입고 예정 리스트");

        // 엑셀 헤더 생성
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("매입일자");
        headerRow.createCell(1).setCellValue("거래처명");
        headerRow.createCell(2).setCellValue("발주 담당자");
        headerRow.createCell(3).setCellValue("상품수");
        headerRow.createCell(4).setCellValue("총수량");
        headerRow.createCell(5).setCellValue("총금액");
        headerRow.createCell(6).setCellValue("상태");
        headerRow.createCell(7).setCellValue("요청배송일");
        
        System.out.println("PurchaseExcelServiceImpl purchaseDetailPlanExcel purchaseDetailPlan->"+purchaseDetailPlan);

        // 엑셀 데이터 생성
        for (int i = 0; i < purchaseDetailPlan.size(); i++) {
            Row dataRow = sheet.createRow(i + 1);
            PurchaseDetailsAll p = purchaseDetailPlan.get(i);
            dataRow.createCell(0).setCellValue(p.getPurchase_date());
            dataRow.createCell(1).setCellValue(p.getClient_name());
            dataRow.createCell(2).setCellValue(p.getEmp_name());
            dataRow.createCell(3).setCellValue(p.getProduct_count());
            dataRow.createCell(4).setCellValue(p.getTotal_quantity());
            dataRow.createCell(5).setCellValue(p.getTotal_price());
            dataRow.createCell(6).setCellValue(p.getStatus());
            dataRow.createCell(7).setCellValue(p.getReq_delivery_date().substring(0, 10));
        }

        // 열 너비 자동 조정
        for (int colIndex = 0; colIndex <= 8; colIndex++) {
            sheet.autoSizeColumn(colIndex);
        }

        // 엑셀 파일 생성
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        workbook.write(outputStream);
        workbook.close();

        return outputStream.toByteArray();
	}
	

	// PurchaseExcelController  ResponseEntity<byte[]> purchaseDetailExcel(PurchaseDetailsAll purchase_details) - 입고 조회 엑셀
	@Override
	public byte[] purchaseDetailExcel(PurchaseDetailsAll purchase_details) throws IOException {
		
		purchase_details.setStart(1);
		purchase_details.setEnd(999999);
		
		List<PurchaseDetailsAll> purchaseDetail = purchaseDetailService.searchListPurchaseDetail(purchase_details);
		
        return generatePurchaseDetailExcel(purchaseDetail, "입고 조회");
	}

	// PurchaseExcelController  ResponseEntity<byte[]> purchaseDetailNoExcel(PurchaseDetailsAll purchase_details) - 미입고 조회 엑셀
	@Override
	public byte[] purchaseDetailNoExcel(PurchaseDetailsAll purchase_details) throws IOException {
		
		purchase_details.setStart(1);
		purchase_details.setEnd(999999);
		
		List<PurchaseDetailsAll> purchaseDetailNo = purchaseDetailService.searchListPurchaseDetailNo(purchase_details);
		
        return generatePurchaseDetailExcel(purchaseDetailNo, "미입고 조회");
	}
	
	// 입고 엑셀 공통 - 매입일자, 거래처명, 담당자, 상품수, 총수량, 총금액, 상태
    private byte[] generatePurchaseDetailExcel(List<PurchaseDetailsAll> purchase_details, String sheetName) throws IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet(sheetName);

        // 엑셀 헤더 생성
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("매입일자");
        headerRow.createCell(1).setCellValue("거래처명");
        headerRow.createCell(2).setCellValue("담당자");
        headerRow.createCell(3).setCellValue("상품수");
        headerRow.createCell(4).setCellValue("총수량");
        headerRow.createCell(5).setCellValue("총금액");
        headerRow.createCell(6).setCellValue("상태");
        
        System.out.println("PurchaseExcelServiceImpl generatePurchaseDetailExcel purchase_details->"+purchase_details);

        // 엑셀 데이터 생성
        for (int i = 0; i < purchase_details.size(); i++) {
            Row dataRow = sheet.createRow(i + 1);
            PurchaseDetailsAll p = purchase_details.get(i);
            dataRow.createCell(0).setCellValue(p.getPurchase_date());
            dataRow.createCell(1).setCellValue(p.getClient_name());
            dataRow.createCell(2).setCellValue(p.getEmp_name());
            dataRow.createCell(3).setCellValue(p.getProduct_count());
            dataRow.createCell(4).setCellValue(p.getTotal_quantity());
            dataRow.createCell(5).setCellValue(p.getTotal_price());
            dataRow.createCell(6).setCellValue(p.getStatus());
        }

        // 열 너비 자동 조정
        for (int colIndex = 0; colIndex <= 8; colIndex++) {
            sheet.autoSizeColumn(colIndex);
        }

        // 엑셀 파일 생성
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        workbook.write(outputStream);
        workbook.close();

        return outputStream.toByteArray();
    }
	
}
