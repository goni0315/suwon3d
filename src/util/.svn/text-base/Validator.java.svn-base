package util; 
 
import java.util.ArrayList;
import java.util.Date;
import java.util.Vector;
 
 public final class Validator
 {
   public static boolean maxLen(String data, int maxLength)
   {
     return (data.length() > maxLength);
   }
 
   public static boolean minLen(String data, int minLength)
   {
     return ((data != null) && (data.length() < minLength));
   }
 
   public static boolean betweenVal(double data, double lowerData, double upperData)
   {
     return ((lowerData < data) && (data < upperData));
   }
 
   public static boolean betweenVal(int data, int lowerData, int upperData)
   {
     return ((lowerData < data) && (data < upperData));
   }
 
   public static boolean betweenVal(Date data, Date lowerData, Date upperData)
   {
     return ((data.after(lowerData)) && (data.before(upperData)));
   }
 
   public static boolean betweenVal(String data, String lowerData, String upperData)
   {
     return ((lowerData.length() < data.length()) && (data.length() < upperData.length()));
   }
 
   public static boolean isNull(String data)
   {
     return ((data == null) || (data.equals(null)));
   }
 
   public static boolean isZero(String data)
   {
     return data.equals("0");
   }
 
   public static boolean isBlank(String str)
   {
     int strLen;
     if ((str == null) || ((strLen = str.length()) == 0))
       return true;
     
     for (int i = 0; i < strLen; ++i) {
       if (!(Character.isWhitespace(str.charAt(i)))) {
         return false;
       }
     }
     return true;
   }
 
   public static boolean isNotBlank(String str)
   {
     int strLen;
     if ((str == null) || ((strLen = str.length()) == 0))
       return false;
     
     for (int i = 0; i < strLen; ++i) {
       if (!(Character.isWhitespace(str.charAt(i)))) {
         return true;
       }
     }
     return false;
   }
 
   public static boolean isEmpty(String str)
   {
     return ((str == null) || (str.length() == 0));
   }
 
   public static boolean isNotEmpty(String str)
   {
     return ((str != null) && (str.length() > 0));
   }
 
   public static boolean isNoData(String data)
   {
     return ((data == null) || (data.length() == 0));
   }
 
   public static boolean isNoData(Vector data)
   {
     return (data.size() == 0);
   }
 
   public static boolean isNoData(ArrayList data)
   {
     return (data.size() == 0);
   }
 
   public static boolean isNoData(Object data)
   {
     return (data == null);
   }
 
   public static boolean isNoData(Object[] data)
   {
     return (data.length == 0);
   }
 
   public static final boolean isAlphaNumeric(String text)
   {
     if (text == null) {
       return false;
     }
     int size = text.length();
     for (int i = 0; i < size; ++i) {
       if (!(Character.isDigit(text.charAt(i))))
         return false;
     }
     return true;
   }
 
   public static boolean isEmailAddr(String data)
   {
     if (data == null) {
       return false;
     }
 
     return (data.indexOf("@") != -1);
   }
 
   public static boolean isSSN(String serial1, String serial2)
   {
     if (serial1.length() != 6) {
       return false;
     }
     if (serial2.length() != 7) {
       return false;
     }
 
     int digit = 0;
     for (int i = 0; i < serial1.length(); ++i) {
       String str_dig = serial1.substring(i, i + 1);
       if ((str_dig.length() < 0) || (str_dig.length() > 9)) {
         digit += 1;
       }
     }
 
     if ((serial1 == "") || (digit != 0)) {
       return false;
     }
 
     int digit1 = 0;
     for (int i = 0; i < serial2.length(); ++i) {
       String str_dig1 = serial2.substring(i, i + 1);
       if ((str_dig1.length() < 0) || (str_dig1.length() > 9)) {
         digit1 += 1;
       }
     }
 
     if ((serial2 == "") || (digit1 != 0)) {
       return false;
     }
 
     if (Integer.parseInt(serial1.substring(2, 3)) > 1) {
       return false;
     }
 
     if (Integer.parseInt(serial1.substring(4, 5)) > 3) {
       return false;
     }
 
     if ((Integer.parseInt(serial2.substring(0, 1)) > 4) || (Integer.parseInt(serial2.substring(0, 1)) == 0))
     {
       return false;
     }
 
     int a1 = Integer.parseInt(serial1.substring(0, 1));
     int a2 = Integer.parseInt(serial1.substring(1, 2));
     int a3 = Integer.parseInt(serial1.substring(2, 3));
     int a4 = Integer.parseInt(serial1.substring(3, 4));
     int a5 = Integer.parseInt(serial1.substring(4, 5));
     int a6 = Integer.parseInt(serial1.substring(5, 6));
 
     int check_digit1 = a1 * 2 + a2 * 3 + a3 * 4 + a4 * 5 + a5 * 6 + a6 * 7;
 
     int b1 = Integer.parseInt(serial2.substring(0, 1));
     int b2 = Integer.parseInt(serial2.substring(1, 2));
     int b3 = Integer.parseInt(serial2.substring(2, 3));
     int b4 = Integer.parseInt(serial2.substring(3, 4));
     int b5 = Integer.parseInt(serial2.substring(4, 5));
     int b6 = Integer.parseInt(serial2.substring(5, 6));
     int b7 = Integer.parseInt(serial2.substring(6, 7));
 
     int check_digit = check_digit1 + b1 * 8 + b2 * 9 + b3 * 2 + b4 * 3 + b5 * 4 + b6 * 5;
 
     check_digit %= 11;
     check_digit = 11 - check_digit;
     check_digit %= 10;
 
     return (check_digit == b7);
   }
 }
