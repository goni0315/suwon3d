package suwon.web.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.dao.ModelLibListDao;
import suwon.web.vo.ModelLibListVo;

public class ModelLibListService implements ModelLibListDao{
	private SqlMapClientTemplate sqlMapClientTemplate;
	private HashMap<String, Object> valueMap = new HashMap<String, Object>();
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	
	public List<ModelLibListVo> getModelLibList() {
		return sqlMapClientTemplate.queryForList("sms.getModelLibList");
	}
	
	@Override
	public ArrayList listModel(String modelName) {
		ArrayList<ModelLibListVo> result = new ArrayList<ModelLibListVo>();
		result = (ArrayList<ModelLibListVo>) sqlMapClientTemplate.queryForList("sms.getModelLibList", modelName);
		return result;
	}
	@Override
	public ArrayList listSmallModel(String libl_cde, String libm_cde, String texture_file) {
		valueMap.put("libl_cde", libl_cde);
		valueMap.put("libm_cde", libm_cde);
		valueMap.put("texture_file", texture_file);
		ArrayList<ModelLibListVo> result = new ArrayList<ModelLibListVo>();
		result = (ArrayList<ModelLibListVo>) sqlMapClientTemplate.queryForList("sms.getModel",valueMap);
		return result;
	}
	@Override
	public List<ModelLibListVo> getModel(String modelCode) {
		valueMap.put("modelCode", modelCode);
		
		return sqlMapClientTemplate.queryForList("sms.getModel", valueMap);
	}
}
