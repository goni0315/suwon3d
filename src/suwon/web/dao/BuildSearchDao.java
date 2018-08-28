package suwon.web.dao;

import java.util.List;

import suwon.web.vo.BuildSearchVo;


public interface BuildSearchDao {
	List<BuildSearchVo> getBuildList(String build_name);//건물검색
	List<BuildSearchVo> getBuildList(int startArticleNum, int endArticleNum, String build_name);
	int getbuildTotalNum(String build_name);
}
