package suwon.web.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import net.sf.json.JSONArray;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import suwon.web.Service.RoadSearchService;
import suwon.web.vo.ManageVo;
import util.MyUtil;

/**
 * 도로명주소 페이지에서 도로명검색,시/군/구 조회,도로명 조회,도로번호 검색 Controller 
 * @author Administrator
 *
 */
@Controller
public class RoadSearchController {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private RoadSearchService roadSearchService = (RoadSearchService)context.getBean("roadSearchService");
	private RoadSearchService buildSearchService = (RoadSearchService)context.getBean("roadSearchService");//건물명조회
	private RoadSearchService getRoadTotalNum = (RoadSearchService)context.getBean("roadSearchService");
	
	private int currentPage = 1;			//현재 페이지
	private int showPageLimit = 1000;	//보여줄 수 있는 페이지수의 한계 
	private int startArticleNum = 0;
	private int endArticleNum = 0;
	
	/**
	 * 
	 * @param vo
	 * @param request
	 * @param response
	 * @return	
	 * @throws Exception
	 */
	//ajax용 시군구
	@RequestMapping("/rnChoSearch")
	@ResponseBody
	public JSONArray nSearch(@ModelAttribute ManageVo vo,HttpServletRequest request, HttpServletResponse response)throws Exception {
		response.setContentType("text/plain;charset=UTF-8");
		response.setHeader("Cache-Control", "no-chche");
		response.setCharacterEncoding("utf-8");				
		//System.out.println("초성입니다");

		HashMap<String, String> map = new HashMap<String, String>();
		String sggName = request.getParameter("sggName");
		//String rn_cd = request.getParameter("rn_cd");
		JSONArray jsonarr = JSONArray.fromObject(roadSearchService.searchNComboList(sggName));
		//System.out.println(jsonarr);
		return jsonarr;			
	}
	
	//ajax용 초성 도로조회
	@RequestMapping("/getRnSearch")
	@ResponseBody
	public void nSearch1(@ModelAttribute ManageVo vo, HttpServletRequest request, HttpServletResponse response)throws Exception {
		response.setContentType("text/plain;charset=UTF-8");
		response.setHeader("Cache-Control", "no-chche");
		response.setCharacterEncoding("utf-8");				
					
		
		HashMap<String, String> map = new HashMap<String, String>();
//		MyUtil myUtil = new MyUtil();

		
		//String r_cho = makeChoChar(map.get("r_cho"));
		map.put("sggName", request.getParameter("sggName"));
		map.put("r_cho", request.getParameter("r_cho"));
		map.put("rn", request.getParameter("rn"));
		map.put("rn_cd", request.getParameter("rn_cd"));
//		map.put("rn_cd", request.getParameter("rn_cd"));
		//map.put("startVal", request.getParameter("startVal"));
		//map.put("endVal", request.getParameter("endVal"));

		JSONArray jsonarr = JSONArray.fromObject(roadSearchService.getRnSearch(map));
		//System.out.println("getRnSearch의 :::"+jsonarr);
		response.getWriter().write(jsonarr.toString());
						
	}
	
	@RequestMapping("/roadSearch.do")
	public ModelAndView boardList(HttpServletRequest request, HttpServletResponse response){
	
		String cp = request.getContextPath();
		int numPerPage = 5;
		
		String rnNm = request.getParameter("rnNm");
		String bonbun = request.getParameter("bonbun");
		String bubun = request.getParameter("bubun");
		String rn_cd = request.getParameter("rn_cd");
		String sgg_cd = request.getParameter("sggNm");
		String pageNum = request.getParameter("pageNum");

			
		if(pageNum != null && !(pageNum.equals(""))){
			currentPage = Integer.parseInt(pageNum);
	    }else{
	    	currentPage = 1;
	    }
		int showArticleLimit = 5;
		startArticleNum = (currentPage-1) * showArticleLimit + 1;	//
		endArticleNum = startArticleNum + showArticleLimit - 1;	//
		
		List<ManageVo> roadList;
		//System.out.println(sgg_cd + ',' + rn_cd + ',' +  bonbun + ',' +  bubun);
		roadList = buildSearchService.getManageList(startArticleNum, endArticleNum,sgg_cd,rn_cd, bonbun, bubun  /*, sgg_cd*/);

		
		int totalNum = getRoadTotalNum.getRoadTotalNum(rn_cd, bonbun,  bubun);		
		int total_page = 0;
		
		
		MyUtil myUtil = new MyUtil();		
		if(totalNum != 0)
		   total_page = myUtil.getPageCount(numPerPage,  totalNum) ;
		
		
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
	    String urlView = cp+"/roadSearch.do?rn_cd="+rn_cd+"&bonbun="+bonbun+"&bubun="+bubun;
	    
		ModelAndView mav = new ModelAndView();
		mav.addObject("roadList",roadList);
		mav.addObject("total_page", Integer.toString(total_page));
		mav.addObject("total_dataCount", total_page);			//총페이지		
		mav.addObject("pageIndexList", myUtil.pageIndexList(currentPage, total_page, urlView));
		mav.setViewName("/jsp/roadlist");
		return mav;
	}
	

	
	@RequestMapping("/searchRn.do")
	public String jibunsear() {
		return "/main";
	}
	
	/**
	 * 도로명검색 페이지 도움말	
	 * @return
	 */	
	@RequestMapping("/RnblinkList.do")
	public String blink() {
		return "/jsp/blinkRnList";
	}
}