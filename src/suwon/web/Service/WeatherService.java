package suwon.web.Service;


import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.mymgr.framework.common.DateUtil;

import suwon.web.vo.DongWeatherVO;
import suwon.web.vo.SuwonDongVO;
import suwon.web.vo.SuwonGuVO;
import suwon.web.vo.WeekWeatherVO;
import util.NetWork;

@Repository
public class WeatherService {
	private SqlMapClientTemplate sqlMapClientTemplate;

	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	private Log log = LogFactory.getLog(getClass());
	/**
	 * @param args
	 */
//	public static void main(String[] args) {
//		try {
//			Map result = new HashMap<String, String>();
//			
//			SAXBuilder builder = new SAXBuilder();
//			Document doc = builder.build("http://www.kma.go.kr/wid/queryDFS.jsp?gridx=74&gridy=66");
//			
//			Element root = doc.getRootElement();
//			List<Element> elements = root.getChildren();
//			
//			/* S header */
//			Element header = root.getChild("header");
//			Element body = root.getChild("body");
//			
//			if(header != null){
//				Element tm = header.getChild("tm"); // 발표시각
//				Element ts = header.getChild("ts"); // 시간step
//				
//				result.put("tm", tm.getText());
//				result.put("ts", ts.getText());
//				
//				printResult(result);
//			}
//			/* E header */
//			
//			/* S body */
//			if(body != null){
//				List<Element> listDatas = body.getChildren();
//				
//				for(int i = 0; i < listDatas.size(); i++){
//					result = new HashMap<String, String>();
//					
//					Element data = listDatas.get(i);
//					
//					Element hour = data.getChild("hour"); // <hour>18</hour> 동네예보 3시간단위(15시~18시까지)
//					result.put("hour", hour.getText());
//					//18시 point값 적용요소 : 기온, 풍향, 풍속, 습도
//					//15시~18시 구간 적용요소 : 하늘상태, 강수상태, 강수확률
//					Element day = data.getChild("day"); // <day>0</day> 1번째날(오늘/내일/모레 중 오늘)
//					Element temp = data.getChild("temp"); // <temp>6.5</temp> 현재시간온도(15시~18시)
//					result.put("temp", temp.getText());
//					Element tmx = data.getChild("tmx"); // <tmx>-999.0</tmx> 최고온도 missing(값이 없을 경우)
//					Element tmn = data.getChild("tmn"); // <tmn>-999.0</tmn> 최저온도 missing(값이 없을 경우)
//					Element sky = data.getChild("sky"); // <sky>4</sky> 하늘상태코드
//					//① 1 : 맑음 ② 2 : 구름조금 ③ 3 : 구름많음 ④ 4 : 흐림
//					Element pty = data.getChild("pty"); // <pty>0</pty> 강수상태코드
//					//① 0 : 없음 ② 1 : 비 ③ 2 : 비/눈 ④ 3 : 눈/비 ⑤ 4 : 눈
//					Element wfKor = data.getChild("wfKor"); // <wfKor>흐림</wfKor> 날씨한국어
//					//① 맑음 ② 구름 조금 ③ 구름 많음 ④ 흐림 ⑤ 비 ⑥ 눈/비 ⑦ 눈
//					Element wfEn = data.getChild("wfEn"); // <wfEn>Cloudy</wfEn> 날씨영어
//					//① Clearly ② Little Cloudy ③ Mostly Cloudy ④ Cloudy ⑤ Rainy ⑥ Snow/Rain ⑦ Snow
//					Element pop = data.getChild("pop"); // <pop>17</pop> 강수확률%
//					Element r12 = data.getChild("r12"); // <r12>0.0</r12> 12시간 예상강수량
////					[강수량범주 및 표시방법 / 저장값]
////					① 0.1mm 미만 (0mm 또는 없음) / 0 <= x < 0.1 
////					② 0.1mm 이상 1mm 미만(1mm 미만) / 0.1 <= x < 1 
////					③ 1mm 이상 5mm 미만(1~4mm) / 1 <= x < 5
////					④ 5mm 이상 10mm 미만(5~9mm) /5 <= x < 10
////					⑤ 10mm 이상 25mm 미만(10~24mm) / 10 <= x < 25
////					⑥ 25mm 이상 50mm 미만(25~49mm) / 25 <= x < 50
////					⑦ 50mm 이상(50mm 이상) / 50 <= x
//					Element s12 = data.getChild("s12"); // <s12>0.0</s12> 12시간 예상적설량
////					[적설량범주 및 표시방법 / 저장값]
////					① 0.1cm 미만 (0mm 또는 없음) / 0 <= x < 0.1
////					② 0.1mm 이상 1mm 미만(1mm 미만) / 0.1 <= x < 1
////					③ 1mm 이상 5mm 미만(1~4mm) / 1 <= x < 5
////					④ 5mm 이상 10mm 미만(5~9mm) /5 <= x < 10
////					⑤ 10mm 이상 25mm 미만(10~24mm) / 10 <= x < 20
////					⑥ 50mm 이상(50mm 이상) / 20 <= x
//					Element ws = data.getChild("ws"); // <ws>1.8</ws> 풍속(m/s) 반올림처리 값 이용(정수)
//					Element wd = data.getChild("wd"); // <wd>2</wd> 풍향
//					//풍향(8방): 국문8방위/영문8방위
//					/* 풍향 0~7 (북, 북동, 동, 남동, 남, 남서, 서, 북서)*/
//					Element wdKor = data.getChild("wdKor"); // <wdKor>동</wdKor> 풍향한국어
////					① 동(E) ② 북(N) ③ 북동(NE) ④ 북서(NW) ⑤ 남(S) ⑥ 남동(SE) ⑦ 남서(SW) ⑧ 서(W)
//					Element wdEn = data.getChild("wdEn"); // <wdEn>E</wdEn> 풍향영어
////					① E(동) ② N(북) ③ NE(북동) ④ NW(북서) ⑤ S(남) ⑥ SE(남동) ⑦ SW(남서) ⑧ W(서)
//					Element reh = data.getChild("reh"); // <reh>49</reh> 습도%
//					
//					System.out.println("========================");
//					printResult(result);
//				}
//			}
//			/* E body */
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//	
//	static void printResult(Map result){
//		Iterator<String> keys = result.keySet().iterator();
//		
//		while(keys.hasNext()){
//			String key = keys.next();
//			System.out.println(key + " = " + result.get(key));
//		}
//	}
	
