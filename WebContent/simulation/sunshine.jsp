<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>3차원공간정보활용시스템</title>
<link href="${ctx}/css/admin_common.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/jquery-ui.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css" />

<%-- <script type="text/javascript" src="${ctx}/js/calendar.js"></script> --%>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-ui-1.8.18.custom.min.js"></script>

<script type="text/javascript">

var shadowTime = false;
var input_pos = null; // 측정지점입력

var now = new Date();
var year= now.getFullYear();
var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
var chan_val = year + '-' + mon + '-' + day;

top.exeFunction();

//현재 시간 불러오기
function sunStart(){
	for(var i = 1; i <= 12; i++){
		$("#s_hour").append("<option value="+i+">"+i+"</option>");
		$("#e_hour").append("<option value="+i+">"+i+"</option>");
	}
	for(var i = 1; i <= 59; i++){
		$("#s_minute").append("<option value="+i+">"+i+"</option>");
		$("#e_minute").append("<option value="+i+">"+i+"</option>");
	}
	
	$("#s_hour").val("8").attr("selected", "selected");
	$("#e_hour").val("6").attr("selected", "selected");
	$('#txtDate').val(chan_val);
}

//객체 선택
function buildChoose(){ 
	top.setXDMouseMode(6);
	top.setWorkMode('객체선택');	
}

//측정지점 설정
function sunlightPoint(){ 
	
	top.addFunction(function(pos){
		top.XDOCX.XDObjDelete("Temporary", "측정지점");
		
		top.XDOCX.XDRefSetColor(255, 255, 0, 0);
		top.XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 0, 0, 0);
		top.XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);	
        		
		top.XDOCX.XDLaySetEditable("Temporary");
		top.XDOCX.XDObjCreateText('측정지점', '측정지점', '');
		top.setWorkMode('');
        top.setXDMouseMode(1);
        top.XDOCX.XDMapRender();
	});
	
	top.setXDMouseMode(0);
	top.setWorkMode('측정지점입력');
	
	top.addFunction(function(pos){
		input_pos = pos;
	});
}

/**
 * 측정지점입력
 */
function setAnalysisInputPoint2(){
	input_pos = "199020.1,77.1,436939.1";
	input_pos = input_pos.split(',');
	
	top.XDOCX.XDObjDelete("Temporary", "test");

	top.XDOCX.XDRefSetPos(input_pos[0], input_pos[1], input_pos[2]);
	top.XDOCX.XDRefSetColor(255, 255, 0, 0);
	top.XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 0, 0, 0);
    		
	top.XDOCX.XDLaySetEditable("Temporary");
	if (top.XDOCX.XDObjCreateText('test', '측정지점', '')){
		top.XDOCX.XDMapRender();	
	}    
}

//결과값
function valueCheck(){
	top.exeFunction();
}

//일시정지
function pauseSunlight(){
	top.XDOCX.XDAnsShadowSimulation(0);
	top.setWorkMode('객체선택');	
}

//정지
function stopSunlight(){
	top.XDOCX.XDAnsShadowSimulStop();
	top.XDOCX.XDUIShadowTimeInfo(false);
	top.XDOCX.XDAnsShadowClear();
	top.XDOCX.XDMapRender();

    shadowTime = false;
}

//초기화
function clearSunlight(){ 
	$('#result_time').val('');
	$('#result_x').val('');
	$('#result_y').val('');
	$('#result_z').val('');
	$("#s_hour").val("8").attr("selected", "selected");
	$("#e_hour").val("5").attr("selected", "selected");
	$('#today').val(chan_val);
	
	top.XDOCX.XDAnsShadowSimulStop();
	top.XDOCX.XDUIShadowTimeInfo(false);
	top.XDOCX.XDAnsShadowClear();
	top.XDOCX.XDMapRender();

    shadowTime = false;
    top.mapXDInit();
}


