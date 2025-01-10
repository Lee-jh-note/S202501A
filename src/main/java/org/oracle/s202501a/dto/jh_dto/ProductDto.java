package org.oracle.s202501a.dto.jh_dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class ProductDto {

    private Long product_no;
    private String product_name;
    private String description;
    private int status;
    private int category;
    private int product_delete;
    private Date reg_date;

    // 거래처 명
    private String client_name;
    // 카테고리 설명
    private String content;


}
