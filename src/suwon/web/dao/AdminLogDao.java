package suwon.web.dao;

import java.net.SocketException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import suwon.web.vo.AdminLogListVo;
import suwon.web.vo.AdminLogVo;

public interface AdminLogDao {
	
	//관리자 로그 입력
	public void insertAdminLog(AdminLogVo adminLog, HttpServletRequest request) throws SocketException;
		
	// 해당 관리자 로그 리스트 가져오기
	public List<AdminLogListVo> getList(String usrid, int page, int numPerPage);	

	
	// 해당 관리자 로그 리스트 가져오기
	public List<AdminLogListVo> getSearchList(HashMap<String, String> searchInfo, int page, int numPerPage);	
	
	// 해당 관리자 로그 갯수 가져오기
		public String recordAdminLog(String usrid);
		
		
		// 해당 관리자 조회한 로그 갯수 가져오기
		public String recordAdminSearchLog(HashMap<String, String> searchInfo2);	

}
