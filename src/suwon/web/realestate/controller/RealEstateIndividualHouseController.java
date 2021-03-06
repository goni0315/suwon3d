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

import org.apache.commons.codec.binary.Base64;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.gpki.gpkiapi.GpkiApi;
import com.gpki.gpkiapi.cert.X509Certificate;
import com.gpki.gpkiapi.cms.EnvelopedData;
import com.gpki.gpkiapi.crypto.PrivateKey;
import com.gpki.gpkiapi.exception.GpkiApiException;
import com.gpki.gpkiapi.storage.Disk;

import suwon.web.Service.BuildInfoSearchService;
import suwon.web.vo.BuildSearchVo;

@Controller
public class RealEstateIndividualHouseController {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private BuildInfoSearchService buildInfoSearchService = (BuildInfoSearchService) context.getBean("buildInfoSearchService");
	/**
	 *	개별주택
	 * @param request
	 * @param response
	 * @return
	 * @throws GpkiApiException 
	 */
	static String xml = "";
	@RequestMapping("/realEstateIndividualHouse.do")
	public ModelAndView realEstateLandIndividualHouse(HttpServletRequest request, HttpServletResponse response) throws GpkiApiException{
		String pnu = (String)request.getParameter("pnu");
		String bulidNo = landBulidNoInfo(pnu);
		String landIndividualHouse = landIndividualHouseInfo(pnu,bulidNo);
		//String landIndividualHouse = "2014,2013,2012,2011,2010,2009,2008,2007,2006,2005,&245000000,248000000,252000000,236000000,237000000,238000000,241000000,240000000,227000000,212000000,&207,207,207,207,207,207,207,207,207,207,&890.06,890.06,890.06,890.06,890.06,890.06,890.06,890.06,890.06,890.06,";
		
		ModelAndView mav = new ModelAndView();
		String bul_man_no = (String)request.getParameter("bul_man_no");
		List<BuildSearchVo> buildList=null;	
		 if(bul_man_no!=null){

			 buildList = buildInfoSearchService.getBuildInfoList(bul_man_no);
			 mav.addObject("buildList", buildList);
				mav.addObject("bul_man_no", bul_man_no);
			 //System.out.println("buildList2:::::::"+buildList);
		 }
		 
		 if(pnu!=null){
			 mav.addObject("pnu", pnu);
		 }
		mav.addObject("landIndividualHouse", landIndividualHouse);
		mav.setViewName("/jsp/realEstate/realEstateIndividualHouse");
		
		return mav;
	}

	/**
	 * @return 
	 * @throws GpkiApiException 
	 */
	public static String landIndividualHouseInfo(String args,String bulidNo) throws GpkiApiException {
		//System.out.println("pnu : " + pnu);
		// TODO Auto-generated method stub
		RealEstateIndividualHouseController kct = new RealEstateIndividualHouseController();
		boolean gpkiflag = false;
		
		String sgg = args.substring(0,5);
		String emd = args.substring(5,10);
		String san = args.substring(10,11);
		String bobn = args.substring(11,15);
		String bubn = args.substring(15);
		String buldnum = bulidNo;
		
		//System.out.println ("SVC1000104".endsWith("0104") );
		
		/* 서버에서 정보 요청 */
		xml = kct.getKRAS000033(sgg,emd,san,bobn,bubn,buldnum);
		
		/* 
		 * 개인정보가 포함되는 경우는 데이터가 암호화 되므로 gpki 로 복호화해야 함 
		 * 테스트 서버는 현재 암호화를 진행하지 않고 있음
		 */
		if(gpkiflag){
			xml = kct.decrypt(xml);
		}
		
		String landInfo = "";
		//응답메세지 처리
		if(!sortLand("MESSAGE").equals("SUCCESS,")){
			landInfo = sortLand("MESSAGE");
		}else{
			//연도
			landInfo += sortLand("BASE_YEAR")+ "&";
			//주택가격
			landInfo += sortLand("INDI_HOUSE_PRC")+ "&";
			//토지면적
			landInfo += sortLand("LAND_AREA")+ "&";
			//건물면적
			landInfo += sortLand("BLDG_AREA");
		}
		System.out.println("개별주택 : " +landInfo);
		
		return landInfo;
	}
	
