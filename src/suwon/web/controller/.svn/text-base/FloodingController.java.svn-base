package suwon.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import suwon.web.Service.FloodingService;
import suwon.web.vo.AdfInfoVo;
import suwon.web.vo.FloodVo;
import suwon.web.vo.ShelterSearchVo;
import util.MyUtil;


/**
 *(Ajax)침수시뮬레이션 페이지에서 침수정보(침수지역등록,검색), 대피소(대피소 등록, 검색) Controller 
 * @author Administrator
 *
 */
@Controller
public class FloodingController {
	
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");				
	private FloodingService shelterjibunSearch = (FloodingService) context.getBean("shelterjibunSearch");//
	private FloodingService shelterjibunSearchTotalNum = (FloodingService) context.getBean("shelterjibunSearch");//
	private int currentPage = 1;
	private int showPageLimit = 1000; 
	private int startArticleNum = 0;
	private int endArticleNum = 0;	

	/**
	 *침수시뮬레이션 페이지에서  대피소(대피소 검색) do 
	 * @author Administrator
	 *
	 */	
	@RequestMapping("/ShelterSearch.do")
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response){
	
		String cp = request.getContextPath();		
		int numPerPage   = 5;
		String pageNum  = request.getParameter("pageNum"); //페이지		
		String sgg_cd = request.getParameter("sggNm");
		String emd_cd =  request.getParameter("emdNm");
		String grade = request.getParameter("grade");
		//String use = request.getParameter("use");			
		//String useText = useValueToText(use);
		String useText = request.getParameter("useText");//성공
		if(useText.equals("전체")){
			useText="";
		}
		String facNm = request.getParameter("facNm");	
		
				
	    if(pageNum != null && !(pageNum.equals(""))){//페이지 캐스팅
	    	currentPage = Integer.parseInt(pageNum);
	    }else{
	    	currentPage = 1;
	    }
	    int showArticleLimit = 5;

	    startArticleNum = (currentPage - 1) * showArticleLimit + 1; //페이지
		endArticleNum = startArticleNum + showArticleLimit -1;      //페이지	    
		List<ShelterSearchVo> emdJibunList;
		emdJibunList = shelterjibunSearch.shelterjibunSearch(startArticleNum, endArticleNum,sgg_cd, emd_cd, grade, useText, facNm);

		
		int totalNum = shelterjibunSearchTotalNum.shelterjibunSearchTotalNum( sgg_cd,  emd_cd,  grade,  useText,  facNm);	
		int total_page = 0;
		MyUtil myUtil = new MyUtil();
		if(totalNum != 0)   total_page = myUtil.getPageCount(numPerPage,  totalNum) ;		
		
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        String urlView = cp+"/ShelterSearch.do?sgg_cd="+sgg_cd+"&emd_cd="+emd_cd+"&grade="+grade+"&useText="+useText+"&facNm="+facNm;

		
		ModelAndView mav = new ModelAndView();		
		mav.addObject("emdJibunList", emdJibunList);				//emdService.
		mav.addObject("total_page", Integer.toString(total_page));
		mav.addObject("total_dataCount", total_page);			//총페이지		
		mav.addObject("pageIndexList", myUtil.pageIndexList(currentPage, total_page, urlView));		
		mav.setViewName("/jsp/shelter/shelter_search_result");	
		return mav;
		
	}
	
	/**
	 *(Ajax)침수시뮬레이션 페이지에서  대피소(대피소 검색에서 소재지부분) do 
	 * @author Administrator
	 *
	 */			
	@RequestMapping("/shelterjibunSearch")
	@ResponseBody
	public JSONArray nSearch(@ModelAttribute ShelterSearchVo vo) throws Exception {
	
		JSONArray jsonarr = JSONArray.fromObject(shelterjibunSearch.listEmd(vo.getSgg_cd()));
		return jsonarr;
	}
	
	/**
	 * 침수시뮬레이션 > 대피소 > 대피소검색 (iframe 페이지)
	 * @return
	 */
	@RequestMapping("/shelterBlinkList.do")
	public String shelterblink() {
		return "/jsp/shelterBlinkList";
	}	
	
	
	/**
	 *(Ajax)침수시뮬레이션 페이지에서  대피소(대피소 등록) do 
	 * @author Administrator
	 *
	 */	
	@RequestMapping("/ShelterAdd.do")	
	public String ShelterInsert(@ModelAttribute("ShelterSearchVo") ShelterSearchVo shelterInsert,HttpServletRequest req, HttpServletResponse res){
	
		shelterjibunSearch.ShelterInsert(shelterInsert);
		System.out.println("controller의 shelterInsert ::"+shelterInsert);
		return "../flooding/shelter_add";		
	}
	
