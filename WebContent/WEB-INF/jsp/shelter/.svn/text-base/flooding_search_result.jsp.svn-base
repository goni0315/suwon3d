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
/*
 * 팝업창 상세정보
 */
function floodInfo(flo_seq){
	var w=window.open(WEB_SERVER_URL+"/FloodInfo.do?flo_seq="+flo_seq,"_blank","width=400px,height=210px");
	var winxpos = (window.screen.width-1250)/2;
	var winypos = (window.screen.height-685)/2;
	w.moveTo(winxpos,winypos);
}
/*
 * 좌표이동
 */
function doView(layer, keycode){
	if(keycode=='1933'){//2012년도
 	top.XDOCX.XDCamSetLookAt(199040.031250,23.9,516706.375000,280,90);
	
	//var pos = top.XDOCX.XDSrcObjPosition(layer, keycode, false);
	//pos = pos.split(',');
	//alert(pos);
	//top.searchXDPointPosition(pos[0], pos[2]);
	}
	if(keycode=='1394'){//2009년도
	 	top.XDOCX.XDCamSetLookAt(199533.343750,26.200001,517593.062500,280,90);
		
/* 		var pos = top.XDOCX.XDSrcObjPosition(layer, keycode, false);
		pos = pos.split(',');
		alert(pos);
		top.searchXDPointPosition(pos[0], pos[2]); */
	}
}
</script>
</head>
<body>
<div id="bbsCont" style="width:320px;  overflow-y:auto;">
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
              <td rowspan="2" align="center" class="f_dblue_b">${status.count}</td><!--'<c:out value="${sms.pnu}"></c:out>'  -->
              <td class="f_orange_b" onClick="javascript:doView('FL_CHIMWL_T', '<c:out value="${sms.flo_xy}"></c:out>')" style="cursor: pointer;">${sms.flo_loc} (${sms.flo_year}년)</td>
              <td rowspan="1"><a href="#"><img src="${ctx}/images/btn_info.gif" alt="상세정보" style="margin-top:2px;" onClick="floodInfo('${sms.flo_seq}')" /></a></td>
            </tr>
            <tr>
              <td>재해명 : ${sms.dmg_nm}</td><td></td>
              </tr>
             </c:forEach>
             </c:if>
             <c:if test="${empty floodSearchList}"> 
             <tr>
              <td colspan="2">검색리스트가 없습니다</td><td></td>
            </tr>
             </c:if>              
          </table>
        </div>
</body>
</html>