	public static void main(String[] args){
//		DongWeatherService dongWeatherService = new DongWeatherService();
//		
//		List<DongWeatherVO> listDongWeather = dongWeatherService.listDongWeather(74, 66);
//		
//		for (DongWeatherVO dongWeather : listDongWeather) {
//			System.out.println("=============================");
//			System.out.println(dongWeather.getDay());
//			System.out.println(dongWeather.getHour());
//			System.out.println(dongWeather.getPop());
//			System.out.println(dongWeather.getPty());
//			System.out.println(dongWeather.getR12());
//			System.out.println(dongWeather.getReh());
//			System.out.println(dongWeather.getS12());
//			System.out.println(dongWeather.getSky());
//			System.out.println(dongWeather.getTemp());
//			System.out.println(dongWeather.getTm());
//			System.out.println(dongWeather.getWd());
//			System.out.println(dongWeather.getWdEn());
//			System.out.println(dongWeather.getWdKor());
//			System.out.println(dongWeather.getWfKor());
//			System.out.println(dongWeather.getWs());
//		}

		
		/* 해당 날짜의 요일 구하기 
		String[] week = { "일", "월", "화", "수", "목", "금", "토" };
		
		Locale locale = java.util.Locale.KOREA;

	    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss", locale);

	    try {
	    	sdf.parse("20120327101202");
		} catch (Exception e) {
			e.printStackTrace();
		}

	    Calendar cal = sdf.getCalendar();

	    String dayOfWeek = week[cal.get(Calendar.DAY_OF_WEEK)-1];
	    
	    System.out.println("dayOfWeek : " + dayOfWeek);
	    */
		WeatherService dongWeatherService = new WeatherService();
		List<SuwonDongVO> n_list = dongWeatherService.getDongWeather();	//현재날씨 예제
//		dongWeatherService.getDongWeather('b');	//주간날씨 예제
//		dongWeatherService.listWeekWeather();

		System.out.println("dddd");
	}
	/**
	 * 동에 따른 기상정보를 수집
	 * parameter : 
	 * 	char flag - a: 현재날씨(지도표현), b : 주간날씨(팝업표현) 
	 * */
	public List<SuwonDongVO> getDongWeather(){
		System.out.println("getDongWeather start");
		 List<SuwonDongVO> n_list = new ArrayList<SuwonDongVO>();	//기상정보
			JSONArray g_list =this.listGuList(41);	//구정보
			JSONArray dw_list = new JSONArray();	//동정보
			for(Object obj :g_list){
				JSONObject j_obj = (JSONObject)obj;
				Integer cod = Integer.valueOf((String)j_obj.get("code"));
				if(cod==41111 || cod==41113 || cod==41115 | cod==41117){
					JSONArray d_list = this.listDongList(cod);
					for(Object obj2 :d_list){
						JSONObject jf_obj = (JSONObject)obj2;
						SuwonDongVO dongVo = new SuwonDongVO();
						dongVo.setCode(jf_obj.getString("code"));
						dongVo.setValue(jf_obj.getString("value"));
						dongVo.setGridX(jf_obj.getString("x"));
						dongVo.setGridY( jf_obj.getString("y"));
						List<DongWeatherVO>  we_list =new ArrayList<DongWeatherVO>();
						dongVo.setDongVo(this.listDongWeather(dongVo.getGridX(), dongVo.getGridY()).get(0));
						n_list.add(dongVo);
					}
				}

			}
			System.out.println(n_list.toString());		 
			System.out.println("getDongWeather end");
		 return n_list;
	}
	public SuwonDongVO getVo(String dongId){
		JSONArray array = listDongList(Integer.parseInt(dongId.substring(0,5)));
		SuwonDongVO return_obj = new SuwonDongVO(); 
		for(Object obj : array){
			JSONObject j_obj = (JSONObject)obj;
			if(j_obj.getString("code").equals(dongId)){
				return_obj.setCode(j_obj.getString("code"));
				return_obj.setValue(j_obj.getString("value"));
				return_obj.setGridX(j_obj.getString("x"));
				return_obj.setGridY(j_obj.getString("y"));
				break;
			}
		}
		return return_obj;
	}
	private JSONArray listGuList(int suwonCode){
			String str = new NetWork().requestHttp("http://www.kma.go.kr/DFSROOT/POINT/DATA/mdl."+suwonCode+".json.txt");
			
			JSONArray json = JSONArray.fromObject(JSONSerializer.toJSON(str));

		return json;
	}
	private JSONArray listDongList(int dongCode){
			String str = new NetWork().requestHttp("http://www.kma.go.kr/DFSROOT/POINT/DATA/leaf."+dongCode+".json.txt");
			
			JSONArray json = JSONArray.fromObject(JSONSerializer.toJSON(str));
			

		return json;
	}
	
