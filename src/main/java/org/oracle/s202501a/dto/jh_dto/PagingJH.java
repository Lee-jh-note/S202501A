package org.oracle.s202501a.dto.jh_dto;


import lombok.*;
import lombok.experimental.Accessors;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class PagingJH {

    private int start;      // 페이지 시작 번호
    private int end;        // 페이지 끝 번호
    private int totalPage;  // 총 페이지 수
    private int startPage;  // 시작 페이지 (페이지 블록 내)
    private int endPage;    // 끝 페이지 (페이지 블록 내)
    private int currentPage; // 현재 페이지

//    private int currentPage = 1;
//    private int pageBlock = 10;
//    private int rowPage = 10;
//    private int start;
//    private int end;
//    private int startPage;
//    private int endPage;
//    private int total;
//    private int totalPage;
//
//
//    public PagingJH(int total, String currentPage1) {
//
//        this.total = total;
//        if (currentPage1 != null) {
//            this.currentPage = Integer.valueOf(currentPage1);
//
//            start = (currentPage - 1) * rowPage + 1;
//            end = start + rowPage - 1;
//
//            totalPage = (int) Math.ceil((double) total / rowPage);
//
//            startPage = currentPage - (currentPage - 1) % pageBlock;
//            endPage = startPage + pageBlock - 1;
//
//            if (endPage > totalPage) {
//                endPage = totalPage;
//            }
//        }
//    }
}
