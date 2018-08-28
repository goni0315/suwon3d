package suwon.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import suwon.web.Service.HasuPipeSearchService;
import suwon.web.vo.HasuPipeVo;


/**
 * 하수관거 정보조회를 담당하는 Controller 
 * @author Administrator
 *
 */
@Controller
public class HasuPipeSearchController {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");		
	private HasuPipeSearchService hasuPipeSearchService = (HasuPipeSearchService ) context.getBean("hasuPipeSearchService");//산조회 테스트

	@RequestMapping("/hasuPipeSearch.do")
	public ModelAndView boardList(HttpServletRequest request, HttpServletResponse response){
		
		String ftr_idn = request.getParameter("ftr_idn");
		System.out.println("ftr_idn=" + ftr_idn);
		 List<HasuPipeVo> HasuPipeInfoList;
					 		
		if(ftr_idn != null){
		 HasuPipeInfoList = hasuPipeSearchService.getHasuPipeList(ftr_idn);	 
			 System.out.println(HasuPipeInfoList);
		}else{
		 HasuPipeInfoList = null;
		}
			
		 	ModelAndView mav = new ModelAndView();				
			mav.addObject("HasuPipeInfoList", HasuPipeInfoList);	//emdService.
			mav.setViewName("/jsp/hasuPipeSearch");
			return mav;
	}
}
