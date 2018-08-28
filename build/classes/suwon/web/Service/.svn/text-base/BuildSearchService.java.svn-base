package suwon.web.Service;

import java.util.HashMap;
import java.util.List;


import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.dao.BuildSearchDao;
import suwon.web.vo.BuildSearchVo;


public class BuildSearchService implements BuildSearchDao{

	
	private SqlMapClientTemplate sqlMapClientTemplate;
	private HashMap<String, Object> valueMap = new HashMap<String, Object>();

	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}

	@Override
	public List<BuildSearchVo> getBuildList(String build_name) {
	
		//return sqlMapClientTemplate.queryForList("sms.getBuildList");
		valueMap.put("build_name", build_name);
		return sqlMapClientTemplate.queryForList("sms.getBuildList",valueMap);
	}

	/*@Override
	public List<BuildSearchVo> getBuildList(int startArticleNum,int endArticleNum, String pnuCode) {
		
		valueMap.put("startArticleNum", startArticleNum);
		valueMap.put("endArticleNum", endArticleNum);
		valueMap.put("pnuCode", pnuCode);
		return sqlMapClientTemplate.queryForList("sms.getBuildList",valueMap);
	}*/
	
	//******************************페이징처리*******************************
	@Override
	public List<BuildSearchVo> getBuildList(int startArticleNum, int endArticleNum, String build_name) {
		
		valueMap.put("startArticleNum", startArticleNum);
		valueMap.put("endArticleNum", endArticleNum);		
		valueMap.put("build_name", build_name);
		
		return sqlMapClientTemplate.queryForList("sms.buildSearchList", valueMap);
	}
	
	public int getbuildTotalNum(String build_name) {
		
		valueMap.put("build_name", build_name);
		return (Integer) sqlMapClientTemplate.queryForObject("sms.buildTotalNum", valueMap);
	}
	
}
