package suwon.web.Service;

import java.util.HashMap;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.dao.HasuPipeSearchDao;
import suwon.web.vo.HasuPipeVo;

public class HasuPipeSearchService implements HasuPipeSearchDao{

	private SqlMapClientTemplate sqlMapClientTemplate;
	private HashMap<String, Object> valueMap = new HashMap<String, Object>();
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	@Override
	public List<HasuPipeVo> getHasuPipeList(String ftr_idn) {
		
		return sqlMapClientTemplate.queryForList("sms.getHasuPipeList", ftr_idn);
	}

}
