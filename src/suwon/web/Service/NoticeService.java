package suwon.web.Service;

import suwon.web.vo.NoticeVo;
import suwon.web.dao.NoticeDao;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class NoticeService implements NoticeDao{
	
	private SqlMapClientTemplate sqlMapClientTemplate;

	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	
	//전체 공지사항 리스트 쿼리 가져오기
	@SuppressWarnings("unchecked")
	public List<NoticeVo> getNoticeList(int page, int numPerPage)throws SQLException{
		return (List<NoticeVo>)sqlMapClientTemplate.queryForList("sms.getNoticeList", null, page, numPerPage);
	}

	//긴급공지글 가져오기 쿼리
	@SuppressWarnings("unchecked")
	public List<NoticeVo> getNoticeImp(String typNotice, int numPerPage)throws SQLException{
		return (List<NoticeVo>)sqlMapClientTemplate.queryForList("sms.getImpNotice", typNotice, 0, numPerPage);
	}
	
	//검색 리스트 가져오기 쿼리
	@SuppressWarnings("unchecked")
	public List<NoticeVo> getSearchNotice(Map<String, String> searchMap, int page, int numPerPage)throws SQLException{
		return (List<NoticeVo>)sqlMapClientTemplate.queryForList("sms.searchNotice", searchMap, page, numPerPage);
	}
	
	//검색 전체리스트 가져오기 쿼리
	@SuppressWarnings("unchecked")
	public List<NoticeVo> getSearchNotice(Map<String, String> searchMap)throws SQLException{
		return (List<NoticeVo>)sqlMapClientTemplate.queryForList("sms.searchNotice", searchMap);	
	}	
	//선택된 공지글 쿼리 가져오기
	public NoticeVo getNotice(int bod_seq)throws SQLException{
		return (NoticeVo)sqlMapClientTemplate.queryForObject("sms.getNotice", bod_seq);
	}
	
	//공지글 이동 
	public NoticeVo getNoticeMove(Map moveMap)throws SQLException{
		return (NoticeVo)sqlMapClientTemplate.queryForObject("sms.movingNotice", moveMap);
	}
	
	//공지글 작성 쿼리 가져오기
	public void insertNotice(NoticeVo noticeArticle)throws SQLException{
		sqlMapClientTemplate.insert("sms.insertNotice", noticeArticle);
	}
	
	//공지글 삭제 쿼리 가져오기
	public void deleteNotice(int bod_seq)throws SQLException{
		sqlMapClientTemplate.delete("sms.deleteNotice", bod_seq);
	}
	
	//공지글 수정 쿼리 가져오기
	public void updateNotice(NoticeVo noticeArticle)throws SQLException{
		sqlMapClientTemplate.update("sms.updateNotice", noticeArticle);
	}
	
	//공지글 갯수 받아오기
	public String recordNotice()throws SQLException{
		return (String)sqlMapClientTemplate.queryForObject("sms.getNoticeRecord");
	}
	
	//공지글 조회수 카운팅
	public void updateCountNotice(NoticeVo noticeArticle)throws SQLException{
		sqlMapClientTemplate.update("sms.setNoticeCount", noticeArticle);
	}
	
	//검색 공지글 갯수 받아오기
	public String recordSearchNotice(Map<String, String> searchMap)throws SQLException{ 
		return (String)sqlMapClientTemplate.queryForObject("sms.getSearchNoticeRecord", searchMap);
	}

	public List countPopup() {
		return sqlMapClientTemplate.queryForList("sms.countPopup");
	}

	public NoticeVo getPopupInfo(String bod_seq) {
		NoticeVo list = null;
		if(bod_seq!=null){
			list = (NoticeVo)sqlMapClientTemplate.queryForObject("sms.openPopup",bod_seq);
		}
		return list;
	}
}
