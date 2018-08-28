package suwon.web.Service;

import java.util.HashMap;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.dao.LayerListDao;
import suwon.web.vo.LayerListVo;
import suwon.web.vo.UsrLayerLoadVo;

public class LayerListService implements LayerListDao{

	private SqlMapClientTemplate sqlMapClientTemplate;
	private HashMap<String, Object> valueMap = new HashMap<String, Object>();
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	
	//레이어 목록 불러오기
	@Override
	public List<LayerListVo> getLayerList() {
		return sqlMapClientTemplate.queryForList("sms.getLayerList");
	}
	//레이어 목록 저장하기
	@Override
	public void setLayerList(String[] layList) {
		for(int i=0;i<layList.length;i++){
			String[] rlayList = layList[i].split("#");
			valueMap.put("usrid", rlayList[0]);
			valueMap.put("lay_seq", rlayList[1]);
			valueMap.put("f_view", rlayList[2]);
			sqlMapClientTemplate.insert("sms.writeLayer",valueMap);
		}
		
		//sqlMapClientTemplate.queryForList("sms.writeLayer",layList);
	}
	
	//사용자 아이디로 저장되어져 있는 설정들을 불러온다.
	@Override
	public List<UsrLayerLoadVo> getUsrLayerList(String usr_id) {
		valueMap.put("usr_id", usr_id);
		return sqlMapClientTemplate.queryForList("sms.getUsrLayerList", valueMap);
	}
	
	//사용자 아이디로 레이어의 설정이 저장되어있는 지 확인
	@Override
	public List<UsrLayerLoadVo> getUsrLayerchk(String usr_id) {
		valueMap.put("usr_id", usr_id);
		return sqlMapClientTemplate.queryForList("sms.getUsrLayerChk", valueMap);
	}

	@Override
	public void delUsrLayer(String dleId) {
		sqlMapClientTemplate.delete("sms.deleteLayer",dleId);
	}
}
