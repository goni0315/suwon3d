package suwon.web.controller;

import java.io.IOException;
import java.net.SocketException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mymgr.framework.controller.ResponseUtil;

import suwon.web.Service.AdminLogService;
import suwon.web.Service.AdminService;
import suwon.web.dao.AdminDao;
import suwon.web.vo.AdminIpVo;
import suwon.web.vo.AdminLogListVo;
import suwon.web.vo.AdminLogVo;
import suwon.web.vo.BldgInfoVo;
import suwon.web.vo.LayInfoVo;
import util.MyUtil;
import util.Paging;
/**
 * 
 * 이 클래스는 관리자페이지를 위한 클래스다. 
 * 이 클래스는 관리자 페이지 이동, 관리자 페이지 레이어 정보, 레이어목록검색, 레이어 정보 업데이트를 요청한 경우 해당역할을 수행한다.
 * 관리자 페이지 이동 기능에 대한 컨트롤은 goAdminPage 메소드를 사용하여 수행한다.
 * 관리자 페이지 레이어 목록검색 기능에 대한 컨트롤은 getLayerList 메소드를 사용하여 수행한다.
 * 관리자 페이지 레이어 정보 기능에 대한 컨트롤은 getLayerInfoForSeq 메소드를 사용하여 수행한다.
 * 관리자 페이지 레이어 정보 업데이트 기능에 대한 컨트롤은 doLayerInfoUpdate 메소드를 사용하여 수행한다.
 * 
 * Project        : Suwon3d
 * Package        : suwon.web.controller
 * File           : AdminController.java
 * @author        : hp
 * @CompanyName   : EGIS
 * @DeveloperName : 이호성
 * @since         : 2015. 8. 6.
 * @version       : 1.0
 */
@Controller
public class AdminController implements AdminDao{
	
	HttpSession session;
	String usrid="";
	int sessionTime=60*60*10;
	private int currentPage = 1;
	/**
	 * 보여줄 최대 페이지 수
	 */
	private int showPageLimit = 1000; 
	/**
	 * 시작 페이지 변수
	 */
	private int startArticleNum = 0;
	
	private int endArticleNum = 0;
	
	/**
	 * applicationContext 연결부
	 */
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	
	/**
	 * adminService 연결부
	 */
	private AdminService adminService = (AdminService) context.getBean("adminService");
	private AdminLogService adminLogService = (AdminLogService) context.getBean("adminLogService");
	
	
	/**
	 * 관리자 페이지로 이동		
	 * @param request 관리자 아이디
	 * @return mav 관리자페이지 경로, 관리자 아이디반환
	 */
	/**
	 * 
	 * Method : goAdminPage
	 * @since  2015. 8. 6.
	 * @paramType 
	 * @returnType ModelAndView
	 * @param request
	 * @return
	 * @see ex) return 값을 전달하는 페이지명
	 *      조건에 따른 return 값 전달 페이지가 다를 경우
	 *      ex) True  : 페이지명
	            False : 페이지명
	 */			
	@RequestMapping("/admin.do")
	public ModelAndView goAdminPage(HttpServletRequest request, HttpServletResponse response) throws IOException{
		
			String pUsrid = request.getParameter("adminUsrid");
			
			ModelAndView mav = new ModelAndView("jsp/admin/index");			
						
			session = request.getSession(true); //true는 세션이있으면 반환 없으면 만들어서 반환
			
			//pUsrid="21027059"; //실제 서비스할때는 삭제
			
			session.setAttribute("usrid", pUsrid);
								
			session.setMaxInactiveInterval(sessionTime);	
			
			usrid = (String)session.getAttribute("usrid");	
			
			AdminLogVo alv = new AdminLogVo();
			alv.setUsrid(usrid);
			alv.setMenu("관리자페이지 접속");		
			adminLogService.insertAdminLog(alv, request);
			
			
			//System.out.println(session.getId());
			
			
			
			return mav;	  
			
			
			
	}
	/**
	 * 관리자 페이지 레이어 목록 검색
	 * @param request ContextPath
	 * @return mav 검색결과반환
	 */
	@RequestMapping("/admin/layerList.do")
	public ModelAndView getLayerList(HttpServletRequest request, HttpServletResponse response) throws SocketException{
		
		
		
		List<LayInfoVo> list=null;
		 String urlView=null;
		 String cp = request.getContextPath();
		String msg = ServletRequestUtils.getStringParameter(request, "searchLayGroup", null);
		int totalNum = 0;
	    int showArticleLimit = 5;
		int total_page = 0;
		int numPerPage   = 5;
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

		if(request.getSession(false)==null) {
			
			ModelAndView mv = new ModelAndView("../error");
			
					return mv;
				}
	
		session = request.getSession(false);
	
		usrid=(String)session.getAttribute("usrid");
		
		String chk = request.getParameter("chk");		
		
		if(pageNum==null && chk==null) {
		AdminLogVo alv = new AdminLogVo();		
		
		alv.setMenu("레이어관리 열람");	
		alv.setUsrid(usrid);		
		
		adminLogService.insertAdminLog(alv, request);
		}
		
		if(msg==null){
			 list = adminService.getLayerListForAdmin(startArticleNum, endArticleNum);
			 totalNum = adminService.getLayerListCntForAdmin(startArticleNum, endArticleNum);	
			 urlView = cp+"/admin/layerList.do";
		}else{
			list = adminService.getLayerListForAdminInLayerListPage(startArticleNum, endArticleNum, msg);
			totalNum = adminService.getLayerListCntForAdminInLayerListPage(startArticleNum, endArticleNum,msg);	
			 urlView = cp+"/admin/layerList.do?searchLayGroup="+msg;
		}
		//System.out.println("totalNum: "+totalNum);
		List<LayInfoVo> grp_list = adminService.getGroupListForAdmin();
		Map<String, List> returnMap = new HashMap<String, List>();
		returnMap.put("resultList", list);
		returnMap.put("groupList", grp_list);
		

		

		MyUtil myUtil = new MyUtil();
		if(totalNum != 0)   total_page = myUtil.getPageCount(numPerPage,  totalNum) ;
		
	    
	    ModelAndView mav = new ModelAndView("jsp/admin/sub1");
			mav.addObject("resultMap",returnMap);
			mav.addObject("keyWord", msg);
			mav.addObject("totalNum", totalNum);
			mav.addObject("pageIndexList", myUtil.pageIndexList(currentPage, total_page, urlView));
			return mav;		
	}
	
