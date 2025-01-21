package org.oracle.s202501a.dto.jh_dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.security.Key;
import java.util.Date;
import java.util.Map;

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
    private int mid_category;

    //페이징 처리
    private String currentPage;

    private String pageNum;
    private int start;
    private int end;

    // 거래처 명
//    private String client_name;
    // 카테고리 설명
    private String content;
    private String title;

//    // 카테고리ㅋㅋ
//    private Map<String,CategoriesDto> top_categories ;
//    private Map<String,CategoriesDto> mid_categories ;

}
