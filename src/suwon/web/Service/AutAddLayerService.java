package suwon.web.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.dao.AutAddLayerDao;
import suwon.web.vo.LayAutVo;
import suwon.web.vo.LayInfoVo;

public class AutAddLayerService implements AutAddLayerDao{
	private SqlMapClientTemplate sqlMapClientTemplate;
	private HashMap<String, Object> valueMap = new HashMap<String, Object>();
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	
	
	//ajax
	@Override
	public List<LayInfoVo> getLayGrpNmList() {

		return sqlMapClientTemplate.queryForList("sms.getLayGrpNmList");
	}
	
	@Override
	public ArrayList listLayer(String grpName) {
	
		ArrayList<LayAutVo> result = new ArrayList<LayAutVo>(); 
	    result =  (ArrayList<LayAutVo>) sqlMapClientTemplate.queryForList("sms.listLayer", grpName);
		return result;
	}

	@Override
	public boolean autAddLayer(LayAutVo layAutVo) {
		sqlMapClientTemplate.insert("sms.autAddLayer", layAutVo);
		
		return true;		
	}
}
