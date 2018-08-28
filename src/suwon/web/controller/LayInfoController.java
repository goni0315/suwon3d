package suwon.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import suwon.web.Service.LayInfoService;
import suwon.web.vo.LayInfoVo;
@Controller
public class LayInfoController {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private LayInfoService layInfoService = (LayInfoService) context.getBean("layInfoService");//본번,부
	
	
	@RequestMapping("/layInfoSearch.do")
	public ModelAndView boardList(HttpServletRequest request, HttpServletResponse response){
		
		List<LayInfoVo> layInfoList;	//dao//산체크리스트
		 		   
		
		String aut_cde = request.getParameter("aut_cde");
		if(aut_cde !=null){
			layInfoList = layInfoService.getLayInfoList(aut_cde);	
			System.out.println(aut_cde);
		}else{
			layInfoList = null;
		}
		 	ModelAndView mav = new ModelAndView();				
			mav.addObject("layInfoList", layInfoList);	//emdService.
			mav.setViewName("/main");
			return mav;
		
	}
}
