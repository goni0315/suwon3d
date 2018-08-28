package suwon.web.thematic.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.thematic.dao.ThematicDao;
import suwon.web.thematic.dao.ThematicPolygonDao;
import suwon.web.thematic.vo.ThematicPolygonVo;
import suwon.web.thematic.vo.ThematicVo;

public class ThematicPolygonService implements ThematicPolygonDao{

	
	private SqlMapClientTemplate sqlMapClientTemplate;
	private HashMap<String, Object> valueMap = new HashMap<String, Object>();
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}

	@Override
	public String getPolygonPoint(String pnu) throws Exception{
		List<ThematicPolygonVo> tempList = null;
		String polygonPoint = "";
		valueMap.put("pnu", pnu);
		try{
			tempList = sqlMapClientTemplate.queryForList("thematicPolygon.getPolygonList",valueMap);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("잘못된 값이 입력되었습니다.");
		}
		
		for(int i=0;i<tempList.size();i++){
			polygonPoint = polygonPoint + tempList.get(i) + "#";
		}

		return polygonPoint;
	}
}
