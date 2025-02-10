package org.oracle.s202501a.service.yj_service;

import java.util.List;

import org.oracle.s202501a.dao.yj_dao.MainPageDao;
import org.oracle.s202501a.dto.ny_dto.Notice;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class MainPageServiceImpl implements MainPageService {
	
	private final MainPageDao md;

	@Override
	public List<Notice> mainNotice(Notice notice) {
		List<Notice> noticeList = null;
		System.out.println("MainPageServiceImpl listNotice Start...");
		noticeList = md.mainNotice(notice);
		System.out.println("MainPageServiceImpl listNotice NoticeList.size()->" + noticeList.size());

		return noticeList;
	}
	
	
}
