/**
 * 
 */
package suwon.web.landdown;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

import org.codehaus.jackson.map.ObjectMapper;

  
public class PostURL {  
    public static void main(String[] args) {
    	String url =  "http://211.34.105.76:8090/api/fcst_sws.do?init_tm=201601122100&order_by=SM_BASIN_CD";
        
        String fileName = "C:\\fcst_sws.txt" ;
    	try {
	    	DefaultHttpClient httpclient = new DefaultHttpClient();
	    	HttpGet getRequest = new HttpGet(url);
	    	HttpResponse response = null;  	
	    	InputStream in;
	    	StringBuffer strBuf = new StringBuffer();
	    	
	    	//@SuppressWarnings("unchecked")
//			HashMap<String, Object> rs = new ObjectMapper().readValue(strBuf.toString(), HashMap.class) ;
//	    	System.out.println(rs) ;
	    	getRequest.addHeader("accept", "application/json");
			response = httpclient.execute(getRequest);
			in = response.getEntity().getContent();
			BufferedReader reader = new BufferedReader(new InputStreamReader(in));
			
			String line;
			line = reader.readLine();
			strBuf.append(line);
			reader.close();
			String str = strBuf.toString();
			
			str = str.substring(34);
			String[] arrStr = str.split("}]}");
			str = arrStr[0].replaceAll("\\}[,]\\{","\n");
			str = str.replaceAll("\"", "");
			// BufferedWriter 와 FileWriter를 조합하여 사용 (속도 향상)
            BufferedWriter fw = new BufferedWriter(new FileWriter(fileName, true));
            fw = new BufferedWriter(new FileWriter(fileName.toString())); // 덮어쓰기
            
            // 파일안에 문자열 쓰기
            fw.write(str);
            fw.flush();
           
            // 객체 닫기
            fw.close();
            
		} catch (IllegalStateException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		} 
    }
}  