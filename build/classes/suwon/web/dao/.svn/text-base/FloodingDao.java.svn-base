package suwon.web.dao;

import java.util.ArrayList;
import java.util.List;

import suwon.web.vo.FloodVo;
import suwon.web.vo.ShelterSearchVo;

public interface FloodingDao {

	ArrayList listEmd(String sgg_cd);//ajax읍면동값 가져오기
	List <ShelterSearchVo> shelterjibunSearch(int startArticleNum,int  endArticleNum,String sgg_cd, String emd_cd, String grade, String useText, String facNm);//구,동으로 검색 (차츰 플러스)
	boolean ShelterInsert(ShelterSearchVo shelterInsert);
	List <ShelterSearchVo> shelterInfoPopUpList(String dep_seq);//대피소검색 팝업창
	List <FloodVo> floodSearch(String flo_year, String flo_loc, String flo_sot);//침수지역검색
	boolean floodInsert(FloodVo floodInsert);//침수지역등록
	List <FloodVo> floodInfoPopUpList(String flo_seq);//침수지역검색 팝업창
}
