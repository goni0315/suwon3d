package suwon.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import suwon.web.Service.UserConnectListService;
import suwon.web.vo.UserConnectListVo;

@Controller
public class UserConnectListController {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private UserConnectListService connectListService = (UserConnectListService) context.getBean("connectListService");
	
	/**
	 * 사용자 접속정보를 JSP 페이지로 넘겨주는 함수
	 * @return
	 */
	@RequestMapping("/userConnectList.do")
	public ModelAndView userConnectList(HttpServletRequest request, HttpServletResponse response){
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String usrid = request.getParameter("usrid");
		
		List<UserConnectListVo> connectListVos; //사용자 접속정보를 담을 리스트 변수
		if(startDate !=null || endDate !=null || usrid != null){
			 connectListVos = connectListService.getUserconlist(startDate, endDate, usrid);
			 System.out.println(connectListVos);
		 }else{
			 connectListVos = connectListService.getUserlist();
		 }
				
		ModelAndView mav = new ModelAndView();
		mav.addObject("connectListVos", connectListVos);
		mav.setViewName("/jsp/userConnectList");
		
		return mav;
	}
	
}
