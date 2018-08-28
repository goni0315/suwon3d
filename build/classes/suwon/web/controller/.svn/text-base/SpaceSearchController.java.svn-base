package suwon.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import suwon.web.Service.SpaceSearchService;
import suwon.web.vo.BuildSearchVo;
import suwon.web.vo.SpaceVo;
import util.MyUtil;

@Controller
public class SpaceSearchController {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private SpaceSearchService spaceSearchService = (SpaceSearchService) context.getBean("spaceSearchService");

	private int currentPage = 1;
	private int showPageLimit = 1000; 
	private int startArticleNum = 0;
	private int endArticleNum = 0;
	
	@RequestMapping("/radious/search.do")
	public ModelAndView goPage(HttpServletRequest request, HttpServletResponse response) throws Exception{
//		List<HashMap<String, String>> buildGroup = new ArrayList<HashMap<String,String>>();
//		buildGroup = spaceSearchService.getBuildGroup();
		ModelAndView mav = new ModelAndView();
//		mav.addObject("resultList",buildGroup);
		mav.setViewName("/jsp/radiousSearch");	
		return mav;
	}
	
	@RequestMapping("/radious/reseult.do")
	public ModelAndView radiousSearch(HttpServletRequest request, HttpServletResponse response){
		String msg = ServletRequestUtils.getStringParameter(request, "keyWord","");
		String searchlist = ServletRequestUtils.getStringParameter(request, "searchlist","");
		System.out.println("/radious/reseult.do : " + searchlist);
		
		int totalNum = 0;
	    int showArticleLimit = 5;
		int total_page = 0;
		int numPerPage   = 5;
		
		//String urlView=null;
		String cp = request.getContextPath();
		String pageNum  = ServletRequestUtils.getStringParameter(request, "pageNum",null); //페이지		
		
	    if(pageNum != null && !(pageNum.equals(""))){//페이지 캐스팅
	    	currentPage = Integer.parseInt(pageNum);
	    }else{
	    	currentPage = 1;
	    }

	    // expression article variables value
		startArticleNum = (currentPage - 1) * showArticleLimit + 1; //페이지
		endArticleNum = startArticleNum + showArticleLimit -1;      //페이지
		
		// get boardList and get page html code
		/*System.out.println("pageNum" + pageNum);
		System.out.println("startArticleNum : "+startArticleNum);
		System.out.println("endArticleNum : "+endArticleNum);*/

		List<BuildSearchVo> result_list = new ArrayList<BuildSearchVo>();
		
		
		result_list = spaceSearchService.searchBuildListForRadious(msg, searchlist, startArticleNum, endArticleNum);
		/*System.out.println("검색후");
		System.out.println("result_list :  " + result_list);*/
		
		totalNum = spaceSearchService.searchBuildCntForRadious(msg, searchlist);
		
		MyUtil myUtil = new MyUtil();
		
		if(totalNum != 0)   total_page = myUtil.getPageCount(numPerPage,  totalNum) ;
		
		
		ModelAndView  mav = new ModelAndView();
		
		//String urlView = cp+"/radious/reseult.do?keyWord="+msg+"&searchlist="+searchlist;
		
		mav.setViewName("/jsp/result/radiousResult");
		mav.addObject("result_list", result_list);
		mav.addObject("keyWord", msg);
		
		mav.addObject("totalNum", totalNum);
		
		mav.addObject("pageIndexList", myUtil.pageIndexList(currentPage, total_page));
		
		return mav;
	}
	/**
	 * 공간검색 > 반경검색 페이지 도움말	
	 * @return
	 */
	@RequestMapping("/radious/blinkResultList.do")
	public String blinkJibunList() {
		return "/jsp/blinkResultList";
	}	
	
	@RequestMapping("/region/reseult.do")
	public ModelAndView regionSearch(HttpServletRequest request, HttpServletResponse response){
		String msg = ServletRequestUtils.getStringParameter(request, "keyWord","");
		String searchlist = ServletRequestUtils.getStringParameter(request, "searchlist","");
		
		
		int totalNum = 0;
	    int showArticleLimit = 5;
		int total_page = 0;
		int numPerPage   = 5;
		
		//String urlView=null;
		String cp = request.getContextPath();
		String pageNum  = ServletRequestUtils.getStringParameter(request, "pageNum",null); //페이지		
		
	    if(pageNum != null && !(pageNum.equals(""))){//페이지 캐스팅
	    	currentPage = Integer.parseInt(pageNum);
	    }else{
	    	currentPage = 1;
	    }

	    // expression article variables value
		startArticleNum = (currentPage - 1) * showArticleLimit + 1; //페이지
		endArticleNum = startArticleNum + showArticleLimit -1;      //페이지
		
		// get boardList and get page html code
		/*System.out.println("pageNum" + pageNum);
		System.out.println("startArticleNum : "+startArticleNum);
		System.out.println("endArticleNum : "+endArticleNum);*/

		List<BuildSearchVo> result_list = new ArrayList<BuildSearchVo>();
		
		//System.out.println("검색전");
		result_list = spaceSearchService.searchBuildListForRegion(msg, searchlist, startArticleNum, endArticleNum);
		//System.out.println("검색후");
			
		totalNum = spaceSearchService.searchBuildCntForRegion(msg, searchlist);
		
		MyUtil myUtil = new MyUtil();
		
		if(totalNum != 0)   total_page = myUtil.getPageCount(numPerPage,  totalNum) ;
		
		
		ModelAndView  mav = new ModelAndView();
		
		//String urlView = cp+"/radious/reseult.do?keyWord="+msg+"&searchlist="+searchlist;
		
		mav.setViewName("/jsp/result/regionResult");
		mav.addObject("result_list", result_list);
		mav.addObject("keyWord", msg);
		
		mav.addObject("totalNum", totalNum);
		
		mav.addObject("pageIndexList", myUtil.pageIndexList(currentPage, total_page));
		
		return mav;
	}
	/**
	 * 공간검색 > 영역검색 페이지 도움말	
	 * @return
	 */
	@RequestMapping("/region/blinkRadiousList.do")
	public String blinkRadiousList() {
		return "/jsp/blinkRadiousList";
	}		
}
