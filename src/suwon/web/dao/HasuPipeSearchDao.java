package suwon.web.dao;

import java.util.List;

import suwon.web.vo.HasuPipeVo;



public interface HasuPipeSearchDao {

	List<HasuPipeVo> getHasuPipeList(String ftr_idn);
}