	/**
	 * 관리자 페이지 레이어 정보
	 * @param request 해당레이어 일련번호
	 * @param response 해당레이어 DB 정보
	 * @return 해당레이어 DB 정보 JSON 형식으로 반환
	 */	
	
	@RequestMapping("/admin/layerInfo.do")
	public String getLayerInfoForSeq(HttpServletRequest request, HttpServletResponse response){
		int seq = Integer.parseInt(ServletRequestUtils.getStringParameter(request, "seq","0"));
		LayInfoVo vo = adminService.getLayerInfoForSeq(seq);
		return ResponseUtil.responseJSON(response, vo);
	}	
	
	/**
	 * 관리자 페이지 레이어 정보 업데이트
	 * @param paramVo 레이어 업데이트 정보
	 * @return msg 레이어 업데이트 결과 반환
	 */
	@RequestMapping("/admin/layerInfoUpdate.do")
	@ResponseBody
	public String doLayerInfoUpdate(HttpServletRequest request, HttpServletResponse response, LayInfoVo paramVo) throws SocketException{
		
		if(request.getSession(false)==null) {
			
			new ModelAndView("redirect:error.do");
			
			
					
				}
	
	session = request.getSession(false);
	usrid=(String)session.getAttribute("usrid");
	
      AdminLogVo alv = new AdminLogVo();
      alv.setMenu(paramVo.getKor_nm()+" 레이어 업데이트");		 
      alv.setUsrid(usrid);
      adminLogService.insertAdminLog(alv, request);
		
		
		
		
		String msg= adminService.doLayerInfoUpdate(paramVo);
		return msg;
	}
	
	
	
