package suwon.web.facility.Service;

import java.util.HashMap;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.facility.dao.SangsuPipeSearchDao;
import suwon.web.facility.vo.SangsuPipeVo;
import suwon.web.facility.vo.UflComPipeVo;
import suwon.web.facility.vo.UflElcPipeVo;
import suwon.web.facility.vo.UflGasPipeVo;
import suwon.web.facility.vo.UflHeatPipeVo;
import suwon.web.facility.vo.UflLpgPipeVo;
import suwon.web.facility.vo.UflWidePipeVo;
import suwon.web.vo.HasuPipeVo;

public class SangsuPipeSearchService implements SangsuPipeSearchDao{
	
	private SqlMapClientTemplate sqlMapClientTemplate;
	private HashMap<String, Object> valueMap = new HashMap<String, Object>();
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	@Override
	public List<SangsuPipeVo> getSangsuPipeList(String ftr_idn) {		
			
		return sqlMapClientTemplate.queryForList("sms.getSangsuPipeList", ftr_idn);
	}
	
	@Override
	public List<HasuPipeVo> getHasuPipeList(String ftr_idn) {
		
		return sqlMapClientTemplate.queryForList("sms.getHasuPipeList", ftr_idn);
	}
	
	@Override
	public List<UflElcPipeVo> getElcPipeList(String ftr_idn) {		
			
		return sqlMapClientTemplate.queryForList("sms.getElcPipeList", ftr_idn);
	}
	
	@Override
	public List<UflLpgPipeVo> getLpgPipeList(String ftr_idn) {
		
		return sqlMapClientTemplate.queryForList("sms.getLpgPipeList", ftr_idn);
	}
	
	@Override
	public List<UflGasPipeVo> getGasPipeList(String ftr_idn) {		
			
		return sqlMapClientTemplate.queryForList("sms.getGasPipeList", ftr_idn);
	}
	
	@Override
	public List<UflHeatPipeVo> getHeatPipeList(String ftr_idn) {		
			
		return sqlMapClientTemplate.queryForList("sms.getHeatPipeList", ftr_idn);
	}
	@Override
	public List<UflComPipeVo> getComPipeList(String ftr_idn) {		
			
		return sqlMapClientTemplate.queryForList("sms.getComPipeList", ftr_idn);
	}
	@Override
	public List<UflWidePipeVo> getWidePipeList(String ftr_idn) {		
			
		return sqlMapClientTemplate.queryForList("sms.getWidePipeList", ftr_idn);
	}	
}
