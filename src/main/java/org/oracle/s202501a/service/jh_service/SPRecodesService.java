package org.oracle.s202501a.service.jh_service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.dao.jh_dao.SPRecodesDao;
import org.oracle.s202501a.dto.jh_dto.PagingJH;
import org.oracle.s202501a.dto.jh_dto.SPRecodesDto;
import org.oracle.s202501a.dto.jh_dto.SPRecodesPagingDto;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Transactional
@RequiredArgsConstructor
@Slf4j
@Service
public class SPRecodesService {

    private final SPRecodesDao spRecodesDao;
    private final PagingService pagingService;

    public List<SPRecodesDto>SPRecodesFindAll(SPRecodesDto spRecodesDto){
        return spRecodesDao.SPRecodesFindAll(spRecodesDto).stream()
//                .peek(spRecodesDto1 -> System.out.println(spRecodesDto1))
                .toList();
    }

    public SPRecodesPagingDto getSPRecodesList(SPRecodesDto spRecodesDto, String yymmdd, String productName) {
        // yymmdd 값이 있으면 포맷을 맞추고, 없으면 기본값 설정
        if (yymmdd != null && !yymmdd.isEmpty()) {
            String formattedYymm = yymmdd.substring(2).replace('-', '/');
            spRecodesDto.setYymmdd(formattedYymm);
        }
        if (yymmdd == null) {
            yymmdd = new SimpleDateFormat("yy/MM").format(new Date());
            spRecodesDto.setYymmdd(yymmdd);
        }

        // 검색 조건이 있을 경우, 필터링된 데이터 조회
        if (productName != null && !productName.isEmpty()) {
            spRecodesDto.setProduct_name((productName));
        } else {
            spRecodesDto.setProduct_name("");
        }

        // 총 갯수 조회
        int total = SPRecodesFindAllCnt(spRecodesDto);

        // 페이징 계산
        PagingJH page = pagingService.getPagingInfo(total, spRecodesDto.getCurrentPage());
        spRecodesDto.setStart(page.getStart());
        spRecodesDto.setEnd(page.getEnd());

        // 필터링된 레코드 리스트 조회
        List<SPRecodesDto> list = SPRecodesFindAll(spRecodesDto);

        return new SPRecodesPagingDto(list, page, yymmdd, productName);
    }

    public int SPRecodesFindAllCnt(SPRecodesDto spRecodesDto) {
        return spRecodesDao.SPRecodesFindAllCnt(spRecodesDto);
    }
}
