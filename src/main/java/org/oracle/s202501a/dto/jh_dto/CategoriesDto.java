package org.oracle.s202501a.dto.jh_dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class CategoriesDto {

    private int top_category;
    private int mid_category;
    private String title;
    private String content;

    List<CategoriesDto> topList;
    List<CategoriesDto> midList;


}
