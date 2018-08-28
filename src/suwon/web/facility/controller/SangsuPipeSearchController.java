package suwon.web.facility.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import suwon.web.facility.Service.SangsuPipeSearchService;
import suwon.web.facility.vo.SangsuPipeVo;
import suwon.web.facility.vo.UflComPipeVo;
import suwon.web.facility.vo.UflElcPipeVo;
import suwon.web.facility.vo.UflGasPipeVo;
import suwon.web.facility.vo.UflHeatPipeVo;
import suwon.web.facility.vo.UflLpgPipeVo;
import suwon.web.facility.vo.UflWidePipeVo;
import suwon.web.vo.HasuPipeVo;
/**
 * 상수관거 정보조회를 담당하는 Controller 
 * @author Administrator
 *
 */
@Controller
public class SangsuPipeSearchController {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");		
	private SangsuPipeSearchService sangsuPipeSearchService = (SangsuPipeSearchService ) context.getBean("sangsuPipeSearchService");//�곗“���뚯뒪��
	private SangsuPipeSearchService hasuPipeSearchService = (SangsuPipeSearchService ) context.getBean("sangsuPipeSearchService");
	private SangsuPipeSearchService elcPipeSearchService = (SangsuPipeSearchService ) context.getBean("sangsuPipeSearchService");
	private SangsuPipeSearchService lpgPipeSearchService = (SangsuPipeSearchService ) context.getBean("sangsuPipeSearchService");
	private SangsuPipeSearchService gasPipeSearchService = (SangsuPipeSearchService ) context.getBean("sangsuPipeSearchService");
	private SangsuPipeSearchService heatPipeSearchService = (SangsuPipeSearchService ) context.getBean("sangsuPipeSearchService");
	private SangsuPipeSearchService comPipeSearchService = (SangsuPipeSearchService ) context.getBean("sangsuPipeSearchService");
	private SangsuPipeSearchService widePipeSearchService = (SangsuPipeSearchService ) context.getBean("sangsuPipeSearchService");
	
