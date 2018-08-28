package util;

import java.sql.Time;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public abstract class DateUtil
{

  public static final String YEAR_FORMAT = "yyyy";
  public static final String MONTH_FORMAT = "MM";
  public static final String DATE_FORMAT = "dd";
  public static final String YEAR_MONTH_FORMAT = "yyyyMM";
  public static final String DEFAULT_DATE_FORMAT = "yyyyMMdd";
  public static final String DOT_MONTH_FORMAT = "yyyy.MM";
  public static final String DOT_DATE_FORMAT = "yyyy.MM.dd";
  public static final String DASH_DATE_FORMAT = "yyyy-MM-dd";
  public static final String DEFAULT_DATETIME_FORMAT = "yyyyMMddHHmmssSSS";
  public static final String DEFAULT_TIMESTAMP_FORMAT = "yyyyMMddHHmmss";
  public static final String DOT_DATETIME_FORMAT = "yyyy.MM.dd HH:mm";
  public static final String DASH_DATETIME_FORMAT = "yyyy-MM-dd HH:mm";
  public static final String DOT_TIMESTAMP_FORMAT = "yyyy.MM.dd HH:mm:ss";
  public static final String DASH_TIMESTAMP_FORMAT = "yyyy-MM-dd HH:mm:ss";
  public static final String DEFAULT_TIME_FORMAT = "HHmmss";
  public static final String COLONE_TIME_FORMAT = "HH:mm:ss";
  public static final String DEFAULT_TIME_MILLS_FORMAT = "HHmmssSSS";
  public static final String COLONE_TIME_MILLS_FORMAT = "HH:mm:ss.SSS";
  public static final String KO_YEAR_FORMAT = "yyyy년";
  public static final String KO_MONTH_FORMAT = "MM월";
  public static final String KO_YEAR_MONTH_FORMAT = "yyyy년 MM월";
  public static final String QUOTATION_YEAR_FORMAT = "''yy";
  public static final String QUOTATION_YEAR_MONTH_FORMAT = "''yy.MM";
  public static final String CARRY_OVER_MONTH = "13";
  public static final int BEFORE_DATE_FLAG = 0;
  public static final int AFTER_DATE_FLAG = 1;
  public static final long ONE_DAY_MS = 86400000L;

  public static String getLastYear(String year)
  {
    int intYear = Integer.parseInt(year);
    return Integer.toString(intYear - 1);
  }

  public static String getBeforeMonth(String strDate, String format, int month)
  {
    SimpleDateFormat fmt = new SimpleDateFormat(format);
    Calendar calendar = Calendar.getInstance();
    try {
      calendar.setTime(fmt.parse(strDate));
    } catch (Exception e) {
      return null;
    }

    if (calendar.get(5) == calendar.getActualMaximum(5))
    {
      calendar.add(2, -1 * month);
      calendar.set(5, calendar.getActualMaximum(5));
    }
    else {
      calendar.add(2, -1 * month);
    }

    return dateToString(calendar.getTime(), format);
  }

  public static String getCurrentDate()
  {
    SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
    return df.format(new java.util.Date());
  }

  public static String getCurrentDate(String format)
  {
    SimpleDateFormat df = new SimpleDateFormat(format);
    return df.format(new java.util.Date());
  }

  public static String getCurrentDateTime()
  {
    Calendar calendar = Calendar.getInstance();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");

    return formatter.format(calendar.getTime());
  }

  public static java.sql.Date getCurrentSqlDate()
  {
    return new java.sql.Date(convertStringToDate(getCurrentDate(), "yyyyMMdd").getTime());
  }

  public static Time getCurrentSqlTime()
  {
    return new Time(System.currentTimeMillis());
  }

  public static int getBetweenDays(java.util.Date startDate, java.util.Date endDate)
  {
    if ((startDate == null) || (endDate == null)) {
      throw new IllegalArgumentException("시작일자, 종료일자는 null이 아니어야합니다.");
    }

    long startTime = startDate.getTime();
    long endTime = endDate.getTime();

    long msSecondPerDay = 86400000L;

    int days = (int)(endTime / msSecondPerDay) - (int)(startTime / msSecondPerDay);

    return days;
  }

  public static java.util.Date getMaximumDate()
  {
    return convertStringToDate("99991231", "yyyyMMdd");
  }

  public static java.sql.Date getMaximumSqlDate()
  {
    return new java.sql.Date(convertStringToDate("99991231", "yyyyMMdd").getTime());
  }

  public static java.sql.Date[] getBeforeAfterSqlDates(java.util.Date baseDate)
  {
    java.sql.Date[] generatedDates = new java.sql.Date[2];
    long baseTime = baseDate.getTime();
    generatedDates[0] = new java.sql.Date(baseTime - 86400000L);

    generatedDates[1] = new java.sql.Date(baseTime + 86400000L);

    return generatedDates;
  }

  public static java.sql.Date getLastDateOfPrevMonth()
  {
    return getLastDateOfPrevMonth(null);
  }

  public static String convertTimeToString(long time, String format)
  {
    SimpleDateFormat formatter = new SimpleDateFormat(format);
    return formatter.format(new java.util.Date(time));
  }

  public static Time convertStringToTime(String time, String format)
  {
    java.util.Date date = convertStringToDate(time, format);
    
    return new Time(date.getTime());
  }

  public static String convertTimestampToString(Timestamp time, String format)
  {
    if (time == null) return null;
    SimpleDateFormat formatter = new SimpleDateFormat(format);
    return formatter.format(time);
  }

  public static String convertStringToString(String strDate, String beforeFormat, String afterFormat)
  {
    if ((strDate == null) || (strDate.length() == 0)) {
      return null;
    }
    if (strDate.length() != beforeFormat.length()) {
      

      return null;
    }

    String addFormat = "";

    if ((beforeFormat.indexOf("y") < 0) && (beforeFormat.indexOf("Y") < 0) && (((afterFormat.indexOf("y") >= 0) || (afterFormat.indexOf("Y") >= 0))))
    {
      addFormat = "yyyy";
    }

    if ((beforeFormat.indexOf("M") < 0) && (afterFormat.indexOf("M") >= 0)) {
      addFormat = addFormat + "MM";
    }

    if ((beforeFormat.indexOf("d") < 0) && (beforeFormat.indexOf("D") < 0) && (((afterFormat.indexOf("d") >= 0) || (afterFormat.indexOf("D") >= 0))))
    {
      addFormat = addFormat + "dd";
    }

    if (addFormat.length() > 0) {
      String addDate = getCurrentDate(addFormat);
      strDate = addDate + strDate;
      beforeFormat = addFormat + beforeFormat;
    }

    java.util.Date date = convertStringToDate(strDate, beforeFormat);
    return convertDateToString(date, afterFormat);
  }

  public static java.util.Date convertStringToDate(String strDate, String format)
  {
    if ((strDate == null) || (strDate.length() == 0)) {
      return null;
    }
    if (strDate.length() != format.length()) {
      return null;
    }
    if (!(isValidDate(strDate, format))) {
      
      return null;
    }
    try {
      SimpleDateFormat fmt = new SimpleDateFormat(format);
      return fmt.parse(strDate, new ParsePosition(0)); } catch (Exception e) {
    }
    return null;
  }

  public static java.sql.Date convertStringToSqlDate(String strDate, String format)
  {
    return new java.sql.Date(convertStringToDate(strDate, format).getTime());
  }

  public static String convertDateToString(java.util.Date date, String format)
  {
    if (date == null) {
      return null;
    }
    SimpleDateFormat sdf = new SimpleDateFormat(format);
    return sdf.format(date);
  }

  public static boolean isSameYear(String compareDate1, String compareDate2, String dateFormat)
  {
    String date1 = convertStringToString(compareDate1, dateFormat, "yyyy");

    String date2 = convertStringToString(compareDate2, dateFormat, "yyyy");

    return date1.equals(date2);
  }

  public static boolean isBetweenYear(int comDate, String compareDate1, String compareDate2, String dateFormat)
  {
    int date1 = Integer.parseInt(convertStringToString(compareDate1, dateFormat, "yyyy"));

    int date2 = Integer.parseInt(convertStringToString(compareDate2, dateFormat, "yyyy"));

    return ((comDate >= date1) && (comDate <= date2));
  }

  public static boolean isBeforeDate(java.util.Date date)
  {
    String currentDate = getCurrentDate("yyyyMMdd");
    String compareDate = dateToString(date, "yyyyMMdd");
    int compare = currentDate.compareTo(compareDate);

    return (compare > 0);
  }

  public static boolean isBeforeDate(java.util.Date baseDate, java.util.Date compareDate)
  {
    int compareResult = compareDate(baseDate, compareDate);

    return (compareResult > 0);
  }

  public static boolean isAfterDate(java.util.Date date)
  {
    String currentDate = getCurrentDate("yyyyMMdd");
    String compareDate = dateToString(date, "yyyyMMdd");
    int compare = currentDate.compareTo(compareDate);

    return (compare < 0);
  }

  public static boolean isAfterDate(java.util.Date baseDate, java.util.Date compareDate)
  {
    int compareResult = compareDate(baseDate, compareDate);

    return (compareResult < 0);
  }

  public static boolean isSameDate(java.util.Date compareDate1, java.util.Date compareDate2)
  {
    return isSame(compareDate1, compareDate2, 3);
  }

  public static boolean isSameMonth(java.util.Date compareDate1, java.util.Date compareDate2)
  {
    return isSame(compareDate1, compareDate2, 2);
  }

  public static boolean isSameYear(java.util.Date compareDate1, java.util.Date compareDate2)
  {
    return isSame(compareDate1, compareDate2, 1);
  }

  private static boolean isSame(java.util.Date compareDate1, java.util.Date compareDate2, int compareType)
  {
    String format = null;
    switch (compareType)
    {
    case 1:
      format = "yyyy";
      break;
    case 2:
      format = "yyyyMM";
      break;
    case 3:
      format = "yyyyMMdd";
    }

    String date1 = dateToString(compareDate1, format);
    String date2 = dateToString(compareDate2, format);
    return date1.equals(date2);
  }

  public static int compareDate(java.util.Date baseDate, java.util.Date compareDate)
  {
    String standard = dateToString(baseDate, "yyyyMMdd");
    String compare = dateToString(compareDate, "yyyyMMdd");
    return standard.compareTo(compare);
  }

  public static boolean isInTimeRange(Time startTime, Time endTime, Time baseTime)
  {
    if ((startTime != null) && (endTime != null) && (baseTime != null)) {
      if (startTime.getTime() >= endTime.getTime()) {
        endTime.setTime(endTime.getTime() + 86400000L);
      }

      if (baseTime.getTime() < startTime.getTime()) {
        baseTime.setTime(baseTime.getTime() + 86400000L);
      }

      return ((startTime.getTime() <= baseTime.getTime()) && (endTime.getTime() >= baseTime.getTime()));
    }

    

    return false;
  }

  public static java.sql.Date toSqlDate(java.util.Date date)
  {
    return new java.sql.Date(date.getTime());
  }

  public static java.sql.Date addDay(java.sql.Date baseDate, int addDay)
  {
    return addDate(baseDate, addDay, 3);
  }

  public static java.sql.Date addMonth(java.sql.Date baseDate, int addMonth)
  {
    return addDate(baseDate, addMonth, 2);
  }

  public static java.sql.Date addYear(java.sql.Date baseDate, int addYear)
  {
    return addDate(baseDate, addYear, 1);
  }

  private static java.sql.Date addDate(java.sql.Date baseDate, int addDate, int dateType)
  {
    Calendar calendar = Calendar.getInstance();

    if (baseDate != null) {
      calendar.setTime(baseDate);
    }

    switch (dateType)
    {
    case 1:
      calendar.add(1, addDate);
      break;
    case 2:
      calendar.add(2, addDate);
      break;
    case 3:
      calendar.add(5, addDate);
    }

    java.sql.Date addResult = new java.sql.Date(calendar.getTimeInMillis());

    return addResult;
  }

  public static java.sql.Date getLastDateOfPrevMonth(java.sql.Date baseDate)
  {
    Calendar calendar = Calendar.getInstance();
    if (baseDate != null) {
      calendar.setTime(baseDate);
    }

    calendar.add(5, -1 * calendar.get(5));

    java.sql.Date lastDateOfLastMonth = new java.sql.Date(calendar.getTimeInMillis());

    return lastDateOfLastMonth;
  }

  public static Timestamp convertStringToTimestamp(String time, String format)
  {
    if ((time == null) || ("".equals(time)))
    {
      return null;
    }

    java.util.Date date = convertStringToDate(time, format);
    return new Timestamp(date.getTime());
  }

  public static String dateToString(java.util.Date date, String format)
  {
    SimpleDateFormat df = new SimpleDateFormat(format);
    return df.format(date);
  }

  public static boolean isValidDate(String date, String format)
  {
    SimpleDateFormat sdf = new SimpleDateFormat(format);

    java.util.Date testDate = null;
    try
    {
      testDate = sdf.parse(date);
    }
    catch (ParseException e)
    {
      return false;
    }

    return (sdf.format(testDate).equals(date));
  }
}