/*	@RequestMapping("/shelterBlinkList.do")
	public String blink() {
	
		return "/jsp/blinkShelter_addList";
	}*/	

	
	
	/**
	 *침수시뮬레이션 페이지 > 대피소 > 대피소검색(상세정보 팝업창 띄우기) do 
	 * @author Administrator
	 *
	 */		
	@RequestMapping("/ShelterInfo.do")
	public ModelAndView ShelterInfoPopUp(HttpServletRequest request, HttpServletResponse response){
		
		String dep_seq = request.getParameter("dep_seq");
		List <ShelterSearchVo> shelterInfoPopUpList;
		shelterInfoPopUpList = shelterjibunSearch.shelterInfoPopUpList(dep_seq);
		ModelAndView mav = new ModelAndView();		
		mav.addObject("shelterInfoPopUpList", shelterInfoPopUpList);
		mav.setViewName("../pop/shelterInfo");			
		return mav;

	}	
	
	
	/**
	 *침수시뮬레이션 페이지에서  침수정보(침수지역 등록) do 
	 * @author Administrator
	 *
	 */		
	@RequestMapping("/FloodAdd.do")
	public String floodAdd(@ModelAttribute("FloodVo") FloodVo floodInsert,HttpServletRequest req, HttpServletResponse res){
		
		String flo_year = req.getParameter("flo_year");
		String flo_sot = req.getParameter("flo_sot");
		
		if(flo_year.equals("전체")){
			flo_year="";
		}
		if(flo_sot.equals("전체")){
			flo_sot="";
		}
		
		shelterjibunSearch.floodInsert(floodInsert);
		return "../flooding/flooding_add";
	}	
	
	/**
	 *침수시뮬레이션 페이지에서  침수정보(침수지역검색) do 
	 * @author Administrator
	 *
	 */		
	@RequestMapping("/FloodSearch.do")
	public ModelAndView floodSearch(HttpServletRequest request, HttpServletResponse response){

		String flo_year = request.getParameter("flo_year");
		String flo_loc = request.getParameter("flo_loc");		
		String flo_sot = request.getParameter("flo_sot");
			
		if(flo_year.equals("전체")){
			flo_year = "";
		}
		if(flo_loc.equals("전체")){
			flo_loc = "";
		}
		if(flo_sot.equals("전체")){
			flo_sot = "";
		}		

		List <FloodVo> floodSearchList;
		floodSearchList = shelterjibunSearch.floodSearch(flo_year, flo_loc, flo_sot);
			ModelAndView mav = new ModelAndView();		
			mav.addObject("floodSearchList", floodSearchList);
			mav.setViewName("/jsp/shelter/flooding_search_result");			
			return mav;
	}

	/**
	 * 침수시뮬레이션 > 대피소 > 대피소검색 (iframe 페이지)
	 * @return
	 */
	@RequestMapping("/floodingBlinkList.do")
	public String floodingblink() {
		return "/jsp/floodingBlinkList";
	}	
	
	
	/**
	 *침수시뮬레이션 페이지 > 침수정보 > 침수지역검색(상세정보 팝업창 띄우기) do 
	 * @author Administrator
	 *
	 */		
	@RequestMapping("/FloodInfo.do")
	public ModelAndView floodInfoPopUp(HttpServletRequest request, HttpServletResponse response){
		
		String flo_seq = request.getParameter("flo_seq");
		List <FloodVo> floodInfoPopUpList;
		floodInfoPopUpList = shelterjibunSearch.floodInfoPopUpList(flo_seq);
		ModelAndView mav = new ModelAndView();		
		mav.addObject("floodInfoPopUpList", floodInfoPopUpList);
		mav.setViewName("../pop/floodInfo");			
		return mav;

	}
	
	
	/**
	 * 대피소 용도 셀렉트 박스에서 선택된 value 값에 따라 지정된 텍스트로 변환해주는 함수
	 * 
	 * @param useValue 셀렉트 박스에서 선택된 value 값
	 * @return useText 용도 텍스트 값
	 */
	public String useValueToText(String useValue){
	
		String useText = null;

		if(useValue.equals("1")){
			useText = "강의실";
		}else if(useValue.equals("2")){
			useText = "골프연습장";
		}else if(useValue.equals("3")){
			useText = "공연장";
		}else if(useValue.equals("4")){
			useText = "교육실";
		}else if(useValue.equals("5")){
			useText = "교육장";
		}else if(useValue.equals("6")){
			useText = "노래방";
		}else if(useValue.equals("7")){
			useText = "다방";
		}else if(useValue.equals("8")){
			useText = "대피소";
		}else if(useValue.equals("9")){
			useText = "백화점";
		}else if(useValue.equals("10")){
			useText = "병원";
		}else if(useValue.equals("11")){
			useText = "볼링장";
		}else if(useValue.equals("12")){
			useText = "사무실";
		}else if(useValue.equals("13")){
			useText = "상가";
		}else if(useValue.equals("14")){
			useText = "서고";
		}else if(useValue.equals("15")){
			useText = "식당";
		}else if(useValue.equals("16")){
			useText = "약품실";
		}else if(useValue.equals("17")){
			useText = "연회장";
		}else if(useValue.equals("18")){
			useText = "유치원";
		}else if(useValue.equals("19")){
			useText = "음식점";
		}else if(useValue.equals("20")){
			useText = "일반음식점";
		}else if(useValue.equals("21")){
			useText = "조리실";
		}else if(useValue.equals("22")){
			useText = "종교시설";
		}else if(useValue.equals("23")){
			useText = "주차장";
		}else if(useValue.equals("24")){
			useText = "지하식당";
		}else if(useValue.equals("25")){
			useText = "지하실";
		}else if(useValue.equals("26")){
			useText = "지하주차장";
		}else if(useValue.equals("27")){
			useText = "지하창고";
		}else if(useValue.equals("28")){
			useText = "창고";
		}else if(useValue.equals("29")){
			useText = "체육시설";
		}else if(useValue.equals("30")){
			useText = "탁구장";
		}else if(useValue.equals("31")){
			useText = "학원";
		}else if(useValue.equals("32")){
			useText = "헬스클럽";
		}else if(useValue.equals("33")){
			useText = "회의실";
		}else if(useValue.equals("33")){
			useText = "휴게실";
		}else if(useValue.equals("33")){
			useText = "휴게음식점";
		}
		
		return useText;
	}
}
