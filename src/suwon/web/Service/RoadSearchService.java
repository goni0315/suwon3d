package suwon.web.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;


import suwon.web.dao.RoadSearchDao;
import suwon.web.vo.ManageVo;
import suwon.web.vo.SggVo;
import util.MyUtil;


public class RoadSearchService implements RoadSearchDao{
//public class RoadSearchService extends SqlMapClientDaoSupport  implements RoadSearchDao{
	private SqlMapClientTemplate sqlMapClientTemplate;
	private HashMap<String, Object> valueMap = new HashMap<String, Object>();
	private HashMap<String, String> map = new HashMap<String, String>();
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}

/*	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}*/
	@Override
	public List<SggVo> getSggList() {
	
		return sqlMapClientTemplate.queryForList("sms.getSggList");
	}
	
	//초성검색
		@Override
		public ArrayList searchNComboList(String sggName) {
					
			ArrayList<ManageVo> result = new ArrayList<ManageVo>(); 
			result = (ArrayList<ManageVo>) sqlMapClientTemplate.queryForList("sms.getChoList",sggName);
			return result;
		}
		
	//도로명선택
	/*@Override
	public ArrayList listRn(String sggName) {
		ArrayList<ManageVo> result = new ArrayList<ManageVo>(); 
		result =  (ArrayList<ManageVo>) sqlMapClientTemplate.queryForList("sms.getRnSearch", sggName);
		return result;
	}*/
		
		@Override
		public Object getRnSearch(HashMap<String, String> map) {

			MyUtil util = new MyUtil();
			util.getNComboList(map);
			
			return sqlMapClientTemplate.queryForList("sms.getRnSearch",map);
		}
	/***********페이즹처리	************/	
	@Override
	public List<ManageVo> getManageList(int startArticleNum, int endArticleNum,String sgg_cd, String rn_cd, String bonbun, String bubun/*, String sgg_cd*/) {
		
		
		valueMap.put("startArticleNum", startArticleNum);
		valueMap.put("endArticleNum", endArticleNum);
		valueMap.put("sgg_cd", sgg_cd);
		valueMap.put("rn_cd", rn_cd);
		valueMap.put("bonbun", bonbun);
		valueMap.put("bubun", bubun);
		
//		valueMap.put("sgg_cd", sgg_cd);
		
		return  sqlMapClientTemplate.queryForList("sms.getManageList",valueMap);
	}
	
	//페이징처리rn_cd, bonbun,  bubun
	
	public int getRoadTotalNum(String rn_cd, String bonbun, String bubun) {

			valueMap.put("rn_cd", rn_cd);
			valueMap.put("bonbun", bonbun);
			valueMap.put("bubun", bubun);
								
			return (Integer) sqlMapClientTemplate.queryForObject("sms.getRoadTotalNum", valueMap);
		}

	

	
	
	
}