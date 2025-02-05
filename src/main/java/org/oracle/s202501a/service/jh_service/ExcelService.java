package org.oracle.s202501a.service.jh_service;

import lombok.RequiredArgsConstructor;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.oracle.s202501a.dto.jh_dto.SPRecodesDto;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ExcelService {

    private final SPRecodesService spRecodesService;

    public byte[] createSPRecodesExcel(String yymmdd) throws IOException {

        SPRecodesDto dto = new SPRecodesDto();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        dto.setStart(1);
        dto.setEnd(999999);
        String tyymmdd = yymmdd.substring(2).replace('-', '/');
        dto.setYymmdd(tyymmdd);
        List<SPRecodesDto> dtos = spRecodesService.SPRecodesFindAll(dto);
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("판매 실적");

        // 엑셀 헤더 생성
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("날짜");
        headerRow.createCell(1).setCellValue("대분류");
        headerRow.createCell(2).setCellValue("제품 코드");
        headerRow.createCell(3).setCellValue("제품 이름");
        headerRow.createCell(4).setCellValue("구매량");
        headerRow.createCell(5).setCellValue("구매단가");
        headerRow.createCell(6).setCellValue("구매총액");
        headerRow.createCell(7).setCellValue("판매량");
        headerRow.createCell(8).setCellValue("판매단가");
        headerRow.createCell(9).setCellValue("판매총액");
        headerRow.createCell(10).setCellValue("처리자");
        headerRow.createCell(11).setCellValue("처리일자");

        System.out.println(dtos);
        // 엑셀 데이터 생성
        for (int i = 0; i < dtos.size(); i++) {
            Row dataRow = sheet.createRow(i + 1); // 행 인덱스 1부터 시작
            dataRow.createCell(0).setCellValue(dtos.get(i).getYymmdd());
            dataRow.createCell(1).setCellValue(dtos.get(i).getTitle());
            dataRow.createCell(2).setCellValue(dtos.get(i).getProduct_no());
            dataRow.createCell(3).setCellValue(dtos.get(i).getProduct_name());
            dataRow.createCell(4).setCellValue(dtos.get(i).getPurQuantity());
            dataRow.createCell(5).setCellValue(dtos.get(i).getPurPrice());
            dataRow.createCell(6).setCellValue(dtos.get(i).getPurPrice() * dtos.get(i).getPurQuantity());
            dataRow.createCell(7).setCellValue(dtos.get(i).getSaleQuantity());
            dataRow.createCell(8).setCellValue(dtos.get(i).getSalePrice());
            dataRow.createCell(9).setCellValue(dtos.get(i).getSalePrice() * dtos.get(i).getSaleQuantity());
            dataRow.createCell(10).setCellValue(dtos.get(i).getEmp_name());
            dataRow.createCell(11).setCellValue(sdf.format(dtos.get(i).getReg_date()));

        }
        sheet.autoSizeColumn(0); // 날짜 열
        sheet.autoSizeColumn(1); // 대분류 열
        sheet.autoSizeColumn(2); // 제품 코드 열
        sheet.autoSizeColumn(3); // 제품 이름 열
        sheet.autoSizeColumn(4); // 구매량 열
        sheet.autoSizeColumn(5); // 구매단가 열
        sheet.autoSizeColumn(6); // 구매총액 열
        sheet.autoSizeColumn(7); // 판매량 열
        sheet.autoSizeColumn(8); // 판매단가 열
        sheet.autoSizeColumn(9); // 판매총액 열
        sheet.autoSizeColumn(10); // 처리자 열
        sheet.autoSizeColumn(11); // 처리일자 열
        // 엑셀 파일을 ByteArrayOutputStream에 작성
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        workbook.write(outputStream);
        workbook.close();

        return outputStream.toByteArray(); // 생성된 엑셀 파일을 byte 배열로 반환
    }

}
