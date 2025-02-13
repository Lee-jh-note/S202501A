package org.oracle.s202501a.dao.ny_dao;

import java.util.List;

import org.oracle.s202501a.dto.ny_dto.Notice;

public interface NoticeDao {

	int totalNotice();
	List<Notice> listNotice(Notice notice);
	void increaseHit(Long board_No);
	Notice contents(Long board_No);
	int updateNotice(Notice notice);
	int deleteNotice(Long board_No);
	int insertNotice(Notice notice);
	int condTotalNotice(Notice notice);
	List<Notice> noticeSearchList(Notice notice);
	

}
