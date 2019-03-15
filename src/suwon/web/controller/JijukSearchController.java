package suwon.web.controller;



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

import suwon.web.Service.JijukSearchService;
import suwon.web.vo.CbndVo;
import suwon.web.vo.EmdVo;
import util.MyUtil;

/**
 *(Ajax)지번검색 페이지에서 시/군/구 조회, 읍/면/동 조회, 산체크, 건물번호 검색 Controller 
 * @author Administrator
 *
 */
@Controller
public class JijukSearchController {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");			
	private JijukSearchService jijukSearchService = (JijukSearchService) context.getBean("jijukSearchService");//본번,부번조회
	private JijukSearchService jibunService = (JijukSearchService ) context.getBean("jijukSearchService");//산조회 테스트
	private JijukSearchService getJinbunTotalNum = (JijukSearchService ) context.getBean("jijukSearchService");
	
	private int currentPage = 1;			//현재 페이지
	private int showPageLimit = 1000;	//보여줄 수 있는 페이지수의 한계 
	private int startArticleNum = 0;
	private int endArticleNum = 0;
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/jijukSearch.do")
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response){
		String cp = request.getContextPath();
		int numPerPage = 5;
		String sggNm = request.getParameter("sggNm");
		String emdNm = request.getParameter("emdNm");
		//String sanChk = "1";
		String sanChk = request.getParameter("sanChk");		
		String bonbun = request.getParameter("bonbun");
		String bubun = request.getParameter("bubun");
		String pageNum = request.getParameter("pageNum");
		
		//pnu에서 같은 값을 가져오기위한 자릿수 맞춰주기
		if(!(bonbun=="" || bonbun==null)) {
			bonbun = String.format("%04d", Integer.parseInt(bonbun));
		}			
		if(!(bubun=="" || bubun==null)) {
			bubun = String.format("%04d", Integer.parseInt(bubun));
		}
		
/*    if(sanChk == "on"!(sanChk.equals(""))){
    	sanChk = "2";
    	}else if(sanChk.equals(null)){
    	sanChk = "1";    	
   }*/
   
	if(pageNum != null && !(pageNum.equals(""))){
		currentPage = Integer.parseInt(pageNum);
    }else{
    	currentPage = 1;
    }
    
	int showArticleLimit = 5;
	startArticleNum = (currentPage-1) * showArticleLimit + 1;	//
	endArticleNum = startArticleNum + showArticleLimit - 1;	//
	
		List<CbndVo> jibunList;	//dao//산체크리스트
		jibunList = jibunService.getJibun(startArticleNum, endArticleNum, /*sggNm,*/ emdNm, sanChk, bonbun,  bubun);
		int totalNum = getJinbunTotalNum.getJibunTotalNum(/*sggNm,*/ emdNm, sanChk, bonbun,  bubun);
	
	//	System.out.println(pnuCode);

	
	int total_page = 0;
	MyUtil myUtil = new MyUtil();
	
	if(totalNum != 0)
	   total_page = myUtil.getPageCount(numPerPage,  totalNum) ;

	
	// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
    String urlView = cp+"/jijukSearch.do?emdNm="+emdNm+"&sanChk="+sanChk+"&bonbun="+bonbun+"&bubun="+bubun;
    /*sggNm="+sggNm+"&*/
		ModelAndView mav = new ModelAndView();		
		mav.addObject("jibunList", jibunList);				//emdService.
		mav.addObject("total_page", Integer.toString(total_page));
		mav.addObject("total_dataCount", total_page);			//총페이지		
		mav.addObject("pageIndexList", myUtil.pageIndexList(currentPage, total_page, urlView));
		mav.setViewName("/jsp/jibunlist");	
		return mav;
	}//jibunSearch


	
	
	@RequestMapping("/jibunSearch")
	@ResponseBody
	public JSONArray nSearch(@ModelAttribute EmdVo vo) throws Exception {
		//List a = drawService.listEmb(vo.getEname());
		JSONArray jsonarr = JSONArray.fromObject(jijukSearchService.listEmd(vo.getSggName()));
		return jsonarr;
	}
	/**
	 * 
	 * @return
	 */
	@RequestMapping("/searchJibun.do")
	public String jibunsear() {
		return "/main";
	}		
	/**
	 * 지번검색 페이지 도움말	
	 * @return
	 */
	@RequestMapping("/blinkJibunList.do")
	public String blinkJibunList() {
		return "/jsp/blinkJibunList";
	}
	
}