//실행
function doAnalysis(){
	var txtDate = $('#txtDate').val();
	var selectYMD = txtDate.split('-');
    var sYear = selectYMD[0];
	var sMon = selectYMD[1];
	var sDay = selectYMD[2];
	
	if(input_pos == null || input_pos.length != 3){
		alert('측정지점을 입력하십시오.');
		return;
	}

	var s_flag = $('#s_flag').val();
	var s_hour = parseInt($('#s_hour').val());
	var s_minute = $('#s_minute').val();
	//alert('s_flag : ' + s_flag + 's_hour : ' + s_hour);
	var e_flag = $('#e_flag').val();
	var e_hour = parseInt($('#e_hour').val());
	var e_minute = $('#e_minute').val();
	
	if(s_flag == '오후'){
		if(s_hour != 12) s_hour = s_hour + 12;
		else s_hour = 0;
	}
	
	if(e_flag == '오후'){
		if(e_hour != 12) e_hour = e_hour + 12;
		else e_hour = 0;
	}		
	top.initFunction();
	top.addFunction(function(){
		shadowTime = false;
	    var sTmp = top.XDOCX.XDAnsShadowGetSunLightMinute();
	    top.XDOCX.XDUIShadowTimeInfo(false);
	    top.XDOCX.XDAnsShadowClear();
	    top.XDOCX.XDUIClearInputPoint();
	    top.XDOCX.XDSelClear();
	    top.XDOCX.XDMapRender();

	    top.setXDMouseMode(1);
	    
	    	var result_time = sTmp.split(',');

			$('#result_time').val(result_time[0]+'시간 '+result_time[1]+'분');
	    	$('#result_x').val(input_pos[0]);
	    	$('#result_y').val(input_pos[1]);
	    	$('#result_z').val(input_pos[2]);
	    	
	    	top.setIndicator('선택지점',
	    		{
	    			'일조량': result_time[0]+'시간 '+result_time[1]+'분',
	    			'TX': input_pos[0],
	    			'TY': input_pos[1],
	    			'TZ': input_pos[2]
	    		}
	    	);
	    	
	    	<c:if test="${ not empty param.deli_idx }">
    		top.inc_busi_if.receiveData(
    			${param.deli_idx},
				{
	    			'일조량': result_time[0]+'시간 '+result_time[1]+'분',
	    			'TX': input_pos[0],
	    			'TY': input_pos[1],
	    			'TZ': input_pos[2]
	    		}
    		);
    		
    		top.tool7.nextLandscapeProccessStep();
    		</c:if>
	});
	
	if (shadowTime == true) // 일시정지 시 다시 재생
    {
        top.XDOCX.XDAnsShadowSimulation(1);
        return;
    }
	
	var Cnt = top.XDOCX.XDSelGetCount();

    if (Cnt > 0)
    {
        top.XDOCX.XDUIShadowTimeInfo(true);
        
        var ideley = 2;
        var iterm = 2;
      
        if($('#speed_mode').val() == '0'){ // 빠름
        	ideley = 5;
            iterm = 1;
        }else if($('#speed_mode').val() == '1'){ // 보통
        	ideley = 2;
            iterm = 5;
        }else if($('#speed_mode').val() == '2'){ // 느림
        	ideley = 1;
            iterm = 10;
        }


        top.XDOCX.XDAnsShadowSetPos(input_pos[0], input_pos[1], input_pos[2], true);
        top.XDOCX.XDAnsShadowSimulTime(sYear, sMon, sDay, s_hour, s_minute, 0, e_hour, e_minute, 0);
        top.XDOCX.XDShadowSimulTerm(ideley, iterm);
      
        top.XDOCX.XDShadowSimulation(1);
        shadowTime = true;
    }else{
    	alert('일조권 보기 대상객체를 선택해야 합니다.');
    }
}
//태양궤적도 보기
function btnSunView_onclick() {
	var txtDate = $('#txtDate').val();
	var selectYMD = txtDate.split('-');
    var tYear = selectYMD[0];
	var tMon = selectYMD[1];
	var tDay = selectYMD[2];

	//alert(tYear + ' ' + tMon + ' ' + tDay); 
    if (tYear == "" || tMon == "" || tDay == "") {
        alert("달력에서 날짜를 선택해 주세요!");
        return;
    }
	
    sy = tYear;
    sm = tMon;
    sd = tDay;
	
	var cntrPos = top.XDOCX.XDGetCenterPos();
	//alert(cntrPos);
	cntrPos += "," + sy + "," + sm + "," + sd;
	
	var w = 655;
	var h = 500;
	var l = 250;
	var t = 20;
	if (top.getIEVersion() >= 7) {
		w = 650;
		h = 498;
	}
	
	var cntr = "no";
	var url = "${ctx}/pop/pop_sunshine.jsp";	    
    
    if (cntrPos != "") {        
        window.showModelessDialog(url, cntrPos, "dialogWidth:" + w + "px; dialogHeight:" + h + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px; border:thin; status:no; resizable:no; center:" + cntr + "; help:no; scroll:no;");
    }
}
</script>
<script type="text/javascript">
$(function(){
	var todayDate = new Date();
	
	/* $("#datepicker1").val(todayDate.getFullYear()+"-"+addZero(eval(todayDate.getMonth()))+"-"+todayDate.getDate());
	$("#datepicker2").val(todayDate.getFullYear()+"-"+addZero(eval(todayDate.getMonth()+1))+"-"+todayDate.getDate()); */
	
	//달력 관련
	$.datepicker.setDefaults({
        changeMonth: true,
        changeYear: true,
		monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],	    
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	    showMonthAfterYear:true,
	    dateFormat: 'yy-mm-dd',
	    buttonImageOnly: true,
	    buttonText: "달력",
	    buttonImage: ""
	});
	
	$("#txtDate").datepicker({
	    defaultDate: todayDate,//(2013, 1-1, 27),
	    //showOn: "both", // focus, button, both
	    showAnim: "clip", // blind, clip, drop, explode, fold, puff, slide, scale, size, pulsate, bounce, highlight, shake, transfer (효과)
	    showOptions: {direction: 'horizontal'},
	    duration: 500
	}); 
});

