package suwon.web.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mymgr.framework.common.DateUtil;
import com.mymgr.framework.controller.ResponseUtil;

import suwon.web.Service.AdfInfoService;
import suwon.web.Service.WeatherService;
import suwon.web.vo.AdfInfoVo;
import suwon.web.vo.DongWeatherVO;
import suwon.web.vo.SuwonDongVO;
import suwon.web.vo.WeekWeatherVO;



@Controller
public class WeatherController  {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private WeatherService weatherService = (WeatherService) context.getBean("weatherService");
	
	
	/**
	 * 실시간 기상정보(표출용)
	 * */
	@RequestMapping("/weather/nowWeather.do")
	public String nowWeather(HttpServletRequest req, HttpServletResponse res){		
		System.out.println("/weather/nowWeather.do start");
		List<SuwonDongVO> n_list  = weatherService.getDongWeather();
		System.out.println("/weather/nowWeather.do end");
		return ResponseUtil.responseJSON(res, n_list);
	}	
	/**
	 * 기상정보 팝업
	 * */	
	@RequestMapping("/weather/weeklyDongWeather.do")
	public ModelAndView infoWeather(SuwonDongVO vo, HttpServletRequest request, HttpServletResponse response){
		ModelAndView mav = new ModelAndView();
		String tm = null;
		
		List<WeekWeatherVO> listWeekWeather = weatherService.listWeekWeather();
		SuwonDongVO suwonDongVO =  weatherService.getVo(vo.getCode());
		List<DongWeatherVO> listDongWeather = weatherService.listDongWeather(vo.getGridX(), vo.getGridY());
		
		if(listWeekWeather.size() > 0){
			tm = listWeekWeather.get(0).getTm();
		}
		
			mav.setViewName("/jsp/pop/infoWeather");
			
			mav.addObject("tm", DateUtil.convertDateFormat(tm, "yyyy-MM-dd HH:mm"));
			mav.addObject("suwonDongVO", suwonDongVO);
			mav.addObject("listWeekWeather", listWeekWeather);
			mav.addObject("listDongWeather", listDongWeather);

		
		return mav;
	}
	
}
