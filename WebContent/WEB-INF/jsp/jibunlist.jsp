<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/css/common.css" />
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>


<script type="text/javascript" src="${ctx}/js/roadView.js"></script>
<script type="text/javascript" src="${ctx}/js/Properties.js"></script>
<script type="text/javascript" src="${ctx}/js/xml2json.js"></script>
<script type="text/javascript" src="${ctx}/js/proj4js-compressed.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.xdomainajax.js"></script>
<script type="text/javascript" src="${ctx}/js/common.js"></script>
<script> 
/*KLIS 한국토지 정보 시스템연계 링크걸기(부동산 정보 열람) */
var bulidNo = "";
function jibunInfo(pnu){
/* 	var url = "${ctx}/realEstateBulidNo.do?pnu=" + pnu;
	$.ajax({
		type:"get",
		timeout : 10000,
		url: url,
		dataType: "json",
		error : function(request, status, error) {
			alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
		},
		success : function(result){
			alert(result);
			bulidNo = result;
		}	
		
	}); */
	//var winform = window.open("${ctx}/realEstateCadastre.do?pnu=" + pnu + "&bulidNo=" + bulidNo,"대장정보조회","toolbar=0, status=0, scrollbars=auto, location=0, menubar=0, width=913px, height=370px");
	var winform = window.open("${ctx}/realEstateCadastre.do?pnu=" + pnu,"대장정보조회","toolbar=no, status=no, scrollbars=no, location=no, menubar=no, width=909px, height=370px");
	winform.moveTo(screen.availWidth/2-1220/2,screen.availHeight/2 - 680/2);
	winform.focus();
}

/*
 * 좌표이동
 */
function doView(layer, keycode){
	
	var pos = top.XDOCX.XDSrcObjPosition(layer, keycode, false);
	pos = pos.split(',');
    
	//영통구 이의동 1197
	if(keycode=="4111710300111970000"){
		top.searchXDPointPosition(204103.093750, 523309.093750);
		return;		
	}
	
	
	top.searchXDPointPosition(pos[0], pos[2]);
	
}
//좌표 변환 관련 prj4.js [S]
Proj4js.defs["SR-ORG:6640"] = "+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=600000 +ellps=GRS80 +units=m +no_defs";
Proj4js.defs['WGS84경위도'] = '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs';
Proj4js.defs['KATEC'] =
'+proj=tmerc +lat_0=38 +lon_0=128 +k=0.9999 +x_0=400000 +y_0=600000 +ellps=bessel +towgs84=-146.43,507.89,681.46,0,0,0,0 +units=m +no_defs';

Proj4js.reportError = function(msg) { alert(msg); }
  
var wgs84 = new Proj4js.Proj('WGS84경위도');
var grs80tm = new Proj4js.Proj('SR-ORG:6640');
var katec = new Proj4js.Proj('KATEC');
//좌표 변환 관련 prj4.js [E]
/**
 * 로드뷰 분기 함수  
 */
function doRoadView(keycode,flag){
	
	var pos = top.XDOCX.XDSrcObjPosition('KO3D_PL_BBND', keycode, false);
	
	pos = pos.split(',');

	var p = new Proj4js.Point(pos[0],pos[2]);
	
	if(flag=="daum"){
		Proj4js.transform(grs80tm, wgs84, p);
		//alert((Math.round(p.x*1000)/1000) +"  /// " + (Math.round(p.y*1000)/1000));
		ShowRoadView(Math.round(p.x*1000)/1000,Math.round(p.y*1000)/1000); //건물 좌표에는 로드뷰 정보가 없어서 반올림해서 표현
		
		
	}else{
		Proj4js.transform(grs80tm, katec, p);
		ShowStreetView(Math.round(p.x),Math.round(p.y));
		
	}
}



</script>
</head>
<body>
	<div id="bbsCont"
		style="height: 100%; overflow-y: auto; width: 320px;">
		<table border="0" cellpadding="0" cellspacing="0" class="wps_100" title="list" summary="list">
			<col class="w_40" />
			<col />
			<col class="w_60" />
			<thead>
				<tr>
					<th>No</th>
					<th>&nbsp;</th>
					<th>&nbsp;</th>
				</tr>
				<c:if test="${not empty jibunList}">

					<c:forEach var="sms" items="${jibunList}" varStatus="status">
						<tr>
							<td rowspan="2" align="center" class="f_dblue_b">${status.count}</td>
							<td class="f_orange_b" onclick="doView('KO3D_PL_BBND', '<c:out value="${sms.pnu}"></c:out>')" style="cursor: pointer;">
							${sms.sgg_nm} ${sms.emd_nm} ${sms.lnbr_mnnm}  
							<c:if test="${sms.lnbr_mnnm eq null}">${sms.jibun}</c:if>
							<c:if test="${sms.lnbr_slno!=null && sms.lnbr_slno!=0}">- ${sms.lnbr_slno}</c:if> 							
							</td>
							<td  align="center"><!--rowspan="2"  -->
								<img src="${ctx}/images/btn_land.gif" alt="토지대장" style="cursor: pointer;" onclick="jibunInfo('${sms.pnu}');doView('KO3D_PL_BBND', '<c:out value="${sms.pnu}"></c:out>')" />
							</td>
						</tr>
						<tr>
							<td><%-- 
								<c:if test="${not empty sms.buld_mnnm}">${sms.sgg_nm} ${sms.rn} ${sms.buld_mnnm} <c:if test="${not empty sms.buld_slno}">- ${sms.buld_slno}</c:if></c:if>
								<c:if test="${empty sms.buld_mnnm}">- </c:if>
								 --%>
								${sms.sgg_nm} ${sms.rn} ${sms.buld_mnnm}
								<c:if test="${sms.buld_slno!=null && sms.buld_slno!=0}">- ${sms.buld_slno}</c:if> 
								 <!--- ${sms.buld_slno}  -->
								<c:if test="${empty sms.rn}">  </c:if>
							</td>
							<td>
								<!-- 로드뷰 기능 삽입 예정 아직 구현 안됨 -->
								<%-- <img src='${ctx}/images/potal/daum.png' alt='로드뷰' style='cursor: pointer;' onclick='doRoadView("${sms.pnu}","daum")' />&nbsp;&nbsp;
								<img src='${ctx}/images/potal/naver.png' alt='거르뷰' style='cursor: pointer;' onclick='doRoadView("${sms.pnu}","naver")'/> --%>
							</td>								
						</tr>
					</c:forEach>
					
				</c:if>
				<c:if test="${empty jibunList}">
					<tr>
						<td colspan=5>검색된 결과가 없습니다.</td>
					</tr>
				</c:if>
		</table>
		<br>
		<c:if test="${total_dataCount != 0}">
			<div align="center">
				<span height="30" style="font-size: 12px">${pageIndexList}</span>
			</div>
		</c:if>
	</div>
</body>
</html>