	/**
	 * 동별 일기 예보
	 * 
	 * @param gridx
	 * @param gridy
	 * @return
	 */
	public List<DongWeatherVO> listDongWeather(String gridx, String gridy){
		List<DongWeatherVO> listDongWeather = new ArrayList<DongWeatherVO>();
		
		try {
			SAXBuilder builder = new SAXBuilder();
			Document doc = builder.build("http://www.kma.go.kr/wid/queryDFS.jsp?gridx="+gridx+"&gridy="+gridy);
			
			Element root = doc.getRootElement();
			List<Element> elements = root.getChildren();
			
			/* S header */
			Element header = root.getChild("header");
			Element body = root.getChild("body");
			Element tm = null;
			
			if(header != null){
				tm = header.getChild("tm"); // 발표시각
			}
			/* E header */
			
			/* S body */
			if(body != null){
				List<Element> listDatas = body.getChildren();
				
				for(int i = 0; i < listDatas.size(); i++){
					DongWeatherVO dongWeather = new DongWeatherVO();
					Element data = listDatas.get(i);
					
					// <hour>18</hour> 동네예보 3시간단위(15시~18시까지)
					//18시 point값 적용요소 : 기온, 풍향, 풍속, 습도
					//15시~18시 구간 적용요소 : 하늘상태, 강수상태, 강수확률
					dongWeather.setHour(data.getChild("hour").getValue());
					
					// <day>0</day> 1번째날(오늘/내일/모레 중 오늘)
					dongWeather.setDay(data.getChild("day").getValue());
					
					// <temp>6.5</temp> 현재시간온도(15시~18시)
					dongWeather.setTemp(data.getChild("temp").getValue());
					dongWeather.setTmn(data.getChild("tmn").getValue());
					dongWeather.setTmx(data.getChild("tmx").getValue());

					// <sky>4</sky> 하늘상태코드
					//① 1 : 맑음 ② 2 : 구름조금 ③ 3 : 구름많음 ④ 4 : 흐림
					dongWeather.setSky(data.getChild("sky").getValue());
					
					// <pty>0</pty> 강수상태코드
					//① 0 : 없음 ② 1 : 비 ③ 2 : 비/눈 ④ 3 : 눈/비 ⑤ 4 : 눈
					dongWeather.setPty(data.getChild("pty").getValue());
					
					// <wfKor>흐림</wfKor> 날씨한국어
					//① 맑음 ② 구름 조금 ③ 구름 많음 ④ 흐림 ⑤ 비 ⑥ 눈/비 ⑦ 눈
					dongWeather.setWfKor(data.getChild("wfKor").getValue());
					
					// <pop>17</pop> 강수확률%
					dongWeather.setPop(data.getChild("pop").getValue());
					
					// <r12>0.0</r12> 12시간 예상강수량
//					[강수량범주 및 표시방법 / 저장값]
//					① 0.1mm 미만 (0mm 또는 없음) / 0 <= x < 0.1 
//					② 0.1mm 이상 1mm 미만(1mm 미만) / 0.1 <= x < 1 
//					③ 1mm 이상 5mm 미만(1~4mm) / 1 <= x < 5
//					④ 5mm 이상 10mm 미만(5~9mm) /5 <= x < 10
//					⑤ 10mm 이상 25mm 미만(10~24mm) / 10 <= x < 25
//					⑥ 25mm 이상 50mm 미만(25~49mm) / 25 <= x < 50
//					⑦ 50mm 이상(50mm 이상) / 50 <= x
					dongWeather.setR12(data.getChild("r12").getValue());
					
					// <s12>0.0</s12> 12시간 예상적설량
//					[적설량범주 및 표시방법 / 저장값]
//					① 0.1cm 미만 (0mm 또는 없음) / 0 <= x < 0.1
//					② 0.1mm 이상 1mm 미만(1mm 미만) / 0.1 <= x < 1
//					③ 1mm 이상 5mm 미만(1~4mm) / 1 <= x < 5
//					④ 5mm 이상 10mm 미만(5~9mm) /5 <= x < 10
//					⑤ 10mm 이상 25mm 미만(10~24mm) / 10 <= x < 20
//					⑥ 50mm 이상(50mm 이상) / 20 <= x
					dongWeather.setS12(data.getChild("s12").getValue());
					
					// <ws>1.8</ws> 풍속(m/s) 반올림처리 값 이용(정수)
					dongWeather.setWs(data.getChild("ws").getValue());
					
					// <wd>2</wd> 풍향
					//풍향(8방): 국문8방위/영문8방위
					/* 풍향 0~7 (북, 북동, 동, 남동, 남, 남서, 서, 북서)*/
					dongWeather.setWd(data.getChild("wd").getValue());
					
					// <wdKor>동</wdKor> 풍향한국어
					dongWeather.setWdKor(data.getChild("wdKor").getValue());
					
					// <reh>49</reh> 습도%
					dongWeather.setReh(data.getChild("reh").getValue());

					if(tm != null){
						dongWeather.setDayOfWeek(readDayOfWeek(tm.getValue(), data.getChild("day").getValue()));
					}
					
					listDongWeather.add(dongWeather);
					
				}
			}
			/* E body */
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listDongWeather;
	}
	
	
	/**
	 * 주간 일기예보
	 * 
	 * @return
	 */
	public List<WeekWeatherVO> listWeekWeather(){
		List<WeekWeatherVO> listWeekWeather = new ArrayList<WeekWeatherVO>();
		
		try {
			String tmValue = ""; // 발표시각
			
			SAXBuilder builder = new SAXBuilder();
			Document doc = builder.build("http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=109");
			
			Element root = doc.getRootElement();
			List<Element> elements = root.getChildren();
			
			/* S header */
			Element header = root.getChild("header");
			Element body = root.getChild("body");
			
			if(header != null){
				Element tm = header.getChild("tm"); // 발표시각
				tmValue = tm.getValue();
			}
			/* E header */
			
			/* S body */
			if(body != null){
				List<Element> listLocations = body.getChildren();
				
				for(int i = 0; i < listLocations.size(); i++){
					Element location = listLocations.get(i);
					
					if("수원".equals(location.getChild("city").getText())){ // 수원시
						List<Element> listDatas = location.getChildren("data");
						
						if(listDatas != null){
							for(int j = 0; j < listDatas.size(); j++){
								WeekWeatherVO weekWeather = new WeekWeatherVO();
								
								Element data = listDatas.get(j);
								
								weekWeather.setTm(tmValue);
								
								// <numEf>2</numEf> 2일후 예보
								/** 발효번호 **/
								//23시 부터~11시 이전 : 오늘오전(0), 오늘오후(1), 내일오전(2), 내일오후(3) 
								//11시 부터~23시 이전 : 오늘오후(0), 내일오전 (1), 내일오후(2), 모레오전(3)
								weekWeather.setNumEf(data.getChild("numEf").getValue());
								
								// <tmEf>2010-03-10</tmEf> yyyy-mm-dd 년월일 시간태그
								weekWeather.setTmEf(DateUtil.convertDateFormat(data.getChild("tmEf").getValue(), "-", "MM/dd"));
								
								// <wf>구름많고 눈</wf> 날씨예보 태그
								//① 맑음 ② 구름 조금 ③ 구름 많음 ④ 흐림 ⑤ 비 ⑥ 눈/비 ⑦ 눈
								weekWeather.setWf(data.getChild("wf").getValue());
								
								// <tmn>-2</tmn> 최저온도 태그
								weekWeather.setTmn(data.getChild("tmn").getValue());
								
								// <tmx>4</tmx> 최고온도 태그
								weekWeather.setTmx(data.getChild("tmx").getValue());
								
								weekWeather.setDayOfWeek(readDayOfWeek(data.getChild("tmEf").getValue()));
								
								listWeekWeather.add(weekWeather);
							}
						}
						
						break;
					}
					
				}
			}
			/* E body */
		} catch (Exception e) {
			log.error("주간 일기예보", e);
		}
		
		return listWeekWeather;
	}
	
	/**
	 * 해당일자 요일 구하기
	 * @param tm
	 * @param day
	 * @return 요일
	 */
	public String readDayOfWeek(String tm, String day){
		String[] week = { "일", "월", "화", "수", "목", "금", "토" };
		
		Locale locale = java.util.Locale.KOREA;

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm", locale);

		try {
			sdf.parse(tm);
		} catch (Exception e) {
			e.printStackTrace();
		}

		Calendar cal = sdf.getCalendar();

		String dayOfWeek = ""; 
		
		if(Integer.valueOf(day) == 0){ // 오늘
			dayOfWeek = week[cal.get(Calendar.DAY_OF_WEEK)-1]; 
		}else if(Integer.valueOf(day) == 1){ // 내일
			int index = cal.get(Calendar.DAY_OF_WEEK);
			
			if(index == 7){
				dayOfWeek = week[0];
			}else{
				dayOfWeek = week[cal.get(Calendar.DAY_OF_WEEK)];
			}
		}else if(Integer.valueOf(day) == 2){ // 모레
			int index = cal.get(Calendar.DAY_OF_WEEK);
			
			if(index == 6){
				dayOfWeek = week[0];
			}else if(index == 7){
				dayOfWeek = week[1];
			}else{
				dayOfWeek = week[cal.get(Calendar.DAY_OF_WEEK)+1];
			}
		}

		return dayOfWeek;
	}
	/**
	 * 해당일자 요일 구하기
	 * @param tmEf
	 * @return 요일
	 */
	public String readDayOfWeek(String tmEf){
		String[] week = { "일", "월", "화", "수", "목", "금", "토" };
		
		Locale locale = java.util.Locale.KOREA;

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", locale);

		try {
			sdf.parse(tmEf);
		} catch (Exception e) {
			log.error("해당일자 요일 구하기", e);
		}

		Calendar cal = sdf.getCalendar();

		String dayOfWeek = week[cal.get(Calendar.DAY_OF_WEEK)-1];

		return dayOfWeek;
	}
	
}
