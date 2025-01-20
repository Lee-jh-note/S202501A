package org.oracle.s202501a.dao.jh_dao;

import org.apache.ibatis.annotations.Mapper;
import org.oracle.s202501a.dto.jh_dto.SPRecodesDto;
import org.springframework.stereotype.Component;

import java.util.List;

@Mapper
public interface SPRecodesDao {

    List<SPRecodesDto>SPRecodesFindAll(SPRecodesDto spRecodesDto);

    int SPRecodesFindAllCnt(SPRecodesDto spRecodesDto);
}
