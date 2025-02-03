package org.oracle.s202501a.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TestEmpDto {

    private Long emp_No; // emp_no
    private Long dept_No;
    private String emp_Name;
    private String emp_Tel;
    private String emp_Email;

}
