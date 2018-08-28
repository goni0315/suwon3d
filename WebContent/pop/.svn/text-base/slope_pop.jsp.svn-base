<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>경사분석</title>

<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<script type="text/javascript">
//처음 경사도 화면이 나타날 수 있도록 설정
$('#grade').css("display", "block");
$('#slope').css("display", "none");

//경사도,향 영역지정
function area(){
	
	top.XDOCX.XDUIClearInputPoint();
	top.parent.parent.XDOCX.XDLayRemove("slant");
	top.parent.parent.XDOCX.XDUISetWorkMode(24);
	
}

//경사도,향 영역지정취소
function areaCancel(){ //input button 생성

	top.XDOCX.XDUIClearInputPoint();
	top.MapControl('map_clear');
	
}

//경사도 실행
function gradeExe(){ //input button 생성
	if (top.XDOCX.XDUIInputPointCount() > 2){
		top.XDOCX.XDLayRemove("slant");
		top.XDOCX.XDLayCreateEX(1, "slant", 1, 30000);
		top.XDOCX.XDLaySetEditable("slant");
		result = top.XDOCX.XDAnsTerrainAvgSlove();
		
		top.XDOCX.XDMapResetRTT();
		top.XDOCX.XDMapRender();
		top.XDOCX.XDUISetWorkMode(1);
	
		var txtsp = result.split(",");
		
		txt01.value = new String( Math.round((new Number(txtsp[0])*100) / 100) );
		txt02.value = new String( Math.round((new Number(txtsp[2])*100) / 100) );
		txt03.value = new String( Math.round((new Number(txtsp[1])*100) / 100) );
		
		top.setIndicator('경사도', {
     	   '평균경사': txt01.value, 
     	   '최대경사': txt02.value, 
     	   '최소경사': txt03.value
     	});
        

	}else{
		alert("3개 이상의 점을 입력해야 합니다.");
	}
    
}

//경사향 분석
function slopeExe(){ 
	
	if (top.XDOCX.XDUIInputPointCount() > 2)
	{
		top.XDOCX.XDLayRemove("slantDirection");
		top.XDOCX.XDLayCreateEX(1, "slantDirection", 1, 30000);
		top.XDOCX.XDLaySetEditable("slantDirection");

	    result = top.XDOCX.XDAnsTerrainAvgDirect();

	    top.XDOCX.XDMapResetRTT();
	    top.XDOCX.XDMapRender();
	    top.XDOCX.XDUISetWorkMode(1);

		var avgDirection = ''; // 평균경사향
		var avgAngle = ''; // 평균경사도

		avgAngle = parseInt(result*100)/100; // 평균경사도
		
	    if (result <= 12.25 && result > -12.25){
			avgDirection = '북향';
	    }else if (result <= 33.75 && result > -12.25){
			avgDirection = "북북동향";
	    }else if (result <= -12.5 && result > -33.75){
			avgDirection =  "북북서향";
	    }else if (result <= 56.25 && result > 33.75){
			avgDirection =  "북동향";
	    }else if (result <= -33.75 && result > -56.25){
			avgDirection =  "북서향";
	    }else if (result <= 78.75 && result > 56.25){
			avgDirection = "북동동향";
	    }else if (result <= -56.25 && result > -78.75){
			avgDirection =  "북서서향";
	    }else if (result <= 101.25 && result > 78.75){
			avgDirection = "동향";
	    }else if (result <= -78.75 && result > -101.25){
			avgDirection = "서향";
	    }else if (result <= 123.75 && result > 101.25){
			avgDirection = "남동동향";
	    }else if (result <= -101.25 && result > -123.75){
			avgDirection =  "남서서향";
	    }else if (result <= 146.25 && result > 123.75){
			avgDirection = "남동향";
	    }else if (result <= -123.75 && result > -146.25){
			avgDirection = "남서향";
	    }else if (result <= 168.75 && result > 146.25){
			avgDirection = "남남동향";
	    }else if (result <= -146.25 && result > -168.75){
			avgDirection =  "남남서향";
	    }else if (result <= 180 && result > 168.75){
			avgDirection = "남향";
	    }else if (result <= -168.75 && result >= -180){
			avgDirection =  "남향";
	    }else{
			alert("오류가 발생하였습니다.");
	    }
		
	    avgDirectionResult.value = avgDirection;
	    
	    top.setIndicator('경사향', {
     		'평균경사향': avgDirection
     	});

	}else{
		alert("3개 이상의 점을 입력해야 합니다.");
	}
}
//경사향 초기화
function slopeClear(){
	top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDLayRemove("slantDirection");
	top.XDOCX.XDUISetWorkMode(1);
	top.XDOCX.XDMapResetRTT();
	top.XDOCX.XDMapRender();
}
//경사도 초기화
function gradeClear(){
	top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDLayRemove("slant");
	top.XDOCX.XDUISetWorkMode(1);
	top.XDOCX.XDMapResetRTT();
	top.XDOCX.XDMapRender();
}

