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
public class RealEstateUsuallyHeaderController {
	private ApplicationContext context = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private BuildInfoSearchService buildInfoSearchService = (BuildInfoSearchService) context.getBean("buildInfoSearchService");
	/**
	 *	일반표제부
	 * @param request
	 * @param response
	 * @return
	 * @throws GpkiApiException 
	 */
	static String xml = "";
	@RequestMapping("/realEstateUsuallyHeader.do")
	public ModelAndView realEstateUsuallyHeader(HttpServletRequest request, HttpServletResponse response) throws GpkiApiException{
		String pnu = (String)request.getParameter("pnu");
		String landUsuallyHeader = landUsuallyHeaderInfo(pnu);
		//String landUsuallyHeader = "1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,& ,1.기숙사,10.동측강의동,11.학군단강의동,12.변전실,13.실험동,14.인문사회관,대강의동,15.수위실,16.본관,17.도서관,18.기숙사,19.기숙사식당,2.본관[제1이공관],20.교육연구동(송재관),21.파워플랜트,22.팔달관,23.부속병원(본관),24.병원영안실,26.전자계산소,27.종합연구소,28.기숙사[제3생활관]A동,29.기숙사[제3생활관]B동,3.서관,30.의과대학,31.체육관,32.국가지정연구소,33동,34.산학협력원,35.정문화장실,36.토목실험동및영상표시연구소,37.대형지반 연구실험동,38.토목실험동창고-2,42.폐기물 보관소,43.버스관리소,45.동물사육장,47.테니스장 관리동,49.화공실험동 창고,5.학생회관,50.식당창고,52.신학생회관,53.교량실험실동,54.종합관,55.종합설계동,56.비품창고 1동,57.비품창고 2동,58.임상수기센터 및 실험동물센터,59.약학대약학관,6.실습공장,국제학사, , ,&아주대학교, , , , , , , , , , , , , , , ,원천동 5-1 의료시설 (학교법인대우학원), , , , , , , , , , , , , , , , , , , , , , , , ,아주대학교,아주대학교,아주대학교,아주대학교, , , ,아주대학교,창현고등학교,의과대학,&총괄,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,일반,& ,4121.53,1991.62,1418.49,396,1759.47,7571.68,50.28,13120.03,13311.67,5416.09,2910.225,11283.99,19120.22,2483.75,15683.88,101627.45,36,5115.39,11147.2,5873.9,6647.19,4893.18,38197.9,6991.79,1492.86,230,10714.77,62.38,1485.21,500.17,35.11,95.92,34.56,172.8,63.36,50.84,4000.17,54.26,5180.87,600,25757.21,745.63,330,330,4268.39,3967.86,4266.08,10096.78,7480.08, ,";
		
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
		mav.addObject("landUsuallyHeader", landUsuallyHeader);
		mav.setViewName("/jsp/realEstate/realEstateUsuallyHeader");
		
		return mav;
	}

	/**
	 * @return 
	 * @throws GpkiApiException 
	 */
	public static String landUsuallyHeaderInfo(String args) throws GpkiApiException {
		//System.out.println("args : " + args);
		// TODO Auto-generated method stub
		RealEstateUsuallyHeaderController kct = new RealEstateUsuallyHeaderController();
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
		xml = kct.getKRAS000102(sgg,emd,san,bobn,bubn);
		
		/* 
		 * 개인정보가 포함되는 경우는 데이터가 암호화 되므로 gpki 로 복호화해야 함 
		 * 테스트 서버는 현재 암호화를 진행하지 않고 있음
		 */
		if(gpkiflag){
			xml = kct.decrypt(xml);
		}
		
		String landInfo = "";
		//응답메세지 처리
		if(!sortLandBulidInfo("MESSAGE").equals("SUCCESS,")){
			landInfo = sortLandBulidInfo("MESSAGE");
		}else{
			//건물종류코드
			landInfo += sortLandBulidInfo("BLDG_KIND_CD") + "&";
			//동명칭
			landInfo += sortLandBulidInfo("DONG_NM") + "&";
			//건물명칭
			landInfo += sortLandBulidInfo("BLDG_NM") + "&";
			//건물종류명
			landInfo += sortLandBulidInfo("BLDG_KIND_NM") + "&";
			//연면적
			landInfo += sortLandBulidInfo("GAREA");
		}
		System.out.println("일반표제부 : " +landInfo);
		
		return landInfo;
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
	public static String sortLandBulidInfo(String searchValue) {
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
				if(textNode != null){
					resultList += textNode.getNodeValue() + ",";
				}else{
					resultList += " ,";
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			
		}
		
		return resultList;
	}

}
