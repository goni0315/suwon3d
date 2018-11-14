package suwon.web.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import suwon.web.vo.AutVo;
import suwon.web.vo.DeptVo;
import suwon.web.vo.MenuVo;
import suwon.web.vo.UsrAutVo;
import suwon.web.vo.UsrIdVo;
import suwon.web.vo.UsrNameVo;

public interface UsrAutDao {
	
	List<UsrAutVo> getUsrAutList(Map paramMap) throws Exception; //사용자 권한 조회
	
	List<DeptVo> getMainDeptList(); //메인 부서명 조회
	
	List<DeptVo> getSubDeptList(String dept_id); //하위 부서명 조회
	
	int getUsrAutListCount(Map paramMap) throws Exception; //사용자 수 조회
	
	List<AutVo> getAutList();
	
	String modifyUsrAut(Map paramMap);
	
	List<MenuVo> getAllMenuList();
	
	List<MenuVo> getMenuList(String autcde);
	
	String updateMenuAut(Map paramMap);
	
	String removeMenuAut(Map paramMap);
	
	List<UsrIdVo> getAutUserId(String aut);
	
	List<UsrNameVo> getAutUserName(Map list);
	
	
	
}
