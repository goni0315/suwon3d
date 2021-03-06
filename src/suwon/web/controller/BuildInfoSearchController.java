package suwon.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import suwon.web.Service.BuildInfoSearchService;
import suwon.web.vo.BuildSearchVo;
import util.StirngUtil;

/**
 *   정보조회 페이지에서 건물검색을 담당하는 Controller 
 * @author Administrator
 *
 */
@Controller
public class BuildInfoSearchController {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private BuildInfoSearchService buildInfoSearchService = (BuildInfoSearchService) context.getBean("buildInfoSearchService");

	@RequestMapping("/buildInfoSearch.do")
	public void boardList(HttpServletRequest request, HttpServletResponse response) throws Exception{


		
		String bul_man_no= StirngUtil.trimString(request.getParameter("key"));
			//String[] bul_man_no2 = bul_man_no.split("3DS"); 		
		 List<BuildSearchVo> buildList=null;		 
		 
		 String pnu =  buildInfoSearchService.getBuildPNU(bul_man_no);
		 
		 
		 if(pnu==null || pnu=="") {
				response.sendRedirect("errBldgInfo.do");
			}
		 
		 if(bul_man_no!=null){

			 buildList = buildInfoSearchService.getBuildInfoList(bul_man_no);
			 //System.out.println("buildList2:::::::"+buildList);
/*			 bul_man_no = bul_man_no+".3DS";
			 System.out.println("bul_man_no1:"+bul_man_no);
			 buildList = buildInfoSearchService.getBuildInfoList(bul_man_no);
			 System.out.println(buildList);
			 if(bul_man_no!=null){
				 
				 StringTokenizer st = new StringTokenizer(bul_man_no, "3DS");
				 while(st.hasMoreTokens()){
					 String temp=st.nextToken();
					 System.out.println(st);					 
				 }
				 System.out.println(st);
				 System.out.println(bul_man_no);

				 
				 bul_man_no = bul_man_no+".3ds";
				 System.out.println("bul_man_no2::"+bul_man_no);
				 buildList = buildInfoSearchService.getBuildInfoList(bul_man_no);
				 System.out.println("buildList2:::::::"+buildList);
			 } */
		 }else{						 
			 buildList = buildInfoSearchService.getBuildInfoList(bul_man_no);
			 /*bul_man_no = bul_man_no+".3DS";
			 buildList = buildInfoSearchService.getBuildInfoList(bul_man_no);
			 System.out.println("buildList:::::::"+buildList);*/
/*			 if(buildList.equals("")){
				 bul_man_no = bul_man_no+".3ds";
				 buildList = buildInfoSearchService.getBuildInfoList(bul_man_no);
				 System.out.println("buildList2:::::::"+buildList);				 
			 }
*/		 }
	 	 
	     	
			if(pnu!=null)
				response.sendRedirect("realEstateCadastre.do?bul_man_no="+bul_man_no+"&pnu="+pnu);							
			
			
			
			//이전 건물정보조회코드
			//ModelAndView mav = new ModelAndView();
			//mav.addObject("buildList", buildList);
			//mav.addObject("pnu", pnu);
			//mav.setViewName("../pop/BuildInfo");
			//return mav;

	}
	
	@RequestMapping("/errBldgInfo.do")
	public ModelAndView errBldgInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{

		ModelAndView mav = new ModelAndView();		
		mav.setViewName("jsp/realEstate/errBldgInfo");
		return mav;
	}

	
	
	
}
