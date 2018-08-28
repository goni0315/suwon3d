package util;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class MyUtil {
	// 문자열의 내용중 원하는 문자열을 다른 문자열로 변환
	// String str = replaceAll(str, "\r\n", "<br>"); // 엔터를 <br>로 변환
	public String replaceAll(String str, String oldStr, String newStr) throws Exception {
		if(str == null)
			return "";

        Pattern p = Pattern.compile(oldStr);

        // 입력 문자열과 함께 매쳐 클래스 생성
        Matcher m = p.matcher(str);

        StringBuffer sb = new StringBuffer();
        boolean result = m.find();

        // 패턴과 일치하는 문자열을 newStr 로 교체해가며 새로운 문자열을 만든다.
        while(result) {
            m.appendReplacement(sb, newStr);
            result = m.find();
        }

        // 나머지 부분을 새로운 문자열 끝에 덫 붙인다.
        m.appendTail(sb);

		return sb.toString();
	}

	// E-Mail 검사
    public boolean isEmail(String email) {
        if (email==null) return false;
        boolean b = Pattern.matches(
            "[\\w\\~\\-\\.]+@[\\w\\~\\-]+(\\.[\\w\\~\\-]+)+", 
            email.trim());
        return b;
    }

	// NULL 인 경우 ""로 
    public String checkNull(String str) {
        String strTmp;
        if (str == null)
            strTmp = "";
        else
            strTmp = str;
        return strTmp;
    }

// *******************************************************************************
    // 페이지 수 구하기
	public int getPageCount(int numPerPage, int dataCount) {
		int pageCount = 0;
		int remain;

		 // 총 페이지 수를 구하기 위한 나머지 계산
		remain = dataCount % numPerPage;
		//System.out.println(remain);
		if(remain == 0)
			pageCount = dataCount / numPerPage;
		else
			pageCount = dataCount / numPerPage + 1;

		return pageCount;
	}
    
// Get 방식에 의한 페이지 처리 메서드 *************************************
    public String pageIndexList(int current_page, int total_page, String list_url) {
        int numPerBlock = 5;   // 리스트에 나타낼 페이지 수
        int currentPageSetUp;
        int n;
        int page;
        StringBuffer strList = new StringBuffer();
        
        if(current_page == 0)
        	return "";
        
        if(list_url.indexOf("?") != -1)
        	list_url = list_url + "&";
        else
        	list_url = list_url +"?";
        /*페이지 이미지 경로 하드 코딩시 바뀜*/
        // 표시할 첫 페이지
        currentPageSetUp = (current_page / numPerBlock) * numPerBlock;
        if (current_page % numPerBlock == 0)
            currentPageSetUp = currentPageSetUp - numPerBlock;

        // 1 페이지
        if ((total_page > numPerBlock) && (currentPageSetUp > 0)) {
        	strList.append("<a href='"+list_url+"pageNum=1'><img src='/Suwon3d/images/bbs/page_first.gif' alt='맨앞' class='vmiddle' style='cursor: pointer;'/></a>&nbsp;");
        	
           //strList.append("<a href='"+list_url+"pageNum=1'>1</a> ");
        }

        // [Prev] : 총 페이지수가 numPerBlock 이상인 경우 이전 numPerBlock 보여줌
        n = current_page - numPerBlock;
        if (total_page > numPerBlock && currentPageSetUp > 0) {
        	strList.append("<a href='"+list_url+"pageNum="+n+"'><img src='/Suwon3d/images/bbs/page_prev.gif' alt='이전' class='vmiddle mar_r5' /></a>&nbsp;");
           //strList.append("[<a href='"+list_url+"pageNum="+n+"'>Prev</a>] ");
        }

        // 바로가기 페이지 구현
        page = currentPageSetUp + 1;
        while((page <= total_page) && (page <= currentPageSetUp + numPerBlock)) {
           if(page == current_page) {
             strList.append("[<font color='Fuchsia'>"+page+"</font>]&nbsp;");
           }
           else {
             strList.append("[<a href='"+list_url+"pageNum="+page+"'>"+page+"</a>]&nbsp;");
           }
           page++;
        }

        // [Next] : 총 페이지수가 numPerBlock 페이지 이상인 경우 다음 numPerBlock 페이지를 보여줌
        // n = currentPageSetUp + numPerBlock + 1;
        n = current_page + numPerBlock;
        if (total_page - currentPageSetUp > numPerBlock) {
        	strList.append("<a href='"+list_url+"pageNum="+n+"'><img src='/Suwon3d/images/bbs/page_next.gif' alt='다음' class='vmiddle mar_l5' style='cursor: pointer;'/></a>&nbsp;");
        	
			//strList.append("[<a href='"+list_url+"pageNum="+n+"'>Next</a>] ");
        }

        // 마지막 페이지
        if ((total_page > numPerBlock) && (currentPageSetUp + numPerBlock < total_page)) {
        	strList.append("<a href='"+list_url+"pageNum="+total_page+"'><img src='/Suwon3d/images/bbs/page_last.gif' alt='맨뒤' class='vmiddle' style='cursor: pointer;'/></a>");
        	
			//strList.append("<a href='"+list_url+"pageNum="+total_page+"'>"+total_page+"</a>");
        }

        return strList.toString();
    }
    
 // 상민 ajax사용위해 만듬 함수  *************************************
    public String pageIndexList(int current_page, int total_page, String fnName, String param) {
        
    	int numPerBlock = 5;   // 리스트에 나타낼 페이지 수
        int currentPageSetUp;
        int n;
        int page;
        
        StringBuffer strList = new StringBuffer();
        
        if(current_page == 0)
        	return "";
        
        
        /*페이지 이미지 경로 하드 코딩시 바뀜*/
        // 표시할 첫 페이지
        currentPageSetUp = (current_page / numPerBlock) * numPerBlock;
        if (current_page % numPerBlock == 0)
            currentPageSetUp = currentPageSetUp - numPerBlock;

        // 1 페이지
        if ((total_page > numPerBlock) && (currentPageSetUp > 0)) {
        	strList.append("<a href='javascript:fn_setPage(1);"+fnName+"(\""+param+"\");'><img src='/Suwon3d/images/bbs/page_first.gif' alt='맨앞' class='vmiddle' style='cursor: pointer;'/></a>&nbsp;");
        	
           //strList.append("<a href='"+list_url+"pageNum=1'>1</a> ");
        }

        // [Prev] : 총 페이지수가 numPerBlock 이상인 경우 이전 numPerBlock 보여줌
        n = current_page - numPerBlock;
        if (total_page > numPerBlock && currentPageSetUp > 0) {
        	strList.append("<a href='javascript:fn_setPage("+n+");"+fnName+"(\""+param+"\");'><img src='/Suwon3d/images/bbs/page_prev.gif' alt='이전' class='vmiddle mar_r5' /></a>&nbsp;");
           //strList.append("[<a href='"+list_url+"pageNum="+n+"'>Prev</a>] ");
        }

        // 바로가기 페이지 구현
        page = currentPageSetUp + 1;
        while((page <= total_page) && (page <= currentPageSetUp + numPerBlock)) {
           if(page == current_page) {
             strList.append("[<font color='Fuchsia'>"+page+"</font>]&nbsp;");
           }
           else {
             strList.append("[<a href='javascript:fn_setPage("+page+");"+fnName+"(\""+param+"\");'>"+page+"</a>]&nbsp;");
           }
           page++;
        }

        // [Next] : 총 페이지수가 numPerBlock 페이지 이상인 경우 다음 numPerBlock 페이지를 보여줌
        // n = currentPageSetUp + numPerBlock + 1;
        n = current_page + numPerBlock;
        if (total_page - currentPageSetUp > numPerBlock) {
        	strList.append("<a href='javascript:fn_setPage("+n+");"+fnName+"(\""+param+"\");'><img src='/Suwon3d/images/bbs/page_next.gif' alt='다음' class='vmiddle mar_l5' style='cursor: pointer;'/></a>&nbsp;");
        	
			//strList.append("[<a href='"+list_url+"pageNum="+n+"'>Next</a>] ");
        }

        // 마지막 페이지
        if ((total_page > numPerBlock) && (currentPageSetUp + numPerBlock < total_page)) {
        	strList.append("<a href='javascript:fn_setPage("+total_page+");"+fnName+"(\""+param+"\");'><img src='/Suwon3d/images/bbs/page_last.gif' alt='맨뒤' class='vmiddle' style='cursor: pointer;'/></a>");
        	
			//strList.append("<a href='"+list_url+"pageNum="+total_page+"'>"+total_page+"</a>");
        }

        return strList.toString();
    }   
// *******************************************************************************

    // 자바 스크립트(listPage 함수)에 의한 페이지 처리 메서드 ***********************
    public String pageIndexList(int current_page, int total_page) {
        int numPerBlock = 5;   // 리스트에 나타낼 페이지 수
        int currentPageSetUp;
        int n;
        int page;
        String strList="";
        
        if(current_page == 0)
        	return "";

        // 표시할 첫 페이지
        currentPageSetUp = (current_page / numPerBlock) * numPerBlock;
        if (current_page % numPerBlock == 0)
            currentPageSetUp = currentPageSetUp - numPerBlock;

        // 1 페이지
        if ((total_page > numPerBlock) && (currentPageSetUp > 0)) {
            strList = "<a onclick='listPage(1);'><img src='/Suwon3d/images/bbs/page_first.gif' alt='맨앞' class='vmiddle' style='cursor: pointer;'/></a>&nbsp;";
        }

        // [Prev] : 총 페이지수가 numPerBlock 이상인 경우 이전 numPerBlock 보여줌
        n = current_page - numPerBlock;
        if (total_page > numPerBlock && currentPageSetUp > 0) {
            strList = strList + "<a onclick='listPage("+n+");'><img src='/Suwon3d/images/bbs/page_prev.gif' alt='이전' class='vmiddle mar_r5'style='cursor: pointer;' /></a>&nbsp;";
        }

        // 바로가기 페이지 구현
        page = currentPageSetUp + 1;
        while((page <= total_page) && (page <= currentPageSetUp + numPerBlock)) {
           if(page == current_page) {
        	   
               strList = strList + "[<font color='Fuchsia'>"+page+"</font>]&nbsp;";
           }
           else {
        	   
               strList = strList +"[<a onclick='listPage("+page+");' style='cursor: pointer;'>"+page+"</a>]&nbsp";
           }
           page++;
        }

        // [Next] : 총 페이지수가 numPerBlock 페이지 이상인 경우 다음 numPerBlock 페이지를 보여줌
        // n = currentPageSetUp + numPerBlock + 1;
        n = current_page + numPerBlock;
        if (total_page - currentPageSetUp > numPerBlock) {
            strList = strList + "<a onclick='listPage("+n+");'><img src='/Suwon3d/images/bbs/page_next.gif' alt='다음' class='vmiddle mar_l5' style='cursor: pointer;'/></a>&nbsp;";
        }

        // 마지막 페이지
        if ((total_page > numPerBlock) && (currentPageSetUp + numPerBlock < total_page)) {
            strList = strList + "<a onclick='listPage("+total_page+");'><img src='/Suwon3d/images/bbs/page_last.gif' alt='맨뒤' class='vmiddle' style='cursor: pointer;'/></a>";
        }

        return strList;
    }

// *******************************************************************************

// Ajax 페이지 처리 메서드 *************************************
    public String ajaxPageIndexList(int current_page, int total_page, String list_url, String targets) {
        int numPerBlock = 10;   // 리스트에 나타낼 페이지 수
        int currentPageSetUp;
        int n;
        int page;
        StringBuffer strList = new StringBuffer();
        
        if(current_page == 0)
        	return "";
        
        if(list_url.indexOf("?") != -1)
        	list_url = list_url + "&";
        else
        	list_url = list_url +"?";

        // 표시할 첫 페이지
        currentPageSetUp = (current_page / numPerBlock) * numPerBlock;
        if (current_page % numPerBlock == 0)
            currentPageSetUp = currentPageSetUp - numPerBlock;

        // 1 페이지
        if ((total_page > numPerBlock) && (currentPageSetUp > 0)) {
           strList.append("<a dojoType='struts:BindAnchor' href='"+list_url+"pageNo=1' targets='"+targets+"' showError='true'>1</a> ");
        }

        // [Prev] : 총 페이지수가 numPerBlock 이상인 경우 이전 numPerBlock 보여줌
        n = current_page - numPerBlock;
        if (total_page > numPerBlock && currentPageSetUp > 0) {
           strList.append("[<a dojoType='struts:BindAnchor' href='"+list_url+"pageNo="+n+"' targets='"+targets+"' showError='true'>Prev</a>] ");
        }

        // 바로가기 페이지 구현
        page = currentPageSetUp + 1;
        while((page <= total_page) && (page <= currentPageSetUp + numPerBlock)) {
           if(page == current_page) {
             strList.append("<font color='Fuchsia'>"+page+" </font>");
           }
           else {
             strList.append("<a dojoType='struts:BindAnchor' href='"+list_url+"pageNo="+page+"' targets='"+targets+"' showError='true'>"+page+"</a> ");
           }
           page++;
        }

        // [Next] : 총 페이지수가 numPerBlock 페이지 이상인 경우 다음 numPerBlock 페이지를 보여줌
        n = current_page + numPerBlock;
        if (total_page - currentPageSetUp > numPerBlock) {
			strList.append("[<a dojoType='struts:BindAnchor' href='"+list_url+"pageNo="+n+"' targets='"+targets+"' showError='true'>Next</a>] ");
        }

        // 마지막 페이지
        if ((total_page > numPerBlock) && (currentPageSetUp + numPerBlock < total_page)) {
			strList.append("<a dojoType='struts:BindAnchor' href='"+list_url+"pageNo="+total_page+"' targets='"+targets+"' showError='true'>"+total_page+"</a>");
        }

        return strList.toString();
    }
// *******************************************************************************
    
    // 8859_1 를 euc-kr로
    public String isoToEuc(String str) {
        String convStr = null;
        try {
            if(str == null)
                return "";

            convStr = new String(str.getBytes("8859_1"),"euc-kr");
        } catch (UnsupportedEncodingException e) {
        }
        return convStr;
    }

    // 8859_1 를 utf-8로
    public String isoToUtf(String str) {
        String convStr = null;
        try {
            if(str == null)
                return "";

            convStr = new String(str.getBytes("8859_1"),"utf-8");
        } catch (UnsupportedEncodingException e) {
        }
        return convStr;
    }

    // euc-kr 를 ISO-8859-1 로
    public String eucToIso(String str) {
        String convStr = null;
        try {
            if(str == null)
                return "";

            convStr = new String(str.getBytes("euc-kr"),"8859_1");
        } catch (UnsupportedEncodingException e) {
        }
        return convStr;
    }
    
    // KSC56O1 를 8859_1로
    public String fromKorean(String str) {
        String convStr = null;
        try {
            if(str == null)
                return "";

            convStr = new String(str.getBytes("KSC5601"),"8859_1");
        } catch (UnsupportedEncodingException e) {
        }
        return convStr;
    }
    
    // euc-kr 를 KSC5601 로
    public String eucToKsc(String str) {
        String convStr = null;
        try {
            if(str == null)
                return "";

            convStr = new String(str.getBytes("euc-kr"),"8859_1");
            convStr = new String(convStr.getBytes("8859_1"),"KSC5601");
        } catch (UnsupportedEncodingException e) {
        }
        return convStr;
    }
    
    //초성검색************************************************

public Object getNComboList(HashMap<String, String> map){
	//RoadSearchService road;
		
		String sggName = nullCheck(map.get("sggName"));
		map.put("sggName",sggName);
		
		String startVal = makeSetCho(map.get("r_cho"));
		map.put("startVal", startVal);	
		
		String endVal = makeSetCho2(map.get("r_cho"));	
		map.put("endVal", endVal);
	
		return  map;//road.getRnSearch(map);
	}



    public String makeSetCho(String r_cho) {
		String startVal=null;//, endVal=null;
		if (r_cho.equals("a")) {
			startVal = "가";
		} else if (r_cho.equals("b")) {
			startVal = "나";

		} else if (r_cho.equals("c")) {
			startVal = "다";

		} else if (r_cho.equals("d")) {
			startVal = "라";

		} else if (r_cho.equals("e")) {
			startVal = "마";

		} else if (r_cho.equals("f")) {
			startVal = "바";

		} else if (r_cho.equals("g")) {
			startVal = "사";

		} else if (r_cho.equals("h")) {
			startVal = "아";

		} else if (r_cho.equals("i")) {
			startVal = "자";

		} else if (r_cho.equals("j")) {
			startVal = "차";

		} else if (r_cho.equals("k")) {
			startVal = "카";

		} else if (r_cho.equals("l")) {
			startVal = "타";

		} else if (r_cho.equals("m")) {
			startVal = "파";

		} else if (r_cho.equals("n")) {
			startVal = "하";

		} 

		return startVal;
	}

    public String makeSetCho2(String r_cho) {
		String  endVal=null;
		if (r_cho.equals("a")) {

			endVal = "나";
		} else if (r_cho.equals("b")) {

			endVal = "다";
		} else if (r_cho.equals("c")) {

			endVal = "라";
		} else if (r_cho.equals("d")) {

			endVal = "마";
		} else if (r_cho.equals("e")) {

			endVal = "바";
		} else if (r_cho.equals("f")) {

			endVal = "사";
		} else if (r_cho.equals("g")) {

			endVal = "아";
		} else if (r_cho.equals("h")) {

			endVal = "자";
		} else if (r_cho.equals("i")) {

			endVal = "차";
		} else if (r_cho.equals("j")) {

			endVal = "카";
		} else if (r_cho.equals("k")) {

			endVal = "타";
		} else if (r_cho.equals("l")) {

			endVal = "파";
		} else if (r_cho.equals("m")) {

			endVal = "하";
		} else if (r_cho.equals("n")) {

			endVal = "히";
		} 
		return endVal ;
	}
    
    
    private String nullCheck(String value){
		if(value==null){
			return "";
		}else if(value.equals("undefined")){
			return "";
		}else{
			return value;
		}
    }    
    
}