</script>
</head>

<body style="background: url(${ctx}/images/category_bg1.gif)" onload="sunStart();">
	<div id="panel">
		<div id="title">
			<div id="category1" style="margin-top: 35px;">
				<ul style="width: 320px;">
					<li class="f_whit_am">일조분석 대상</li>
					<li style="clear: both; float: left;">
						<label for="textfield">
								<input name="RadioGroup1" type="radio" id="RadioGroup1_0" value="라디오" checked="checked" />객체선택
						</label>
					</li>
					<li style="float: left; margin: 0 0 0 3px;">
						<a href="#" onclick="buildChoose()">
							<img src="${ctx}/images/btn_obj.gif" />
						</a>
					</li>
					<li style="float: left; margin: 0 0 0 3px;">
						<a href="#" onclick="clearSunlight()">
							<img src="${ctx}/images/btn_cancel.gif" />
						</a>
					</li>
					<li style="clear: both; margin-top:5px;">
					
<!-- 					레이어 선택 기능은 개발이 안된것인가 소스상으로 기능구현이 안되어 있어보임 -->
<!-- 					<label for="textfield">  -->
<!-- 						<input type="radio" name="RadioGroup1" value="라디오" id="RadioGroup1_1" />레이어 -->
<!-- 					</label> -->
<!-- 						<select name="" style="margin-top:5px;"> -->
<!-- 								<option>객체선택모드</option> -->
<!-- 						</select> -->
<!-- 					</li> -->
<!-- 					<li style="height: 120px;"> -->
<!-- 						<div id="bbsCont" style="height: 100px; overflow-y: scroll; width: 310px; background: #FFF; border: solid 1px #333333;"> -->
<!-- 							<table border="0" cellpadding="0" cellspacing="0" class="wps_100" summary="가시결과list"> -->
<%-- 								<col class="w_40" /> --%>
<%-- 								<col /> --%>
<!-- 								<tr> -->
<!-- 									<th>No</th> -->
<!-- 									<th>레이어</th> -->
<!-- 								</tr> -->
<!-- 							</table> -->
<!-- 						</div> -->
<!-- 					</li> -->
					<li style="height: 120px;">
						<fieldset style="padding:5px;">
							<legend class="f_whit_am">시간 설정</legend>
							<ul>
								<li style="float: left;">
									<label for="textfield" style="width: 80px;">현재날짜</label>
									<!-- <input type="text" value="" id="today" readonly/> -->
