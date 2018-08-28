package suwon.web.dao;

import java.util.ArrayList;
import java.util.List;

import suwon.web.vo.CbndVo;
import suwon.web.vo.SggVo;



public interface JijukSearchDao {
	
	List<SggVo> getSggList();
	ArrayList listEmd(String sggName);
	List<CbndVo> getJibun(int startArticleNum,int endArticleNum, /*String sggNm*/ String emdNm, String sanChk, String bonbun, String bubun);//산체크 테스트
	
	int getJibunTotalNum(/*String sggNm,*/String emdNm,String sanChk,String bonbun,String  bubun);//pnu카운트(페이징처리를 위해서)
	
	/*List<SggVo> getSggList();			//시군구조회
	List<EmdVo> getEmdList();			//읍면동 조회
	List<EmdVo> getEmdSearch(String keyword);	//읍면동 검색
	List<EmdVo> getCbndChk(String keywordSan);	//산 체크 검색
	List<CbndVo> getPnuCode(String bonbun, String bubun);	//본번, 부번
*/	
	
	
	/*List<CbndVo> getJibunList(int startArticleNum, int endArticleNum, String pnuCode);*/
}
