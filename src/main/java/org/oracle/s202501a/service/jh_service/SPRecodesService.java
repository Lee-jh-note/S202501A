package org.oracle.s202501a.service.jh_service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.oracle.s202501a.dao.jh_dao.SPRecodesDao;
import org.oracle.s202501a.dto.jh_dto.SPRecodesDto;
import org.springframework.stereotype.Service;

import java.util.List;

@Transactional
@RequiredArgsConstructor
@Slf4j
@Service
public class SPRecodesService {

    private final SPRecodesDao spRecodesDao;

    public List<SPRecodesDto>SPRecodesFindAll(SPRecodesDto spRecodesDto){
        System.out.println(" 서비스에서 다오 호출 전 : " + spRecodesDto);
        return spRecodesDao.SPRecodesFindAll(spRecodesDto);
    }

    public int SPRecodesFindAllCnt(SPRecodesDto spRecodesDto){
        return spRecodesDao.SPRecodesFindAllCnt(spRecodesDto);
    }
}
