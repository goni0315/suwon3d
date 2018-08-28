package suwon.web.Service;

import java.util.HashMap;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.dao.LayInfoDao;
import suwon.web.vo.LayInfoVo;

public class LayInfoService implements LayInfoDao{

	private SqlMapClientTemplate sqlMapClientTemplate;
	private HashMap<String, Object> valueMap = new HashMap<String, Object>();
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	@Override
	public List<LayInfoVo> getLayInfoList(String aut_cde) {
	
		return sqlMapClientTemplate.queryForList("sms.getLayInfoList", aut_cde);
	}
}
