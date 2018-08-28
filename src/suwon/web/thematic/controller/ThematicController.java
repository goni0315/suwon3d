package suwon.web.thematic.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.format.ScriptStyle;
import jxl.format.UnderlineStyle;
import jxl.write.*;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import suwon.web.thematic.service.ThematicService;
import suwon.web.thematic.service.ThematicPolygonService;
import suwon.web.thematic.vo.ExcelDoroVo;
import suwon.web.thematic.vo.ExcelJibunVo;
import suwon.web.thematic.vo.ExcelPointVo;
import suwon.web.thematic.vo.SafetyExcelVo;
import suwon.web.thematic.vo.SafetyExcelWriteVo;
import suwon.web.thematic.vo.ThematicExcelWriteVo;
import suwon.web.thematic.vo.ThematicPolygonVo;
import util.ExcelUtil;


@Controller
public class ThematicController {


	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");	
	private ThematicService thematicService = (ThematicService) context.getBean("thematicService");
	private ThematicPolygonService thematicPolygonService = (ThematicPolygonService) context.getBean("thematicPolygonService");
	private String filePath = "D:/Suwon3dSystem/apache-tomcat-6.0.26/backup/Excel/"; //실서버
//	private String filePath = "c:/xdcashe/";//내부테스트 업로드
	
	private String safetyPath = "D:/Suwon3dSystem/apache-tomcat-6.0.26/webapps/Suwon3d/excel/safetyPoint.xls"; //실서버용
	private String thematicPath = "D:/Suwon3dSystem/apache-tomcat-6.0.26/webapps/Suwon3d/excel/thematicPoint.xls"; //실서버용
	
//	private String safetyPath = "E:/[Suwon3dSystem]/apache-tomcat-6.0.37-windows-x86/apache-tomcat-6.0.37/webapps/Suwon3d/excel/safetyPoint.xls"; //서울서버
//	private String thematicPath = "E:/[Suwon3dSystem]/apache-tomcat-6.0.37-windows-x86/apache-tomcat-6.0.37/webapps/Suwon3d/excel/thematicPoint.xls"; //서울서버
	
//	private String safetyPath = "D:/lee-hosg/PROJECT/Suwon3DProject/workspace/Suwon3d/WebContent/excel/safetyPoint.xls"; //호성자리
//	private String thematicPath = "D:/lee-hosg/PROJECT/Suwon3DProject/workspace/Suwon3d/WebContent/excel/thematicPoint.xls"; //호성자리
	
	
	@RequestMapping("/thematic.do")
	public String thematicMain(){

		return "jsp/thematic/thematic";
	}

