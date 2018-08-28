package suwon.web.Service;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.dao.AutoChkAdminDao;
import suwon.web.vo.UsrIdVo;

public class AutoChkAdminService implements AutoChkAdminDao {

	private SqlMapClientTemplate sqlMapClientTemplate;
	private SqlMapClientTemplate sqlMapClientTemplate2;

	public SqlMapClientTemplate getSqlMapClientTemplate2() {
		return sqlMapClientTemplate2;
	}

	public void setSqlMapClientTemplate2(SqlMapClientTemplate sqlMapClientTemplate2) {
		this.sqlMapClientTemplate2 = sqlMapClientTemplate2;
	}

	public SqlMapClientTemplate getSqlMapClientTemplate() {
		return sqlMapClientTemplate;
	}

	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}

	public AutoChkAdminService(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}

	public AutoChkAdminService() {

	}

	@Override
	// sys001을 sys003으로 업데이트
	public int updateAut() {
		// TODO Auto-generated method stub
		return sqlMapClientTemplate.update("sms.updateAut");

	}

	@SuppressWarnings("unchecked")
	@Override
	// 공간정보 부서 usrid 가져옴
	public List<UsrIdVo> getUsrId() {
		// TODO Auto-generated method stub

		return sqlMapClientTemplate2.queryForList("sms.getusrid");
	}
	


	@Override
	// 가져온 id sys001로 업데이트
	public int updateAdmin(UsrIdVo usrIdVo) {
		// TODO Auto-generated method stub

		return sqlMapClientTemplate.update("sms.updateadmin", usrIdVo);

	}

	public int insertAdmin(UsrIdVo usrIdVo) {

		return sqlMapClientTemplate.update("sms.insertadmin", usrIdVo);
		// TODO Auto-generated method stub

	}



}
