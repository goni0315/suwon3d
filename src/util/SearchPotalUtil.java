package util;

//네이버 검색 API 예제 - blog 검색
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class SearchPotalUtil {

 public static void main(String[] args) {
     String clientId = "hWB4M5y5P_fPowNBamLl";//애플리케이션 클라이언트 아이디값";
     String clientSecret = "iTjZeScUPC";//애플리케이션 클라이언트 시크릿값";
     try {
         String text = URLEncoder.encode("수원시 수원시청", "UTF-8");
         String apiURL = "https://openapi.naver.com/v1/search/local.xml?query="+ text; // json 결과
         //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // xml 결과
         URL url = new URL(apiURL);
         HttpURLConnection con = (HttpURLConnection)url.openConnection();
         con.setRequestMethod("GET");
         con.setRequestProperty("X-Naver-Client-Id", clientId);
         con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
         int responseCode = con.getResponseCode();
         BufferedReader br;
         if(responseCode==200) { // 정상 호출
             br = new BufferedReader(new InputStreamReader(con.getInputStream()));
         } else {  // 에러 발생
             br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
         }
         String inputLine;
         StringBuffer response = new StringBuffer();
         while ((inputLine = br.readLine()) != null) {
             response.append(inputLine);
         }
         br.close();
         System.out.println(response.toString());
     } catch (Exception e) {
         System.out.println(e);
     }
 }
}