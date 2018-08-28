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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import suwon.web.Service.AdminLogService;
import suwon.web.Service.UsrAutService;
import suwon.web.vo.AdminLogVo;
import suwon.web.vo.AutVo;
import suwon.web.vo.DeptVo;
import suwon.web.vo.MenuVo;

import suwon.web.vo.UsrAutVo;
import util.MyUtil;
@Controller
public class  UsrAutController {
	
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private UsrAutService usrAutService = (UsrAutService) context.getBean("usrAutService");
	private AdminLogService adminLogService = (AdminLogService) context.getBean("adminLogService");
	private int currentPage = 1;
	private int showPageLimit = 1000; 
	private int startArticleNum = 0;
	private int endArticleNum = 0;
	private int numPerPage   = 10;
	HttpSession session;
	String usrid;
	
	/**
	 * 권한관리 페이지로 이동 
	 * @throws SocketException 
	 */
	@RequestMapping("/usrAutList.do")
	public ModelAndView goUsrAut(HttpServletRequest request, HttpServletResponse response) throws SocketException {
		
		if(request.getSession(false)==null) {
			
			ModelAndView mav = new ModelAndView("../error");
			
					return mav;
				}
	
		session = request.getSession(false);
	
		usrid=(String)session.getAttribute("usrid");
		
		String chk = request.getParameter("chk");
		
		if(chk==null) {
		AdminLogVo alv = new AdminLogVo();		
		
		alv.setMenu("권한관리 열람");	
		alv.setUsrid(usrid);		
		
		adminLogService.insertAdminLog(alv, request);
		}
		
		ModelAndView mav = new ModelAndView("/jsp/admin/usrAutMng");
			
		return mav;
	}
	
	/**
	 * 부서 리스트 반환 
	 * @param request
	 * @param response
	 * @return DeptVo 메인 부서 목록
	 */
	@RequestMapping("/mainDeptList.do")
	@ResponseBody
	public JSONArray selectMainDeptList(HttpServletRequest request, HttpServletResponse response){
			
			List<DeptVo> n_list  = usrAutService.getMainDeptList(); //메인부서 목록 요청
			
			JSONArray deptArr = JSONArray.fromObject(n_list); //json 형변환 //상위 부서명
			
			return deptArr;  //반환
		
	}
	
