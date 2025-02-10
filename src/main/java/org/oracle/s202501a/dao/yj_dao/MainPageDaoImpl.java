package org.oracle.s202501a.dao.yj_dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.ny_dto.Notice;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;


@Repository
@RequiredArgsConstructor
public class MainPageDaoImpl implements MainPageDao {
	
	private final SqlSession session;

	@Override
	public List<Notice> mainNotice(Notice notice) {
		List<Notice> noticeList = null;
		System.out.println("MainPageDaoImpl noticeSelect Start..." );
		try {
			noticeList = session.selectList("yjMainNotice", notice);
		} catch (Exception e) {
			System.out.println("MainPageDaoImpl noticeSelect Exception->"+e.getMessage());
		}
		return noticeList;
	}
	
	
}
