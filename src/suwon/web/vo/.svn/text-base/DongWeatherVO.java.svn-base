package suwon.web.vo;

import com.mymgr.framework.common.StrUtil;

public class DongWeatherVO {
	private String tm; // 발표시각
	private String hour; // <hour>18</hour> 동네예보 3시간단위(15시~18시까지)
	private String day; // <day>0</day> 1번째날(오늘/내일/모레 중 오늘)
	private String temp; // <temp>6.5</temp> 현재시간온도(15시~18시)
	private String tmx;
	private String tmn;
	private String sky; // <sky>4</sky> 하늘상태코드
	private String pty; // <pty>0</pty> 강수상태코드
	private String wfKor; // <wfKor>흐림</wfKor> 날씨한국어
	private String pop; // <pop>17</pop> 강수확률%
	private String r12; // <r12>0.0</r12> 12시간 예상강수량
	private String s12; // <s12>0.0</s12> 12시간 예상적설량
	private String ws; // <ws>1.8</ws> 풍속(m/s) 반올림처리 값 이용(정수)
	private String wd; // <wd>2</wd> 풍향
	private String wdKor; // <wdKor>동</wdKor> 풍향한국어
	private String wdEn; // <wdEn>E</wdEn> 풍향영어
	private String reh; // <reh>49</reh> 습도%
	
	private String dayOfWeek; // 요일
	
	public String getTm() {
		return tm;
	}
	public void setTm(String tm) {
		this.tm = tm;
	}
	public String getHour() {
		return hour;
	}
	/**
	 * Hour 문자열 정보로 변환
	 * 
	 * @return
	 */
	public String getStrHour() {
		if(hour == null) return hour;
		
		int endHour = Integer.parseInt(hour);
		int staHour = endHour - 3;
		
		
		return StrUtil.fillChar(String.valueOf(staHour), '0', 2, 0)+"~"+StrUtil.fillChar(String.valueOf(endHour), '0', 2, 0);
	}
	public void setHour(String hour) {
		this.hour = hour;
	}
	public String getDay() {
		return day;
	}
	/**
	 * Day 문자열 정보로 변환
	 * 
	 * @return
	 */
	public String getStrDay() {
		if(day == null) return day;
		
		int intDay = Integer.parseInt(day);
		
		if(intDay == 0) return "오늘" ;
		else if(intDay == 1) return "내일" ;
		else if(intDay == 2) return "모레" ;
		
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getTemp() {
		return temp;
	}
	public void setTemp(String temp) {
		this.temp = temp;
	}
	public String getSky() {
		return sky;
	}
	public void setSky(String sky) {
		this.sky = sky;
	}
	public String getPty() {
		return pty;
	}
	public void setPty(String pty) {
		this.pty = pty;
	}
	public String getWfKor() {
		return wfKor;
	}
	public void setWfKor(String wfKor) {
		this.wfKor = wfKor;
	}
	public String getPop() {
		return pop;
	}
	public void setPop(String pop) {
		this.pop = pop;
	}
	public String getR12() {
		return r12;
	}
	public void setR12(String r12) {
		this.r12 = r12;
	}
	public String getS12() {
		return s12;
	}
	public void setS12(String s12) {
		this.s12 = s12;
	}
	public String getWs() {
		return ws;
	}
	public void setWs(String ws) {
		this.ws = ws;
	}
	public String getWd() {
		return wd;
	}
	public void setWd(String wd) {
		this.wd = wd;
	}
	public String getWdKor() {
		return wdKor;
	}
	public void setWdKor(String wdKor) {
		this.wdKor = wdKor;
	}
	public String getWdEn() {
		return wdEn;
	}
	public void setWdEn(String wdEn) {
		this.wdEn = wdEn;
	}
	public String getReh() {
		return reh;
	}
	public void setReh(String reh) {
		this.reh = reh;
	}
	public String getTmx() {
		return "-999.0".equals(tmx) ? "" : tmx;
	}
	public void setTmx(String tmx) {
		this.tmx = tmx;
	}
	public String getTmn() {
		return "-999.0".equals(tmn) ? "" : tmn;
	}
	public void setTmn(String tmn) {
		this.tmn = tmn;
	}
	public String getDayOfWeek() {
		return dayOfWeek;
	}
	public void setDayOfWeek(String dayOfWeek) {
		this.dayOfWeek = dayOfWeek;
	}
}