	@RequestMapping("/sangsuPipeSearch.do")
	public ModelAndView sangsuList(HttpServletRequest request, HttpServletResponse response){
		
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
	/**
	 * 상수관거 정보조회 팝업창을 담당하는 do
	 * @author Administrator
	 *
	 */	
	@RequestMapping("/SangsuInfo.do")
	public ModelAndView SangsuPopUpList(HttpServletRequest request, HttpServletResponse response){
		
		 String ftr_idn= request.getParameter("key");
		 List<SangsuPipeVo> SangsuPipeInfoList;
		 System.out.println("ftr_idn:::"+ftr_idn);
		 
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
	
	/**
	 * 하수관거 정보조회를 담당하는 do
	 * @author Administrator
	 *
	 */	
	@RequestMapping("/hasuPipeSearch.do")
	public ModelAndView hasuList(HttpServletRequest request, HttpServletResponse response){
		
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
	/**
	 * 하수관거 정보조회 팝업창을 담당하는 do
	 * @author Administrator
	 *
	 */	
	@RequestMapping("/HasuInfo.do")
	public ModelAndView hasuPopUpList(HttpServletRequest request, HttpServletResponse response){
		
		String ftr_idn= request.getParameter("key");

		//ftr_num = Integer.parseInt(ftrNum);
		System.out.println("두번재 do의 1ftr_idn"+ftr_idn);
		 List<HasuPipeVo> HasuPipeInfoList;
					
		 
		 if(ftr_idn != null ){
			 HasuPipeInfoList =hasuPipeSearchService.getHasuPipeList(ftr_idn);	 
			 System.out.println(HasuPipeInfoList);
		 }else {
			 HasuPipeInfoList = null;
		 }
		 
		 	ModelAndView mav = new ModelAndView();				
			mav.addObject("HasuPipeInfoList", HasuPipeInfoList);	//emdService.
			mav.setViewName("../pop/HasuInfo");//mav.setViewName("../pop/SangsuInfo");
			return mav;
	}
	
	/**
	 * 전력지증관로 정보조회를 담당하는 do
	 * @author Administrator
	 *
	 */	
	@RequestMapping("/uflElcPipeSearch.do")
	public ModelAndView uflElcList(HttpServletRequest request, HttpServletResponse response){

		 String ftr_idn= request.getParameter("ftr_idn");
		 List<UflElcPipeVo> ElcPipeInfoList;
					
		 
		 if(ftr_idn != null ){
			 ElcPipeInfoList =elcPipeSearchService.getElcPipeList(ftr_idn);	 		
		 }else {
			 ElcPipeInfoList = null;
		 }
		 
		 	ModelAndView mav = new ModelAndView();				
			mav.addObject("ElcPipeInfoList", ElcPipeInfoList);	
			mav.setViewName("jsp/underFacility/ElcPipeSearch");
			return mav;			
	}

	/**
	 * 전력지증관로 정보조회 팝업창을 담당하는 do
	 * @author Administrator
	 *
	 */	
	@RequestMapping("/ElcPipeInfo.do")
	public ModelAndView ElcPopUpList(HttpServletRequest request, HttpServletResponse response){
		
		 String ftr_idn= request.getParameter("key");
		 List<UflElcPipeVo> ElcPipeInfoList;
					
		 
		 if(ftr_idn != null ){
			 ElcPipeInfoList =elcPipeSearchService.getElcPipeList(ftr_idn);	 
			 System.out.println(ElcPipeInfoList);
		 }else {
			 ElcPipeInfoList = null;
		 }
		 
		 	ModelAndView mav = new ModelAndView();				
			mav.addObject("ElcPipeInfoList", ElcPipeInfoList);	//emdService.
			mav.setViewName("../pop/ElcPipeInfo");//mav.setViewName("../pop/SangsuInfo");
			return mav;
	}	
	
	/**
	 * LPG배관 정보조회를 담당하는 do
	 * @author Administrator
	 *
	 */	
	@RequestMapping("/uflLpgPipeSearch.do")
	public ModelAndView uflLpgPipeList(HttpServletRequest request, HttpServletResponse response){
		 
		 String ftr_idn= request.getParameter("ftr_idn");
		 List<UflLpgPipeVo> LpgPipeInfoList;
							 
		 if(ftr_idn != null ){
			 LpgPipeInfoList =lpgPipeSearchService.getLpgPipeList(ftr_idn);	 		
		 }else {
			 LpgPipeInfoList = null;
		 }		 
		 	ModelAndView mav = new ModelAndView();				
			mav.addObject("LpgPipeInfoList", LpgPipeInfoList);
			mav.setViewName("jsp/underFacility/LpgPipeSearch");
			return mav;			
	}
	
	/**
	 * LPG배관 정보조회 팝업창을 담당하는 do
	 * @author Administrator
	 *
	 */		
	@RequestMapping("/LpgPipeInfo.do")
	public ModelAndView LpgPopUpList(HttpServletRequest request, HttpServletResponse response){
		
		 String ftr_idn= request.getParameter("key");
		 List<UflLpgPipeVo> LpgPipeInfoList;
					
		 
		 if(ftr_idn != null ){
			 LpgPipeInfoList =lpgPipeSearchService.getLpgPipeList(ftr_idn);	 
			 System.out.println(LpgPipeInfoList);
		 }else {
			 LpgPipeInfoList = null;
		 }
		 
		 	ModelAndView mav = new ModelAndView();				
			mav.addObject("LpgPipeInfoList", LpgPipeInfoList);	//emdService.
			mav.setViewName("../pop/LpgPipeInfo");//mav.setViewName("../pop/SangsuInfo");
			return mav;
	}	
	
	/**
	 * 천연가스배관 정보조회를 담당하는 do
	 * @author Administrator
	 *
	 */		
	@RequestMapping("/uflGasPipeSearch.do")
	public ModelAndView uflGasPipeList(HttpServletRequest request, HttpServletResponse response){
	
		 String ftr_idn= request.getParameter("ftr_idn");
		 List<UflGasPipeVo> GasPipeInfoList;
							 
		 if(ftr_idn != null ){
			 GasPipeInfoList =gasPipeSearchService.getGasPipeList(ftr_idn);	 		
		 }else {
			 GasPipeInfoList = null;
		 }		 
		 	ModelAndView mav = new ModelAndView();				
			mav.addObject("GasPipeInfoList", GasPipeInfoList);
			mav.setViewName("jsp/underFacility/GasPipeSearch");
			return mav;			
	}	
	
	/**
	 * 천연가스배관 정보조회 팝업창을 담당하는 do
	 * @author Administrator
	 *
	 */		
	@RequestMapping("/GasPipeInfo.do")
	public ModelAndView GasPopUpList(HttpServletRequest request, HttpServletResponse response){
		
		 String ftr_idn= request.getParameter("key");
		 List<UflGasPipeVo> GasPipeInfoList;
							 
		 if(ftr_idn != null ){
			 GasPipeInfoList =gasPipeSearchService.getGasPipeList(ftr_idn);	 
			 System.out.println(GasPipeInfoList);
		 }else {
			 GasPipeInfoList = null;
		 }
		 
		 	ModelAndView mav = new ModelAndView();				
			mav.addObject("GasPipeInfoList", GasPipeInfoList);	
			mav.setViewName("../pop/GasPipeInfo");
			return mav;
	}
	/**
	 * 난방열배관 정보조회를 담당하는 do
	 * @author Administrator
	 *
	 */	
	@RequestMapping("/uflHeatPipeSearch.do")
	public ModelAndView uflHeatPipeList(HttpServletRequest request, HttpServletResponse response){
		 String ftr_idn= request.getParameter("ftr_idn");
		 List<UflHeatPipeVo> HeatPipeInfoList;
					
		 
		 if(ftr_idn != null ){
			 HeatPipeInfoList =heatPipeSearchService.getHeatPipeList(ftr_idn);	 		
		 }else {
			 HeatPipeInfoList = null;
		 }		 
		 	ModelAndView mav = new ModelAndView();				
			mav.addObject("HeatPipeInfoList", HeatPipeInfoList);
			mav.setViewName("jsp/underFacility/HeatPipeSearch");
			return mav;			
	}	
	/**
	 * 난방열배관 정보조회 팝업창을 담당하는 do
	 * @author Administrator
	 *
	 */		
	@RequestMapping("/HeatPipeInfo.do")
	public ModelAndView HeatPopUpList(HttpServletRequest request, HttpServletResponse response){
		
		 String ftr_idn= request.getParameter("key");
		 List<UflHeatPipeVo> HeatPipeInfoList;
							 
		 if(ftr_idn != null ){
			 HeatPipeInfoList =heatPipeSearchService.getHeatPipeList(ftr_idn);	 
			 System.out.println(HeatPipeInfoList );
		 }else {
			 HeatPipeInfoList  = null;
		 }
		 
		 	ModelAndView mav = new ModelAndView();				
			mav.addObject("HeatPipeInfoList", HeatPipeInfoList );	
			mav.setViewName("../pop/HeatPipeInfo");
			return mav;
	}	
	
	/**
	 * 통신선로 정보조회를 담당하는 do
	 * @author Administrator
	 *
	 */	
	@RequestMapping("/uflComPipeSearch.do")
	public ModelAndView uflComPipeList(HttpServletRequest request, HttpServletResponse response){

	  	 String ftr_idn= request.getParameter("ftr_idn");
		 List<UflComPipeVo> ComPipeInfoList;
							 
		 if(ftr_idn != null ){
			 ComPipeInfoList = comPipeSearchService.getComPipeList(ftr_idn);	 		
		 }else {
			 ComPipeInfoList = null;
		 }		 
		 	ModelAndView mav = new ModelAndView();				
			mav.addObject("ComPipeInfoList", ComPipeInfoList);
			mav.setViewName("jsp/underFacility/ComPipeSearch");
			return mav;			
	}	
	/**
	 * 통신선로 정보조회 팝업창을 담당하는 do
	 * @author Administrator
	 *
	 */
	@RequestMapping("/ComPipeInfo.do")
	public ModelAndView ComPopUpList(HttpServletRequest request, HttpServletResponse response){
		
		 String ftr_idn= request.getParameter("key");
		 List<UflComPipeVo> ComPipeInfoList;
							 
		 if(ftr_idn != null ){
			 ComPipeInfoList =comPipeSearchService.getComPipeList(ftr_idn);	 
			 System.out.println(ComPipeInfoList );
		 }else {
			 ComPipeInfoList  = null;
		 }
		 
		 	ModelAndView mav = new ModelAndView();				
			mav.addObject("ComPipeInfoList", ComPipeInfoList );	
			mav.setViewName("../pop/ComPipeInfo");
			return mav;
	}	
	
	/**
	 * 광역상수관 정보조회를 담당하는 do
	 * @author Administrator
	 *
	 */	
	@RequestMapping("/uflWidePipeSearch.do")
	public ModelAndView uflWidePipeList(HttpServletRequest request, HttpServletResponse response){

	  	 String ftr_idn= request.getParameter("ftr_idn");
		 List<UflWidePipeVo> WidePipeInfoList;
							 
		 if(ftr_idn != null ){
			 WidePipeInfoList = widePipeSearchService.getWidePipeList(ftr_idn);	 		
		 }else {
			 WidePipeInfoList = null;
		 }		 
		 	ModelAndView mav = new ModelAndView();				
			mav.addObject("WidePipeInfoList", WidePipeInfoList);
			mav.setViewName("jsp/underFacility/WidePipeSearch");
			return mav;			
	}	
	/**
	 * 광역상수관 정보조회 팝업창을 담당하는 do
	 * @author Administrator
	 *
	 */
	@RequestMapping("/WidePipeInfo.do")
	public ModelAndView WidePopUpList(HttpServletRequest request, HttpServletResponse response){
		
		 String ftr_idn= request.getParameter("key");
		 List<UflWidePipeVo> WidePipeInfoList;
							 
		 if(ftr_idn != null ){
			 WidePipeInfoList =widePipeSearchService.getWidePipeList(ftr_idn);	 
			 System.out.println(WidePipeInfoList );
		 }else {
			 WidePipeInfoList  = null;
		 }
		 
		 	ModelAndView mav = new ModelAndView();				
			mav.addObject("WidePipeInfoList", WidePipeInfoList );	
			mav.setViewName("../pop/WidePipeInfo");
			return mav;
	}	

}
