package suwon.web.Service;

import java.util.HashMap;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.dao.BuildInfoSearchDao;
import suwon.web.vo.BuildSearchVo;

public class BuildInfoSearchService implements BuildInfoSearchDao{
	private SqlMapClientTemplate sqlMapClientTemplate;
	private HashMap<String, Object> valueMap = new HashMap<String, Object>();
	private HashMap<String, String> valueMap2 = new HashMap<String, String>();

	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}

	@Override
	public List<BuildSearchVo> getBuildInfoList(String bul_man_no) {
			
		valueMap.put("bul_man_no", bul_man_no);
		return sqlMapClientTemplate.queryForList("sms.getBuildInfoList",valueMap);
	}

	public String getBuildPNU(String bul_man_no) {

		
		valueMap2.put("bul_man_no", bul_man_no+".3ds");
		return (String) sqlMapClientTemplate.queryForObject("sms.getBuildPNU", valueMap2);
	}
}
