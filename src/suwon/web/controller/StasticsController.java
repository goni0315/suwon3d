package suwon.web.controller;

import java.net.SocketException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import suwon.web.Service.AdminLogService;
import suwon.web.Service.StatisticsService;
import suwon.web.Service.UsrAutService;
import suwon.web.vo.AdminLogVo;
import suwon.web.vo.DeptVo;
import suwon.web.vo.MenuVo;
import suwon.web.vo.MlogVo;
import suwon.web.vo.SttParamVo;
import suwon.web.vo.UsrAutVo;
import util.DateUtil;
import util.MyUtil;
import util.Validator;
@Controller
public class StasticsController {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private StatisticsService statisticsService = (StatisticsService) context.getBean("statisticsService");//본번,부
	private UsrAutService usrAutService = (UsrAutService) context.getBean("usrAutService");
	private AdminLogService adminLogService = (AdminLogService) context.getBean("adminLogService");
	
	private int currentPage = 1;
	private int showPageLimit = 1000; 
	private int startArticleNum = 0;
	private int endArticleNum = 0;
	private int numPerPage   = 10;
	HttpSession session;
	String usrid="";
	/**
	 * 접속 통계 페이지로 이동  
	 * @param request 
	 * @param response
	 * @return
	 * @throws SocketException 
	 */
	@RequestMapping("/connStat.do")
	public ModelAndView goConnStat(HttpServletRequest request, HttpServletResponse response) throws SocketException{
	
		
		if(request.getSession(false)==null) {
			
			ModelAndView mav = new ModelAndView("../error");
			
					return mav;
				}
	
		session = request.getSession(false);
	
		usrid=(String)session.getAttribute("usrid");
		
	    AdminLogVo alv = new AdminLogVo();		
		
		alv.setMenu("접속통계조회 열람");	
		alv.setUsrid(usrid);		
		
		adminLogService.insertAdminLog(alv, request);
		
		
		
		ModelAndView mav = new ModelAndView("jsp/admin/connStat");
		return  mav;
		
	}
	
	/**
	 * 접속 통계 페이지로 이동  
	 * @param request 
	 * @param response
	 * @return
	 * @throws SocketException 
	 */
	@RequestMapping("/printStat.do")
	public ModelAndView goPrintStat(HttpServletRequest request, HttpServletResponse response) throws SocketException{
	
		if(request.getSession(false)==null) {
			
			ModelAndView mav = new ModelAndView("../error");
			
					return mav;
				}
	
		session = request.getSession(false);
	
		usrid=(String)session.getAttribute("usrid");
		
	    AdminLogVo alv = new AdminLogVo();		
		
		alv.setMenu("출력이력조회 열람");	
		alv.setUsrid(usrid);		
		
		adminLogService.insertAdminLog(alv, request);
		
		ModelAndView mav = new ModelAndView("jsp/admin/printStat");
		return  mav;
		
	}
	/**
	 *	메뉴 리스트 조회 
	 * @param response 
	 * @return @josnarry menulist
	 * @throws Exception 
	 */
	@RequestMapping("/statGetMenuList.do")
	@ResponseBody
	public JSONArray getAllMenuLIst(HttpServletRequest request, HttpServletResponse response) throws Exception {
				
			JSONArray returnArr = new JSONArray(); //뷰페이지로 넘길 파라미터 json
			//System.out.println(paramMap.get("idList"));
			MyUtil myUtil = new MyUtil();
			
			Map returnMap = new HashMap(); //결과값 담을 맵
			
			List<MenuVo> allm_list  = usrAutService.getAllMenuList(); //전체 메뉴
			
			
			returnMap.put("allm_list", allm_list);
			//
			returnArr = JSONArray.fromObject(returnMap);
			
			//System.out.println(returnArr);
			
			return returnArr; //반환
		
	}
	
