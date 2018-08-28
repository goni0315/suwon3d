<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>3차원공간정보활용시스템</title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css" />

<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<script type="text/javascript" src="${ctx}/js/xdk.js"></script>

<script type="text/javascript">
var Start_point0;
var Start_point1;
var Start_point2;
var End_point0;
var End_point1;
var End_point2;
var Pointcnt = 0;

//가시권 시작점
function gasiStart(){ 
	top.XDOCX.XDSetMouseState(0);
	top.setWorkMode('Gs_Start_point');
	
}
//가시권 목표점
function gasiEnd(){ 
	top.XDOCX.XDSetMouseState(0);
	top.setWorkMode('Gs_End_point');
	
}
//가시권 실행
function gasiExe(){ 
	if ((Start_point0!=null) && (Start_point1!=null) && (Start_point2!=null)) {
		
	}else{
		alert("분석시점이 없습니다. 분석시점을 다시 입력해주세요.");
	return;
	}
	if ((Start_point0!=null) && (Start_point1!=null) && (Start_point2!=null)) {
		
	}else{
		alert("분석시점이 없습니다. 분석시점을 다시 입력해주세요.");
	return;
	}	
	
	var rt = "";
		
	top.XDOCX.XDRefSetColor(255, 0, 255, 0);			
	top.XDOCX.XDAnsViewShedSetColor(0);
	top.XDOCX.XDAnsViewShedSetColor(1);
	top.XDOCX.XDRefSetColor(255, 255, 0, 0);
	top.XDOCX.XDAnsViewShedSetColor(2);

     //참조색 사용 후 기본색으로 복귀
    top.XDOCX.XDRefSetColor(255, 255, 255, 255);
     
	top.XDOCX.XDAnsSetViewElement(ViewAngle.value, 1);
	
	rt = top.XDOCX.XDAnsCreateViewshed(parseFloat(Start_point0), parseFloat(Start_point1 +  Number(ViewHeight.value)), parseFloat(Start_point2), parseFloat(End_point0), parseFloat(End_point1), parseFloat(End_point2));
	Result(rt);
}
//결과창
function Result(rt){
	Pointcnt++;
    var info = rt.split(",");
    var tArea = parseInt(info[0]*100)/100;
    var gZone = parseInt(info[1]*100)/100;
    var rZone = Math.round((parseFloat(gZone) / parseFloat(tArea)) * 100)+"%";

    $('#bbsCont1').append($('<tr>'+
			'<td width="80" align="center">'+Pointcnt+'</td>'+
			'<td width="80" align="center">'+rZone+'</td>'+
			'<td width="80" align="center">'+gZone+'</td>'+
			'<td width="80" align="center">'+tArea+'</td>'+
			'</tr>'
	));
}
//초기화
function gasiClear(){
	top.XDOCX.XDLayClear("Temporary");
	Pointcnt=0;
	top.XDOCX.XDMapRenderLock(true);
	top.XDOCX.XDViewAreaClear();
	top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDMapRenderLock(false);
	top.XDOCX.XDMapResetRTT();
	top.XDOCX.XDMapRender();
	Start_point0=null;
	End_point0=null;
	$('#bbsCont1').empty();
	$('#bbsCont1').append($('<tr>'+
		'<tr>'+
		'<th width="80">No</th>'+
		'<th width="80">가시비율</th>'+
		'<th width="80">가시범위</th>'+
		'<th width="80">전체범위</th>'+
		'</tr>'
	));
}

</script>
<script type="text/javascript" for="XDOCX" event="MouseUp(Button, Shift, sx, sy)" >
	MouseUpEventHandler(Button, Shift, sx, sy);
</script>
</head>
<body>
	<div id="panel">
		<div id="title">
			<div id="category">
				<ul style="width: 320px;">
					<li style="float: left;"><a href="gasi.jsp" target="left"><img src="${ctx}/images/btn_gasi_on.gif" alt="가시권" /></a></li>
					<li style="float:left;margin-left: 4px;"><a href="gasi_zone.jsp" target="left"><img src="${ctx}/images/btn_gasiZone_off.gif" alt="가시권역" /></a></li>
					<li style="float: right">
						<a href="sasun.jsp"target="left">
							<img src="${ctx}/images/btn_sasun_off.gif" alt="사선분석" />
						</a>
				  </li>
					<li style="padding-top: 15px; clear: both;"><img src="${ctx}/images/category_SIDE.gif" /></li>
				  <li class="f_whit_am">분석시점설정</li>
					<li style="float:left;margin: 0 3px 0 0;">
						<a href="#" onclick="gasiStart()"><img src="${ctx}/images/btn_gasi_point.gif"/></a>
					</li>
					<li style="margin: 0 3px 0 0;float:left;">
						<a href="#" onclick="gasiEnd()"><img src="${ctx}/images/btn_Gasi_ta.gif"/></a>
					</li>
					<li style="margin: 0 3px 0 0; float:left;">
						<a href="#" onclick="gasiClear()"><img src="${ctx}/images/btn_analysis_cancel.gif"/></a>
					</li>
                    <li></li>
				</ul>
				<fieldset style="clear:both;padding:5px;margin-top:10px;">
	  			<legend class="f_whit_am">분석설정옵션</legend>
						<ul>
							<li style="float: left;">가시각 
							   <input type="text" name="ViewAngle" id="ViewAngle" value="90" /> 도
							</li>
							<li style="clear: both;">시야높이 
							  <input type="text" name="ViewHeight" id="ViewHeight" value="1.7" /> m
							</li>
						</ul>
					</fieldset>
			<a href="#" onclick="gasiExe()"><img src="${ctx}/images/btn_ok.gif" style="margin:10px 0 10px 0; float:right;"/></a>
			</div>
		</div>
		<div>
		<div class="f_whit_am" style="width:340px; margin-top: 30px; margin-left: 10px">
			분석 결과 
		</div>
			<div id="bbsCont1" style="height: 100%; overflow-y: yes; width: 330px;">
				<table border="0" cellpadding="0" cellspacing="0" class="wps_100" title="가시결과list" summary="가시결과list">
					<tr>
						<th width="70">No</th>
						<th width="70">가시비율</th> 
						<th width="90">가시범위(㎡)</th>
						<th width="90">전체범위(㎡)</th>
					</tr>
				</table>
		</div>
	</div>
</body>
</html>
