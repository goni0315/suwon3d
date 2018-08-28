package suwon.web.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.dao.StatisticsDao;
import suwon.web.vo.MlogVo;

public class StatisticsService implements StatisticsDao{
	private SqlMapClientTemplate sqlMapClientTemplate; //kopps
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	/**
	 * 접속 통계 구하는 함수
	 * 
	 */
	@Override
	public List<MlogVo> getConnList(Map paramMap) {
		
		List<MlogVo> l_list =  sqlMapClientTemplate.queryForList("sms.getConnList", paramMap);
		
		return l_list;
	}
	/**
	 * 접속 통계 구하는 함수 페이징을 위한 총수
	 * 
	 */
	@Override
	public int getConnListCount(Map paramMap) {
		Map pMap = new HashMap();
		
		int total =  (Integer)sqlMapClientTemplate.queryForObject("sms.getConnListCount", paramMap);
		
		return total;
	}
	
	@Override
	public List<MlogVo> getDayGraphData(Map paramMap) {
		List<MlogVo> g_list =  sqlMapClientTemplate.queryForList("sms.getDayGraphData", paramMap);
		
		return g_list;
	}

	@Override
	public List<MlogVo> getMonthGraphData(Map paramMap) {
		List<MlogVo> g_list =  sqlMapClientTemplate.queryForList("sms.getMonthGraphData", paramMap);
		
		return g_list;	
	}
}
