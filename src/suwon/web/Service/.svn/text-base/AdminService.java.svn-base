package suwon.web.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.dao.AdminDao;
import suwon.web.vo.LayInfoVo;

public class AdminService implements AdminDao{
	private SqlMapClientTemplate sqlMapClientTemplate;

	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	/*
	 * 레이어리스트 반환*/
	@SuppressWarnings("unchecked")
	public List<LayInfoVo> getLayerListForAdmin(int startArticleNum, int endArticleNum){
		List<LayInfoVo> list = new ArrayList<LayInfoVo>();
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("start",startArticleNum);
		param.put("end", endArticleNum);
		list = sqlMapClientTemplate.queryForList("sms.getLayerListForManager",param);
		return list;
		
	}
	public LayInfoVo getLayerInfoForSeq(int seq) {
		LayInfoVo vo = (LayInfoVo)sqlMapClientTemplate.queryForObject("sms.getLayerInfoForManager",seq);
		System.out.println(vo.toString());
		return vo;
	}
	@SuppressWarnings("unchecked")
	public List<LayInfoVo> getGroupListForAdmin() {
		List<LayInfoVo> list = new ArrayList<LayInfoVo>();
		list = sqlMapClientTemplate.queryForList("sms.getGroupListForManager");
		return list;
	}
	public String doLayerInfoUpdate(LayInfoVo paramVo) {
		int result = 0;
		String resultMsg = null;
		result = sqlMapClientTemplate.update("sms.doLayerInfoUpdate", paramVo);
		if(result==1){
			resultMsg = "정상적으로 업데이트가 완료되었습니다.";
		}else{
			resultMsg = "업데이트에 실패하였습니다.";
		}
		return resultMsg;
	}
	public List<LayInfoVo> getLayerListForAdminInLayerListPage(int startArticleNum, int endArticleNum, String grp_cde) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("start",startArticleNum);
		param.put("end", endArticleNum);
		param.put("grp_cde", grp_cde);
		List<LayInfoVo> list = new ArrayList<LayInfoVo>();
		list = sqlMapClientTemplate.queryForList("sms.getLayerListForManagerInlayerListPage", param);
		return list;
	}
	public int getLayerListCntForAdmin(int startArticleNum, int endArticleNum) {
		int returns = (Integer)sqlMapClientTemplate.queryForObject("sms.getLayerListCntForManager");
		return returns;
	}
	public int getLayerListCntForAdminInLayerListPage(int startArticleNum, int endArticleNum, String msg) {
		int returns = (Integer)sqlMapClientTemplate.queryForObject("sms.getLayerListCntForManagerInlayerListPage", msg); 
		return returns;
	}
	
	
}
