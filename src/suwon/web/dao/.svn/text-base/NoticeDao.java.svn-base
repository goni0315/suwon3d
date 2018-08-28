package suwon.web.dao;

import suwon.web.vo.NoticeVo;

import java.util.List;
import java.util.Map;
import java.sql.SQLException;

public interface NoticeDao {
	
	//전체 공지사항 리스트 쿼리 가져오기
	public List<NoticeVo> getNoticeList(int page, int numPerPage)throws SQLException;
	
	//긴급공지글 가져오기 쿼리
	public List<NoticeVo> getNoticeImp(String typNotice, int numPerPage)throws SQLException;

	//검색 리스트 가져오기 쿼리
	public List<NoticeVo> getSearchNotice(Map<String, String> searchMap, int page, int numPerPage)throws SQLException;
	
	//검색 전체 리스트 가져오기 쿼리
	public List<NoticeVo> getSearchNotice(Map<String, String> searchMap)throws SQLException;
	
	//선택된 공지글 쿼리 가져오기
	public NoticeVo getNotice(int bod_seq)throws SQLException;
			
	//공지글 이동 
	public NoticeVo getNoticeMove(Map moveMap)throws SQLException;
	
	//공지글 작성 쿼리 가져오기
	public void insertNotice(NoticeVo noticeArticle)throws SQLException;
	
	//공지글 삭제 쿼리 가져오기
	public void deleteNotice(int bod_seq)throws SQLException;
	
	//공지글 수정 쿼리 가져오기
	public void updateNotice(NoticeVo noticeArticle)throws SQLException;
			
	//공지글 갯수 받아오기
	public String recordNotice()throws SQLException;
	
	//공지글 조회수 카운팅
	public void updateCountNotice(NoticeVo noticeArticle)throws SQLException;
		
	//검색 공지글 갯수 받아오기
	public String recordSearchNotice(Map<String, String> searchMap)throws SQLException;
		
	
}
