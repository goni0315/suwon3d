package suwon.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import suwon.web.Service.SggService;
import suwon.web.vo.SggVo;


/**
 * 지번검색 페이지에서 시/군/구 조회 Controller
 * @author Administrator
 *
 */	
@Controller
public class SggController {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private SggService sggService = (SggService) context.getBean("sggService");
	
	@RequestMapping("/sgg.do")
	public ModelAndView boardList(HttpServletRequest request, HttpServletResponse response){
		
/*		String keyword = null;
		
		if(request.getParameter("keyword") != null){
			keyword = request.getParameter("keyword").trim();
		}
		
		List<EmdVo> sggList; //dao
		if(keyword != null){
			sggList = sggService.getSggSearch(keyword);
		} else {
			sggList = sggService.getSggList();
		}
*/		
		List<SggVo> sggList ;
		
		sggList = sggService.getSggList();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("sggList", sggList);
		mav.setViewName("/jsp/sgg");
		return mav;
		
	}
}
