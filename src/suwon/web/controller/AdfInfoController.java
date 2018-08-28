package suwon.web.controller;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import suwon.web.Service.AdfInfoService;
import suwon.web.vo.AdfInfoVo;





/**
 * 泥⑤��뚯씪���곗씠���뚯씪紐��뺤옣�� �낅젰�섎뒗 Controller
 * @author Administrator
 *
 */
@Controller
public class AdfInfoController {
	
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private AdfInfoService adfInfoService = (AdfInfoService) context.getBean("adfInfoService");
	
	
	@RequestMapping("/main.do")
	public String boardWrite(@ModelAttribute("AdfInfoVo") AdfInfoVo adfInfoVo){		
				return "main";
		//		return "/jsp/sql_Index";
	}
	

}
