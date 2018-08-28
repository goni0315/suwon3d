package suwon.web.thematic.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.thematic.dao.ThematicDao;
import suwon.web.thematic.vo.ThematicVo;

public class ThematicService implements ThematicDao{

	
	private SqlMapClientTemplate sqlMapClientTemplate;
	private HashMap<String, Object> valueMap = new HashMap<String, Object>();
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	
	@Override
	public String getPNU(String emdName, String sanCD, String bonCD, String booCD) {
		valueMap.put("emdName", emdName);
		valueMap.put("sanCD", sanCD);
		valueMap.put("bonCD", bonCD);
		valueMap.put("booCD", booCD);
		
		String pnu = "";
		try{
			List<ThematicVo> tempList = sqlMapClientTemplate.queryForList("thematic.getPNUInfoList",valueMap);
			ThematicVo tempThematicVo = tempList.get(0);
			pnu = tempThematicVo.getPnu();
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("잘못된 값이 입력되었습니다.");
		}
		return pnu;
	}

	@Override
	public String getDoro(String sggNm, String doroNm, String buldBonCd, String buldBooCd) {
		valueMap.put("sggNm", sggNm);
		valueMap.put("doroNm", doroNm);
		valueMap.put("buldBonCd", buldBonCd);
		valueMap.put("buldBooCd", buldBooCd);
		
		String bd_mgt_sn = "";
		try{
			List<ThematicVo> tempDoroList = sqlMapClientTemplate.queryForList("thematic.getDoroList",valueMap);
			ThematicVo tempDoroVo = tempDoroList.get(0);
			bd_mgt_sn = tempDoroVo.getBd_mgt_sn();
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("도로명엑셀의 잘못된 값이 있습니다.");
		}
		//System.out.println("도로명 : " + rds_man_no);
		return bd_mgt_sn;
	} 
	
}
