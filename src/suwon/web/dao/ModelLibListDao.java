package suwon.web.dao;

import java.util.ArrayList;
import java.util.List;

import suwon.web.vo.ModelLibListVo;

public interface ModelLibListDao {
	List<ModelLibListVo> getModelLibList();
	ArrayList listModel(String modelName);
	ArrayList listSmallModel(String libl_cde,String libm_cde, String texture_file);
	List<ModelLibListVo> getModel(String modelCode);
}
