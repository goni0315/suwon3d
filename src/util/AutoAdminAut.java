package util;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import suwon.web.Service.AutoChkAdminService;
import suwon.web.vo.UsrIdVo;

public class AutoAdminAut {
	
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private AutoChkAdminService autoChkAdminService = (AutoChkAdminService) context.getBean("autoChkAdminService");
	public void autoAdminAut() {
		
		// sys001 권한을 sys003으로 변경
				int updateResult = autoChkAdminService.updateAut();
			//System.out.println(updateResult);
				// 공간정보팀 usrid 가져옴
				List<UsrIdVo> result = autoChkAdminService.getUsrId();			
				
				
				// usrid를 sys001로 업데이트하고 없는것은 입력함
				for (int i = 0; i < result.size(); i++) {
					UsrIdVo usrIdVo = new UsrIdVo();
					usrIdVo.setUsrid(result.get(i).getUsrid());
					//System.out.println(result.get(i).getUsrid());
					int updateAdminResult = autoChkAdminService.updateAdmin(usrIdVo);
					if (updateAdminResult == 0) {
						int insertResult = autoChkAdminService.insertAdmin(usrIdVo);
						//System.out.println(insertResult);
					}
				}			
				
				
	}
	

}
