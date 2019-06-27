package suwon.web.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.dao.AdminDao;
import suwon.web.vo.AdminIpVo;
import suwon.web.vo.BldgChartVo;
import suwon.web.vo.BldgInfoVo;
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
	
	//로그인한 id, ip로 DB 조회
	public List<AdminIpVo> getAdminIP(String usrid, String conip) {
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("usrid",usrid);
		param.put("conip",conip);
		
		List<AdminIpVo> li = new ArrayList<AdminIpVo>();
		li = sqlMapClientTemplate.queryForList("sms.getAdminIP", param); 
		return li;
	}
	
	//로그인한 id, ip로 DB 입력
	public void setAdminIP(String usrid, String conip) {
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("usrid",usrid);
		param.put("conip",conip);
		
		sqlMapClientTemplate.insert("sms.setAdminIP", param); 
		 
		
	}
	public void delAdminIP(String usrid, String conip) {
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("usrid",usrid);
		param.put("conip",conip);
		
		sqlMapClientTemplate.delete("sms.delAdminIP", param); 
		
		
	}
	public List<BldgInfoVo> getBldgList(String year, Integer startNum, Integer endNum) {
		
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("year",year);
		param.put("startNum",startNum.toString());
		param.put("endNum",endNum.toString());
		
		List<BldgInfoVo>list = sqlMapClientTemplate.queryForList("sms.getBldgList", param);
		return list; 
		
	}
	
	public int getTotalCount() {
		
		
		int count = (Integer) sqlMapClientTemplate.queryForObject("sms.getTotalCount");
		return count; 
		
	}
	public List<BldgChartVo> getBldgChartYear() {
		
		List<BldgChartVo> list = sqlMapClientTemplate.queryForList("sms.getBldgChartYear");
		
		return list;
	}
	
	public String getBldgChartCount(String year, String type) {
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("year", year);
		param.put("type", type);
		
		String count = (String) sqlMapClientTemplate.queryForObject("sms.getBldgChartCount" ,param);
		
		return count;
	}

	
	
}
