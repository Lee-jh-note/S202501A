package org.oracle.s202501a.service.rw_service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.oracle.s202501a.dto.rw_dto.SalesAll;
import org.oracle.s202501a.dto.rw_dto.SalesDetailsAll;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class SalesExcelServiceImpl implements SalesExcelService {

	private final SalesService salesService;
	private final SalesDetailsService salesDetailsService;

	// 수주 조회 엑셀
	@Override
	public byte[] listSalesExcel(SalesAll sales) throws IOException {

		sales.setStart(1);
		sales.setEnd(999999);
		System.out.println("SalesExcelServiceImpl listSalesExcel 엑셀 검색조건 " + sales);

		List<SalesAll> listSales = salesService.listSales(sales);

		return generateSalesExcel(listSales, "수주 조회 결과");
	}

	// 수주 엑셀 공통 - 매출일자, 제목, 거래처명, 담당자, 상품수, 총수량, 총금액, 상태, 요청배송일
	private byte[] generateSalesExcel(List<SalesAll> saleses, String sheetName) throws IOException {
		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet(sheetName);

		// 엑셀 헤더 생성
		Row headerRow = sheet.createRow(0);
		headerRow.createCell(0).setCellValue("매출일자");
		headerRow.createCell(1).setCellValue("제목");
		headerRow.createCell(2).setCellValue("거래처명");
		headerRow.createCell(3).setCellValue("담당자");
		headerRow.createCell(4).setCellValue("상품수");
		headerRow.createCell(5).setCellValue("총수량");
		headerRow.createCell(6).setCellValue("총금액");
		headerRow.createCell(7).setCellValue("상태");
		headerRow.createCell(8).setCellValue("요청배송일");

		System.out.println("SalesExcelServiceImpl generateExcel saleses->" + saleses);

		// 엑셀 데이터 생성
		for (int i = 0; i < saleses.size(); i++) {
			Row dataRow = sheet.createRow(i + 1);
			SalesAll p = saleses.get(i);
			dataRow.createCell(0).setCellValue(p.getSales_date());
			dataRow.createCell(1).setCellValue(p.getTitle());
			dataRow.createCell(2).setCellValue(p.getClient_name());
			dataRow.createCell(3).setCellValue(p.getEmp_name());
			dataRow.createCell(4).setCellValue(p.getCount());
			dataRow.createCell(5).setCellValue(p.getTotalQuantity());
			dataRow.createCell(6).setCellValue(p.getTotalPrice());
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

	// 출고 예정 조회 엑셀
	@Override
	public byte[] listPreSalesDetailsExcel(SalesDetailsAll salesDetails) throws IOException {

		salesDetails.setStart(1);
		salesDetails.setEnd(999999);

		List<SalesDetailsAll> listPreSalesDetails = salesDetailsService.listPreSalesDetails(salesDetails);

		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("출고 예정 조회");

		// 엑셀 헤더 생성
		Row headerRow = sheet.createRow(0);
		headerRow.createCell(0).setCellValue("매입일자");
		headerRow.createCell(1).setCellValue("거래처명");
		headerRow.createCell(2).setCellValue("수주담당자");
		headerRow.createCell(3).setCellValue("상품수");
		headerRow.createCell(4).setCellValue("총수량");
		headerRow.createCell(5).setCellValue("총금액");
		headerRow.createCell(6).setCellValue("상태");
		headerRow.createCell(7).setCellValue("요청배송일");

		System.out
				.println("SalesExcelServiceImpl listPreSalesDetailsExcel listPreSalesDetails->" + listPreSalesDetails);

		// 엑셀 데이터 생성
		for (int i = 0; i < listPreSalesDetails.size(); i++) {
			Row dataRow = sheet.createRow(i + 1);
			SalesDetailsAll p = listPreSalesDetails.get(i);
			dataRow.createCell(0).setCellValue(p.getSales_date());
			dataRow.createCell(1).setCellValue(p.getClient_name());
			dataRow.createCell(2).setCellValue(p.getEmp_name());
			dataRow.createCell(3).setCellValue(p.getCount());
			dataRow.createCell(4).setCellValue(p.getTotalQuantity());
			dataRow.createCell(5).setCellValue(p.getTotalPrice());
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

	// 출고 조회 엑셀
	@Override
	public byte[] listGoSalesDetailsExcel(SalesDetailsAll salesDetails) throws IOException {

		salesDetails.setStart(1);
		salesDetails.setEnd(999999);

		List<SalesDetailsAll> listGoSalesDetails = salesDetailsService.listGoSalesDetails(salesDetails);

		return generateSalesDetailsExcel(listGoSalesDetails, "출고 조회");
	}

	// 미출고 조회 엑셀
	@Override
	public byte[] listNoSalesDetailsExcel(SalesDetailsAll salesDetails) throws IOException {

		salesDetails.setStart(1);
		salesDetails.setEnd(999999);

		List<SalesDetailsAll> listNoSalesDetails = salesDetailsService.listNoSalesDetails(salesDetails);

		return generateSalesDetailsExcel(listNoSalesDetails, "미출고 조회");
	}

	// 출고 엑셀 공통 - 매출일자, 거래처명, 담당자, 상품수, 총수량, 총금액, 상태
	private byte[] generateSalesDetailsExcel(List<SalesDetailsAll> salesDetails, String sheetName) throws IOException {
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

		System.out.println("SalesExcelServiceImpl generateSalesDetailsExcel salesDetails->" + salesDetails);

		// 엑셀 데이터 생성
		for (int i = 0; i < salesDetails.size(); i++) {
			Row dataRow = sheet.createRow(i + 1);
			SalesDetailsAll p = salesDetails.get(i);
			dataRow.createCell(0).setCellValue(p.getSales_date());
			dataRow.createCell(1).setCellValue(p.getClient_name());
			dataRow.createCell(2).setCellValue(p.getEmp_name());
			dataRow.createCell(3).setCellValue(p.getCount());
			dataRow.createCell(4).setCellValue(p.getTotalQuantity());
			dataRow.createCell(5).setCellValue(p.getTotalPrice());
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
