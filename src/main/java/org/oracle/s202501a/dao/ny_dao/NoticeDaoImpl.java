package org.oracle.s202501a.dao.ny_dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.oracle.s202501a.dto.ny_dto.Notice;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class NoticeDaoImpl implements NoticeDao  {
	private final SqlSession session; 
	
	
	

	
	//공지사항 리스트 전체 수 
		@Override
		public int totalNotice() {
			int totNoticeCount = 0;
			System.out.println("NoticeDaoImpl Start totalNotice...");
			try {
				totNoticeCount = session.selectOne("nytotalNotice");
				System.out.println("NoticeDaoImpl totalNotice totNoticeCount->" + totNoticeCount);
			} catch (Exception e) {
				System.out.println("NoticeDaoImpl totalNotice e.getMessage()->" + e.getMessage());
			}

			return totNoticeCount;
		}




		//공지사항 리스트 
		@Override
		public List<Notice> listNotice(Notice notice) {
			List<Notice> noticeList = null;
			System.out.println("NoticeDaoImpl noticeSelect Start..." );
			try {
				noticeList = session.selectList("nylistNotice", notice);
			} catch (Exception e) {
				System.out.println("NoticeDaoImpl noticeSelect Exception->"+e.getMessage());
			}
			return noticeList;
		}




		//공지사항 조회
		@Override
		public void increaseHit(Long notice_No) {
			 System.out.println("NoticeDAOImpl Start increaseHit... notice_No: " + notice_No);
		        int result =0;
		        result = session.update("nyntincreaseHit", notice_No);
		        System.out.println("NoticeDAOImpl Start increaseHit result: " + result);
		    }



		//공지사항 상세
		@Override
		public Notice contents(Long board_No) {
			System.out.println("NoticeDaoImpl detail start..");
			Notice notice = new Notice();
			
			try {
				//
				notice = session.selectOne("nylistNoticeSelOne", board_No); // #기본키여서 셀렉트원?
				System.out.println("NoticeDaoImpl detail notice->" + notice);
			} catch (Exception e) {
				System.out.println("NoticeDaoImpl detail Exception->" + e.getMessage());
			}
			return notice;
		}



		//공지사항 수정
		@Override
		public int updateNotice(Notice notice) {
			System.out.println("NoticeDaoImpl update start..");
			System.out.println("다오 업데이트" +notice);
			int updatentCount = 0;
			try {
				updatentCount = session.update("nyUpdateNotice", notice);
			} catch (Exception e) {
				System.out.println("NoticeDaoImpl updateNotice Exception->" + e.getMessage());
			}
			return updatentCount;
			}

		//게시판 삭제
		public int deleteNotice(Long board_No) {
			System.out.println("NoticeDaoImpl delete start..");
			int result = 0;
			System.out.println("NoticeDaoImpl delete Board_No->"+board_No);
			try {
				result  = session.delete("nydeleteNotice",board_No);
				System.out.println("NoticeDaoImpl delete result->"+result);
			} catch (Exception e) {
				System.out.println("NoticeDaoImpl delete Exception->"+e.getMessage());
			}

			return result;
		}



		// 공지 등록
		@Override
		public int insertNotice(Notice notice) {
			int result = 0;
			System.out.println("NoticeDaoImpl insertNotice Start...");
			try {
				System.out.println("NoticeDaoImpl insertNotice ->"+notice);
				result = session.insert("nyinsertNotice", notice);
			} catch (Exception e) {
				System.out.println("NoticeDaoImpl insertNotice Exception->" + e.getMessage());
			}
			return result;
		}
	
}
