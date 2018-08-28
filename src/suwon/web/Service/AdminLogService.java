package suwon.web.Service;

import java.net.SocketException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.dao.AdminLogDao;
import suwon.web.vo.AdminLogListVo;
import suwon.web.vo.AdminLogVo;
import util.ConIP;

public class AdminLogService implements AdminLogDao{
	
	
	
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	HashMap<String, Object> valueMap = new HashMap<String, Object>();
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	
	//관리자 로그 쌓기
	@Override
	public void insertAdminLog(AdminLogVo adminLog, HttpServletRequest request) throws SocketException {
				
		
		valueMap.put("usrid", adminLog.getUsrid());
		valueMap.put("conip", new ConIP().getConIP(request));
		valueMap.put("menuname", adminLog.getMenu());
		//System.out.println(valueMap);	
		
		
		sqlMapClientTemplate.insert("sms.admloginfo", valueMap);
					
	}

	
	
	// 해당 관리자 로그 리스트 가져오기
	@Override
	public List<AdminLogListVo> getList(String usrid, int page, int numPerPage) {		
		
		@SuppressWarnings("unchecked")
		List<AdminLogListVo> list =  sqlMapClientTemplate.queryForList("sms.getAdminLogList", usrid, page, numPerPage);
		
		
		return list;
	}
	
	// 해당 관리자 검색로그 리스트 가져오기
	@Override
	public List<AdminLogListVo> getSearchList(HashMap<String, String> searchInfo, int page, int numPerPage) {		
		
		@SuppressWarnings("unchecked")
		List<AdminLogListVo> list =  sqlMapClientTemplate.queryForList("sms.getAdminSearchLogList", searchInfo, page, numPerPage);
		
		
		return list;
	}

	/**
	 * 이 메소드는 ...을 하기 위한 메소드이다.
	 * @Method     : recordNotice
	 * @since      : 2018. 5. 9.
	 * @paramType  :  
	 * @returnType : void
	 * @see        : ex) return 값을 전달하는 페이지명
	 *               조건에 따른 return 값 전달 페이지가 다를 경우
	 *               ex) True  : 페이지명
	 *                   False : 페이지명
	 */
	//해당 관리자 로그 갯수
	public String recordAdminLog(String usrid) {
		return (String)sqlMapClientTemplate.queryForObject("sms.getAdminLogRecord", usrid);
		
	}
	
	//해당 관리자 조회한 메뉴 로그 갯수
	public String recordAdminSearchLog(HashMap<String, String> searchInfo2) {
		return (String)sqlMapClientTemplate.queryForObject("sms.getAdminSearchLogRecord", searchInfo2);
		
	}

}
