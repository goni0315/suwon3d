package suwon.web.Service;

import java.util.HashMap;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.dao.SangsuPipeSearchDao;
import suwon.web.vo.SangsuPipeVo;

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

}
