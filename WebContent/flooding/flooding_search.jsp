<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xml:lang="ko">
<head>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css"/>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>3차원공간정보활용시스템</title>
<script type="text/javascript">
function floodSearch(){//(최종)전체검색

	document.getElementById("flo_year").value= $("#year option:selected").text();//성공
	document.getElementById("flo_loc").value= $("#loc option:selected").text();
	document.getElementById("flo_sot").value= $("#sort option:selected").text();
	var flo_year = document.getElementById("flo_year").value;
	var flo_loc= document.getElementById("flo_loc").value;
	var flo_sot = document.getElementById("flo_sot").value;
	
	if(flo_year=="전체"){
		flo_year="";
	} 	
	if(flo_loc=="전체"){
		flo_loc="";
	} 
	if(flo_sot=="전체"){
		flo_sot="";
	} 
	
	//useText = use;
	//alert(useText);
	var frm = document.getElementById("frm");
	var grade = $("#grade option:selected").val();
	var use = $("#use option:selected").val();	
	
	frm.action = '${ctx}/FloodSearch.do';
 	frm.target = 'searchList'; 
	frm.submit();
	
 	top.XDOCX.XDLaySetVisible('FL_CHIMSL',true);
	top.XDOCX.XDLaySetVisible('FL_CHIMSL_T',true);
	top.XDOCX.XDLaySetVisible('FL_CHIMWL',true);
	top.XDOCX.XDLaySetVisible('FL_CHIMWL_T',true);
}
function floodInfo(flo_seq){
	var w=window.open(WEB_SERVER_URL+"/FloodInfo.do?flo_seq="+flo_seq,"_blank","width=400px,height=210px");
	var winxpos = (window.screen.width-1250)/2;
	var winypos = (window.screen.height-685)/2;
	w.moveTo(winxpos,winypos);
}
</script>
</head>

<body style="background:url(${ctx}/images/category_bg1.gif)">
<form id="frm" action="" method="post">
<input type="hidden" id="flo_year" name="flo_year" value=""></input>
<input type="hidden" id="flo_loc" name="flo_loc" value=""></input>
<input type="hidden" id="flo_sot" name="flo_sot" value=""></input>
<div id="panel">
    <div id="title">
        <div id="category1">
       <ul style="width:320px;">
       <li style="float:right;"><a href="${ctx}/flooding/flooding_add.jsp" target="left"><img src="${ctx}/images/btn_flooding_add_off.gif" alt="가시권"/></a>
        </li>
        <li style="float:left"><a href="${ctx}/flooding/flooding_search.jsp" target="left"><img src="${ctx}/images/btn_flooding_search_on.gif" alt="가시권역"/></a>
        </li>
        <li style=" padding-top:15px;clear:both; "><img src="${ctx}/images/category_SIDE.gif" /></li>
        </ul>
		<fieldset  style="padding:5px;">
        <legend class="f_whit_am">침수지역검색</legend>
             <ul style="padding:5px;">
            <li style="float:left;">
              <label for="textfield">침수년도</label>
              <select name="year" id="year" style="width:100px">
                <option value="">전체</option>
                <option value="1">2012</option>
                <option value="2">2009</option>
                </select>
            </li>
            <li style=" clear:both;">
              <label for="textfield">침수지구</label>
				<select name="loc" id="loc" style="width:100px">
				<option value="">전체</option>
                <option value="1">고색1지구</option>
                <option value="2">평동지구</option>
                </select>
            </li>            
            <li style=" clear:both;">
              <label for="textfield">침수형태</label>
				<select name="sort" id="sort" style="width:100px">
				<option value="">전체</option>
                <option value="1">집중호우</option>                
                </select>
            </li>                       
            </ul>
        </fieldset>

        <hr />
		<input type="image" src="${ctx}/images/btn_search.gif" align="absmiddle" onClick="floodSearch()" style="margin:10px 0 10px 0; float:right;"/>
	  </div>
    </div>
    <div>
        <h4><img src="${ctx}/images/result_title1.gif" alt="결과" width="340" height="34"/></h4>
        <div id="bbsCont" style="height:100%; overflow-y:yes; width:340px;">
          <table border="0" cellpadding="0" cellspacing="0" class="wps_100" summary="가시결과list">
           <col class="w_40"/>
			<col />
            <col class="w_60"/>
            <thead>
            <tr>
              <th>NO</th>
              <th>정보</th>
              <th>이동/정보</th>
            </tr>
            <c:if test="${not empty floodSearchList}">
            <c:forEach var="sms" items="${floodSearchList}"  varStatus="status">
            <tr>
              <td rowspan="2" align="center" class="f_dblue_b">${status.count}</td>
              <td class="f_orange_b">${sms.flo_loc} (${sms.flo_year}년)</td>
              <td rowspan="2"><a href="#"><img src="${ctx}/images/btn_info.gif" alt="상세정보" style="margin-top:2px;" onClick="floodInfo('${sms.flo_seq}')" /></a></td>
            </tr>
            <tr>
              <td>재해명 : ${sms.dmg_nm}</td>
              </tr>
             </c:forEach>
             </c:if>
             <c:if test="${empty floodSearchList}"> 
             <tr>
              <td colspan="3">검색리스트가 없습니다</td>
            </tr>
             </c:if>
              <iframe id="searchList" name="searchList" src="${ctx}/floodingBlinkList.do" frameborder="0" width="100%" height="620px" scrolling="no" />                                                 
          </table>
        </div>
    </div>
</div>
</form>
</body>
</html>