	@RequestMapping(value="/adminLogList.do")
	public ModelAndView adminLogList(HttpServletRequest request, 
			HttpServletResponse response) throws Exception{		
		
		
		if(request.getSession(false)==null) {
			
			ModelAndView mav = new ModelAndView("../error");
			
					return mav;
				}
			
			MyUtil myUtil = new MyUtil();
			int numPerPage = 5;
			int viewPage = 0;
			int record = 0;
			int totalPage = 0;
		
			String pageNum  = request.getParameter("pageNum");
			String menuname = request.getParameter("menu");
						
			if("0".equals(menuname)) {
				return new ModelAndView("redirect:adminLogList.do");				
			} else if(menuname==null)  {
							
				session = request.getSession(false);
				
				usrid=(String)session.getAttribute("usrid");
				    	
				if(pageNum == null) {
			    AdminLogVo alv = new AdminLogVo();		
				
				alv.setMenu("관리자 접속이력조회 열람");	
				alv.setUsrid(usrid);		
				
				adminLogService.insertAdminLog(alv, request);
				}
				
				//해당 관리자 로그 총 갯수
				record = Integer.parseInt(adminLogService.recordAdminLog(usrid));
								
				
				totalPage = myUtil.getPageCount(numPerPage, record); //전체페이지수
				
				
				//페이지 캐스팅
				if(pageNum != null && !(pageNum.equals(""))){
				    	currentPage = Integer.parseInt(pageNum);
				    }else{
				    	currentPage = 1;
				}
				
				
			////첫페이지 및 마지막 페이지 오류
				if(currentPage == 1){
					viewPage = 0;
					pageNum = "1";
				}
				else if(currentPage > totalPage){
					viewPage = (totalPage - 1) * numPerPage;
					pageNum = String.valueOf(totalPage);
				}	
				else
					viewPage = (currentPage -1) * numPerPage;
				
				
				
				//페이지 URL
				String urlView = "adminLogList.do?usrid="+usrid;	
			


				//해당 관리자 로그 가져오기			
				List<AdminLogListVo> adminLoglist = adminLogService.getList(usrid, viewPage, numPerPage); 
				
				
				ModelAndView mav = new ModelAndView("/jsp/admin/adminLogList");	//view파일 지정
				
				mav.addObject("adminLoglist", adminLoglist);  
				
				
				//페이징 오브젝트 추가
				mav.addObject("pageIndexList", myUtil.pageIndexList(currentPage, totalPage, urlView));	//전체페이징
				mav.addObject("pageNum", pageNum);			//페이지넘버
				mav.addObject("numPerPage", numPerPage);	//한페이지 당 글의 수
				mav.addObject("totalPage", totalPage); 		//전체페이지
				mav.addObject("noticeRecord", record);		//전체글의 수
				mav.addObject("usrid", usrid);	
				
				
				return mav;
				
			}
			else
			{
				switch(Integer.parseInt(menuname)) {
				
				case 0:
					menuname = "전체";
					break;
				case 1:
					menuname = "공지사항 열람";
					break;
				case 2:
					menuname = "권한관리 열람";
					break;
				case 3:
					menuname = "레이어관리 열람";
					break;
				case 4:
					menuname = "레이어 업데이트";
					break;
				case 5:
					menuname = "접속통계조회 열람";
					break;
				case 6:
					menuname = "출력이력조회 열람";
					break;
				case 7:
					menuname = "관리자 접속이력조회 열람";
					break;
				case 8:
					menuname = "글 열람";
					break;
				case 9:
					menuname = "글 등록";
					break;
				case 10:
					menuname = "글 수정";
					break;
				case 11:
					menuname = "글 삭제";
					break;			
				}
				
				HashMap<String, String> searchInfo = new HashMap<String, String>();
				
				
				searchInfo.put("usrid", usrid);
				searchInfo.put("menuname", menuname);
				
				//해당 관리자 조회 로그 총 갯수
				record = Integer.parseInt(adminLogService.recordAdminSearchLog(searchInfo));
				
				totalPage = myUtil.getPageCount(numPerPage, record); //전체페이지수
				
				
				//페이지 캐스팅
				if(pageNum != null && !(pageNum.equals(""))){
				    	currentPage = Integer.parseInt(pageNum);
				    }else{
				    	currentPage = 1;
				}
				
				
			////첫페이지 및 마지막 페이지 오류
				if(currentPage == 1){
					viewPage = 0;
					pageNum = "1";
				}
				else if(currentPage > totalPage){
					viewPage = (totalPage - 1) * numPerPage;
					pageNum = String.valueOf(totalPage);
				}	
				else
					viewPage = (currentPage -1) * numPerPage;	
				

				
				if("전체".equals(menuname))
					menuname="0";
				else if("공지사항 열람".equals(menuname))
					menuname="1";
				else if("권한관리 열람".equals(menuname))
					menuname="2";
				else if("레이어관리 열람".equals(menuname))
					menuname="3";
				else if("레이어 업데이트".equals(menuname))
					menuname="4";
				else if("접속통계조회 열람".equals(menuname))
					menuname="5";
				else if("출력이력조회 열람".equals(menuname))
					menuname="6";
				else if("관리자 접속이력조회 열람".equals(menuname))
					menuname="7";
				else if("글 열람".equals(menuname))
					menuname="8";
				else if("글 등록".equals(menuname))
					menuname="9";
				else if("글 수정".equals(menuname))
					menuname="10";
				else if("글 삭제".equals(menuname))
					menuname="11";		
				
				
				
				//페이지 URL
				String urlView = "adminLogList.do?menu="+menuname;	


				//해당 관리자 검색 로그 가져오기			
				List<AdminLogListVo> adminLoglist = adminLogService.getSearchList(searchInfo, viewPage, numPerPage); 
				
				ModelAndView mav = new ModelAndView("/jsp/admin/adminLogList");	//view파일 지정
				
				mav.addObject("adminLoglist", adminLoglist);  
				
				//페이징 오브젝트 추가
				mav.addObject("pageIndexList", myUtil.pageIndexList(currentPage, totalPage, urlView));	//전체페이징
				mav.addObject("pageNum", pageNum);			//페이지넘버
				mav.addObject("numPerPage", numPerPage);	//한페이지 당 글의 수
				mav.addObject("totalPage", totalPage); 		//전체페이지
				mav.addObject("noticeRecord", record);		//전체글의 수
				mav.addObject("usrid", usrid);			
				mav.addObject("menu", menuname);	
				return mav;				
				
			}
					
	}	
	
	
	@RequestMapping(value="/error.do")
	public ModelAndView goError(HttpServletRequest request, HttpServletResponse response){
		
		
	
		ModelAndView mav = new ModelAndView("../error");
	
	return mav;
		
	}	
		