	public String getKRAS000033 (String sgg,String emd,String san,String bobn,String bubn,String buldnum){
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
				= "conn_svc_id=KRAS000033" 
		         + "&adm_sect_cd=" + sgg
		         + "&conn_sys_id=KQNX-UNEU-259K-WNO5"  // 3차원활용시스템 ID
		         + "&gpki_id="
		         + "&land_loc_cd=" + emd
		         + "&ledg_gbn="+ san 
		         + "&bobn=" + bobn 
		         + "&bubn=" + bubn
				 + "&srch_bgn_year="
				 + "&srch_end_year="
				 + "&take_ymd="
				 + "&bldg_gbn_no=" + buldnum;
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
			//System.out.println("strText : " + strText);
	    } 	  
	    catch(Exception e){
	    	e.printStackTrace();
	    }
	    return strText;
	}
	
	public String decrypt(String stText) throws GpkiApiException{
		
		/* 우선 Base64로 디코딩 */
		byte[] decoded = Base64.decodeBase64(stText);
		
		
		X509Certificate psignerCert;
 		PrivateKey psignerKey;
	 	byte[] outData = null;
		EnvelopedData envData = null;
		 
		/* 서버인증서 정보를 읽어서 복호화 */
		GpkiApi.init("라이센스파일경로");
		psignerCert  =Disk.readCert("서버인증서.cer");
		psignerKey = Disk.readPriKey("인증서이름.key", "인증서비밀번호");
		envData = new EnvelopedData("NEAT");  // NEAT 알고리즘으로 암호화 
		
		outData = envData.process(decoded,psignerCert,psignerKey );
		
		return new String(outData);
	}
	
	//xml 에서 원하는 태그 값 돌출
	public static String sortLand(String searchValue) {
		//결과값 리턴 변수
		String resultList = "";
		
		try{
			
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			
			//String 문자열을 xml 문서로 인식 하게 하는 작업
			Document document = builder.parse(new InputSource(new StringReader(xml)));
			NodeList nodelist = document.getElementsByTagName(searchValue);
			
			//nodelist의 크기를 구하려면 getLength()라는 메소드가 있음
			
			//Node node = nodelist.item(0);//첫번째 element 얻기
			Node textNode = null;
			int nodeLen = nodelist.getLength();
			for(int i=0;i <=nodeLen-1;i++){
				textNode = nodelist.item(i).getChildNodes().item(0);
				resultList += textNode.getNodeValue() + ",";
			}
		}catch(Exception e){
			e.printStackTrace();
			
		}
		
		return resultList;
	}
	
	public static String landBulidNoInfo(String args) throws GpkiApiException {
		//System.out.println("args : " + args);
		// TODO Auto-generated method stub
		RealEstateBulidNoController kct = new RealEstateBulidNoController();
		boolean gpkiflag = false;
		
		String sgg = args.substring(0,5);
		String emd = args.substring(5,10);
		String san = args.substring(10,11);
		String bobn = args.substring(11,15);
		String bubn = args.substring(15);
		
		//System.out.println ("SVC1000104".endsWith("0104") );
		
		/* 서버에서 정보 요청 */
		xml = kct.getKRAS000102(sgg,emd,san,bobn,bubn);
		

		
		String build_NO = "";
		
		//응답메세지 처리
		if(!sortLandBuldNo("MESSAGE").equals("SUCCESS&")){
			build_NO = sortLandBuldNo("MESSAGE");
		}else{
			//소재지
			build_NO += sortLandBuldNo("BLDG_GBN_NO");
		}
		//System.out.println("build_NO : " +build_NO);
		
		return build_NO;
	}
	
	public String getKRAS000102 (String sgg,String emd,String san,String bobn,String bubn){
	    URLConnection connection = null;
	    String strText = null;
	    
	    try 
	    {
	    	
	    //	URL serverAddress = new URL("http://10.175.82.244/conn/estateGateway");		// 중앙 운영 URL
		//	URL serverAddress = new URL("http://10.47.4.14:8085/conn/estateGateway");	// 시군구 개발 URL
			URL serverAddress = new URL("http://105.1.2.130:8385/conn/estateGateway");	// 수원시 부동산 종합공부
			connection = null;
			String param 
			= "conn_svc_id=KRAS000102" 
			         + "&adm_sect_cd=" + sgg
			         + "&conn_sys_id=KQNX-UNEU-259K-WNO5"  // 3차원활용시스템 ID
			         + "&gpki_id=" 
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
	
	//xml 에서 원하는 태그 값 돌출
	public static String sortLandBuldNo(String searchValue) {
		//결과값 리턴 변수
		String resultValue = "";
		
		try{
			
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			
			//String 문자열을 xml 문서로 인식 하게 하는 작업
			Document document = builder.parse(new InputSource(new StringReader(xml)));
			NodeList nodelist = document.getElementsByTagName(searchValue);
			
			//nodelist의 크기를 구하려면 getLength()라는 메소드가 있음
			Node textNode = null;
			//int nodeLen = nodelist.getLength();
			//for(int i=0;i <=nodeLen-1;i++){
				textNode = nodelist.item(0).getChildNodes().item(0);
				resultValue += textNode.getNodeValue();
			//}
		}catch(Exception e){
			e.printStackTrace();
			
		}
		
		return resultValue;
	}
}
