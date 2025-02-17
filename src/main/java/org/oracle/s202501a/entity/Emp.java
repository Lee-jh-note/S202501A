package org.oracle.s202501a.entity;

import java.io.Serializable;	
import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import lombok.Data;

@Entity
@Data
@SequenceGenerator(
        name         = "emp_no_seq_gen",       // Seq 객체
        sequenceName = "emp_no_seq",           // Seq DB 
        initialValue = 1,
        allocationSize = 1
         )

public class Emp implements Serializable {
		 @Id
		   @GeneratedValue(
	                  strategy = GenerationType.SEQUENCE,
	                  generator = "emp_no_seq_gen"
	               )		  
		  private Long   emp_No;    
		 // 사원 번호
		  @Column(name = "emp_name") // DB 컬럼명과 매핑
	      private String empName; 
	      private Long   dept_No;      // 부서 번호
	      private String Position; 	   // 직급
	      private String emp_Tel; 
	      @Column(name = "emp_email") // DB 컬럼명과 매핑
	      private String empEmail;    // 이메일
	      private String username;
	      private String roles;
	      
	      
	      private Date birth;        // 생년월일
	      private Date hiredate;     // 입사일
	  
	      
	      private String password;	// 비밀번호 (부서이름 + 생년월일)


		
}

