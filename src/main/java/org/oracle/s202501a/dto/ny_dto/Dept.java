package org.oracle.s202501a.dto.ny_dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Dept {
	private Long dept_No; //부서정보
	private String dept_Name; //부서명
	private String dept_Tel; //부서전화번호

}
