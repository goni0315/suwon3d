<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css" />
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript">
var Center_point0;
var Center_point1;
var Center_point2;
var Pointcnt2 = 0;

function gasi_roundStart(){ //input button 생성
	top.XDOCX.XDSetMouseState(0);
	top.setWorkMode('Gs_Center_point');
}

function gasi_roundExe(){ //input button 생성
	
	if ((Center_point0!=null) && (Center_point1!=null) && (Center_point2!=null)) {
		
	}else{
		alert("가시권역_중심점이 없습니다. 분석시점을 다시 입력해주세요.")
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
     
	top.XDOCX.XDAnsSetViewElement(360, 1);
	
	rt = top.XDOCX.XDAnsCreateViewshed(parseFloat(Center_point0), parseFloat(Center_point1) +  parseFloat(ViewHeight2.value), parseFloat(Center_point2), parseFloat(Center_point0), parseFloat(Center_point1), parseFloat(Center_point2) +  parseFloat(ViewArea.value));
	Result(rt)
    
}
function Result(rt){
	Pointcnt2++;
    var info = rt.split(",");
    var tArea2 = parseInt(info[0]*100)/100;
    var gZone2 = parseInt(info[1]*100)/100;
    var rZone2 = Math.round((parseFloat(gZone2) / parseFloat(tArea2)) * 100)+"%";

    $('#bbsCont1').append($('<tr>'+
			'<td width="80" align="center">'+Pointcnt2+'</td>'+
			'<td width="80" align="center">'+rZone2+'</td>'+
			'<td width="80" align="center">'+tArea2+'</td>'+
			'<td width="80" align="center">'+gZone2+'</td>'+
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
</head>
<body>
	<div id="panel">
		<div id="title">
			<div id="category" style="margin-top: 35px;">
				<ul style="width: 320px;">
					<li style="float: left;">
						<a href="gasi.jsp" target="left">
							<img src="${ctx}/images/btn_gasi_off.gif" alt="가시권" />
						</a>
					</li>
					<li style="float:left;margin-left: 4px;">
						<a href="gasi_zone.jsp"target="left">
							<img src="${ctx}/images/btn_gasiZone_on.gif" alt="가시권역" />
						</a>
					</li>
					<li style="float: right">
						<a href="sasun.jsp"target="left">
							<img src="${ctx}/images/btn_sasun_off.gif" alt="사선분석" />
						</a>
					</li>
					<li style="padding-top: 15px; clear: both;"><img src="${ctx}/images/category_SIDE.gif" /></li>

					<li class="f_whit_am">분석시점설정</li>
					<li>
						<a href="#" onclick="gasi_roundStart()"><img src="${ctx}/images/btn_center.gif" width="96" height="24" /></a>
					
						<a href="#" onclick="gasiClear()"><img src="${ctx}/images/btn_analysis_cancel.gif" width="96" height="24" /></a>
					</li>
				</ul>
					<fieldset style="padding:5px">
						<legend class="f_whit_am" style="margin-top: 14px;">분석설정옵션</legend>
						<ul>
							<li style="float: left;">
								반경값 
								  <input type="text" name="ViewArea" id="ViewArea" value="100" /> m
							</li>
							<li style="clear: both;">
								시야높이 
								  <input type="text" name="ViewHeight2" id="ViewHeight2" value="1.7" /> m
							</li>
						</ul>
					</fieldset>
						<a href="#" onclick="gasi_roundExe()">
							<img src="${ctx}/images/btn_ok.gif" style="margin:10px 0 10px 0; float:right;"/>
						</a>
			</div>
		</div>
		<div>
			<div class="f_whit_am" style="width:340px; margin-top: 30px; margin-left: 10px">
				분석 결과 
			</div>
			<div id="bbsCont1" style="height:100%; overflow-y:yes; width:330px;">
			<table border="0" cellpadding="0" cellspacing="0" class="typeH">
				<tr>
					<th width="70">No</th>
					<th width="70">가시비율</th> 
					<th width="90">가시범위(㎡)</th>
					<th width="90">전체범위(㎡)</th>
				</tr>
			</table>
			</div>
		</div>
	</div>
</body>
</html>
