package org.oracle.s202501a.service.yj_service;

import java.io.IOException;

import org.oracle.s202501a.dto.yj_dto.Purchase;
import org.oracle.s202501a.dto.yj_dto.PurchaseDetailsAll;


public interface PurchaseExcelService {

	// PurchaseExcelController  ResponseEntity<byte[]> purchaseExcel() - 발주 리스트 엑셀
	byte[] purchaseExcel() throws IOException;

	// PurchaseExcelController  ResponseEntity<byte[]> purchaseSearchExcel(Purchase purchase) - 발주 검색 엑셀
	byte[] purchaseSearchExcel(Purchase purchase) throws IOException;

	// PurchaseExcelController  ResponseEntity<byte[]> purchaseDetailPlanExcel(PurchaseDetailsAll purchase_details) - 입고예정 엑셀
	byte[] purchaseDetailPlanExcel(PurchaseDetailsAll purchase_details) throws IOException;

	// PurchaseExcelController  ResponseEntity<byte[]> purchaseDetailExcel(PurchaseDetailsAll purchase_details) - 입고 조회 엑셀
	byte[] purchaseDetailExcel(PurchaseDetailsAll purchase_details) throws IOException;

	// PurchaseExcelController  ResponseEntity<byte[]> purchaseDetailNoExcel(PurchaseDetailsAll purchase_details) - 미입고 조회 엑셀
	byte[] purchaseDetailNoExcel(PurchaseDetailsAll purchase_details) throws IOException;

}
