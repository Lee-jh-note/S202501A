package org.oracle.s202501a.service.rw_service;

import java.io.IOException;

import org.oracle.s202501a.dto.rw_dto.SalesAll;
import org.oracle.s202501a.dto.rw_dto.SalesDetailsAll;

public interface SalesExcelService {
	
	// 수주 조회 엑셀
	byte[] listSalesExcel(SalesAll sales) throws IOException;

	// 출고 예정 조회 엑셀
	byte[] listPreSalesDetailsExcel(SalesDetailsAll salesDetails) throws IOException;

	// 출고 조회 엑셀
	byte[] listGoSalesDetailsExcel(SalesDetailsAll salesDetails) throws IOException;

	// 미출고 조회 엑셀
	byte[] listNoSalesDetailsExcel(SalesDetailsAll salesDetails) throws IOException;


}
