package suwon.web.landdown;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

public class ShapeDown implements ServletContextListener{

	public ShapeDown(){}
	private static final int BUFFER_SIZE = 4096;
	//현재 날짜를 받아옴. 
	static Calendar t = Calendar.getInstance();

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		System.out.println("TomcatStop");
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
/*		ScheduledJob job = new ScheduledJob();
		int hour = (1000 * 60) * 60;
		int halfDay = hour * 12;
      	Timer jobScheduler = new Timer();
      	jobScheduler.scheduleAtFixedRate(job, 1000, halfDay);
	    //jobScheduler.cancel();
      	//1 일 , 2 월 , 3 화 , 4 수 , 5 목 , 6 금 , 7 토
  		if(t.get(Calendar.DAY_OF_WEEK) == 6){//토요일
*/  		System.out.println("=====LSMD_CONT_LDREG DOWNLOAD START=====");
  			try {	
				 //서버에서 정보 요청 
  				            //요청파일이름       요청IP         다운로드 경로                  파일 타입(2 ( .shp ) 3 ( .dbf ) 4 ( .shx ))
				downloadFile("LSMD_CONT_LDREG", "105.1.2.130", "D:\\Suwon3dSystem\\LAND_DOWN\\" , "2");
				downloadFile("LSMD_CONT_LDREG", "105.1.2.130", "D:\\Suwon3dSystem\\LAND_DOWN\\" , "3");
				downloadFile("LSMD_CONT_LDREG", "105.1.2.130", "D:\\Suwon3dSystem\\LAND_DOWN\\" , "4");	
				
				System.out.println("=====LSMD_CONT_LDREG DOWNLOAD END=====");
			} catch (Exception e) {
				
				e.printStackTrace();
				System.out.println("=====LSMD_CONT_LDREG DOWNLOAD ERROR=====");
			}
  		//}
	}
	/*public class ScheduledJob extends TimerTask {
		   
		   public void run() {
		      System.out.println(new Date());
		   }
		}*/
	
	//연속지적도 다운로드 
	public static void downloadFile(String layerName, String ip, String path, String type)throws IOException {
    	
        URL url = new URL("http://" + ip + ":8385/conn/estateGateway?" +
        		"conn_svc_id=KRAS000038" +  // shape 다운로드 서비스 
        		"&conn_sys_id=KQNX-UNEU-259K-WNO5" +  // 부여받은 시스템 아이디
        		"&adm_sect_cd=41115" +      // 시군구코드 5자리
        		"&layer_cd=" + layerName +  // 레이어명  ( MLTM. 은 제거해야 함 )
        		"&file_type=" + type);    // 2 ( .shp ) 3 ( .dbf ) 4 ( .shx )
       
        HttpURLConnection httpConn = (HttpURLConnection) url.openConnection();
        int responseCode = httpConn.getResponseCode();
 
        // always check HTTP response code first
        if (responseCode == HttpURLConnection.HTTP_OK) {
            String fileName = "";
            String disposition = httpConn.getHeaderField("Content-Disposition");
            String contentType = httpConn.getContentType();
            int contentLength = httpConn.getContentLength();
 
            if (disposition != null) {
                // extracts file name from header field
                int index = disposition.indexOf("fileName=");
                if (index > 0) {
                    fileName = disposition.substring(index + 9,
                            disposition.length() );
                }
            } 
            
            //System.out.println("Content-Type = " + contentType);
            //System.out.println("Content-Disposition = " + disposition);
            //System.out.println("Content-Length = " + contentLength);
            //System.out.println("fileName = " + fileName);
 
            if(fileName.contains(layerName) || fileName.contains("empty")){
	            // opens input stream from the HTTP connection
	            InputStream inputStream = httpConn.getInputStream();
	            String saveFilePath = path + todayDown() + "_" + fileName ;
	             
	            // opens an output stream to save into file
	            FileOutputStream outputStream = new FileOutputStream(saveFilePath);
	 
	            int bytesRead = -1;
	            byte[] buffer = new byte[BUFFER_SIZE];
	            while ((bytesRead = inputStream.read(buffer)) != -1) {
	                outputStream.write(buffer, 0, bytesRead);
	            }
	 
	            outputStream.close();
	            inputStream.close();
            }
 
            System.out.println(fileName + "_Downloaded");
        }
        httpConn.disconnect();
    }
	
	//현재 년월일 시분
	public static String todayDown() {
		
		//오늘날짜의 해당연도를 구함
		String year = Integer.toString(t.get(Calendar.YEAR));
		//오늘날짜의 해당 월을 구함. 1월은 0이기 때문에 + 1
		String month = Integer.toString((t.get(Calendar.MONTH) + 1));
		//한자리 숫자, 예를 들면 1월인 경우 "01"등으로 문자열 변환
		month = month.length() > 1 ? month : "0" + month;
		//오늘의 날짜 구함
		String day = Integer.toString(t.get(Calendar.DAY_OF_MONTH));
		day = day.length() > 1 ? day : "0" + day;
		//현재 시각의 시를 구함.
		String hh = Integer.toString(t.get(Calendar.HOUR_OF_DAY));
		//현재 시각의 분을 구함.
		String mm = Integer.toString(t.get(Calendar.MINUTE));
		
		return year + "." + month + "." + day + "_" + hh + ":" + mm;		
	}
}
