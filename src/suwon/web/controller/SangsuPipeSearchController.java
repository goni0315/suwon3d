package suwon.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


import suwon.web.Service.SangsuPipeSearchService;
import suwon.web.vo.SangsuPipeVo;
import util.StirngUtil;


/**
 * 상수관거 정보조회를 담당하는 Controller 
 * @author Administrator
 *
 */
@Controller
public class SangsuPipeSearchController {
	
		private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");		
		private SangsuPipeSearchService sangsuPipeSearchService = (SangsuPipeSearchService ) context.getBean("sangsuPipeSearchService");//�곗“���뚯뒪��

		@RequestMapping("/sangsuPipeSearch.do")
		public ModelAndView boardList(HttpServletRequest request, HttpServletResponse response){
			
			String ftr_idn= request.getParameter("ftr_idn");

			//ftr_num = Integer.parseInt(ftrNum);
			//System.out.println(ftr_idn);
			 List<SangsuPipeVo> SangsuPipeInfoList;
						
			 
			 if(ftr_idn != null ){
				 SangsuPipeInfoList =sangsuPipeSearchService.getSangsuPipeList(ftr_idn);	 
				// System.out.println(SangsuPipeInfoList);
			 }else {
				 SangsuPipeInfoList = null;
			 }
			 
			 	ModelAndView mav = new ModelAndView();				
				mav.addObject("SangsuPipeInfoList", SangsuPipeInfoList);	//emdService.
				mav.setViewName("jsp/sangsuPipeSearch");//mav.setViewName("../pop/SangsuInfo");
				return mav;
		}

		@RequestMapping("/SangsuInfo.do")
		public ModelAndView infoList(HttpServletRequest request, HttpServletResponse response){
			
			String ftr_idn= request.getParameter("ftr_idn");

			//ftr_num = Integer.parseInt(ftrNum);
			//System.out.println("두번재 do의 1ftr_idn"+ftr_idn);
			 List<SangsuPipeVo> SangsuPipeInfoList;
						
			 
			 if(ftr_idn != null ){
				 SangsuPipeInfoList =sangsuPipeSearchService.getSangsuPipeList(ftr_idn);	 
				 System.out.println(SangsuPipeInfoList);
			 }else {
				 SangsuPipeInfoList = null;
			 }
			 
			 	ModelAndView mav = new ModelAndView();				
				mav.addObject("SangsuPipeInfoList", SangsuPipeInfoList);	//emdService.
				mav.setViewName("../pop/SangsuInfo");//mav.setViewName("../pop/SangsuInfo");
				return mav;
		}
}
