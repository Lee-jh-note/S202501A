package org.oracle.s202501a.controller.jh_controller;


import lombok.RequiredArgsConstructor;			
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.oracle.s202501a.service.jh_service.ExcelService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

@Controller
@RequiredArgsConstructor
public class ExcelDownController {

    private final ExcelService excelService;

    @GetMapping("/excel/sprecodes")
    public ResponseEntity<byte[]> excelInven() throws IOException {

        byte[] excelFile = excelService.createSPRecodesExcel();

        // HTTP 응답 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=sample.xlsx");
        headers.add("Content-Type", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");

        // 엑셀 파일을 HTTP 응답으로 반환
        return ResponseEntity.ok()
                .headers(headers)
                .body(excelFile);
    }

}
