package suwon.web.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import suwon.web.dao.FloodingDao;

import suwon.web.vo.FloodVo;
import suwon.web.vo.ShelterSearchVo;

public class FloodingService implements FloodingDao{
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
	 *(Ajax)침수시뮬레이션 페이지 > 대피소(대피소 검색) 소재지 읍면동값을 ArrayList에 저장하는 함수  
	 * @author Administrator
	 *
	 */
	@Override
	public ArrayList listEmd(String sgg_cd) {
		ArrayList<ShelterSearchVo> result = new ArrayList<ShelterSearchVo>(); 
	    result =  (ArrayList<ShelterSearchVo>) sqlMapClientTemplate.queryForList("sms.shelterjibunSearch", sgg_cd);	
		return result;
	}
	/**
	 *침수시뮬레이션 페이지 > 대피소(대피소 검색) 각 변수값과 페이징값을 valueMap에 저장하는 함수 
	 * @author Administrator
	 *
	 */
	@Override	
	public List<ShelterSearchVo> shelterjibunSearch(int startArticleNum,int  endArticleNum,String sgg_cd, String emd_cd, String grade, String useText, String facNm){
		
		/*FloodingController as = new FloodingController();
		as.useValueToText(useText);*/
		valueMap.put("startArticleNum", startArticleNum);
		valueMap.put("endArticleNum", endArticleNum);
		valueMap.put("sgg_cd", sgg_cd);
		valueMap.put("emd_cd", emd_cd);
		valueMap.put("grade", grade);
		valueMap.put("useText", useText);
		valueMap.put("facNm", facNm);
		return  sqlMapClientTemplate.queryForList("sms.shelterSearch",valueMap);	
	}
	/**
	 *침수시뮬레이션 페이지 > 대피소(대피소 검색) 페이지count를 valueMap에 저장하는 함수 
	 * @author Administrator
	 *
	 */	
	public int shelterjibunSearchTotalNum(String sgg_cd, String emd_cd, String grade, String useText, String facNm){		
	
		valueMap.put("sgg_cd", sgg_cd);
		valueMap.put("emd_cd", emd_cd);
		valueMap.put("grade", grade);
		valueMap.put("useText", useText);
		valueMap.put("facNm", facNm);
		return  (Integer) sqlMapClientTemplate.queryForObject("sms.shelterjibunSearchTotalNum",valueMap);	
	}
	/**
	 *침수시뮬레이션 페이지 > 대피소(대피소 등록) sqlMapClientTemplate에 저장하는 함수 
	 * @author Administrator
	 *
	 */		
	@Override
	public boolean ShelterInsert(ShelterSearchVo shelterInsert) {
		
		sqlMapClientTemplate.insert("sms.shelterInsert", shelterInsert);	
		return true;
	}
	
	/**
	 *침수시뮬레이션 페이지 > 침수정보 > 침수지역검색 (상세정보 팝업) sqlMapClientTemplate에 저장하는 함수 
	 * @author Administrator
	 *
	 */	
	@Override
	public List<ShelterSearchVo> shelterInfoPopUpList(String dep_seq){
	
		valueMap.put("dep_seq", dep_seq);
		return sqlMapClientTemplate.queryForList("sms.shelterInfoPopUpList",dep_seq);		
	}	
	
	
	
	
	
	/**
	 *침수시뮬레이션 페이지 > 침수정보 > 침수지역 검색 sqlMapClientTemplate에 저장하는 함수 
	 * @author Administrator
	 *
	 */
	@Override
	public List<FloodVo> floodSearch(String flo_year, String flo_loc, String flo_sot) {
	
		valueMap.put("flo_year",flo_year);
		valueMap.put("flo_loc",flo_loc);
		valueMap.put("flo_sot",flo_sot);
		return sqlMapClientTemplate.queryForList("sms.floodSearch",valueMap);

	}
	/**
	 *침수시뮬레이션 페이지 > 침수정보(침수지역 등록) sqlMapClientTemplate에 저장하는 함수 
	 * @author Administrator
	 *
	 */		
	@Override
	public boolean floodInsert(FloodVo floodInsert) {
	
		sqlMapClientTemplate.insert("sms.floodInsert",floodInsert);
		return true;
	}	
	/**
	 *침수시뮬레이션 페이지 > 침수정보 > 침수지역검색 (상세정보 팝업) sqlMapClientTemplate에 저장하는 함수 
	 * @author Administrator
	 *
	 */	
	@Override
	public List<FloodVo> floodInfoPopUpList(String flo_seq){
	
		valueMap.put("flo_seq", flo_seq);
		return sqlMapClientTemplate.queryForList("sms.floodInfoPopUpList",flo_seq);		
	}
	
}