<!-- 								        <input name="txtDate" id="txtDate" /> -->
								        <input type="text" id="txtDate" name="txtDate"/>
								</li>
								<li>
<!-- 								캘린더js의 createpopup은 ie 내장함수인데 11부터 삭제됨 > 제이쿼리ui datepicker로 변경함 -->
<%-- 										<img src="${ctx}/images/bbs/date.gif" style="cursor: pointer;"  onclick="popUpCalendar(this, txtDate, 'yyyy-mm-dd');"/> --%>
								</li>
								<li><label for="s_flag" style="width: 80px;">시작시간</label>
									<select name="s_flag" id="s_flag">
										<option value="오전" selected="selected">오전</option>
										<option value="오후">오후</option>
									</select> 
									<select name="s_hour" id="s_hour">
											
									</select> : 
									<select name="s_minute" id="s_minute">
											
									</select>
								</li>
								<li><label for="e_flag" style="width: 80px;">종료시간</label>
									<select name="e_flag" id="e_flag">
										<option value="오전">오전</option>
										<option value="오후" selected="selected">오후</option>
									</select> <select name="e_hour" id="e_hour">
											
									</select> : <select name="e_minute" id="e_minute">
											
									</select>
								</li>
							</ul>
						</fieldset>
					</li>
					<li class="f_whit_am">일조권 측정지점 선택</li>
					<li>
						<a href="#" onclick="sunlightPoint()">
							<img src="${ctx}/images/btn_sel_point.gif" width="96" height="24" />
						</a>
					</li>
					<li style="height: 120px; margin-top: 10px;">
						<fieldset style="padding:5px;">
							<legend class="f_whit_am">일조량 측정 결과</legend>
							<ul>
								<li >
									<label for="result_time" style="width: 50px;">일조량</label>
									<input type="text" name="result_time" id="result_time" width="70px" readonly/>
								</li>
								<li style="float: left; margin-top:5px;"><label for="result_x" style="width: 15px;">X:</label>
									<input type="text" name="result_x" id="result_x" style="width: 70px" readonly/>
								</li>
								<li style="float: left;margin-top:5px;"><label for="result_y" style="width: 15px;">Y:</label> 
									<input type="text" name="result_y" id="result_y" style="width: 70px" readonly/>
								</li>
								<li style="margin-top:5px;"><label for="result_z" style="width: 15px;">Z:</label> 
									<input type="text" name="result_z" id="result_z" style="width: 70px" readonly/>
								</li>
								<li>
									<a href="#" onclick="btnSunView_onclick()" style="float:right;">
										<img src="${ctx}/images/btn_sun_re1.gif" alt="태양궤적도">
									</a>
									<a href="#" onclick="valueCheck()" style="float:right;">
										<img src="${ctx}/images/btn_sun_re.gif" alt="측정결과확인">
									</a>
								</li>
							</ul>
						</fieldset>
					</li>
					<li style="float: left;">
						<a href="#" onclick="doAnalysis()">
							<img src="${ctx}/images/cont_start.gif" />
						</a>
					</li>
					<li style="float: left;">
						<a href="#" onclick="pauseSunlight()">
							<img src="${ctx}/images/cont_pu.gif" />
						</a>
					</li>
					<li style="float: left;">
						<a href="#" onclick="stopSunlight()">
							<img src="${ctx}/images/cont_stop.gif" />
						</a>
					</li>
					<li>
						<select name="speed_mode" style="margin-top:5px">
							<option value="0">빠름</option>
							<option value="1" selected="selected">보통</option>
							<option value="2">느림</option>
						</select>
					</li>
					<li style="margin-top: 10px; float:right;">
						<a href="#" onclick="doAnalysis();">
							<img src="${ctx}/images/btn_ok.gif"/>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>