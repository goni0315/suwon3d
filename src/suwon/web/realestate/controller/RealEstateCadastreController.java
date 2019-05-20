package suwon.web.realestate.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.gpki.gpkiapi.exception.GpkiApiException;

import suwon.web.Service.BuildInfoSearchService;
import suwon.web.vo.BuildSearchVo;


@Controller
public class RealEstateCadastreController {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private BuildInfoSearchService buildInfoSearchService = (BuildInfoSearchService) context.getBean("buildInfoSearchService");

	/**
	 *	토지대장
	 * @param request
	 * @param response
	 * @return
	 * @throws GpkiApiException 
	 */
	static String xml = "";
	 	
	@RequestMapping("/realEstateCadastre.do")
	public ModelAndView realEstateCadastre(HttpServletRequest request, HttpServletResponse response) throws GpkiApiException{
	
		String pnu = (String)request.getParameter("pnu");
		String bul_man_no = (String)request.getParameter("bul_man_no");
		
		String landCadastre = landCadastreInfo(pnu);
		//String landCadastre = "1111대&08&대&21677.4&경기도 수원시 권선구 에서 행정관할구역변경&1993-02-01& &0&소유권보존&군유지&0&*****& &1989-12-16&02&11690000& &232&19940101& ";
		
		ModelAndView mav = new ModelAndView();
		List<BuildSearchVo> buildList=null;	
		 if(bul_man_no!=null){

			 buildList = buildInfoSearchService.getBuildInfoList(bul_man_no);
			 mav.addObject("bul_man_no", bul_man_no);
			 mav.addObject("buildList", buildList);
			 //System.out.println("buildList2:::::::"+buildList);
		 }
//		 else{						 
//			 buildList = buildInfoSearchService.getBuildInfoList(bul_man_no);	 
//		 }
		 
		 if(pnu!=null){
			 mav.addObject("pnu", pnu);
		 }
		 
		mav.addObject("landCadastre", landCadastre);
		mav.setViewName("/jsp/realEstate/realEstateCadastre");
		
		return mav;
	}

	/**
	 * @return 
	 * @throws GpkiApiException 
	 */
	public static String landCadastreInfo(String args) throws GpkiApiException {
		//System.out.println("args : " + args);
		// TODO Auto-generated method stub
		RealEstateCadastreController kct = new RealEstateCadastreController();
		
		String sgg = args.substring(0,5);
		String emd = args.substring(5,10);
		String san = args.substring(10,11);
		String bobn = args.substring(11,15);
		String bubn = args.substring(15);
		

		
		/* 서버에서 정보 요청 */
		xml = kct.getKRAS000002(sgg,emd,san,bobn,bubn);

		String landInfo = "";
		//응답메세지 처리
		if(!sortLand("MESSAGE").equals("SUCCESS")){
			landInfo = sortLand("MESSAGE");
		}else{
			//지번
			if(Integer.parseInt(sortLand("BUBN")) == 0){
				landInfo = Integer.parseInt(sortLand("BOBN")) + sortLand("JIMOK_NM")+ "&";
			}else{
				landInfo = Integer.parseInt(sortLand("BOBN")) + "-" + Integer.parseInt(sortLand("BUBN")) + sortLand("JIMOK_NM")+ "&";
			}
			//지목코드
			landInfo += sortLand("JIMOK")+ "&";
			//지목명
			landInfo += sortLand("JIMOK_NM")+ "&";
			//면적
			landInfo += sortLand("PAREA")+ "&";
			//최종토지이동사유
			landInfo += sortLand("LAND_MOV_RSN_CD_NM")+ "&";
			//최종토지이동일자
			landInfo += sortLand("LAND_MOV_YMD")+ "&";
			//토지이동관련지번
			landInfo += sortLand("OWNER_ADDR")+ "&";
			//사업시행신고 구분
			landInfo += sortLand("BIZ_ACT_NTC_GBN")+ "&";
			//최종소유권변동사유
			landInfo += sortLand("OWN_RGT_CHG_RSN_CD_NM")+ "&";		
			//소유구분명
			landInfo += sortLand("OWN_GBN_NM")+ "&";
			//공유인수
			landInfo += sortLand("SHR_CNT")+ "&";
			//소유자명
			landInfo += sortLand("OWNER_NM")+ "&";
			//소유자주소
			landInfo += sortLand("OWNER_ADDR")+ "&";
			//최종소유권변동일자
			landInfo += sortLand("OWNDYMD")+ "&";
			//최종토지이동연혁순번
			landInfo += sortLand("LAND_LAST_HIST_ODRNO")+ "&";
			//최종소유권변동연혁순번
			landInfo += sortLand("LAST_JIBN")+ "&";
			//관련집합건물
			landInfo += sortLand("BLDG_GBN_NO")+ "&";
			//토지등급
			landInfo += sortLand("GRD")+ "&";
			//토지등급변동일자
			landInfo += sortLand("GRD_YMD") + "&";
		}
		System.out.println("토지대장 : " +landInfo);
		
		return landInfo;
	}
	
