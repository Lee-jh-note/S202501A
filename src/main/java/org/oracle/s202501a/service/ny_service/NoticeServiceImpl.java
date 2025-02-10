package org.oracle.s202501a.service.ny_service;

import java.util.List;

import org.oracle.s202501a.dao.ny_dao.NoticeDao;
import org.oracle.s202501a.dto.ny_dto.Notice;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class  NoticeServiceImpl implements NoticeService{
	private final NoticeDao nd;
	
	//공지사항 총 수
	@Override
	public int totalNotice() {
		System.out.println("NoticeServiceImpl totalBoard Start ...");
		int totNoticeCnt = nd.totalNotice();
		System.out.println("NoticeServiceImpl totalBoard totNoticeCnt->" + totNoticeCnt);
		return totNoticeCnt;
	}

	//공지사항 리스트 
	@Override
	public List<Notice> listNotice(Notice notice) {
		List<Notice> noticeList = null;
		System.out.println("NoticeServiceImpl listNotice Start...");
		noticeList = nd.listNotice(notice);
		System.out.println("NoticeServiceImpl listNotice NoticeList.size()->" + noticeList.size());

		return noticeList;
	}

	//공지 조회수
	@Override
	public void increaseHitNT(Long board_No) {
		System.out.println("NoticeServiceImplStart increaseHit...");
		nd.increaseHit(board_No);
	}

	//공지 세부내역
	@Override
	public Notice ntcontents(Long board_No) {
		System.out.println("NoticeServiceImpl contents Start...");
		Notice notice = null;
		notice = nd.contents(board_No);
		System.out.println("NoticeServiceImpl contents ...");
		
		return notice;
	}

	// 공지 수정 
	@Override
	public int updateNotice(Notice notice) {
		System.out.println("NoticeServiceImpl update ...");
		int updatentCount = 0;
		updatentCount = nd.updateNotice(notice);
		return updatentCount;
	}
	
	
	//공지 삭제
	@Override
	public int deleteNotice(Long board_No) {
		int result = 0;
		System.out.println("NoticeServiceImpl delete Start..." );
		result =  nd.deleteNotice(board_No);
		return result;
	}

	
	//공지 등록
	@Override
	public int insertNotice(Notice notice) {
		int result = 0;
		System.out.println("NoticeServiceImpl insertBoard Start...");
		result = nd.insertNotice(notice);
		return result;
	}

}
