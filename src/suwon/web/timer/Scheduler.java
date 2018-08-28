/**
 * 
 */
package suwon.web.timer;

import java.util.Calendar;
import java.util.Timer;

public class Scheduler {

	public static void main(String[] args) {
		WeeklySearch weeklySearch = new WeeklySearch();

		Timer timer = new Timer();
		Calendar date = Calendar.getInstance();
		date.set(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);
		date.set(Calendar.AM_PM, Calendar.PM);
		date.set(Calendar.HOUR, 11);
		date.set(Calendar.MINUTE, 29);
		date.set(Calendar.SECOND, 0);
		date.set(Calendar.MILLISECOND, 0);
		
		//일주일 단위 실행
		timer.scheduleAtFixedRate(weeklySearch, date.getTime(), 
				1000 * 60 * 60 * 24 * 7);
	}
}