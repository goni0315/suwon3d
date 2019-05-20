package suwon.web.controller;



import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import suwon.web.Service.BuildSearchService;
import suwon.web.vo.BuildSearchVo;
import util.MyUtil;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;



/**
 * 사용 안함 네이버 검색으로 대체됨/ 
 * 건물검색 페이지에서 건물검색을 담당하는 Controller 
 * @author Administrator
 *
 */
@Controller
public class BuildSearchController {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private BuildSearchService buildSearchService = (BuildSearchService) context.getBean("buildSearchService");
	private ApplicationContext appContext = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private BuildSearchService drawService = (BuildSearchService) appContext.getBean("buildSearchService");
	private int currentPage = 1;
	private int showPageLimit = 1000; 
	private int startArticleNum = 0;
	private int endArticleNum = 0;

	/**
	 * 사용 안함 네이버 검색으로 대체됨/ 
	 * 건물 검색 함수
	 * @param request 건물명, 페이지넘버
	 * @param response
	 * @return
	 */
	@RequestMapping("/buildSearch.do")
	public ModelAndView buildList(HttpServletRequest request, HttpServletResponse response){
		String cp = request.getContextPath();
	
		int numPerPage   = 5;
		 
		String build_name  = request.getParameter("build_name"); //검색어
		String pageNum  = request.getParameter("pageNum"); //페이지
		
		
	    if(pageNum != null && !(pageNum.equals(""))){//페이지 캐스팅
	    	currentPage = Integer.parseInt(pageNum);
	    }else{
	    	currentPage = 1;
	    }
	    
	    int showArticleLimit = 5;
	    //showArticleLimit = 5;
		// expression article variables value
		startArticleNum = (currentPage - 1) * showArticleLimit + 1; //페이지
		endArticleNum = startArticleNum + showArticleLimit -1;      //페이지
		//
		
		// get boardList and get page html code

		
		List<BuildSearchVo> boardList;
		
		// boardList = drawService.getBuildList(startArticleNum, endArticleNum, build_name); // 건물검색 주석 막기
		
		//int totalNum = drawService.getbuildTotalNum(build_name);// 건물검색 주석 막기
		int totalNum = 0;
		
		int total_page = 0;

		MyUtil myUtil = new MyUtil();
		
		if(totalNum != 0)   total_page = myUtil.getPageCount(numPerPage,  totalNum) ;
		
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        String urlView = cp+"/buildSearch.do?build_name="+build_name;

		ModelAndView mav = new ModelAndView();
		
//		mav.addObject("boardList", boardList);
//		mav.addObject("total_page", Integer.toString(total_page));
//		mav.addObject("total_dataCount", totalNum);
//
//		mav.addObject("pageIndexList", myUtil.pageIndexList(currentPage, total_page, urlView));
		
		
	//	if(totalNum == 0 ){ //검색결과가 0 이면 포탈 검색 페이지로 넘긴다.
			mav.addObject("build_name", build_name);
			mav.setViewName("/jsp/potalSearch");
		
//		}else{
		
	//		mav.setViewName("/jsp/buildSearch");
		//}
		
		
		

		return mav;
	}
	/**
	 * 
	 * 건물검색 페이지 도움말	
	 * @return 
	 */	
	@RequestMapping("/blinkBuList.do")
	public String searchBlink() {
		return "/jsp/blinkBuList";
	}
	
	@RequestMapping("/textSearch/potalSearch.do")
	public @ResponseBody String potalSearch(HttpServletRequest request){
		 
		 String clientId = "d6Dw3YlRBGw3KdEB9yWZ";//애플리케이션 클라이언트 아이디값";
	     String clientSecret = "IbE8hfpgdC";//애플리케이션 클라이언트 시크릿값";
	     String searchText = request.getParameter("searchText");
	     String searchList = null;
	     try {
	         String apiURL = "https://openapi.naver.com/v1/search/local.xml?query="+ searchText; // xml 결과
	         URL url = new URL(apiURL);
	         HttpURLConnection con = (HttpURLConnection)url.openConnection();
	         con.setRequestMethod("GET");
	         con.setRequestProperty("X-Naver-Client-Id", clientId);
	         con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	         int responseCode = con.getResponseCode();
	         BufferedReader br;
	         if(responseCode==200) { // 정상 호출
	             br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
	         } else {  // 에러 발생
	             br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"));
	         }
	         String inputLine;
	         StringBuffer response = new StringBuffer();
	         while ((inputLine = br.readLine()) != null) {
	             response.append(inputLine);
	         }
	         br.close();
	         searchList = response.toString();
	         //model.addObject("searchList",searchList);
	         //System.out.println(response.toString());
	         System.out.println("searchList : " + searchList);
	     } catch (Exception e) {
	         System.out.println(e);
	     }
		
		return searchList.toString();
	}
	
}
	
