package suwon.web.dao;

import java.util.List;

import suwon.web.vo.UsrIdVo;


public interface AutoChkAdminDao {

	// sys001을 sys003으로 업데이트
	int updateAut();

	// 공간정보팀  usrid 가져옴
	List<UsrIdVo> getUsrId();	

	// 업데이트가 안된 없는 id 입력
	int insertAdmin(UsrIdVo usrIdVo);

	// 가져온 id sys001로 업데이트
	int updateAdmin(UsrIdVo usrIdVo);

}