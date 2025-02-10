package org.oracle.s202501a.service.ny_service;

import java.util.List;

import org.oracle.s202501a.dto.ny_dto.Notice;

public interface NoticeService {

	int totalNotice();
	List<Notice> listNotice(Notice notice); // 공지 리스트
	void increaseHitNT(Long board_No); //공지 조회수
	Notice ntcontents(Long board_No); //공지 세부내역
	
	int updateNotice(Notice notice); //공지 수정
	int deleteNotice(Long board_No); // 공지 삭제
	int insertNotice(Notice notice); 

}
