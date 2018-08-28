package suwon.web.Service;

import java.util.HashMap;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.dao.UserInfoDao;
import suwon.web.vo.AutVo;
import suwon.web.vo.MlogVo;
import suwon.web.vo.UserInfoVo;

public class UserInfoService implements UserInfoDao{
	private SqlMapClientTemplate sqlMapClientTemplate; //kopps
	
	private SqlMapClientTemplate sqlMapClientTemplate2; //sms
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	
	public void setSqlMapClientTemplate2(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate2 = sqlMapClientTemplate;
	}
	
	/**
	 * 사용자 정보 가져오는 함수
	 * @param usrid 사용자 아이디
	 * @return UsrInfoVo
	 */
	@Override
	public UserInfoVo getUserInfo(String usrid) {
		UserInfoVo vo = new UserInfoVo();
		
		try {
			AutVo subVo = new AutVo();
			
			vo =  (UserInfoVo)sqlMapClientTemplate2.queryForObject("sms.getUserInfo", usrid);
			
			if(vo == null){ //사용자 아이디가 존재 하지 않을때 null 반환

			}else{  
				subVo = (AutVo)sqlMapClientTemplate.queryForObject("sms.getUsrAutCde", usrid);
				if(subVo == null){ //사용자 권한 테이블에 별도 권한이 없을때 일반사용자 권한 반환
					subVo = new AutVo();
					subVo.setAut_cde("SYS003");
					subVo.setAut_des("일반사용자");
				}
				vo.setAut_cde(subVo.getAut_cde());
				vo.setAut_des(subVo.getAut_des());
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			vo = null;
		}
		return vo;
	}
	
	/**
	 * 로그 저장하기 
	 * @param MlogVo 로그정보
	 * @return String SucFlag 성공여부
	 */
	@Override
	public String writeLog(MlogVo vo) {
		
		String sucFlag = "E";

		int cnt =  (int)sqlMapClientTemplate.update("sms.writeLog", vo);
		
		if(cnt == 1 ){
			sucFlag = "S";
		}
		
		return sucFlag;
	}
	/**
	 * 메뉴 권한 조회 
	 * @param menuid 메뉴 아이디
	 * @return String menuAut 메뉴 권한 
	 */
	@Override
	public String checkMenuAut(String menuid) {
		
		String menuAut = (String)sqlMapClientTemplate.queryForObject("sms.chceckMenuAut", menuid);
		
		return menuAut;
	}
	
}
