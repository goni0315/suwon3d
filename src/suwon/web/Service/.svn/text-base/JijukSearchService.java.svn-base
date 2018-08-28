package suwon.web.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


import org.springframework.orm.ibatis.SqlMapClientTemplate;


import suwon.web.dao.JijukSearchDao;
import suwon.web.vo.CbndVo;
import suwon.web.vo.EmdVo;
import suwon.web.vo.SggVo;

public class JijukSearchService implements JijukSearchDao{

	private SqlMapClientTemplate sqlMapClientTemplate;
	private HashMap<String, Object> valueMap = new HashMap<String, Object>();
	
	/**
	 * 
	 * @param sqlMapClientTemplate
	 */
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	
	/**
	 * 입력한 본번과 부번에 일치하는 지번코드(PNU)를 조회하는 함수  
	 */
	/*@Override
	public List<CbndVo> getPnuCode(String bonbun, String bubun) {		
		valueMap.put("bonbun", bonbun);		
		valueMap.put("bubun", bubun);
		
		return sqlMapClientTemplate.queryForList("sms.getCbndList", valueMap);
	}
	
	
	@Override
	public List<EmdVo> getEmdList() {
		
		return sqlMapClientTemplate.queryForList("sms.getEmdList");
	}

	@Override
	public List<EmdVo> getEmdSearch(String keyword) {
		valueMap.put("keyword", keyword);
		return  sqlMapClientTemplate.queryForList("sms.getEmdSearch",valueMap);
	}

	@Override
	public List<EmdVo> getCbndChk(String keywordSan) {
		valueMap.put("keywordSan", keywordSan);
		return  sqlMapClientTemplate.queryForList("sms.getCbndChk",valueMap);
	}
*/
	@Override
	public List<SggVo> getSggList() {
		
		return sqlMapClientTemplate.queryForList("sms.getSggList");
	}

	@Override
	public ArrayList listEmd(String sggName) {
		ArrayList<EmdVo> result = new ArrayList<EmdVo>(); 
	    result =  (ArrayList<EmdVo>) sqlMapClientTemplate.queryForList("sms.getEmdSearch", sggName);
		return result;
	}
	
	//******************************페이징처리*******************************
	@Override
	public List<CbndVo> getJibun(int startArticleNum,int endArticleNum/*,String sggNm*/, String emdNm, String sanChk, String bonbun, String bubun) {

		valueMap.put("startArticleNum", startArticleNum);
		valueMap.put("endArticleNum", endArticleNum);
//		valueMap.put("sggNm", sggNm);
		valueMap.put("emdNm", emdNm);
		valueMap.put("sanChk", sanChk);
		valueMap.put("bonbun", bonbun);
		valueMap.put("bubun", bubun);
		return  sqlMapClientTemplate.queryForList("sms.getJibun",valueMap);		
	}	
		
	//페이징처리
	
	public int getJibunTotalNum(/*String sggNm,*/ String emdNm, String sanChk, String bonbun, String bubun) {
//		valueMap.put("sggNm", sggNm);
		valueMap.put("emdNm", emdNm);
		valueMap.put("sanChk", sanChk);
		valueMap.put("bonbun", bonbun);
		valueMap.put("bubun", bubun);
				
		return (Integer) sqlMapClientTemplate.queryForObject("sms.jibunTotalNum", valueMap);
	}


}