	/**
	 *	하위 리스트 반환 
	 * @param request dept_id 메인 부서 아이디
	 * @param response 
	 * @return DeptVo 하위 부서 목록
	 * @throws Exception 
	 */
	@RequestMapping("/subDeptList.do")
	@ResponseBody
	public JSONArray selectSubDeptList(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			JSONArray returnArr = new JSONArray(); //뷰페이지로 넘길 파라미터 json
			Map returnMap = new HashMap(); //결과값 담을 맵
			
			//[부서명 조회 S]
			String pDeptName = (String)request.getParameter("deptname"); //메인 부서 아이디 파라미터로 받음
			
			List<DeptVo> n_list  = usrAutService.getSubDeptList(pDeptName); //하위부서 목록 조회
			
			JSONArray jsonarr = JSONArray.fromObject(n_list); //json으로 캐스팅
			//[부서명 조회 E]
			
			//[사용자 조회 S]
			List idList = new ArrayList();
			DeptVo vo = new DeptVo();
			
			String mainDeptId="";//페이징에 파라미터로 써줄 메인 dept에 포함되는 id리스트
			
			for(int i = 0; i < n_list.size() ; i++){
				
				vo = (DeptVo)n_list.get(i);
				
				idList.add(vo.getDept_grpid());
				mainDeptId += vo.getDept_grpid()+",";
			}
			
			if(mainDeptId!=null&&mainDeptId!=""){ //메인 아이디 리스트
				mainDeptId = mainDeptId.substring(0, mainDeptId.length()-1);
			}
			
			//idList = idList.substring(0, idList.length()-1);
			
			Map paramMap = new HashMap();
			
			if(idList.size() == 0 ){
				idList = null;
			}
			paramMap.put("idList", idList); //메인 dept에 포함된 grpid목록
			
			paramMap.put("startArticleNum", 1); //시작 페이지
			paramMap.put("endArticleNum", 10); //끝페이지 
			
			//System.out.println(paramMap.get("idList"));
			
			List<UsrAutVo> u_list  = usrAutService.getUsrAutList(paramMap); //메인부서 목록 요청
			
			
			int totalNum = usrAutService.getUsrAutListCount(paramMap); //페이징을 위한 총 개수
			
			//[사용자 조회 E]

			//[페이징 S]
			
			MyUtil myUtil = new MyUtil();
			int total_page = 0;
						
			if(totalNum != 0) total_page = myUtil.getPageCount(numPerPage,  totalNum) ;
			
			String cp = request.getContextPath();
			
			String urlView = "fn_goPage";

			returnMap.put("pageIndexList", myUtil.pageIndexList(1, total_page, urlView,mainDeptId));
			//[페이징 E]
			//System.out.println(myUtil.pageIndexList(1, total_page, urlView));
			
			//[조합 S]
			returnMap.put("n_list", n_list); //부서리스트
			returnMap.put("u_list", u_list); //사용자리스트
			returnMap.put("idList", idList); //부서에 포함된 아이디 리스트
			returnMap.put("totalNum", totalNum); //포함되는 총 사용자수
			
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
	@RequestMapping("/subDeptUsrList.do")
	@ResponseBody
	public JSONArray selectSubDeptUsrList(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			String pGrpId= (String)request.getParameter("grpid"); //메인 부서 아이디 파라미터로 받음
			
			JSONArray returnArr = new JSONArray(); //뷰페이지로 넘길 파라미터 json
			Map returnMap = new HashMap(); //결과값 담을 맵
			
			//[사용자 조회 S]
			List idList = new ArrayList();
			DeptVo vo = new DeptVo();
			
			String mainDeptId="";//페이징에 파라미터로 써줄 메인 dept에 포함되는 id리스트
			
			idList.add(pGrpId);
			mainDeptId = pGrpId;
						
			Map paramMap = new HashMap();
			
			paramMap.put("idList", idList); //메인 dept에 포함된 grpid목록
			paramMap.put("startArticleNum", 1); //시작 페이지
			paramMap.put("endArticleNum", 10); //끝페이지 
			
			//System.out.println(paramMap.get("idList"));
			
			List<UsrAutVo> u_list  = usrAutService.getUsrAutList(paramMap); //메인부서 목록 요청
			
			
			int totalNum = usrAutService.getUsrAutListCount(paramMap); //페이징을 위한 총 개수
			
			//[사용자 조회 E]

			//[페이징 S]
			MyUtil myUtil = new MyUtil();
			
			int total_page = 0;
						
			if(totalNum != 0) total_page = myUtil.getPageCount(numPerPage,  totalNum) ;
			
			String urlView = "fn_goPage";

			returnMap.put("pageIndexList", myUtil.pageIndexList(1, total_page, urlView,mainDeptId));
			
			//[페이징 E]
			//System.out.println(myUtil.pageIndexList(1, total_page, urlView));
			
			//[조합 S]
			returnMap.put("u_list", u_list);
			returnMap.put("idList", idList);
			returnMap.put("totalNum", totalNum); //포함되는 총 사용자수
			
			returnArr = JSONArray.fromObject(returnMap);
			
			//System.out.println(returnArr);
			
			return returnArr; //반환
		
	}
	/**
	 * 사용자 리스트 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	
	@RequestMapping("/mainUsrAutList.do")
	@ResponseBody
	public JSONArray selectUsrAut(HttpServletRequest request, HttpServletResponse response) {
		JSONArray returnArr = new JSONArray(); //뷰페이지로 넘길 파라미터 json
		
		try {
			
			Map returnMap = new HashMap(); //결과값 담을 맵
			MyUtil myUtil = new MyUtil();
			//[사용자 조회 S]
			List idList = new ArrayList();
			DeptVo vo = new DeptVo();
			
			String pUsrName= myUtil.checkNull((String)request.getParameter("usrname")); //메인 부서 아이디 파라미터로 받음
			
			//System.out.println(pUsrName);
			
			String pIds= myUtil.checkNull((String)request.getParameter("grpid")); //메인 부서 아이디 파라미터로 받음
			String pageNum= myUtil.checkNull((String)request.getParameter("page")); //메인 부서 아이디 파라미터로 받음
			int totalNum= Integer.parseInt((String)request.getParameter("totalpage")); //메인 부서 아이디 파라미터로 받음
			
			//System.out.println("pageNum  //  " + pageNum);
			
			int idFlag = pIds.indexOf(",");
			
			if( idFlag > -1){
				String[] idLists = pIds.split(","); 
				for(int i = 0; i < idLists.length ; i++){
					idList.add(idLists[i]);
				}
			}else{
				idList.add(pIds);
			}
			
			
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
			
			//System.out.println(startArticleNum + " // " + endArticleNum);
			
			Map paramMap = new HashMap();
			
			if(idList.size() == 0 ){
				idList = null;
			}
			//[페이징 S]
			
			int total_page = 0;
						
			if(totalNum != 0) total_page = myUtil.getPageCount(numPerPage,  totalNum) ;
			
			String urlView = "fn_goPage";

			returnMap.put("pageIndexList", myUtil.pageIndexList(currentPage, total_page, urlView, pIds));
			
			//[페이징 E]
			if(pUsrName == ""){
				pUsrName = null;
			}
			paramMap.put("usrName", pUsrName); //메인 dept에 포함된 grpid목록
			paramMap.put("idList", idList); //메인 dept에 포함된 grpid목록
			paramMap.put("startArticleNum", startArticleNum); //시작 페이지
			paramMap.put("endArticleNum", endArticleNum); //끝페이지 
			
			//System.out.println(paramMap.get("idList"));
			
			List<UsrAutVo> u_list  = usrAutService.getUsrAutList(paramMap); //메인부서 목록 요청
			
			//[조합 S]
			returnMap.put("u_list", u_list);
			returnMap.put("idList", idList);
			returnMap.put("totalNum", totalNum); //포함되는 총 사용자수
			returnArr = JSONArray.fromObject(returnMap);
			
			//System.out.println(returnArr);
			
			
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e2) {
			e2.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} 
			
		return returnArr;
		
	}
	
	/**
	 *	권한 리스트 조회 
	 * @param 
	 * @param response 
	 * @return @AutVo
	 * @throws Exception 
	 */
	@RequestMapping("/getAutLIst.do")
	@ResponseBody
	public JSONArray getAutLIst(HttpServletRequest request, HttpServletResponse response) throws Exception {
				
			JSONArray returnArr = new JSONArray(); //뷰페이지로 넘길 파라미터 json
			
			//[사용자 조회 S]			
			
			AutVo vo = new AutVo();
			
			//System.out.println(paramMap.get("idList"));
			
			List<AutVo> aut_list  = usrAutService.getAutList(); //메인부서 목록 요청
			
			//[사용자 조회 E]

						
			returnArr = JSONArray.fromObject(aut_list);
			
			//System.out.println(returnArr);
			
			return returnArr; //반환
		
	}
	
	/**
	 *	권한 수정 
	 * @param 
	 * @param response 
	 * @return @resultCode 성공여부 S : 성공 E : 실패
	 * @throws Exception 
	 */
	@RequestMapping("/modifyUsrAut.do")
	@ResponseBody
	public JSONArray modifyUsrAut(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			MyUtil myUtil = new MyUtil();
			//[사용자 조회 S]
			
			Map paramMap = new HashMap();				
			
			String pUsrId= myUtil.checkNull((String)request.getParameter("usrid")); //메인 부서 아이디 파라미터로 받음
			String pIds= myUtil.checkNull((String)request.getParameter("autcde")); //메인 부서 아이디 파라미터로 받음
			
			//System.out.println(pUsrId + "  //  " + pIds);
			
			paramMap.put("usrid", pUsrId); //메인 dept에 포함된 grpid목록
			paramMap.put("autcde", pIds); //시작 페이지
			
			JSONArray returnArr = new JSONArray(); //뷰페이지로 넘길 파라미터 json
						
			//System.out.println(paramMap.get("idList"));
			String resultCode  = usrAutService.modifyUsrAut(paramMap); //메인부서 목록 요청
			
			paramMap.put("resultCde", resultCode);
			
			returnArr = JSONArray.fromObject(paramMap); 
			//System.out.println(returnArr);
			
			return returnArr; //반환
		
	}
	
	/**
	 * 메뉴권한 관리  
	 */
	@RequestMapping("/menuAutMng.do")
	public ModelAndView gomenuAutMng(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView("/jsp/admin/mnuAutMng");
			
		return mav;
	}
	
	/**
	 *	메뉴 리스트 조회 
	 * @param response 
	 * @return @josnarry menulist
	 * @throws Exception 
	 */
	@RequestMapping("/getMenuList.do")
	@ResponseBody
	public JSONArray getAllMenuLIst(HttpServletRequest request, HttpServletResponse response) throws Exception {
				
			JSONArray returnArr = new JSONArray(); //뷰페이지로 넘길 파라미터 json
						
			
			//System.out.println(paramMap.get("idList"));
			MyUtil myUtil = new MyUtil();
			
			String autcde= myUtil.checkNull((String)request.getParameter("autcde")); //메인 부서 아이디 파라미터로 받음
			
			Map returnMap = new HashMap(); //결과값 담을 맵
			
			List<MenuVo> allm_list  = usrAutService.getAllMenuList(); //전체 메뉴
			List<MenuVo> mym_list  = usrAutService.getMenuList(autcde); //권한을 가진 메뉴
			
			returnMap.put("allm_list", allm_list);
			returnMap.put("mym_list", mym_list);
			
			//

						
			returnArr = JSONArray.fromObject(returnMap);
			
			//System.out.println(returnArr);
			
			return returnArr; //반환
		
	}
	
	/**
	 * 메뉴권한 관리  
	 */
	/*@RequestMapping("/getAutMenuList.do")
	public ModelAndView getAutMenuList(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView("/jsp/admin/mnuAutMng");
			
		return mav;
	}*/
	
	/**
	 * 메뉴 권한 변경 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	
	@RequestMapping("/setMenuAut.do")
	@ResponseBody
	public JSONArray setMenuAut(HttpServletRequest request, HttpServletResponse response) {
			JSONArray returnArr = new JSONArray(); //뷰페이지로 넘길 파라미터 json
			
			Map returnMap = new HashMap(); //결과값 담을 맵
			MyUtil myUtil = new MyUtil();
			//[사용자 조회 S]
			
			String pAutcde= myUtil.checkNull((String)request.getParameter("autcde")); //메인 부서 아이디 파라미터로 받음
			String pAddlist= myUtil.checkNull((String)request.getParameter("addlist")); //메인 부서 아이디 파라미터로 받음
			String pRmovelist= myUtil.checkNull((String)request.getParameter("removelist")); //메인 부서 아이디 파라미터로 받음
						
			int addList = pAddlist.indexOf(","); //권한을 더할 리스트
			int removeList = pRmovelist.indexOf(","); //권할을 제가헐 리스트
			
			//[메뉴 권한 변경 S]
			List addListList = new ArrayList();
			List removeListList = new ArrayList();
			
			if( addList > -1){ //넘겨 받은 아이디를 리스트에 담기
				String[] addLists = pAddlist.split(","); 
				for(int i = 0; i < addLists.length ; i++){
					addListList.add(addLists[i]);
				}
			}else{
				if(pAddlist.length() > 1){
					addListList.add(pAddlist);
				}
			}
			
			if( removeList > -1){
				String[] addLists = pRmovelist.split(","); 
				for(int i = 0; i < addLists.length ; i++){
					removeListList.add(addLists[i]);
				}
			}else{
				if(pRmovelist.length() > 1){
					removeListList.add(pRmovelist);
				}
			}
			
			Map paramMap = new HashMap(); //파라미터로 넘길 맵
			
			
			String sucFlag1  = "E"; //결과값 판단 변수
			String sucFlag2  = "E";
			
			if(addListList.size() == 0 ){ //권한을 더할 메뉴가 있는지 판단
				
				addListList = null;
				sucFlag1  = "S";
			}else{
				
				
				
				paramMap.put("autcde", pAutcde); //메인 dept에 포함된 grpid목록
				paramMap.put("addlist", addListList); //메인 dept에 포함된 grpid목록
				sucFlag1 = usrAutService.updateMenuAut(paramMap); //메인부서 목록 요청
			}
			
			if(removeListList.size() == 0 ){//권한을 제거할 메뉴가 있는지 판단
				removeListList = null;
				sucFlag2  = "S";
			}else{
				
				paramMap.put("removelist", removeListList); //메인 dept에 포함된 grpid목록
				
				sucFlag2  = usrAutService.removeMenuAut(paramMap); //메인부서 목록 요청
			}
			
			if(sucFlag1 == "S" && sucFlag2 == "S")
			{
				sucFlag1 = "S";
			}else{
				sucFlag1 = "E";
			}
			
			//[조합 S]
			returnMap.put("resultCode", sucFlag1);
			
			returnArr = JSONArray.fromObject(returnMap);
			
			
		
			
		return returnArr;
		
	}
	
}


