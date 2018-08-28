<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css"/>
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<script type="text/javascript">
function shelterInfo(dep_seq){
	
	var w=window.open(WEB_SERVER_URL+"/ShelterInfo.do?dep_seq="+dep_seq,"_blank","width=450px,height=190px");
//	window.moveTo(screen.availWidth/2-900/2,screen.availHeight/2 - 550/2);	
	var winxpos = (window.screen.width-1250)/2;
	var winypos = (window.screen.height-685)/2;
	w.moveTo(winxpos,winypos);

}
/*
 * 좌표이동
 */
function doView(layer, keycode){

	var pos = top.XDOCX.XDSrcObjPosition(layer, keycode, false);
	pos = pos.split(',');
	top.searchXDPointPosition2(pos[0], pos[2]);
	
}

</script>
</head>
<body>
        <div id="bbsCont" style="height:100%; overflow-y:scroll; width:330px;">
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
                <c:if test="${not empty emdJibunList}">
                <c:forEach var="sms" items="${emdJibunList}"  varStatus="status">
            <tr>
              <td rowspan="3" align="center" class="f_dblue_b">${status.count}</td>
              <td class="f_orange_b" onclick="doView('KO3D_PL_BBND', '<c:out value="${sms.pnu}"></c:out>')" style="cursor: pointer;">${sms.fac_nm}</td> 
              <td rowspan="2"><%-- <img src="${ctx}/images/btn_mapmove.gif" alt="지도이동"/> --%><a href="#"><img src="${ctx}/images/btn_info.gif" alt="상세정보" style="margin-top:2px;" onclick="shelterInfo('${sms.dep_seq}')"/></a>
              </td>
            </tr>
            <tr>
              <td>${sms.dep_addr }</td>
              </tr>
            <tr>
              <td>${sms.use_nm}</td><td></td>
            </tr>
            	</c:forEach>
            	</c:if>
              	<c:if test="${empty emdJibunList}">
	   		 	  <tr>
	       	 		<td colspan=5>검색된 게시물이 없습니다.</td>
	         	  </tr>	
			  	</c:if>                	
          </table>
    <br><c:if test="${total_dataCount != 0}">
			<div align="center">
				<span height="30" style="font-size: 12px">${pageIndexList}</span>
			</div>
		</c:if>
        </div>
</body>
</html>