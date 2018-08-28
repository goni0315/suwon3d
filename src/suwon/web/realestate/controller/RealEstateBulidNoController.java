package suwon.web.realestate.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

import net.sf.json.JSONArray;

import org.apache.commons.codec.binary.Base64;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gpki.gpkiapi.GpkiApi;
import com.gpki.gpkiapi.cert.X509Certificate;
import com.gpki.gpkiapi.cms.EnvelopedData;
import com.gpki.gpkiapi.crypto.PrivateKey;
import com.gpki.gpkiapi.exception.GpkiApiException;
import com.gpki.gpkiapi.storage.Disk;

@Controller
public class RealEstateBulidNoController {
	/**
	 *	건물 식별번호
	 * @param request
	 * @param response
	 * @return
	 * @throws GpkiApiException 
	 */
	static String xml = "";
	@RequestMapping("/realEstateBulidNo.do")
	@ResponseBody
	public JSONArray realEstateBulidNo(HttpServletRequest request, HttpServletResponse response) throws GpkiApiException{
		String pnu = (String)request.getParameter("pnu");
		String bulidNo = landBulidNoInfo(pnu);
		//String[] bulidNo = {"172904"};
		//System.out.println("bulidNo : " + bulidNo + " / / pnu : " + pnu);
		JSONArray jsonArray = new JSONArray();
		jsonArray.add(bulidNo);
		return jsonArray;
	}

	/**
	 * @return 
	 * @throws GpkiApiException 
	 */
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
		if(!sortLand("MESSAGE").equals("SUCCESS&")){
			build_NO = sortLand("MESSAGE");
		}else{
			//소재지
			build_NO += sortLand("BLDG_GBN_NO");
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
