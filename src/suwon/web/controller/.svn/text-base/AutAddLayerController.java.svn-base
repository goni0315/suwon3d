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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import suwon.web.Service.AutAddLayerService;
import suwon.web.vo.LayAutVo;
import suwon.web.vo.LayInfoVo;

@Controller
public class AutAddLayerController {

	
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");	
	private AutAddLayerService autAddLayerService = (AutAddLayerService) context.getBean("autAddLayerService");

			
	@RequestMapping("/getLayGrpNmList.do")
	public ModelAndView boardList(HttpServletRequest request, HttpServletResponse response){			
			//String grpName = request.getParameter("grpName");
		
			List<LayInfoVo>	layList;
			layList = autAddLayerService.getLayGrpNmList();
		
		 	ModelAndView mav = new ModelAndView();	
		 	mav.addObject("layList", layList);
			mav.setViewName("jsp/layInsert");
			return mav;		
	}
	@RequestMapping("/listLayer")
	@ResponseBody
	public JSONArray nSearch(@ModelAttribute LayAutVo vo) throws Exception {
		//List a = drawService.listEmb(vo.getEname());
		JSONArray jsonarr = JSONArray.fromObject(autAddLayerService.listLayer(vo.getGrpName()));
		System.out.println(jsonarr);
		return jsonarr;
	}
	
	
	@RequestMapping(value="/autAddLayer.do", method=RequestMethod.POST) 
	public String board3Write(@ModelAttribute("LayAutVo") LayAutVo layAutVo, HttpServletRequest request){
		String grpName =request.getParameter("grpName");
		String codeNm =request.getParameter("codeNm");
		
		autAddLayerService.autAddLayer(layAutVo);
		System.out.println("grpName="+grpName);
		System.out.println("codeNm="+codeNm);
		
		return "/jsp/layInsert";
		
	}
}
