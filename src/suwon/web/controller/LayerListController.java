package suwon.web.controller;

import java.net.SocketException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import suwon.web.Service.LayerListService;
import suwon.web.vo.LayerListVo;
import suwon.web.vo.UsrLayerLoadVo;

@Controller
public class LayerListController {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private LayerListService layerListService = (LayerListService) context.getBean("layerListService");
	String pUsrId = "";
	
	
	//아이디 체크 후 레이어 페이지에 레이어 전달
	@RequestMapping("/layerList.do")
	public ModelAndView usrLayerLoad(HttpServletRequest request, HttpServletResponse response) throws SocketException{
		List<LayerListVo> layerListVos;
		List<UsrLayerLoadVo> usrLayerLoadVos = null;
		int usrLayerChk = 0;
		ModelAndView mav = new ModelAndView();
				
		pUsrId= (String)request.getParameter("usrid"); //사용자 아이디 파라미터로 받음
		
		usrLayerChk = layerListService.getUsrLayerchk(pUsrId).size();//사용자 아이디에 해당하는 값이 있는지 체크
		
		//아이디 확인이 빈 값이 아닐 경우
		if(usrLayerChk > 0){
			usrLayerLoadVos = layerListService.getUsrLayerList(pUsrId);
			mav.addObject("layerListVos", usrLayerLoadVos);
			
		//아이디 확인이 빈 값일 경우
		}else{
			layerListVos = layerListService.getLayerList();
			mav.addObject("layerListVos", layerListVos);
		}
		mav.addObject("usrid", pUsrId);
		mav.setViewName("/layer/layer");
		
		return mav;
	}
	

	//아이디 체크 후 레이어 메인 페이지에 레이어 정보를 보냄
	@RequestMapping("/layerLoadList.do")
	@ResponseBody
	public JSONArray usrLayerResult(HttpServletRequest request, HttpServletResponse response){
		List<UsrLayerLoadVo> usrLayerLoadVos;
		int usrLayerChk = 0;
		List<LayerListVo> layerListVos;
				
		pUsrId = (String)request.getParameter("usrid"); //사용자 아이디 파라미터로 받음
		usrLayerChk = layerListService.getUsrLayerchk(pUsrId).size();//사용자 아이디에 해당하는 값이 있는지 체크
		
		if(usrLayerChk > 0){
			
			usrLayerLoadVos = layerListService.getUsrLayerList(pUsrId);
			JSONArray jsonArray = JSONArray.fromObject(usrLayerLoadVos);
			return jsonArray;
			
		}else{
			
			layerListVos = layerListService.getLayerList();
			JSONArray jsonArray = JSONArray.fromObject(layerListVos);
			
			return jsonArray;
		}
	}
	
	//레이어 설정 저장
	@RequestMapping("/layerSaveList.do")
	public String usrSaveLayer(HttpServletRequest request, HttpServletResponse response){
		String saveLayerList= (String)request.getParameter("saveLayerList"); 
		pUsrId = (String)request.getParameter("usrid");
		String[] layList = saveLayerList.split(",");
		String rLayList = "";
		String[] usrLayList = null;
		int usrLayerChk = layerListService.getUsrLayerchk(pUsrId).size();//사용자 아이디에 해당하는 값이 있는지 체크

		
		//아이디가 있을 경우
		if(usrLayerChk > 0){
			for(int i=0;i<layList.length;i++){
				rLayList += pUsrId + "#" + layList[i] + " ";
			}
			usrLayList = rLayList.split(" ");
			layerListService.delUsrLayer(pUsrId);
		}else{//아이디가 없을 경우
			for(int i=0;i<layList.length;i++){
				rLayList += pUsrId + "#" + layList[i] + " ";
			}
			usrLayList = rLayList.split(" ");
		}
		layerListService.setLayerList(usrLayList);
		 
		System.out.println(pUsrId);
		return "../layerList.do?usrid="+pUsrId;
		
		
	}
	
	//사용자 레이어 체크
	@RequestMapping("/usrLayerChk.do")
	@ResponseBody
	public JSONArray usrLayerChk(HttpServletRequest request, HttpServletResponse response){
		
		String pUsrId= (String)request.getParameter("usrid"); //사용자 아이디 파라미터로 받음
		int usrLayerChk = 0;
		
		usrLayerChk = layerListService.getUsrLayerchk(pUsrId).size();//사용자 아이디에 해당하는 값이 있는지 체크
		JSONArray jsonArray = JSONArray.fromObject(usrLayerChk);

		if(usrLayerChk > 0){
			return jsonArray;
		}else{
			return null;
		}
	}
}
