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

import suwon.web.Service.ModelLibListService;
import suwon.web.vo.ModelLibListVo;

/*@Controller
public class ModelLibListController {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private ModelLibListService libListService = (ModelLibListService) context.getBean("libListService");
	*//**
	 * 모델 라이브러리 목록 조회
	 * @return
	 *//*
	@RequestMapping("/modelLibList.do")
	public ModelAndView modelLibList(){
		
		List<ModelLibListVo> libListVos;
		libListVos = libListService.getModelLibList();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("libListVos", libListVos);
		mav.setViewName("/jsp/modelLibList");
		return mav;
	}
}
*/
@Controller
public class ModelLibListController {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private ModelLibListService libListService = (ModelLibListService) context.getBean("libListService");
	/**
	 * 모델 라이브러리 목록 조회
	 * @return
	 */
	@RequestMapping("/modelLibListSearch.do")
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response){
		List<ModelLibListVo> libListVos;
		libListVos = libListService.getModelLibList();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("libListVos", libListVos);
		mav.setViewName("/jsp/modelLibList");
		//System.out.println("리스트로 갑니까??");
		return mav;
	}
	@RequestMapping("/modelLibList.do")
	@ResponseBody
	public JSONArray nSearch(@ModelAttribute ModelLibListVo vo) throws Exception {
		JSONArray jsonarr = JSONArray.fromObject(libListService.listModel(vo.getLib_ajax()));
		return jsonarr;
	}
	
	@RequestMapping("/modelLibSmallList.do")
	@ResponseBody
	public JSONArray smallSearch(@ModelAttribute ModelLibListVo vo) throws Exception {
		JSONArray jsonarr = JSONArray.fromObject(libListService.listSmallModel(vo.getLibl_cde(),vo.getLibm_cde(),vo.getTexture_file()));
		//System.out.println("jsonarr : " + jsonarr);
		return jsonarr;
	}
	
	
	@RequestMapping("/searchModel.do")
	public String modelsear() {
		return "/jsp/modelList";
	}	
	/*@RequestMapping("/blinkListM.do")
	public String blink() {
		return "/jsp/blinkList";
	}*/
	
}
