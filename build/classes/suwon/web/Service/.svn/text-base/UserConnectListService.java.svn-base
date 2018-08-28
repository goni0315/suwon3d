package suwon.web.Service;

import java.util.HashMap;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.dao.UserConnectListDao;
import suwon.web.vo.UserConnectListVo;

public class UserConnectListService implements UserConnectListDao{
	private SqlMapClientTemplate sqlMapClientTemplate;
	private HashMap<String, Object> valueMap = new HashMap<String, Object>();
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	
	
	@Override
	public List<UserConnectListVo> getUserconlist(String startDate, String endDate, String usrid) {
		valueMap.put("startDate", startDate);
		valueMap.put("endDate", endDate);
		valueMap.put("usrid", usrid);
		return sqlMapClientTemplate.queryForList("sms.getUserconlist",valueMap);
	}


	@Override
	public List<UserConnectListVo> getUserlist() {
		return sqlMapClientTemplate.queryForList("sms.getUserlist");
	}


}
