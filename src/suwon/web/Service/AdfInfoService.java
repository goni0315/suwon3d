package suwon.web.Service;


import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.dao.AdfInfoDao;
import suwon.web.vo.AdfInfoVo;

public class AdfInfoService implements AdfInfoDao{
	private SqlMapClientTemplate sqlMapClientTemplate;

	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	
	@Override
	public boolean writeArticle(AdfInfoVo adfInfo) {
		sqlMapClientTemplate.insert("sms.writeArticle2", adfInfo);	
		
		return true;
	}
}
