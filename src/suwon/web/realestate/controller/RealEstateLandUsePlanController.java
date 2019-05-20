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
public class RealEstateLandUsePlanController {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private BuildInfoSearchService buildInfoSearchService = (BuildInfoSearchService) context.getBean("buildInfoSearchService");
	/**
	 *	토지이용계획
	 * @param request
	 * @param response
	 * @return
	 * @throws GpkiApiException 
	 */
	static String xml = "";
	@RequestMapping("/realEstateLandUsePlan.do")
	public ModelAndView realEstateLandUsePlan(HttpServletRequest request, HttpServletResponse response) throws GpkiApiException{
		String pnu = (String)request.getParameter("pnu");
		String landUsePlan = landUsePlanInfo(pnu);
		//String landUsePlan = "경기도 수원시 팔달구 인계동 &1111번지&대&21677.4&도시지역, 중심상업지역, 방화지구, 일반미관지구, 제1종지구단위계획구역, 공공청사, 광로2류(접함), 소로1류(접함), 소로2류(접함)&가축사육제한구역<가축분뇨의 관리 및 이용에 관한 법률>, 비행안전제6구역(전술)<군사기지 및 군사시설 보호법> &";
		
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
		mav.addObject("landUsePlan", landUsePlan);
		mav.setViewName("/jsp/realEstate/realEstateLandUsePlan");
		
		return mav;
	}

	/**
	 * @return 
	 * @throws GpkiApiException 
	 */
	public static String landUsePlanInfo(String args) throws GpkiApiException {
		//System.out.println("args : " + args);
		// TODO Auto-generated method stub
		RealEstateLandUsePlanController kct = new RealEstateLandUsePlanController();
		boolean gpkiflag = false;
		
		String sgg = args.substring(0,5);
		String emd = args.substring(5,10);
		String san = args.substring(10,11);
		String bobn = args.substring(11,15);
		String bubn = args.substring(15);
		
		/*System.out.println("sgg : " + sgg);
		System.out.println("emd : " + emd);
		System.out.println("bobn : " + bobn);
		System.out.println("bubn : " + bubn);*/
		
		//System.out.println ("SVC1000104".endsWith("0104") );
		
		/* 서버에서 정보 요청 */
		xml = kct.getKRAS000026(sgg,emd,san,bobn,bubn);
		
		/* 
		 * 개인정보가 포함되는 경우는 데이터가 암호화 되므로 gpki 로 복호화해야 함 
		 * 테스트 서버는 현재 암호화를 진행하지 않고 있음
		 */
		if(gpkiflag){
			xml = kct.decrypt(xml);
		}
		
		String landInfo = "";
		
		//응답메세지 처리
		if(!sortLand("MESSAGE").equals("SUCCESS")){
			landInfo = sortLand("MESSAGE");
		}else{
			//소재지
			landInfo += sortLand("LAND_LOC_NM")+ "&";
			//지번
			landInfo += sortLand("JIBN")+ "&";
			//지목명
			landInfo += sortLand("JIMOK_NM")+ "&";
			//면적
			landInfo += sortLand("PAREA")+ "&";
			/*지역지구등 지정여부*/
			//국토의 계획
			landInfo += sortLand("USELAW_A")+ "&";
			//다른 법령
			landInfo += sortLand("USELAW_B")+ "&";
			//토지이용규제
			landInfo += sortLand("USELAW_D")+ "&";		
		}
		System.out.println("토지이용계획 : " +landInfo);
		
		return landInfo;
	}
	
	public String getKRAS000026 (String sgg,String emd,String san,String bobn,String bubn){
	    URLConnection connection = null;
	    String strText = null;
	    String rStrText = null;
	    try 
	    {
	    	
	    //	URL serverAddress = new URL("http://10.175.82.244/conn/estateGateway");		// 중앙 운영 URL
		//	URL serverAddress = new URL("http://10.47.4.14:8085/conn/estateGateway");	// 시군구 개발 URL
			URL serverAddress = new URL("http://105.1.2.130:8385/conn/estateGateway");	// 수원시 부동산 종합공부
			connection = null;
			String param 
				//     = "conn_sys_id=SYS0000099"  // 개발용으로 제공받은 ID
				= "conn_sys_id=KQNX-UNEU-259K-WNO5"  // 3차원활용시스템 ID
				+ "&adm_sect_cd=" + sgg         
				+ "&conn_svc_id=KRAS000026"  // 3차원활용시스템 ID
				+ "&gpki_id=" 
				+ "&land_loc_cd=" + emd 
				+ "&ledg_gbn=" + san 
				+ "&bobn=" + bobn
				+ "&bubn=" + bubn
				+ "&iss_read_gbn=0000"
				+ "&fee="
				+ "&iss_cnt=1"
				+ "&map_width=100"
				+ "&map_height=100"
				+ "&legend_width=100"
				+ "&legend_height=100"
				+ "&iss_scal=1";
	
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
			rStrText = new String(strText.getBytes(), "EUC-KR");
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