//경사도, 경사향 탭만들기
function displaypan(val){
	if(val == 1){
		$('#grade').css("display", "block");
		$('#slope').css("display", "none");
	}else{
		$('#slope').css("display", "block");
		$('#grade').css("display", "none");
	}
}
</script>
</head>
<body onBulr="self.focus();">
	<div id="grade" style="width: 350px; height: 320px; border: solid 1px #2c3445;">
		<div style="background: #2c3445; margin: 2px;">
			<p style="float: right;">
				
			</p>
			<p class="f_whit_am">경사분석</p>
		</div>
		<ul style="margin: 5px;">
			<li style="float: left;">
				<a href="#" onclick="displaypan(1);">
					<img src="${ctx}/images/pop/slope01_on.gif" />
				</a>
			</li>
			<li>
				<a href="#" onclick="displaypan(2);">
					<img src="${ctx}/images/pop/slope02_off.gif" />
				</a>
			</li>
		</ul>
		<p>
			<img src="${ctx}/images/category_SIDE.gif" alt="" />
		</p>
		<ul style="margin: 5px;">
			<li style="float: left; margin-right: 3px;">
				<a href="#" onclick="area()">
					<img src="${ctx}/images/pop/btn_sel_A.gif" />
				</a>
			</li>
			<li style="margin-right: 3px; float: left;">
				<a href="#" onclick="gradeExe()">
					<img src="${ctx}/images/pop/btn_slope_s.gif" />
				</a>
			</li>
			<li style="margin-right: 3px;">
				<a href="#" onclick="areaCancel();gradeClear()">
					<img src="${ctx}/images/pop/btn_cancel.gif" />
				</a>
			</li>
			<li><span style="padding-top: 5px; clear: both;"><img src="${ctx}/images/category_SIDE1.gif" alt="" /></span></li>
			<li>평균경사도 <input type="text" name="textbox" id="txt01" style="width: 90px;" readonly="readonly"/>
			</li>
			<li style="float: left;">최대경사도 <input type="text" name="LowHeight0" id="txt02" style="width: 90px;" readonly="readonly"/>
			</li>
			<li>최소경사도 <input type="text" name="HiHeight0" id="txt03" style="width: 90px;" readonly="readonly"/>
			</li>
			<li><span style="padding-top: 5px; clear: both;"><img src="${ctx}/images/category_SIDE1.gif" alt="" /></span></li>
		</ul>
		<table width="345" border="0" cellspacing="2" style="margin: 3px;">
			<tr>
				<td width="39" bgcolor="#E11900">&nbsp;</td>
				<td width="124">45도이상</td>
				<td width="39" bgcolor="#649600">&nbsp;</td>
				<td width="125">20도이상25도미만</td>
			</tr>
			<tr>
				<td bgcolor="#CC3001">&nbsp;</td>
				<td>40도이상45도미만</td>
				<td bgcolor="#4CAD08">&nbsp;</td>
				<td>15도이상20도미만</td>
			</tr>
			<tr>
				<td bgcolor="#B04A00">&nbsp;</td>
				<td>35도이상40도미만</td>
				<td bgcolor="#39C500">&nbsp;</td>
				<td>10도이상15도미만</td>
			</tr>
			<tr>
				<td bgcolor="#966401">&nbsp;</td>
				<td>30도이상35도미만</td>
				<td bgcolor="#19E200">&nbsp;</td>
				<td>5도이상10도이하</td>
			</tr>
			<tr>
				<td bgcolor="#7D7D02">&nbsp;</td>
				<td>25도이상30도미만</td>
				<td bgcolor="#01FF02">&nbsp;</td>
				<td>0도이상5도미만</td>
			</tr>
			<tr>
				<td colspan="4"><p style="color: #F00;">시스템에 의한 산출결과는 수치지형도의 등고선을 이용한 분석값이므로 실제 측령값과 상이할 수 있습니다</p></td>
			</tr>
		</table>

	</div>
	
	
	<!--경사향분석-->
	<div id="slope" style="width: 350px; height: 320px; border: solid 1px #2c3445;">
		<div style="background: #2c3445; margin: 2px;">
			<p style="float: right;">
			</p>
			<p class="f_whit_am">경사분석</p>
		</div>
		<ul style="margin: 5px;">
			<li style="float: left;">
				<a href="#" onclick="displaypan(1);">
					<img src="${ctx}/images/pop/slope01_off.gif" />
				</a>
			</li>
			<li>
				<a href="#" onclick="displaypan(2);">
					<img src="${ctx}/images/pop/slope02_on.gif" />
				</a>
			</li>
		</ul>
		<p>
			<img src="${ctx}/images/category_SIDE.gif" alt="" />
		</p>
		<ul style="margin: 5px;">
			<li style="float: left;">
				<a href="#" onclick="area()">
					<img src="${ctx}/images/pop/btn_sel_A.gif" />
				</a>
			</li>
			<li style="float: left;">
				<a href="#" onclick="slopeExe()">
					<img src="${ctx}/images/pop/btn_slope_s.gif" />
				</a>
			</li>
			<li>
				<a href="#" onclick="areaCancel();slopeClear()">
					<img src="${ctx}/images/pop/btn_cancel.gif" />
				</a>
			</li>
			<li><span style="padding-top: 5px; clear: both;"><img src="${ctx}/images/category_SIDE1.gif" alt="" /></span></li>
			<li>평균경사향 <input type="text" id="avgDirectionResult" style="width: 90px;" />
			</li>
			<li style="padding-top: 5px; clear: both;"><span><img src="${ctx}/images/category_SIDE1.gif" alt="" /></span></li>
		</ul>
		<table width="338" height="130" border="0" cellspacing="2" style="margin: 3px;">
			<tr>
				<td width="100" bgcolor="#FF6200">&nbsp;</td>
				<td width="48">북</td>
				<td width="98" bgcolor="#FAB201">&nbsp;</td>
				<td width="55">북동</td>
			</tr>
			<tr>
				<td bgcolor="#FFFD03">&nbsp;</td>
				<td>동</td>
				<td bgcolor="#32FF96">&nbsp;</td>
				<td>남동</td>
			</tr>
			<tr>
				<td bgcolor="#0064FF">&nbsp;</td>
				<td>남</td>
				<td bgcolor="#F36480">&nbsp;</td>
				<td>남서</td>
			</tr>
			<tr>
				<td bgcolor="#952A98">&nbsp;</td>
				<td>서</td>
				<td bgcolor="#C10461">&nbsp;</td>
				<td>북서</td>
			</tr>
		</table>
	</div>
</body>
</html>
