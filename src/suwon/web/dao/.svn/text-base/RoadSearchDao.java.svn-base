package suwon.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import suwon.web.vo.CbndVo;
import suwon.web.vo.ManageVo;
import suwon.web.vo.SggVo;


public interface RoadSearchDao {
	
	List<SggVo> getSggList();
	//ArrayList listChoRn(String choName);//도로명초성조회
	ArrayList searchNComboList(String sggName);	//초성검색(ajax용)
	Object getRnSearch(HashMap<String, String> map);//ArrayList getRnSearch(String sggName, String r_cho);//도로명조회(ajax용)
	List<ManageVo> getManageList(int startArticleNum, int endArticleNum,String sgg_cd,String rn_cd, String bonbun, String bubun/*, String sgg_cd*/);
	
	/*List<ManageVo> getManageList();								//일반도로조회
	List<ManageVo> getManageSearch(String manageSel);//주소검색*/
}