	/**
	 *	하위 리스트 반환 
	 * @param request dept_id 메인 부서 아이디
	 * @param response 
	 * @return DeptVo 하위 부서 목록
	 * @throws Exception 
	 */
	@RequestMapping("/statSubDeptList.do")
	@ResponseBody
	public JSONArray selectSubDeptList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		JSONArray returnArr = new JSONArray(); //뷰페이지로 넘길 파라미터 json
			
			Map returnMap = new HashMap(); //결과값 담을 맵
			
			
			//[부서명 조회 S]
			String pDeptName = (String)request.getParameter("deptname"); //메인 부서 아이디 파라미터로 받음
						
			List<DeptVo> n_list  = usrAutService.getSubDeptList(pDeptName); //하위부서 목록 조회
			
			JSONArray jsonarr = JSONArray.fromObject(n_list); //json으로 캐스팅
			//[부서명 조회 E]
			
			Map paramMap = new HashMap();
			
			MyUtil myUtil = new MyUtil();
			
			returnMap.put("n_list", n_list); //부서리스트
			
			returnArr = JSONArray.fromObject(returnMap);
			
			return returnArr; //반환
		
	}
	/**
	 * 접속자 조회 
	 * @param request 날짜, 부서아이디
	 * @param response 
	 * @return MlogVO 하위 부서 목록
	 * @throws Exception 
	 */
	@RequestMapping("/statConnList.do")
	@ResponseBody
	public JSONArray selectConnList(HttpServletRequest request, @ModelAttribute SttParamVo vo) throws Exception {
			
			//System.out.println(vo.getMnuid() + " // " + vo.getMaindept() + " // " + vo.getSubdept());
			Map paramMap = new HashMap(); //파라미터 담을 맵
			Map returnMap = new HashMap(); //결과값 담을 맵
			
			paramMap.put("menuid", vo.getMnuid()); //메뉴 id
			
			if(Validator.isNoData(vo.getStartdate()) || Validator.isNoData(vo.getEnddate())){ //검색 날짜 있는지 확인 없으면 1달 단위로
				paramMap.put("startdate", DateUtil.convertTimeToString(System.currentTimeMillis()-1296000000,"yyyy-MM-dd"));
				paramMap.put("enddate", DateUtil.getCurrentDate("yyyy-MM-dd"));
			}else{
				paramMap.put("startdate", vo.getStartdate());
				paramMap.put("enddate", vo.getEnddate());
			}
			
			List partlist = new ArrayList(); // 부서 아이디 목록 담을 리스트 
			
			String pageNum = vo.getPage(); //현재 페이지
		    
			String totalNumStr  = vo.getTotalPage(); //토탈 페이지
			
			
			int totalNum = 0; // 토탈 페이지 다시 담을 변수 
			
			if(pageNum != null && !(pageNum.equals(""))){//페이지 캐스팅
		    	currentPage = Integer.parseInt(pageNum);
		    }else{
		    	currentPage = 1;
		    }
			
			
		    			
		    int showArticleLimit = 10;
		    //showArticleLimit = 5;
			// expression article variables value
			startArticleNum = (currentPage - 1) * showArticleLimit + 1; //페이지
			endArticleNum = startArticleNum + showArticleLimit - 1;      //페이지
			
			if(!Validator.isNoData(vo.getSubdept())){ //하위부서 선택이 있는지 없으면 상위부서만 
			
				partlist.add(vo.getSubdept());
			
			}else if(!Validator.isNoData(vo.getMaindept())){ //하위부서 선택이 있는지 없으면 상위부서만
				//[부서명 조회 S]
				String pDeptName = vo.getMaindept();
						
				List<DeptVo> n_list  = usrAutService.getSubDeptList(pDeptName); //하위부서 목록 조회
				
				DeptVo deptVo = new DeptVo();
				
				for(int i = 0; i < n_list.size() ; i++){
					
					deptVo = (DeptVo)n_list.get(i);
					
					partlist.add(deptVo.getDept_grpid());
				}
			}
			
			if(partlist != null){
				paramMap.put("partlist", partlist);
			}
			
			paramMap.put("startArticleNum", startArticleNum); //시작 페이지
			paramMap.put("endArticleNum", endArticleNum); //끝페이지
			
			
			List<MlogVo> l_list  = statisticsService.getConnList(paramMap); //리스트를 위한 조회
			
			if(totalNumStr != null && !(totalNumStr.equals(""))){//페이지 캐스팅
				totalNum = Integer.parseInt(totalNumStr);
		    }else{
		    	totalNum   = statisticsService.getConnListCount(paramMap); // 리스트 페이징을 위한 조회
		    }
			
			int total_page = 0;
			
			MyUtil myUtil = new MyUtil();
			
			if(totalNum != 0) total_page = myUtil.getPageCount(numPerPage,  totalNum) ;
			
			String cp = request.getContextPath();
			
			String urlView = "fn_goPage";
			String params = "";
			
			//그래프용 정보 조회 시작
			List g_list = new ArrayList();
			
			if(vo.getVtype() == "month" || vo.getVtype().equals("month")){
				g_list = statisticsService.getMonthGraphData(paramMap);
			}else{
				g_list = statisticsService.getDayGraphData(paramMap);
				
			}
						
			//리턴 객체에 담기 [S]
			returnMap.put("pageIndexList", myUtil.pageIndexList(currentPage, total_page, urlView,params));
			
			returnMap.put("totalNum", totalNum); //포함되는 총 사용자수
			returnMap.put("vtype", vo.getVtype());
			returnMap.put("g_list", g_list);
			returnMap.put("l_list", l_list);
						
			JSONArray jsonarr = JSONArray.fromObject(returnMap); //json으로 캐스팅
						
			return jsonarr; //반환
	}
	
	/**
	 * 엑셀로 다운로드 
	 * @param request 날짜, 부서아이디
	 * @param response 
	 * @return MlogVO 하위 부서 목록
	 * @throws Exception 
	 */
	@RequestMapping("/connStatExcelDown.do")
	public ModelAndView connStatDownExcel(HttpServletRequest request, @ModelAttribute SttParamVo vo) throws Exception {

			Map paramMap = new HashMap(); //파라미터 담을 맵
			Map returnMap = new HashMap(); //결과값 담을 맵
			
			paramMap.put("menuid", vo.getMnuid()); //메뉴 id
			
			if(Validator.isNoData(vo.getStartdate()) || Validator.isNoData(vo.getEnddate())){ //검색 날짜 있는지 확인 없으면 1달 단위로
				paramMap.put("startdate", DateUtil.convertTimeToString(System.currentTimeMillis()-1296000000,"yyyy-MM-dd"));
				paramMap.put("enddate", DateUtil.getCurrentDate("yyyy-MM-dd"));
			}else{
				paramMap.put("startdate", vo.getStartdate());
				paramMap.put("enddate", vo.getEnddate());
			}
			
			List partlist = new ArrayList(); // 부서 아이디 목록 담을 리스트 
			
			String totalNumStr  = vo.getTotalPage(); //토탈 페이지
			
			int totalNum = 0; // 토탈 페이지 다시 담을 변수 
			
			if(!Validator.isNoData(vo.getSubdept())){ //하위부서 선택이 있는지 없으면 상위부서만 
			
				partlist.add(vo.getSubdept());
			
			}else if(!Validator.isNoData(vo.getMaindept())){ //하위부서 선택이 있는지 없으면 상위부서만
				//[부서명 조회 S]
				String pDeptName = vo.getMaindept();
						
				List<DeptVo> n_list  = usrAutService.getSubDeptList(pDeptName); //하위부서 목록 조회
				
				DeptVo deptVo = new DeptVo();
				
				for(int i = 0; i < n_list.size() ; i++){
					
					deptVo = (DeptVo)n_list.get(i);
					
					partlist.add(deptVo.getDept_grpid());
				}
			}
			
			if(partlist != null){
				paramMap.put("partlist", partlist);
			}
			
			if(totalNumStr != null && !(totalNumStr.equals(""))){//페이지 캐스팅
				totalNum = Integer.parseInt(totalNumStr);
		    }else{
		    	totalNum   = statisticsService.getConnListCount(paramMap); // 리스트 페이징을 위한 조회
		    }
			
			paramMap.put("startArticleNum", 1); //시작 페이지
			paramMap.put("endArticleNum", totalNum); //끝페이지
			
			List<MlogVo> l_list  = statisticsService.getConnList(paramMap); //리스트를 위한 조회

			ModelAndView mav = new ModelAndView();				
			
			mav.addObject("l_list", l_list);	//emdService.
			
			mav.setViewName("jsp/admin/csDownExcel");//mav.setViewName("../pop/SangsuInfo");
			
			System.out.println("다 잘됩니다~~~");
			
			return mav;
			
	}
	/**
	 * 엑셀로 다운로드 
	 * @param request 날짜, 부서아이디
	 * @param response 
	 * @return MlogVO 하위 부서 목록
	 * @throws Exception 
	 */
	@RequestMapping("/printStatExcelDown.do")
	public ModelAndView printStatDownExcel(HttpServletRequest request, @ModelAttribute SttParamVo vo) throws Exception {

			Map paramMap = new HashMap(); //파라미터 담을 맵
			Map returnMap = new HashMap(); //결과값 담을 맵
			
			paramMap.put("menuid", vo.getMnuid()); //메뉴 id
			
			if(Validator.isNoData(vo.getStartdate()) || Validator.isNoData(vo.getEnddate())){ //검색 날짜 있는지 확인 없으면 1달 단위로
				paramMap.put("startdate", DateUtil.convertTimeToString(System.currentTimeMillis()-1296000000,"yyyy-MM-dd"));
				paramMap.put("enddate", DateUtil.getCurrentDate("yyyy-MM-dd"));
			}else{
				paramMap.put("startdate", vo.getStartdate());
				paramMap.put("enddate", vo.getEnddate());
			}
			
			List partlist = new ArrayList(); // 부서 아이디 목록 담을 리스트 
			
			String totalNumStr  = vo.getTotalPage(); //토탈 페이지
			
			int totalNum = 0; // 토탈 페이지 다시 담을 변수 
			
			if(!Validator.isNoData(vo.getSubdept())){ //하위부서 선택이 있는지 없으면 상위부서만 
			
				partlist.add(vo.getSubdept());
			
			}else if(!Validator.isNoData(vo.getMaindept())){ //하위부서 선택이 있는지 없으면 상위부서만
				//[부서명 조회 S]
				String pDeptName = vo.getMaindept();
						
				List<DeptVo> n_list  = usrAutService.getSubDeptList(pDeptName); //하위부서 목록 조회
				
				DeptVo deptVo = new DeptVo();
				
				for(int i = 0; i < n_list.size() ; i++){
					
					deptVo = (DeptVo)n_list.get(i);
					
					partlist.add(deptVo.getDept_grpid());
				}
			}
			
			if(partlist != null){
				paramMap.put("partlist", partlist);
			}
			
			if(totalNumStr != null && !(totalNumStr.equals(""))){//페이지 캐스팅
				totalNum = Integer.parseInt(totalNumStr);
		    }else{
		    	totalNum   = statisticsService.getConnListCount(paramMap); // 리스트 페이징을 위한 조회
		    }
			
			paramMap.put("startArticleNum", 1); //시작 페이지
			paramMap.put("endArticleNum", totalNum); //끝페이지
			
			List<MlogVo> l_list  = statisticsService.getConnList(paramMap); //리스트를 위한 조회

			ModelAndView mav = new ModelAndView();				
			
			mav.addObject("l_list", l_list);	//emdService.
			
			mav.setViewName("jsp/admin/ptDownExcel");//mav.setViewName("../pop/SangsuInfo");
			
			return mav;
			
	}
}
