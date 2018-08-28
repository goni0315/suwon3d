package util;

import org.w3c.dom.Text;

public class StirngUtil {
	public StirngUtil() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * 입력받은 문자열의 앞뒤 공백을 잘라주는 함수
	 * 예시 : 입력값 -> '홍길동 "   , 출력값 -> "홍길동"
	 * @param inputString
	 * @return
	 */
	public static String trimString (String inputString){

		String outputString = null;

		if(inputString !=null){
			outputString = inputString.trim();
		}else{
			System.out.println("입력받은 문자열이 null 입니다.");
		}

		return outputString;
	}
	/**
	 * nullCheck
	 * @param Req
	 * @return
	 */
	 public String nullStringCheck(String Req) {
	        if ( Req == null) return "";
	        else return Req;
	    }
	 /**
	  * nullCehck for String
	  * @param text
	  * @return
	  */
	 public String nullTextCheck(Text text) {
	        if ( text == null)
	        	{ 
	        	return "";
	        	}
	        else
	        	{
	        	String result = strReplace(text.getData());
	        	return result;
	        	}
	 }
	 /**
	  * 스크립트 체크
	  * @param str
	  * @return
	  */
	 public String strReplace(String str){
		  str = rplc(str,"&lt;b&gt;","");
          str = rplc(str,"&lt;/b&gt;","");
          str = rplc(str,"<b>","");
          str = rplc(str,"</b>","");
          return str;
	 }
	 /**
	  * 바꾸기 메소드
	  * @param mainString
	  * @param oldString
	  * @param newString
	  * @return
	  */
	 public static String rplc(String mainString, String oldString, String newString) { 
	        if (mainString == null) {
	            return null;
	        }
	        if (oldString == null || oldString.length() == 0) {
	            return mainString;
	        }
	        if (newString == null) {
	            newString = "";
	        }
	        
	        int i = mainString.lastIndexOf(oldString);
	        if (i < 0)return mainString;
	        StringBuffer mainSb = new StringBuffer(mainString);
	        while (i >= 0) {
	            mainSb.replace(i, (i + oldString.length()), newString);
	            i = mainString.lastIndexOf(oldString, i - 1);
	        }
	        return mainSb.toString();
	    }
}




