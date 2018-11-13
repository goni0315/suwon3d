package suwon.web.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.dao.UsrAutDao;
import suwon.web.vo.AutVo;
import suwon.web.vo.DeptVo;
import suwon.web.vo.MenuVo;
import suwon.web.vo.UserInfoVo;
import suwon.web.vo.UsrAutVo;
import suwon.web.vo.UsrNameVo;

public class UsrAutService implements UsrAutDao{
	
	private SqlMapClientTemplate sqlMapClientTemplate; //kopps
	
	private SqlMapClientTemplate sqlMapClientTemplate2; //sms
	
	private HashMap<String, Object> valueMap = new HashMap<String, Object>();
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	
	public void setSqlMapClientTemplate2(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate2 = sqlMapClientTemplate;
	}
	/**
	 * 사용자 리스트 & 권한 조회
	 */
	@Override
	public List<UsrAutVo> getUsrAutList(Map paramMap) throws Exception {
		// TODO Auto-generated method stub
		//System.out.println((String)paramMap.get("idList"));
		//사용자 목록 조회
		List<UsrAutVo> u_list =  sqlMapClientTemplate2.queryForList("sms.getUsrAutList", paramMap);
		
		//사용자 권환 매핑
		UsrAutVo vo = new UsrAutVo();
		AutVo subVo = new AutVo();  
		
		String usrid = "";
		
		for(int i=0; i < u_list.size(); i++){
		//for(int i=0; i < i; i++){
			
			vo = (UsrAutVo)u_list.get(i);
			
			usrid = vo.getUsrid();
			
			subVo = (AutVo)sqlMapClientTemplate.queryForObject("sms.getUsrAutCde", usrid);
						
			if(subVo == null){
				subVo = new AutVo();
				subVo.setAut_cde("SYS003");
				subVo.setAut_des("일반사용자");
			}
			
			vo.setAut_cde(subVo.getAut_cde());
			vo.setAut_des(subVo.getAut_des());
			
			u_list.set(i, vo);
		}
		return u_list;
	}
	//사용자 수
	@Override
	public int getUsrAutListCount(Map paramMap) throws Exception {
		// TODO Auto-generated method stub
		//System.out.println((String)paramMap.get("idList"));
		return (Integer)sqlMapClientTemplate2.queryForObject("sms.getUsrAutListCount", paramMap);
	}
	//상위부서 목록
	@Override
	public List<DeptVo> getMainDeptList() {
		// TODO Auto-generated method stub
		return sqlMapClientTemplate2.queryForList("sms.getMainDeptList");
	}
	//하위부서 목록 
	@Override
	public List<DeptVo> getSubDeptList(String deptname) {
		// TODO Auto-generated method stub
		return sqlMapClientTemplate2.queryForList("sms.getSubDeptList", deptname);
	}
	
	//하위부서 목록 
	@Override
	public List<AutVo> getAutList() {
		// TODO Auto-generated method stub
		
		return sqlMapClientTemplate.queryForList("sms.getAutList");
	}
	
	//권한 수정 
	@Override
	public String modifyUsrAut(Map paramMap) {
		// TODO Auto-generated method stub
		String resultCode = "E";
		String usrid = (String)paramMap.get("usrid"); 
		int sucFlag = 0;
		
		AutVo subVo = new AutVo();
		
		//권한 설정이 된적 있는지 판단
		subVo = (AutVo)sqlMapClientTemplate.queryForObject("sms.getUsrAutCde", usrid);
		
		//System.out.println(subVo);
		
		if(subVo==null){ //없으면 insert
			sucFlag = (int)sqlMapClientTemplate.update("sms.insertUsrAut",paramMap);
		}else{//있으면 update
			sucFlag = (int)sqlMapClientTemplate.update("sms.modifyUsrAut",paramMap);	
		}
		
		if(sucFlag == 1 ) { //성공여부 
			resultCode = "S";
		}
		
		return resultCode;
	}
	//메뉴목록 조회 
	@Override
	public List<MenuVo> getAllMenuList() {
		// TODO Auto-generated method stub
		return sqlMapClientTemplate.queryForList("sms.getMenuList", "SYS000");
	}
	
	//메뉴목록 조회 
	@Override
	public List<MenuVo> getMenuList(String autcde) {
		// TODO Auto-generated method stub
		return sqlMapClientTemplate.queryForList("sms.getMenuList", autcde);
	}
	
	//메뉴 권한 수정 
	@Override
	public String updateMenuAut(Map paramMap) {
		// TODO Auto-generated method stub
		
		String resultCode = "E";
		
		int addNum = ((List)paramMap.get("addlist")).size();

		int sucFlag = 0;
		

		if(addNum > 0){ //없으면 insert
			sucFlag = (int)sqlMapClientTemplate.update("sms.updateMenuAut",paramMap);
		}
		
		if(sucFlag > 0 ) { //성공여부 
			resultCode = "S";
		}
		
		//System.out.println("updateMenuAut " + resultCode);
		
		return resultCode;
	}
	//메뉴 권한 수정 
		@Override
		public String removeMenuAut(Map paramMap) {
			// TODO Auto-generated method stub
			
			String resultCode = "E";

			int removeNum = ((List)paramMap.get("removelist")).size(); 
					
			int sucFlag = 0;
			
			if(removeNum > 0){ //없으면 insert
				sucFlag = (int)sqlMapClientTemplate.update("sms.removeMenuAut",paramMap);
			}
			
			
			if(sucFlag > 0 ) { //성공여부 
				resultCode = "S";
			}
			//System.out.println("removeMenuAut  " + resultCode);
			return resultCode;
		}

	@Override
	public List<UsrNameVo> getAutUserName(String aut) {
		
		
		
		
		
		return sqlMapClientTemplate.queryForList("sms.getAutUserName", aut);
	}

		
	
	
	
}