	@RequestMapping(value="/thematicJibun.do", method=RequestMethod.POST)
	public ModelAndView thematicJibun(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest mrRequest) {
		
		String name =null; //시설명칭
		String sggNm =null; //시군구명
		String emdName = null; //읍면동명
		String sanCD = null; //산코드
		String bonCD = null; //지번 본번
		String booCD = null; //지번 부번
		String color = null; //색상
		String numSize = null; //수치
		
/*		name = name.trim();
		sggNm = sggNm.trim();
		emdName = emdName.trim();
		sanCD = sanCD.trim();
		bonCD = bonCD.trim();
		booCD = booCD.trim();
		color = color.trim();
		numSize = numSize.trim();*/

		//String excelFile = "d:/FUC-0149.xls";

		//String filePath = "C:/xdcashe/"; //저장될 파일 위치
		MultipartFile file = mrRequest.getFile("fileUrl");
		String fileName = file.getOriginalFilename();
		File uploadFile = new File(filePath + fileName);
		
		if(uploadFile.exists()){
//			fileName = new Date().getTime() + fileName;
			uploadFile = new File(filePath + fileName);
		}
		try {
			file.transferTo(uploadFile);
		} catch (Exception e) {
			
		}
			
/*		int sizeLimit = 10 * 1024 * 1024; //파일 업로드 용량 : 10M
		String formName = "";
		String fileName = "";
//		long fileSize = 0;
		String thematic = "0";		
		MultipartRequest multi;*/
		ModelAndView mav = null;

		try {
			//MultipartRequest multi = new MultipartRequest(request, filePath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());
/*			multi = new MultipartRequest(request, filePath, sizeLimit, "UTF-8");


			thematic = multi.getParameter("thematic");
			Enumeration formNames = multi.getFileNames();


			while(formNames.hasMoreElements()){
				formName = (String)formNames.nextElement();
				fileName = multi.getFilesystemName(formName);
*/
//				if(fileName != null){
//					fileSize = multi.getFile(formName).length();
//				}
//			}

			//File file = new File(filePath + "/" + fileName);
			
			ExcelUtil excelUtil = new ExcelUtil(); 
			List<HashMap<String, String>> result = excelUtil.thematicExcel(filePath,fileName);
			//System.out.println(filePath+"/"+fileName);

			List<ExcelJibunVo> excelJibunList = new ArrayList<ExcelJibunVo>(); // 여기 리스트에 VO 추가


				for (int i=1; i<result.size(); i++){
					HashMap<String, String> map = (HashMap<String, String>)result.get(i);
					
					name = map.get("COL0"); //명칭
					sggNm = map.get("COL1"); //시군구
					emdName = map.get("COL2"); //읍면동
					sanCD = map.get("COL3"); //산
					bonCD = map.get("COL4"); //본번
					booCD = map.get("COL5"); //부번
					color = map.get("COL6"); //색상
					numSize = map.get("COL7"); //크기 1~10
					
					name = name.replaceAll(" ","");
					sggNm = sggNm.replaceAll(" ","");
					emdName = emdName.replaceAll(" ","");
					sanCD = sanCD.replaceAll(" ","");
					bonCD = bonCD.replaceAll(" ","");
					booCD = booCD.replaceAll(" ","");
					color = color.replaceAll(" ","");
					numSize = numSize.replaceAll(" ","");
					String pnu =  thematicService.getPNU(emdName, sanCD, makeBon(bonCD), makeBoo(booCD));

					//System.out.println("본번, 부번"+ makeBon(bonCD) + ", " + makeBoo(booCD));
					ExcelJibunVo excelJibunVO = new ExcelJibunVo(name, sggNm, emdName, sanCD, bonCD, booCD, color, numSize, pnu);
					excelJibunList.add(excelJibunVO);				
				}


			mav = new ModelAndView();
			mav.addObject("excelJibunList",excelJibunList);

			mav.setViewName("jsp/thematic/thematic");

		} catch (IOException e1) {
			e1.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
		
	@RequestMapping(value="/thematicDoro.do", method=RequestMethod.POST)
	public ModelAndView thematicDoro(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest mrRequest) {

		String name =null; //시설명칭
		String sggNm =null; //시군구명
		String color = null; //색상
		String doroNm = null; //도로명
		String buldBonCd = null; //건물 본번
		String buldBooCd = null; //건물 부번
		String numSize = null; //수치

		MultipartFile file = mrRequest.getFile("fileUrl");
		String fileName = file.getOriginalFilename();
		File uploadFile = new File(filePath + fileName);
		
		if(uploadFile.exists()){
//			fileName = new Date().getTime() + fileName;
			uploadFile = new File(filePath + fileName);
		}
		try {
			file.transferTo(uploadFile);
		} catch (Exception e) {
			
		}
			
		ModelAndView mav = null;

		try {

			ExcelUtil excelUtil = new ExcelUtil(); 
			List<HashMap<String, String>> result = excelUtil.thematicExcel(filePath,fileName);
			//System.out.println(filePath+"/"+fileName);

			List<ExcelDoroVo> excelDoroList = new ArrayList<ExcelDoroVo>(); // 여기 리스트에 VO 추가

				for (int i=1; i<result.size(); i++){
					HashMap<String, String> map = (HashMap<String, String>)result.get(i);

					name = map.get("COL0"); //명칭
					sggNm = map.get("COL1"); //시군구
					doroNm = map.get("COL2"); //도로명
					buldBonCd = map.get("COL3"); //건물 본번
					buldBooCd = map.get("COL4"); //건물 부번
					color = map.get("COL5"); //색상
					numSize = map.get("COL6"); //크기 1~10
					
					name = name.replaceAll(" ","");
					sggNm = sggNm.replaceAll(" ","");
					doroNm = doroNm.replaceAll(" ","");
					buldBonCd = buldBonCd.replaceAll(" ","");
					buldBooCd = buldBooCd.replaceAll(" ","");
					color = color.replaceAll(" ","");
					numSize = numSize.replaceAll(" ","");
					if(buldBooCd == ""){
						buldBooCd = "0";
					}
					String bd_mgt_sn =  thematicService.getDoro(sggNm, doroNm, buldBonCd, buldBooCd);
					ExcelDoroVo excelDoroVO = new ExcelDoroVo(name, sggNm, doroNm, buldBonCd, buldBooCd, color, numSize, bd_mgt_sn);
					excelDoroList.add(excelDoroVO);				
				}

			mav = new ModelAndView();
			mav.addObject("excelDoroList",excelDoroList);
//			System.out.println("도로 : " +excelDoroList);
			mav.setViewName("jsp/thematic/thematic");

		} catch (IOException e1) {
			e1.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	
	@RequestMapping(value="/thematicPoint.do", method=RequestMethod.POST)
	public ModelAndView thematicPoint(HttpServletRequest request, HttpServletResponse response,MultipartHttpServletRequest mrRequest) {

		String name =null; //시설명칭
		String color = null; //색상
		String numSize = null; //수치
		String pointX =null; //시군구명
		String pointY = null; //읍면동명

		MultipartFile file = mrRequest.getFile("fileUrl");
		String fileName = file.getOriginalFilename();
		File uploadFile = new File(filePath + fileName);
		
		if(uploadFile.exists()){
//			fileName = new Date().getTime() + fileName;
			uploadFile = new File(filePath + fileName);
		}
		try {
			file.transferTo(uploadFile);
		} catch (Exception e) {
			
		}
		//System.out.println(uploadFile);
		ModelAndView mav = null;

		try {
		
			ExcelUtil excelUtil = new ExcelUtil(); 
			List<HashMap<String, String>> result = excelUtil.thematicExcel(filePath,fileName);
			//System.out.println(filePath+"/"+fileName);

			List<ExcelPointVo> excelPointList = new ArrayList<ExcelPointVo>(); // 여기 리스트에 VO 추가

				for (int i=1; i<result.size(); i++){
					HashMap<String, String> map = (HashMap<String, String>)result.get(i);

					name = map.get("COL0"); //명칭
					pointX = map.get("COL1"); //시군구
					pointY = map.get("COL2"); //읍면동
					color = map.get("COL3"); //색상
					numSize = map.get("COL4"); //크기 1~10

					name = name.replaceAll(" ","");
					pointX = pointX.replaceAll(" ","");
					pointY = pointY.replaceAll(" ","");
					color = color.replaceAll(" ","");
					numSize = numSize.replaceAll(" ","");					
					
					ExcelPointVo excelPointVO = new ExcelPointVo(name, pointX, pointY, color, numSize);
					excelPointList.add(excelPointVO);

				}

			mav = new ModelAndView();
			mav.addObject("excelPointList",excelPointList);
//			mav.setViewName("redirect:thematic.do");
			mav.setViewName("jsp/thematic/thematic");

		} catch (IOException e1) {
			e1.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	
	@RequestMapping(value="/thematicPolygon.do", method=RequestMethod.POST)
	public ModelAndView thematicPolygon(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest mrRequest) {
		
		String name =null; //시설명칭
		String sggNm =null; //시군구명
		String emdName = null; //읍면동명
		String sanCD = null; //산코드
		String bonCD = null; //지번 본번
		String booCD = null; //지번 부번
		String color = null; //색상
		String numSize = null; //수치
		String polygonPoint = "";
		

		MultipartFile file = mrRequest.getFile("fileUrl");
		String fileName = file.getOriginalFilename();
		File uploadFile = new File(filePath + fileName);
		
		if(uploadFile.exists()){
			uploadFile = new File(filePath + fileName);
		}
		try {
			file.transferTo(uploadFile);
		} catch (Exception e) {
			
		}
			
		ModelAndView mav = null;

		try {
		
			ExcelUtil excelUtil = new ExcelUtil(); 
			List<HashMap<String, String>> result = excelUtil.thematicExcel(filePath,fileName);
			//System.out.println(filePath+"/"+fileName);

			List<ExcelJibunVo> excelJibunList = new ArrayList<ExcelJibunVo>(); // 여기 리스트에 VO 추가


				for (int i=1; i<result.size(); i++){
					HashMap<String, String> map = (HashMap<String, String>)result.get(i);
					
					name = map.get("COL0"); //명칭
					sggNm = map.get("COL1"); //시군구
					emdName = map.get("COL2"); //읍면동
					sanCD = map.get("COL3"); //산
					bonCD = map.get("COL4"); //본번
					booCD = map.get("COL5"); //부번
					color = map.get("COL6"); //색상
					numSize = map.get("COL7"); //크기 1~10
					
					name = name.replaceAll(" ","");
					sggNm = sggNm.replaceAll(" ","");
					emdName = emdName.replaceAll(" ","");
					sanCD = sanCD.replaceAll(" ","");
					bonCD = bonCD.replaceAll(" ","");
					booCD = booCD.replaceAll(" ","");
					color = color.replaceAll(" ","");
					numSize = numSize.replaceAll(" ","");
					String pnu =  thematicService.getPNU(emdName, sanCD, makeBon(bonCD), makeBoo(booCD));
					polygonPoint = polygonPoint + pnu + "-";
					//System.out.println("본번, 부번"+ makeBon(bonCD) + ", " + makeBoo(booCD));
					ExcelJibunVo excelJibunVO = new ExcelJibunVo(name, sggNm, emdName, sanCD, bonCD, booCD, color, numSize, pnu);
					excelJibunList.add(excelJibunVO);				
				}
				
				String polygonBoundaryList = thematicPolygonService.getPolygonPoint(polygonPoint);
				//System.out.println("polygonBoundaryList : " + polygonBoundaryList);
				
			mav = new ModelAndView();
			mav.addObject("excelJibunList",excelJibunList);
			mav.addObject("polygonBoundaryList",polygonBoundaryList);

			mav.setViewName("jsp/thematic/thematic");

		} catch (IOException e1) {
			e1.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	//내주제도 좌표 엑셀 추출!!
		@RequestMapping("/thematicWrite.do")
		public String thematicWriteMain(Model model,HttpServletRequest request) throws IOException, Exception{
			String pointX = request.getParameter("xPoint");
			String pointY = request.getParameter("yPoint");
			String[] xSplit = pointX.split(",");
			String[] ySplit = pointY.split(",");
			String xResult="";
			String yResult="";
			
//			WritableWorkbook workbook = Workbook.createWorkbook(new File("c:/안전길 좌표추출.xls"));
			WritableWorkbook workbook = Workbook.createWorkbook(new File(thematicPath));
			
			// 셀형식
			WritableCellFormat textFormat = new WritableCellFormat(new WritableFont (WritableFont.ARIAL, 
	                11, WritableFont.NO_BOLD,               //Bold 스타일
	                false,                                 //이탤릭체여부
	                UnderlineStyle.NO_UNDERLINE, //밑줄 스타일
	                Colour.BLACK,                      //폰트 색
	                ScriptStyle.NORMAL_SCRIPT)); //스크립트 스타일);
			
			// 셀제목 형식
			WritableCellFormat textFormatSub = new WritableCellFormat(new WritableFont (WritableFont.ARIAL, 
					11, WritableFont.BOLD,               //Bold 스타일
					false,                                 //이탤릭체여부
					UnderlineStyle.NO_UNDERLINE, //밑줄 스타일
					Colour.BLACK,                      //폰트 색
					ScriptStyle.NORMAL_SCRIPT)); //스크립트 스타일);
	 
			// 생성
			textFormat.setAlignment(Alignment.CENTRE);
			textFormatSub.setAlignment(Alignment.CENTRE);
			// 테두리
			textFormat.setBorder(Border.ALL, BorderLineStyle.THIN);
			textFormatSub.setBorder(Border.ALL, BorderLineStyle.THIN);
			
			
			//셀형식 (숫자)
			WritableCellFormat integerFormat = new WritableCellFormat (NumberFormats.FLOAT); 
			
			NumberFormat fiveformat = new NumberFormat("0.000000");
			   WritableCellFormat userformat = new WritableCellFormat(fiveformat);
			   userformat.setBorder(Border.ALL, BorderLineStyle.THIN);
			   userformat.setBorder(Border.ALL, BorderLineStyle.THIN);
			
			//시트생성
			WritableSheet sheet1 =workbook.createSheet("안전길 좌표 추출", 0);
			
			int row = sheet1.getRows();
			int col = sheet1.getColumns();
			
			//Label 객체 생성(행, 열, 내용)
			Label label1 = new Label(0, 0, "명칭",textFormatSub);
			Label label2 = new Label(1, 0, "X 좌표",textFormatSub);
			Label label3 = new Label(2, 0, "Y 좌표",textFormatSub);
			Label label4 = new Label(3, 0, "색상",textFormatSub);
			Label label5 = new Label(4, 0, "수치",textFormatSub);
			Label label6 = new Label(5, 0, "정보분류",textFormatSub);

			//엑셀 디자인
			sheet1.setColumnView(0, 18);
			sheet1.setColumnView(1, 18);
			sheet1.setColumnView(2, 18);
			sheet1.setColumnView(3, 18);
			sheet1.setColumnView(4, 18);
			sheet1.setColumnView(5, 18);
			
			//셀에 레이블 추가
			sheet1.addCell(label1);
			sheet1.addCell(label2);
			sheet1.addCell(label3);
			sheet1.addCell(label4);
			sheet1.addCell(label5);
			sheet1.addCell(label6);
			
			List<ThematicExcelWriteVo> thematicExcelWriteList = new ArrayList<ThematicExcelWriteVo>();
			try{
			
			for(int i=0;i<xSplit.length;i++){
				xResult = ySplit[i];
				yResult = xSplit[i];
			
				ThematicExcelWriteVo thematicExcelWriteVo = new ThematicExcelWriteVo(xResult,yResult);		

				//System.out.println("label8 : " + xResult);
				thematicExcelWriteList.add(thematicExcelWriteVo);
				
				Label label7 = new Label(0, i+1, "",textFormat); //명칭NO
				Label label8 = new Label(1, i+1, xResult,textFormat); //y좌표
				Label label9 = new Label(2, i+1, yResult,textFormat); //y좌표
				Label label10 = new Label(3, i+1, "",textFormat); 
				Label label11 = new Label(4, i+1, "",textFormat); 
				Label label12 = new Label(5	, i+1, "",textFormat); 
				
				sheet1.addCell(label7);
				sheet1.addCell(label8);
				sheet1.addCell(label9);
				sheet1.addCell(label10);
				sheet1.addCell(label11);
				sheet1.addCell(label12);
			}

			//쓰기
			workbook.write();
			
			//닫기
			workbook.close();	
			
			}catch(Exception e){
				e.printStackTrace();
				System.out.println("잘못된 추출");
			}
			model.addAttribute("thematicExcelWriteList", thematicExcelWriteList);	
			model.addAttribute("xPoint", pointX);
			model.addAttribute("yPoint", pointY);
			return "jsp/thematic/thematicExcelWrite";
		}
	

	
	@RequestMapping("/safetyRoad.do")
	public String safetyRoadMain(){

		return "jsp/safety/safety";
	}
	
	@RequestMapping(value="/safetyRoadExcel.do", method=RequestMethod.POST)
	public ModelAndView safetyRoadExcel(HttpServletRequest request, HttpServletResponse response,MultipartHttpServletRequest mrRequest) {

		String name =null; //시설명칭
		String pointX =null; //시군구명
		String pointZ =null; //시군구명
		String pointY = null; //읍면동명
		String modelNo = null; //읍면동명
		String lightSize = null; //광원
		
		MultipartFile file = mrRequest.getFile("safetyFile");
		String fileName = file.getOriginalFilename();
		File uploadFile = new File(filePath + fileName);
		
		if(uploadFile.exists()){
//			fileName = new Date().getTime() + fileName;
			uploadFile = new File(filePath + fileName);
		}
		try {
			file.transferTo(uploadFile);
		} catch (Exception e) {
			
		}
		//System.out.println(uploadFile);
		ModelAndView mav = null;

		try {
		
			ExcelUtil excelUtil = new ExcelUtil(); 
			List<HashMap<String, String>> result = excelUtil.thematicExcel(filePath,fileName);
			//System.out.println(filePath+"/"+fileName);

			List<SafetyExcelVo> safetyExcelList = new ArrayList<SafetyExcelVo>(); // 여기 리스트에 VO 추가

				for (int i=1; i<result.size(); i++){
					HashMap<String, String> map = (HashMap<String, String>)result.get(i);

					name = map.get("COL0"); //명칭
					pointX = map.get("COL1"); //X좌표
					pointZ = map.get("COL2"); //X좌표
					pointY = map.get("COL3"); //Y좌표
					modelNo = map.get("COL4"); //모델링번호
					lightSize = map.get("COL5"); //광원	
					
					/*
					name = name.replaceAll(" ","");
					pointX = pointX.replaceAll(" ","");
					pointY = pointY.replaceAll(" ","");
					heightSize = heightSize.replaceAll(" ","");
					lightSize = lightSize.replaceAll(" ","");*/
/*					if(heightSize == "3"){
						heightSize = "30";
					}else if(heightSize == "3.5"){
						heightSize ="35";
					}else if(heightSize == "4"){
						heightSize ="40";
					}else if(heightSize == "4.5"){
						heightSize ="45";
					}else{
						heightSize ="00";
						System.out.println("값잘못들어간다 : " + heightSize);
					}*/
/*					System.out.println("heightSize : " + heightSize);
					System.out.println("modelNo : " + modelNo);
					System.out.println("lightSize : " + lightSize);*/
					SafetyExcelVo safetyExcelVo = new SafetyExcelVo(name, pointX, pointZ, pointY, modelNo, lightSize);
					safetyExcelList.add(safetyExcelVo);
				}

			mav = new ModelAndView();
			mav.addObject("safetyExcelList",safetyExcelList);
//			mav.setViewName("redirect:thematic.do");
			mav.setViewName("jsp/safety/safety");

		} catch (IOException e1) {
			e1.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	
	//엑셀 추출!!
	@RequestMapping("/safetyWrite.do")
	public String safetyWriteMain(Model model,HttpServletRequest request) throws IOException, Exception{
		int cnt = 0;
		String pointX = request.getParameter("xPoint");
		String pointZ = request.getParameter("zPoint");
		String pointY = request.getParameter("yPoint");
		String[] xSplit = pointX.split(",");
		String[] zSplit = pointZ.split(",");
		String[] ySplit = pointY.split(",");
		String xResult="";
		String zResult="";
		String yResult="";
		
//		WritableWorkbook workbook = Workbook.createWorkbook(new File("c:/안전길 좌표추출.xls"));
		WritableWorkbook workbook = Workbook.createWorkbook(new File(safetyPath));
		
		// 셀형식
		WritableCellFormat textFormat = new WritableCellFormat(new WritableFont (WritableFont.ARIAL, 
                11, WritableFont.NO_BOLD,               //Bold 스타일
                false,                                 //이탤릭체여부
                UnderlineStyle.NO_UNDERLINE, //밑줄 스타일
                Colour.BLACK,                      //폰트 색
                ScriptStyle.NORMAL_SCRIPT)); //스크립트 스타일);
		
		// 셀제목 형식
		WritableCellFormat textFormatSub = new WritableCellFormat(new WritableFont (WritableFont.ARIAL, 
				11, WritableFont.BOLD,               //Bold 스타일
				false,                                 //이탤릭체여부
				UnderlineStyle.NO_UNDERLINE, //밑줄 스타일
				Colour.BLACK,                      //폰트 색
				ScriptStyle.NORMAL_SCRIPT)); //스크립트 스타일);
 
		// 생성
		textFormat.setAlignment(Alignment.CENTRE);
		textFormatSub.setAlignment(Alignment.CENTRE);
		// 테두리
		textFormat.setBorder(Border.ALL, BorderLineStyle.THIN);
		textFormatSub.setBorder(Border.ALL, BorderLineStyle.THIN);
		
		
		//셀형식 (숫자)
		WritableCellFormat integerFormat = new WritableCellFormat (NumberFormats.FLOAT); 
		
		NumberFormat fiveformat = new NumberFormat("0.000000");
		   WritableCellFormat userformat = new WritableCellFormat(fiveformat);
		   userformat.setBorder(Border.ALL, BorderLineStyle.THIN);
		   userformat.setBorder(Border.ALL, BorderLineStyle.THIN);
		
		//시트생성
		WritableSheet sheet1 =workbook.createSheet("안전길 좌표 추출", 0);
		
		int row = sheet1.getRows();
		int col = sheet1.getColumns();
		
		//Label 객체 생성(행, 열, 내용)
		Label label1 = new Label(0, 0, "명칭",textFormatSub);
		Label label2 = new Label(1, 0, "X 좌표",textFormatSub);
		Label label3 = new Label(2, 0, "Z 좌표",textFormatSub);
		Label label4 = new Label(3, 0, "Y 좌표",textFormatSub);
		Label label5 = new Label(4, 0, "보안등",textFormatSub);
		Label label6 = new Label(5, 0, "조도분포도(m)",textFormatSub);

		//엑셀 디자인
		sheet1.setColumnView(0, 18);
		sheet1.setColumnView(1, 18);
		sheet1.setColumnView(2, 18);
		sheet1.setColumnView(3, 18);
		sheet1.setColumnView(4, 18);
		sheet1.setColumnView(5, 18);
		
		//셀에 레이블 추가
		sheet1.addCell(label1);
		sheet1.addCell(label2);
		sheet1.addCell(label3);
		sheet1.addCell(label4);
		sheet1.addCell(label5);
		sheet1.addCell(label6);
		
		List<SafetyExcelWriteVo> safetyExcelWriteList = new ArrayList<SafetyExcelWriteVo>();
		try{
		
		for(int i=0;i<xSplit.length;i++){
			cnt = cnt+1;
			xResult = xSplit[i];
			zResult = zSplit[i];
			yResult = ySplit[i];
		
			SafetyExcelWriteVo safetyExcelWriteVo = new SafetyExcelWriteVo(cnt,xResult,zResult,yResult);		

			//System.out.println("label8 : " + xResult);
			safetyExcelWriteList.add(safetyExcelWriteVo);
			
			Label label7 = new Label(0, i+1, Integer.toString(cnt),textFormat); //명칭NO
			Label label8 = new Label(1, i+1, xResult,textFormat); //y좌표
			Label label9 = new Label(2, i+1, zResult,textFormat); //y좌표
			Label label10 = new Label(3, i+1, yResult,textFormat); //y좌표
			Label label11 = new Label(4, i+1, "",textFormat); 
			Label label12 = new Label(5, i+1, "",textFormat); 
			
			sheet1.addCell(label7);
			sheet1.addCell(label8);
			sheet1.addCell(label9);
			sheet1.addCell(label10);
			sheet1.addCell(label11);
			sheet1.addCell(label12);
		}

		//쓰기
		workbook.write();
		
		//닫기
		workbook.close();	
		
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("잘못된 추출");
		}
		model.addAttribute("safetyExcelWriteList", safetyExcelWriteList);	
		model.addAttribute("cnt", cnt);
		model.addAttribute("xPoint", pointX);
		model.addAttribute("zPoint", pointZ);
		model.addAttribute("yPoint", pointY);
		return "jsp/safety/safetyExcelWrite";
	}
	
	
/*	@RequestMapping("/safetyWrite.do")
	public ModelAndView safetyWriteMain(HttpServletRequest request){
		String xPoint = request.getParameter("xPoint");
		String yPoint = request.getParameter("yPoint");
		
		System.out.println("xPoint : " + xPoint);
		String[] xSplit = xPoint.split(","); 
		String[] ySplit = yPoint.split(",");
		System.out.println("aa : "+ xSplit);
		System.out.println("bb"+xSplit[1]);
		System.out.println("cc"+xSplit[2]);
		
		
//		String[] xPoint = request.getParameterValues("xPoint");
//		String[] yPoint = request.getParameterValues("yPoint");
		
		
		String xResult="";
		String yResult="";
		
		//System.out.println("xSplit : " + xSplit);
		//System.out.println("ySplit : " + ySplit);

		ModelAndView mav = new ModelAndView();
		for(int i=0;i<xSplit.length;i++){
			xResult = xResult+xSplit[i];
			//mav.addObject("xPoint",xPoint);
//			System.out.println("xResult : " + xResult);
		}
		for(int i=0;i<ySplit.length;i++){
			yResult = yResult+ySplit[i];
			//mav.addObject("yPoint",yPoint);
//			System.out.println("yResult : " + yResult);
		}

		mav.setViewName("jsp/safety/safetyExcelWrite");
		return mav;
	}*/
	
	
	

	private String makeBon(String bonCD){
		if(bonCD.length()>0){
			bonCD=makeFourNumber(bonCD);

		}else{
			bonCD=makeFourNumber(bonCD);
		}
		return bonCD;
	}
	private String makeBoo(String booCD){		
		if(booCD.length()>0){
			booCD=makeFourNumber(booCD);
		}else{
			booCD=makeFourNumber(booCD);
		}
		return booCD;
	}
	private String makeFourNumber(String value){
		String str=value.trim();
		int idx=str.length();
		for(int i=0;i<4-idx;i++){
			str="0"+str;
		}
		return str;
	}
}
