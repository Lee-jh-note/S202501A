package org.oracle.s202501a.dto.sh_dto;

import java.util.Date;	

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class EmpDTO {
      private Long   emp_No;       // 사원 번호
      private String emp_Name;     // 이름
      private Long   dept_No;      // 부서 번호
      private String Position; 	   // 직급
      private String emp_Tel;      // 전화번호
      private String emp_Email;    // 이메일
      private String dept_Name;    // 부서 이름
      private String username;
      private String roles;
      
      private String birth;        // 생년월일
      private String hiredate;     // 입사일
      
      private int id;		     // 아이디 직원번호
      private String password;	// 비밀번호 (부서이름 + 생년월일)
    
}