	@RequestMapping(value="/adminPCNominate.do")
	@ResponseBody
	public int adminPCNominate (HttpServletRequest request, HttpServletResponse response){
		
		String usrid = request.getParameter("usrid");
		String conip = request.getParameter("conip");
		
		
		//로그인한 id, ip로 DB 조회
		List<AdminIpVo> result = adminService.getAdminIP(usrid, conip);
		
		//DB에 값이 없는경우 
		if(result.get(0).getConip().equals("0") && result.get(0).getUsrid().equals("0")) {
			//adminService.setAdminIP(usrid, conip);
//			System.out.println(result.get(0).getConip());
//			System.out.println(result.get(0).getUsrid());
//			System.out.println("DB에"+usrid+"이름으로"+conip+"아이피를 입력함");
			return 0;
		//db에 usrid, conip가 둘다 같은값이 잇을경우
		} else if(result.get(0).getConip().equals(conip) && result.get(0).getUsrid().equals(usrid)) {
		return 1;
			
		} else if(result.get(0).getUsrid().equals(usrid)	 && !(result.get(0).getConip().equals(conip))	) {
			return 2;
		} 
		
	return 3;
		
	}	
	
	@RequestMapping(value="/addAdminPCNominate.do")
	@ResponseBody
	public int addAdminPCNominate (HttpServletRequest request, HttpServletResponse response){
		
		String usrid = request.getParameter("usrid");
		String conip = request.getParameter("conip");
			
			adminService.setAdminIP(usrid, conip);

			return 0;	
		
	}	
	
	@RequestMapping(value="/delAdminPCNominate.do")
	@ResponseBody
	public int delAdminPCNominate (HttpServletRequest request, HttpServletResponse response){
		
		String usrid = request.getParameter("usrid");
		String conip = request.getParameter("conip");
			
			adminService.delAdminIP(usrid, conip);

			return 0;	
		
	}	
	
	
	@RequestMapping(value="/buildingManagement.do")
	public ModelAndView goBuildingManagement(HttpServletRequest request, HttpServletResponse response){
		
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));

		Paging paging = new Paging();
		paging.setTotalCount(adminService.getTotalCount()); // 전체 게시물
		paging.setPageNum(pageNum); // 현재 페이지 세팅
		paging.setContentNum(15); // 한 페이지 보여줄 게시물 개수
		paging.setCurrentBlock(pageNum); //현재 페이지 블록 세팅
		paging.setLastBlock(paging.getTotalCount()); // 마지막 블록 세팅
		paging.prevnext(pageNum); // 현재 페이지 번호로 앞, 뒤 화살표 세팅
		paging.setStartPage(paging.getCurrentBlock()); //현재 페이지 블록으로 시작 페이지 세팅
		paging.setEndPage(paging.getLastBlock(), paging.getCurrentBlock()); 
		//마지막 페이지 블록과 현재 페이지 블록으로 마지막 페이지 세팅
		
		
		//현재년도 구하기
		//int year = Calendar.getInstance().get(Calendar.YEAR);	
		
		int startNum = (paging.getPageNum()-1)*paging.getContentNum()+1;
		int endNum = paging.getContentNum()*paging.getPageNum();

		List<BldgInfoVo> list = adminService.getBldgList("2018", startNum,  endNum);
	
		ModelAndView mav = new ModelAndView("jsp/buildingManagement");
	    mav.addObject("bldgList", list);
	    mav.addObject("startPage", paging.getStartPage());
	    mav.addObject("endPage", paging.getEndPage());
	    mav.addObject("prev", paging.isPrev());
	    mav.addObject("next", paging.isNext());
	    mav.addObject("pageNum", paging.getPageNum());
	    mav.addObject("totalPage",paging.calcPage(paging.getTotalCount(), paging.getContentNum()));    
	    mav.addObject("totalCount",paging.getTotalCount());    
	return mav;
		
	}	
	
	
}