	public String getKRAS000002 (String sgg,String emd,String san,String bobn,String bubn){
	    URLConnection connection = null;
	    String strText = null;
	    
	    try 
	    {
	    	
	    //	URL serverAddress = new URL("http://10.175.82.244/conn/estateGateway");		// 중앙 운영 URL
		//	URL serverAddress = new URL("http://10.47.4.14:8085/conn/estateGateway");	// 시군구 개발 URL
			URL serverAddress = new URL("http://105.1.2.130:8385/conn/estateGateway");	// 수원시 부동산 종합공부
			connection = null;
			String param 
			//     = "conn_sys_id=SYS0000099"  // 개발용으로 제공받은 ID
				= "conn_sys_id=KQNX-UNEU-259K-WNO5"  // 3차원활용시스템 ID
				+ "&conn_svc_id=KRAS000002" 
				+ "&adm_sect_cd=" + sgg         
				+ "&land_loc_cd=" + emd 
				+ "&ledg_gbn=" + san 
				+ "&bobn=" + bobn 
				+ "&bubn=" + bubn;

			connection = (HttpURLConnection)serverAddress.openConnection();
			connection.setDoOutput(true);
			connection.connect();
					
			OutputStream ops = (OutputStream) connection.getOutputStream();
			ops.write(param.getBytes());
			ops.flush();
			ops.close();
			
	
			BufferedReader rd  = new BufferedReader(new InputStreamReader(connection.getInputStream(),"UTF-8"));
			StringBuffer sb = new StringBuffer();
			String line;
			while((line = rd.readLine()) != null) 
			{
				sb.append(line);
			}
			strText = sb.toString();
			
	    } 	  
	    catch(Exception e){
	    	e.printStackTrace();
	    }
	    return strText;
	}
	

	
	/**
	 * xml 에서 원하는 태그 값 돌출
	 * @param searchValue
	 * @return
	 */
	public static String sortLand(String searchValue) {
		//결과값 리턴 변수
		String resultValue = "";
		
		try{
			
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			
			//String 문자열을 xml 문서로 인식 하게 하는 작업
			Document document = builder.parse(new InputSource(new StringReader(xml)));
			NodeList nodelist = document.getElementsByTagName(searchValue);
			
			//nodelist의 크기를 구하려면 getLength()라는 메소드가 있음
			
			//Node node = nodelist.item(0);//첫번째 element 얻기
			Node textNode = nodelist.item(0).getChildNodes().item(0);
			//System.out.println("textNode.getNodeValue() : " + textNode.getNodeValue());
			if(textNode != null){
				resultValue = textNode.getNodeValue();
			}else{
				resultValue = " ";
			}
			
		}catch(Exception e){
			e.printStackTrace();
			
		}
		
		return resultValue;
	}
}
