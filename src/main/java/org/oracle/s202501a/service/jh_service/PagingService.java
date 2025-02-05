package org.oracle.s202501a.service.jh_service;

import org.oracle.s202501a.dto.jh_dto.PagingJH;
import org.springframework.stereotype.Service;

@Service
public class PagingService {

    private static final int PAGE_BLOCK = 10; // 페이지 블록 크기
    private static final int ROW_PAGE = 15;  // 한 페이지에 표시할 데이터 수

    public PagingJH getPagingInfo(int total, String currentPage) {
        int currentPageInt = (currentPage != null) ? Integer.valueOf(currentPage) : 1;

        // 페이지 정보 계산
        int start = (currentPageInt - 1) * ROW_PAGE + 1;
        int end = start + ROW_PAGE - 1;

        int totalPage = (int) Math.ceil((double) total / ROW_PAGE);

        int startPage = currentPageInt - (currentPageInt - 1) % PAGE_BLOCK;
        int endPage = startPage + PAGE_BLOCK - 1;

        if (endPage > totalPage) {
            endPage = totalPage;
        }

        return new PagingJH(start, end, totalPage, startPage, endPage, currentPageInt);
    }
}
