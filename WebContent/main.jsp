﻿<!-- 
	수원시 3차원 활용시스템 메인 >> 검색기능 >> 도로명검색 결과 페이지
 -->
<%@page import="java.util.Random"%>
<%@page import="util.StirngUtil"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<%@page import="java.net.URLDecoder"%>
 
<%      
	StirngUtil util = new StirngUtil(); 
	request.setCharacterEncoding("UTF-8");
	
	String usrid = URLDecoder.decode(util.nullStringCheck((String)request.getParameter("usrid")), "UTF-8");
	String x2d = URLDecoder.decode(util.nullStringCheck((String)request.getParameter("x")), "UTF-8");
	String y2d = URLDecoder.decode(util.nullStringCheck((String)request.getParameter("y")), "UTF-8");
	String level2d = URLDecoder.decode(util.nullStringCheck((String)request.getParameter("level")), "UTF-8");
	
	 if(usrid.equals("") || usrid == ""){

		 //String ids = "001000197";//testID
		 String ids = "21027059";//testID
		
		//Random ran = new Random();
		
		//int idx = ran.nextInt(10);
		
		usrid = ids;
	 }

%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="generator" content="HTML Tidy for Linux (vers 25 March 2009), see www.w3.org">
<title>수원시 3차원 공간정보 활용시스템</title>
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css">

<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript" src="${ctx}/js/json2.js"></script>
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<script type="text/javascript" src="${ctx}/js/layer.js"></script>
<script type="text/javascript" src="${ctx}/js/xdk.js"></script>
<script type="text/javascript" src="${ctx}/js/weather.js"></script>
<script type="text/javascript" src="${ctx}/js/common.js"></script>

<script type="text/javascript">

var mainContextPath = "${ctx}";

function getMainContextPath(){
	return this.mainContextPath;
}

window.onload = function(){
	
	doLogin("<%=usrid%>","main");
	doLayerLoad("<%=usrid%>");
	};
	
function initSystem(){
		
		if(browserCheck()==BROWSER_IE){

	        //기본 심볼 다운로드
	        downSymbols();
	        //xdServerConnect('105.1.2.121',9830,'Suwon3d',0,0);//서버연결
	        xdServerConnect('192.168.1.124',9830,'Suwon3d',0,0);//서버연결	        
	        //xdServerConnect('58.123.178.238',9830,'Suwon3d',0,0);//서버연결
	        
		}else{
			if(objectCheck("Xdworld plugin")){

				if(getCookie("pluginUpdate")  != "done") {
					window.open("${ctx}/pop/nsSetupPopup.jsp","pluginUpdate","width = 430, height = 330, resizable=no, scrollbars=no, status=no");
				}
				XDOCX=pluginobj;
				//xdServerConnect('105.1.2.121',9830,'Suwon3d',0,0);
				xdServerConnect('192.168.1.124',9830,'Suwon3d',0,0);
				//xdServerConnect('58.138.253.23',9830,'testGroup',0,0);//서버연결
		        //기본 심볼 다운로드
		        downSymbols();
			}else{
				openSetupPage();
			}
		}
        //화면 자동 최대화
        if( parseInt(document.documentElement.clientWidth) + 20 < parseInt(screen.availWidth) ){
        	self.moveTo(0,0);
        	self.resizeTo(screen.availWidth,screen.availHeight); 
        }
	    
	    writeLog("000000","시스템접속"); //접속 로그 기록 
	
	    
};

//사용자 아이디
var usrid = "<%=usrid%>";

var levelHigh = "";

function xdServerConnect(ip, port, group, start_xpoint, start_ypoint) {
	var m_IsConnected = XDOCX.XDNetServerConnect(ip, port);
	switch (m_IsConnected) {
	case 0:
		alert("서버 연결에 실패하였습니다.\n관리자에게 문의하세요.");
		break;
	case 2:
		alert("이미 접속중입니다.");
		break;
	case 1:
		XDOCX.XDNetLayerListRequest(group, 0); // 맵 레이어 데이터 요청 (저해상도)
		<%-- alert("usrid : " + <%=usrid%> + " // x : " + <%=x2d%> + " // y : " + <%=y2d%> + " // level : " + <%=level2d%>); --%>
		var x2d = "<%=x2d%>";
		var y2d = "<%=y2d%>";
		var level2d = "<%=level2d%>";
		
		levelChk(level2d);
		
		if(x2d == ""){
			XDOCX.XDCamSetLookAt(202540.250000,0.000000,518250.421875,280,40);
			XDOCX.XDCamSetDirect(20);
		}else{
			XDOCX.XDCamSetLookAt(y2d,0.000000,x2d,levelHigh,90);
			XDOCX.XDCamSetDirect(0); 
		}
		//XDOCX.XDMapRenderLock(true);
		//시작 시 수원시청을 바라보도록
		//XDOCX.XDCamSetLookAt(202540.250000,0.000000,518250.421875,280,40);
		//XDOCX.XDCamSetLookAt(202540.250000,0.000000,518250.421875,280,90);
		//수원시청을 정면으로 바라보도록 방향각 지정
		//XDOCX.XDCamSetDirect(20);
		//XDOCX.XDCamSetDirect(0);
		XDOCX.XDCtrlSetView(2); // 3D인덱스맵 종료
		XDOCX.XDLayCreateEX(0, 'WEATHER', 1, 20000); // 날씨정보 레이어
		top.XDOCX.XDLaySetVisible("WEATHER",false);
		XDOCX.XDMapLoad();
		XDOCX.XDMapResetRTT();
		XDOCX.XDMapRender();
		XDOCX.XDMapSetUnderGround(false);//지하보기 설정
		//XDOCX.XDUISetKeyMode(false);//키 입력 방지
		//지도 뒤 배경설정
		//XDOCX.XDRefSetColor(0,0,0,0);//색설정		
		//XDOCX.XDMapSetBackColor();//지도배경색 적용
		//XDOCX.XDMapSetAmbient(100);	//건물 이미지 음영처리
		
		layViewVal();
		setEvent();
		top.setIndexMap();//인덱스맵
		inputNote();//우측하단 문구 적용
		setViewInfo();//고도값 표현
		break;
	};
}

//수원 2d 레벨값
function levelChk(level) {
	
	var numLevel = parseInt(level);
	
	if(numLevel >= 71950){
		 levelHigh = 21462.11;
		
	}else if(numLevel <= 71950 && numLevel >= 35975){
		 levelHigh = 8867.48;
		
	}else if(numLevel <= 35975 && numLevel >= 17987){
		 levelHigh = 3757.84;
		
	}else if(numLevel <= 17987 && numLevel >= 8993){
		 levelHigh = 2020.24;
		
	}else if(numLevel <= 8993 && numLevel >= 4496){
		 levelHigh = 1404.41;
		
	}else if(numLevel <= 4496 && numLevel >= 2248){
		 levelHigh = 652.53;
		
	}else if(numLevel <= 2248 && numLevel >= 1124){
		 levelHigh = 391.91;
		
	}else if(numLevel <= 1124 && numLevel >= 562){
		 levelHigh = 221.51;
		
	}else if(numLevel <= 562 && numLevel >= 281){
		 levelHigh = 102.92;
		
	}else if(numLevel <= 281){
		 levelHigh = 66.59;
		
	};
}
	function setEvent(){
		document.addEventListener("MouseUp",function(event){
			MouseUpEventHandler(event.detail.nButton,event.detail.nShift, event.detail.nX, event.detail.nY);
			
		});
	}
	/* top.XDOCX.XDLaySetVisible('LT_C_UD801_UDV100',false);
	top.XDOCX.XDLayerSetSelectable('LT_C_UD801_UDV100',false); */	
	function openSetupPage(){
		var mapArea = document.getElementById("egis_map");
		mapArea.className="egis_map";
		mapArea.style.backgroundColor="#000000";
		mapArea.innerHTML="<center><img src='${ctx}/cab/np_setup.jpg' usemap='#np_setup'></center>";
		mapArea.innerHTML+="	<map name='np_setup'><area shape='rect' coords='256,205,541,280' href='${ctx}/cab/nsXDWorldSetup.exe' target='_self' alt='플러그인 설치' title='플러그인설치'/></map>";
	}
	
	function MM_preloadImages() { //v3.0
		var d = document;
		if (d.images) {
			if (!d.MM_p)
				d.MM_p = new Array();
			var i, j = d.MM_p.length, a = MM_preloadImages.arguments;
			for (i = 0; i < a.length; i++)
				if (a[i].indexOf("#") != 0) {
					d.MM_p[j] = new Image;
					d.MM_p[j++].src = a[i];
				};
		};
	}

	function MM_findObj(n, d) { //v4.01
		var p, i, x;
		if (!d)
			d = document;
		if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
			d = parent.frames[n.substring(p + 1)].document;
			n = n.substring(0, p);
		}
		if (!(x = d[n]) && d.all)
			x = d.all[n];
		for (i = 0; !x && i < d.forms.length; i++)
			x = d.forms[i][n];
		for (i = 0; !x && d.layers && i < d.layers.length; i++)
			x = MM_findObj(n, d.layers[i].document);
		if (!x && d.getElementById)
			x = d.getElementById(n);
		return x;
	}

	function MM_nbGroup(event, grpName) { //v6.0
		
		var i, img, nbArr, args = MM_nbGroup.arguments;
		if (event == "init" && args.length > 2) {
			if ((img = MM_findObj(args[2])) != null && !img.MM_init) {
				img.MM_init = true;
				img.MM_up = args[3];
				img.MM_dn = img.src;
				if ((nbArr = document[grpName]) == null)
					nbArr = document[grpName] = new Array();
				nbArr[nbArr.length] = img;
				for (i = 4; i < args.length - 1; i += 2)
					if ((img = MM_findObj(args[i])) != null) {
						if (!img.MM_up)
							img.MM_up = img.src;
						img.src = img.MM_dn = args[i + 1];
						nbArr[nbArr.length] = img;
					};
			};
		} else if (event == "over") {
			document.MM_nbOver = nbArr = new Array();
			for (i = 1; i < args.length - 1; i += 3)
				if ((img = MM_findObj(args[i])) != null) {
					if (!img.MM_up)
						img.MM_up = img.src;
					img.src = (img.MM_dn && args[i + 2]) ? args[i + 2]
							: ((args[i + 1]) ? args[i + 1] : img.MM_up);
					nbArr[nbArr.length] = img;
				};
		} else if (event == "out") {
			for (i = 0; i < document.MM_nbOver.length; i++) {
				img = document.MM_nbOver[i];
				img.src = (img.MM_dn) ? img.MM_dn : img.MM_up;
			};
		} else if (event == "down") {
			nbArr = document[grpName];
			top.XDOCX.XDUISetWorkMode(1);
			if (nbArr)
				for (i = 0; i < nbArr.length; i++) {
					img = nbArr[i];
					img.src = img.MM_up;
					img.MM_dn = 0;
				}
			document[grpName] = nbArr = new Array();
			for (i = 2; i < args.length - 1; i += 2)
				if ((img = MM_findObj(args[i])) != null) {
					if (!img.MM_up)
						img.MM_up = img.src;
					img.src = img.MM_dn = (args[i + 1]) ? args[i + 1]
							: img.MM_up;
					nbArr[nbArr.length] = img;
				};
		};
	}
	
	//기본 화면에서 사용하는 툴바 기능들
	function MapControl(mode) {
		top.setWorkMode('');
		if(mode == "clickInformation"){//정보조회
			clickShowInfo();
		}else if (mode == "move_hand") { // 손이동
			top.XDOCX.XDUISetWorkMode(1);
		} else if (mode == "map_clear") { // 클리어
			top.XDOCX.XDLayClear("Temporary");
			top.XDOCX.XDUIClearInputPoint();
			top.XDOCX.XDAnsClear();
			top.XDOCX.XDSelClear();
			top.XDOCX.XDUIDistanceClear();
			top.XDOCX.XDUIAreaClear();
			top.XDOCX.XDUIClearMemo();
			top.XDOCX.XDMapResetRTT();
			top.XDOCX.XDUISetWorkMode(1);
		    top.XDOCX.XDLayClear("조망축"); //대상 레이어를 초기화
		    top.XDOCX.XDLayClear("WEATHER"); //대상 레이어를 초기화
		    top.XDOCX.XDMapRenderLock(false);
		    top.XDOCX.XDMapRender(); //현재 화면을 갱신 요청
			top.XDOCX.XDLaySetEditable("Temporary");
			top.XDOCX.XDAnsJomangListClear();
			top.XDOCX.XDLaySetEditable("Temporary2");
			top.XDOCX.XDLayRemove("Temporary2");
			top.XDOCX.XDLayRemove("slant");
			top.XDOCX.XDLayRemove("slantDirection");
			top.XDOCX.XDLayRemove("thematic_map");
			top.XDOCX.XDLayRemove("SAFETY_ROAD");
			top.XDOCX.XDLayRemove("SAFETY_ROAD_T");
			top.XDOCX.XDTerrEditUndo();
			top.XDOCX.XDLayClear("cWater");

			top.XDOCX.XDLayClear(top.getMLayer2());
			mainToolMenu('tool4');
			top.XDOCX.XDUISetWorkMode(1);
		} else if (mode == "cam_total") { // 전체보기
			top.XDOCX.XDCamSetDirect(0); // 북쪽보기
			var ln = "";
			for ( var i = 0; i < top.XDOCX.XDLayGetCount(); i++) {
				ln = top.XDOCX.XDLayGetName(i);
				if (top.XDOCX.XDLayGetType(ln) == 8) {
					var tmpRect = top.XDOCX.XDLayGetBox(ln);
					if (tmpRect != "") {
						tmpRect = tmpRect.split(",");
						var cx = (parseInt(tmpRect[0]) + parseInt(tmpRect[3])) / 2;
						var cz = (parseInt(tmpRect[2]) + parseInt(tmpRect[5])) / 2;
						top.XDOCX.XDCamLookAt(cx, 17000, cz - 12000, cx, 0, cz);
					}
					break;
				};
			};
		} else if (mode == "cam_zoomin") { // 확대
			top.XDOCX.XDUISetWorkMode(2);
		} else if (mode == "cam_zoomout") { // 축소
			top.XDOCX.XDUISetWorkMode(4);
		} else if (mode == "cam_1stmode") { // 1인칭모드
			top.XDOCX.XDCamSetMode(1);
		} else if (mode == "cam_3rdmode") { // 3인칭모드
			top.XDOCX.XDCamSetMode(0);
		} else if (mode == "cal_dist") { // 거리측정
			top.XDOCX.XDUISetWorkMode(81);
			document.getElementById("sliceTool").style.display = "none";
			document.getElementById("slopeTool").style.display = "none";
		} else if (mode == "cal_rect") { // 면적측정
			top.XDOCX.XDUISetWorkMode(80);
			document.getElementById("sliceTool").style.display = "none";
			document.getElementById("slopeTool").style.display = "none";
		} else if (mode == "cal_hei") { // 높이측정		
			top.setWorkMode(mode); // setSimulMode(13);
			top.XDOCX.XDUISetWorkMode(20);
			top.XDOCX.XDUIClearInputPoint();
			document.getElementById("sliceTool").style.display = "none";
			document.getElementById("slopeTool").style.display = "none";
		} else if (mode == "cal_volume") { // 부피측정
			top.setWorkMode(mode); //setSimulMode(12);
			top.XDOCX.XDUISetWorkMode(6);
			top.XDOCX.XDSelClear();
			document.getElementById("sliceTool").style.display = "none";
			document.getElementById("slopeTool").style.display = "none";
		} else if (mode == "img_save") { // 이미지저장
			try {
				var fn = top.XDOCX.XDOpenFileDlg(false, "jpg,bmp,png");
				
				if (fn != "") {
					top.XDOCX.XDCapScreenShot(fn);
					if (!top.XDOCX.XDUIFileExist(fn)) {
						alert("출력하지 못 하였습니다.");
					};
				};
			} catch (ex) {				
				alert("출력 중 오류가 발생하였습니다.");
			};
		} else if (mode == "img_print") { // 프린터인쇄
			try {
				top.XDOCX.XDCapScreenToPrint(0);
			} catch (ex) {
				alert("인쇄 중 오류가 발생하였습니다.");
			};
		}
		top.XDOCX.XDMapRender();
	}

	//화면 사이즈 함수
	function jsWResize() {

		tmp_size_width = document.documentElement.clientWidth;
		libWidthNum = tmp_size_width / 100 * 80;

		$("#maparea").width(tmp_size_width - winWidthNum);
		$("#libView").width(tmp_size_width - libWidthNum);
	}
	
	//지하보기 설정 함수
	function undergroundView(){
		
		if(document.getElementById("under").checked == true){
			XDOCX.XDMapSetUnderGround(true);//지하보기 설정
		}else if(document.getElementById("under").checked == false){
			XDOCX.XDMapSetUnderGround(false);//지하보기 설정
		}
	}
	
	//도움말 팝업띄우기
	function helpPopup(){
	 var winform = window.open("${ctx}/help/help.html","보기",  "toolbar=0, status=0, scrollbars=auto, location=0, menubar=0, width=700, height=550"); 
		winform.moveTo(screen.availWidth/2-700/2,screen.availHeight/2 - 550/2);
		winform.focus();
	 }
	//단면분석 띄우기
	function sliceToolView(){
		top.XDOCX.XDUISetWorkMode(1);
		if(document.getElementById("sliceTool").style.display == "none"){
			document.getElementById("sliceTool").style.display = "block";
			document.getElementById("slopeTool").style.display = "none"; 
		}else{
			document.getElementById("sliceTool").style.display = "none"; 
		}
	}
	
	//경사분석 띄우기
	function slopeToolView(){
		top.XDOCX.XDUISetWorkMode(1);
		if(document.getElementById("slopeTool").style.display == "none"){
			document.getElementById("slopeTool").style.display = "block";
			document.getElementById("sliceTool").style.display = "none";
		}else{
			document.getElementById("slopeTool").style.display = "none"; 
		}
	}
	
	function getHjdong(){
		return  eval('('+hjdong+')');
	}
	/**
	 * 실시간 날씨정보 데이터 로드
	 */
	function loadWeatherInfo(){
//		parent.displayLoading(true); // 데이터  로딩 이미지 보기
		MapControl('cam_total');
		top.XDOCX.XDLayClear("WEATHER");

		alert("날씨정보를 로드합니다.");
		// 동네예보
		ajaxRequest('${ctx}/weather/nowWeather.do', '', function(listHjdo){

			var gWeatherInfo = null; // 날씨정보
			var HjdongArr = getHjdong();
			if(listHjdo.length > 0){
				gWeatherInfo = listHjdo;

				var height = 0;
				var dongWeather = ''; // 읍면동별 동네예보 정보
				var symbol_id = ''; // 심볼 아이디
				var symbol_img = ''; // 심볼 이미지
				var dongCdx, dongCdy=0;	//동 좌표

				for(var i = 0; i < gWeatherInfo.length; i++){
					for(var j=0;j<HjdongArr.length;j++){
						if(gWeatherInfo[i].code==HjdongArr[j].code){
							dongCdx= HjdongArr[j].codx;
							dongCdy = HjdongArr[j].cody;
						};
					}
// 					height = XDOCX.XDTerrainGetHeight(parseFloat(dongCdx), parseFloat(dongCdy));
// 					height = XDOCX.XDTerrainGetHeight(dongCdx, dongCdy);
 					XDOCX.XDRefSetFontStyle("바탕체", 13, true, true, 1, 0, 0, 0);
 					height = XDOCX.XDTerrGetPointHeight(203773.093750, 519913.593750);
					dongWeather = gWeatherInfo[i].dongVo;

 					symbol_id = gWeatherInfo[i].code + '_' + gWeatherInfo[i].gridX + '_' + gWeatherInfo[i].gridY;
 					symbol_img = getWeatherImgPath(parent.getXDWorkPath(), dongWeather.wfKor);
					XDOCX.XDRefSetColor(255, 0, 250, 0);
 					createSymbol(weatherLayerName, symbol_id, dongCdx, height, dongCdy, gWeatherInfo[i].value +'('+dongWeather.wfKor+')', 255, 50, 255, 0, symbol_img, false);
 					XDOCX.XDRefSetColor(255, 255, 0, 0);
				}
// 				parent.changeViewPos('weather'); // 지도 시점 변경
// 				parent.displayLoading(false); // 데이터  로딩 이미지 숨김
// 				parent.setMessage('div_-weather.gif', 1);
				alert('지도 상의 날씨 아이콘을 클릭하시면 \n동별로 주간날씨 정보를 볼 수 있습니다.');
				top.setWorkMode('info');
				top.XDOCX.XDUISetWorkMode(6);
			}else{
// 				parent.displayLoading(false); // 데이터  로딩 이미지 숨김
				alert('실시간 날씨정보(동네예보) 수신에 실패했습니다.\n다시 시도해 주십시오.');
// 				gWeatherInfo = null;	
			};
			
		}, 'post');
	}
	function weatherOnOff(){
		var layStatus=top.XDOCX.XDLayGetVisible("WEATHER");
		if(layStatus==true){
			top.XDOCX.XDLaySetVisible("WEATHER",false);
			top.XDOCX.XDUISetWorkMode(1);
		}else{
			top.loadWeatherInfo();
			top.XDOCX.XDLaySetVisible("WEATHER",true);
		};
	}
	function weeklyWeatherInfo(){
		var weather = window.open('/Suwon3d/weather/weeklyDongWeather.do?code=4111157200&gridX=60&gridY=121','weather', 'width=518,height=269');	
				if(weather){
					weather.focus();
				};
			
	}
	//E 날씨정보

	//녹화 팝업띄우기
	function recPop(){
	 var winform = window.open("pop/rec.jsp","보기",  "toolbar=0, status=0, scrollbars=auto, location=0, menubar=0, width=370, height=150"); 
	 	winform.moveTo(screen.availWidth - 360,screen.availHeight - 140);
		winform.focus();
	 }
	/**
	 * 왼쪽페이지 보임
	 */
	function showLeftMenu(num){
		document.getElementById("left_toggle" + num).src = "${ctx}/images/subMenu_close.gif";
		$('#aside').show();
	}
	
	/**
	 * 왼쪽페이지 숨김
	 */
	function hideLeftMenu(num){
		document.getElementById("left_toggle" + num).src = "${ctx}/images/subMenu_open.gif"; 
		$('#aside').hide();
		//$("#map_area,#aside").width(screen.availWidth-winWidthNum);
	}
	/**
	 * 왼쪽 페이지 보임/숨김
	 */
	function toggleVisibleLeftMenu(num){
		if($('#aside').css('display').toUpperCase() == 'NONE'){
			showLeftMenu(num);
		}else{
			hideLeftMenu(num);
		}
	}
	
	//우측상단 툴바 토글키
	function mainToolMenu(objNm) {
		if(objNm == 'tool8'){ //날씨정보
			document.getElementById("tool8").src = "${ctx}/images/tool08_on.gif";
			document.getElementById("tool1").src = "${ctx}/images/tool01_off.gif";
			document.getElementById("tool2").src = "${ctx}/images/tool02_off.gif";
			document.getElementById("tool3").src = "${ctx}/images/tool03_off.gif";
			document.getElementById("tool4").src = "${ctx}/images/tool04_on.gif";
	
		}else if(objNm == 'tool1'){//시설물정보조회
			MapControl('cam_3rdmode');
			document.getElementById("tool8").src = "${ctx}/images/tool08_off.gif";
			document.getElementById("tool1").src = "${ctx}/images/tool01_on.gif";
			document.getElementById("tool2").src = "${ctx}/images/tool02_off.gif";
			document.getElementById("tool3").src = "${ctx}/images/tool03_on.gif";
			document.getElementById("tool4").src = "${ctx}/images/tool04_off.gif";
	
		}else if(objNm == 'tool2'){//1인칭
			document.getElementById("tool8").src = "${ctx}/images/tool08_off.gif";
			document.getElementById("tool1").src = "${ctx}/images/tool01_off.gif";
			document.getElementById("tool2").src = "${ctx}/images/tool02_on.gif";
			document.getElementById("tool3").src = "${ctx}/images/tool03_off.gif";
			document.getElementById("tool4").src = "${ctx}/images/tool04_on.gif";
			MapControl('move_hand');
		}else if(objNm == 'tool3'){//3인칭
			document.getElementById("tool8").src = "${ctx}/images/tool08_off.gif";
			document.getElementById("tool1").src = "${ctx}/images/tool01_off.gif";
			document.getElementById("tool2").src = "${ctx}/images/tool02_off.gif";
			document.getElementById("tool3").src = "${ctx}/images/tool03_on.gif";
			document.getElementById("tool4").src = "${ctx}/images/tool04_on.gif";
			MapControl('move_hand');
		}else if(objNm == 'tool4'){//손이동
			if(document.getElementById("tool3").src.indexOf('on.gif') == -1){
				document.getElementById("tool2").src = "${ctx}/images/tool02_on.gif";
				document.getElementById("tool3").src = "${ctx}/images/tool03_off.gif";
			}else{
				document.getElementById("tool2").src = "${ctx}/images/tool02_off.gif";
				document.getElementById("tool3").src = "${ctx}/images/tool03_on.gif";
			}
			document.getElementById("tool8").src = "${ctx}/images/tool08_off.gif";
			document.getElementById("tool1").src = "${ctx}/images/tool01_off.gif";
			document.getElementById("tool4").src = "${ctx}/images/tool04_on.gif";
	
		}
	}
	
	//문구적용
	inputNote = function(){
	
		XDOCX.XDUISetLoadPos(8,315,60);	//0: 좌상, 1: 중상, 2: 우상  ...	(스트리밍 패널위치이동)
		XDOCX.XDAddUserText(33, "굴림", 9, 1, 255, 255, 255, 255, -500, -23, "※ 모든 자료는");
		XDOCX.XDAddUserText(33, "굴림", 9, 1, 255, 255, 0, 0, -410, -23, " 행정내부망");
		XDOCX.XDAddUserText(33, "굴림", 9, 1, 255, 255, 255, 255, -345, -23, " 에서");
		XDOCX.XDAddUserText(33, "굴림", 9, 1, 255, 255, 0, 0, -310, -23, "참고용");
		XDOCX.XDAddUserText(33, "굴림", 9, 1, 255, 255, 255, 255, -270, -23, "으로만 활용해 주시고 외부로 유출을 금합니다.");
	
	};
	
	//고도값표현
	setViewInfo = function(){
		XDOCX.XDUISetViewInfo(true,9,15,180);//(고도값 표현)
	};
	
	//좌표값 표출
	function clickPosView(pos){
		var splitPos = pos.split(",");
		for(var i=1;i<8;i++){
			document.getElementById("yVal" + i).value = splitPos[0]; 
			document.getElementById("xVal" + i).value = splitPos[2];
		};
	}

	//2D 연결
	/*
		2D웹 연결 URL, 레벨별 고도값을 알아야함
	*/
	function change2D() {
		var pos = XDOCX.XDGetCenterPos();
		var cenPos = pos.split(",");
		XDOCX.XDCameraSetAngle(90);
		var dis = Math.floor(XDOCX.XDCameraGetDistance());
		//alert("X : " + cenPos[2] + " / Y : " + cenPos[0] + "/// dis : " +dis);
		
		var change2D = window.open('/Suwon3d/weather/weeklyDongWeather.do?usrid=' + <%=usrid%> + '&x=' + cenPos[2] + '&y=' + cenPos[0]+ '&lv=' + lv, 'fullscreen=yes');	
			if(change2D){
				change2D.focus();
			};
	}
	
/* 	function setLayerLoad() {
		
	} */
	

</script>
<style type="text/css">
div.c5 {
	overflow: hidden;
	position: relative;
	z-index: 1;
	background-image: url(images/mapbg.png);
	background-position: 0 0;
	background-repeat: repeat
}
div.c3 {
	height: 100px
}
div.c2 {
	display: none;
}
div.c1 {
	margin-left: 2em
}
</style>
<meta>
</head>
<body>
<script type="text/javascript" for="XDOCX" event="MouseUp(Button, Shift, sx, sy)" >
	MouseUpEventHandler(Button, Shift, sx, sy);
	var xyz = XDOCX.XDUIClickPos();
	clickPosView(xyz);
</script>

<div>
    <div id="header">
        <div id="head">
            <div id="logo"><a href="#" onclick="location.reload(true);"><img src="images/top_ci.gif" alt="수원시 3차원 공간정보 활용시스템"></a></div>
            <div>
                <ul id="topMenu">
                    <li><a href="#" onClick="javascript:showHistory('m01',7,'menu01');MM_nbGroup('down','group1','subMenu01off','${ctx}/images/subMenu01_on.gif',1);" onKeyPress=""><img src="${ctx}/images/menu01_on.gif" alt="지도검색" name="menu01" id="menu01"></a></li>
                    <li><a href="#" onClick="javascript:showHistory('m02',7,'menu02');MM_nbGroup('down','group2','subMenu11off','${ctx}/images/subMenu11_on.gif',1);" onKeyPress=""><img src="${ctx}/images/menu02_off.gif" alt="시설물입지" name="menu02" id="menu02"></a></li>
                    <li><a href="#" onClick="javascript:showHistory('m03',7,'menu03');MM_nbGroup('down','group3','subMenu21off','${ctx}/images/subMenu21_on.gif',1);" onKeyPress=""><img src="${ctx}/images/menu03_off.gif" alt="경관시뮬레이션" name="menu03" id="menu03"></a></li>
                    <li><a href="#" onClick="javascript:showHistory('m04',7,'menu04');MM_nbGroup('down','group4','subMenu31off','${ctx}/images/subMenu31_on.gif',1);" onKeyPress=""><img src="${ctx}/images/menu04_off.gif" alt="침수시뮬레이션" name="menu04" id="menu04"></a></li>
                    <li><a href="#" onClick="javascript:showHistory('m05',7,'menu05');return false; MapControl('map_clear')" onKeyPress=""><img src="${ctx}/images/menu05_off.gif" alt="내주제도" name="menu05" id="menu05"></a></li>
                    <li><a href="#" onClick="javascript:showHistory('m07',7,'menu07');return false;" onKeyPress=""><img src="${ctx}/images/menu07_off.gif" alt="안전길" name="menu07" id="menu07"></a></li>
                    <li><a href="#" onClick="javascript:showHistory('m06',7,'menu06');return false;" onKeyPress=""><img src="${ctx}/images/menu06_off.gif" alt="레이어" name="menu06" id="menu06"></a></li>
                </ul>
                <!-- 1 -->
                <div id="m01" class="subMenu">
                    <ul>
                        <li><a href="${ctx}/search/jibun.jsp" target="left" onClick="MM_nbGroup('down','group1','subMenu01off','${ctx}/images/subMenu01_on.gif',1)" onMouseOver="MM_nbGroup('over','subMenu01off','${ctx}/images/subMenu01_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img id="01" src="${ctx}/images/subMenu01_on.gif" alt="" name="subMenu01off" border="0" onload="MM_nbGroup('init','group1','subMenu01off','${ctx}/images/subMenu01_off.gif',1)"></a></li>
                        <li><a href="${ctx}/search/road.jsp" target="left" onClick="MM_nbGroup('down','group1','subMenu02off','${ctx}/images/subMenu02_on.gif',1)" onMouseOver="MM_nbGroup('over','subMenu02off','${ctx}/images/subMenu02_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img id="02" src="${ctx}/images/subMenu02_off.gif" alt="" name="subMenu02off"  border="0" onload=""></a></li>
                        <li><a href="${ctx}/search/build.jsp" target="left" onClick="MM_nbGroup('down','group1','subMenu03off','${ctx}/images/subMenu03_on.gif',1)" onMouseOver="MM_nbGroup('over','subMenu03off','${ctx}/images/subMenu03_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img id="03" src="${ctx}/images/subMenu03_off.gif" alt="" name="subMenu03off"  border="0" onload=""></a></li>
                        <li><a href="${ctx}/search/radiousSearch.jsp" target="left" onClick="MM_nbGroup('down','group1','subMenu04off','${ctx}/images/subMenu04_on.gif',1)" onMouseOver="MM_nbGroup('over','subMenu04off','${ctx}/images/subMenu04_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img id="04" src="${ctx}/images/subMenu04_off.gif" alt="" name="subMenu04off"  border="0" onload=""></a></li>
                        <li><img id="left_toggle1" src="${ctx}/images/subMenu_close.gif" onclick="toggleVisibleLeftMenu(1)" ></li>
                        <li>
	                        <br>
	                       	&nbsp; <B>X</B> : <input id="xVal1" type="text" value="" size="15" style="background-color: #ECEDED; border:0; margin-top: 4px" readonly>
	               			<B>Y</B> : <input id="yVal1" type="text" value="" size="15" style="background-color: #ECEDED; border:0;" readonly>
	               		</li>
                    </ul>
                </div>
                <!-- 2 -->
                <div id="m02" class="subMenu c2">
                    <ul>
                        <li><a href="${ctx}/facility/facility.jsp" target="left" onClick="MM_nbGroup('down','group2','subMenu11off','${ctx}/images/subMenu11_on.gif',1);MapControl('move_hand');" onMouseOver="MM_nbGroup('over','subMenu11off','${ctx}/images/subMenu11_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img id="11" src="${ctx}/images/subMenu11_on.gif" alt="" name="subMenu11off"  border="0" onload="MM_nbGroup('init','group2','subMenu11off','${ctx}/images/subMenu11_off.gif',1)"></a></li>
                        <li><a href="${ctx}/facility/road.jsp" target="left" onClick="MM_nbGroup('down','group2','subMenu12off','${ctx}/images/subMenu12_on.gif',1);MapControl('move_hand')" onMouseOver="MM_nbGroup('over','subMenu12off','${ctx}/images/subMenu12_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img id="12" src="${ctx}/images/subMenu12_off.gif" alt="" name="subMenu12off" border="0" onload=""></a></li>
                        <li><a href="${ctx}/facility/tree.jsp" target="left" onClick="MM_nbGroup('down','group2','subMenu13off','${ctx}/images/subMenu13_on.gif',1);MapControl('move_hand')" onMouseOver="MM_nbGroup('over','subMenu13off','${ctx}/images/subMenu13_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img id="13" src="${ctx}/images/subMenu13_off.gif" alt="" name="subMenu13off" border="0" onload=""></a></li>
                        <li><a href="${ctx}/facility/streetlamp.jsp" target="left" onClick="MM_nbGroup('down','group2','subMenu14off','${ctx}/images/subMenu14_on.gif',1);MapControl('move_hand')" onMouseOver="MM_nbGroup('over','subMenu14off','${ctx}/images/subMenu14_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img id="14" src="${ctx}/images/subMenu14_off.gif" alt="" name="subMenu14off" border="0" onload=""></a></li>
                        <li><a href="${ctx}/facility/edit_move.jsp" target="left" onClick="MM_nbGroup('down','group2','subMenu15off','${ctx}/images/subMenu15_on.gif',1);MapControl('move_hand')" onMouseOver="MM_nbGroup('over','subMenu15off','${ctx}/images/subMenu15_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img id="15" src="${ctx}/images/subMenu15_off.gif" alt="" name="subMenu15off" border="0" onload=""></a></li>
                        <li><img id="left_toggle2" src="${ctx}/images/subMenu_close.gif" onclick="toggleVisibleLeftMenu(2)" ></li>
                        <li>
	                        <br>
	                       	&nbsp; <B>X</B> : <input id="xVal2" type="text" value="" size="15" style="background-color: #ECEDED; border:0; margin-top: 4px" readonly>
	               			<B>Y</B> : <input id="yVal2" type="text" value="" size="15" style="background-color: #ECEDED; border:0;" readonly>
	               		</li>
                    </ul>
                </div>
                <div id="m03" class="subMenu c2">
                    <ul>
                        <li><a href="${ctx}/simulation/gasi.jsp" target="left" onClick="MM_nbGroup('down','group3','subMenu21off','${ctx}/images/subMenu21_on.gif',1);MapControl('move_hand')" onMouseOver="MM_nbGroup('over','subMenu21off','${ctx}/images/subMenu21_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img id="21" src="${ctx}/images/subMenu21_on.gif" alt="" name="subMenu21off"  border="0" onload="MM_nbGroup('init','group3','subMenu21off','${ctx}/images/subMenu21_off.gif',1)"></a></li>
                        <li><a href="${ctx}/simulation/view.jsp" target="left" onClick="MM_nbGroup('down','group3','subMenu22off','${ctx}/images/subMenu22_on.gif',1);MapControl('move_hand')" onMouseOver="MM_nbGroup('over','subMenu22off','${ctx}/images/subMenu22_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img id="22" src="${ctx}/images/subMenu22_off.gif" alt="" name="subMenu22off" border="0" onload=""></a></li>
                        <li><a href="${ctx}/simulation/height.jsp" target="left" onClick="MM_nbGroup('down','group3','subMenu23off','${ctx}/images/subMenu23_on.gif',1);MapControl('move_hand')" onMouseOver="MM_nbGroup('over','subMenu23off','${ctx}/images/subMenu23_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img id="23" src="${ctx}/images/subMenu23_off.gif" alt="" name="subMenu23off" border="0" onload=""></a></li>
                        <li><a href="${ctx}/simulation/sunshine.jsp" target="left" onClick="MM_nbGroup('down','group3','subMenu24off','${ctx}/images/subMenu24_on.gif',1);MapControl('move_hand')" onMouseOver="MM_nbGroup('over','subMenu24off','${ctx}/images/subMenu24_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img id="24" src="${ctx}/images/subMenu24_off.gif" alt="" name="subMenu24off" border="0" onload=""></a></li>
                        <li><a href="${ctx}/simulation/landEdit.jsp" target="left" onClick="MM_nbGroup('down','group3','subMenu25off','${ctx}/images/subMenu25_on.gif',1);MapControl('move_hand')" onMouseOver="MM_nbGroup('over','subMenu25off','${ctx}/images/subMenu25_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img id="25" src="${ctx}/images/subMenu25_off.gif" alt="" name="subMenu25off" border="0" onload=""></a></li>
                        <li><img id="left_toggle3" src="${ctx}/images/subMenu_close.gif" onclick="toggleVisibleLeftMenu(3)" ></li>
                        <li>
	                        <br>
	                       	&nbsp; <B>X</B> : <input id="xVal3" type="text" value="" size="15" style="background-color: #ECEDED; border:0; margin-top: 4px" readonly>
	               			<B>Y</B> : <input id="yVal3" type="text" value="" size="15" style="background-color: #ECEDED; border:0;" readonly>
	               		</li>
                    </ul>
                </div> 
                <div id="m04" class="subMenu c2">
                    <ul>
                        <li><a href="${ctx}/flooding/flooding_search.jsp" target="left" onClick="MM_nbGroup('down','group4','subMenu31off','${ctx}/images/subMenu31_on.gif',1);MapControl('map_clear')" onMouseOver="MM_nbGroup('over','subMenu31off','${ctx}/images/subMenu31_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img id="31" src="${ctx}/images/subMenu31_on.gif" alt="" name="subMenu31off"  border="0" onload="MM_nbGroup('init','group4','subMenu31off','${ctx}/images/subMenu31_off.gif',1)"></a></li>
                        <li><a href="${ctx}/flooding/shelter_search.jsp" target="left" onClick="MM_nbGroup('down','group4','subMenu32off','${ctx}/images/subMenu32_on.gif',1);MapControl('map_clear')" onMouseOver="MM_nbGroup('over','subMenu32off','${ctx}/images/subMenu32_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img id="32" src="${ctx}/images/subMenu32_off.gif" alt="" name="subMenu32off" border="0" onload=""></a></li>
                        <li><a href="${ctx}/flooding/floodingS.jsp" target="left" onClick="MM_nbGroup('down','group4','subMenu33off','${ctx}/images/subMenu33_on.gif',1);MapControl('map_clear')" onMouseOver="MM_nbGroup('over','subMenu33off','${ctx}/images/subMenu33_on.gif','',1)" onMouseOut="MM_nbGroup('out')"><img id="33" src="${ctx}/images/subMenu33_off.gif" alt="" name="subMenu33off" border="0" onload=""></a></li>
                        <li><img id="left_toggle4" src="${ctx}/images/subMenu_close.gif" onclick="toggleVisibleLeftMenu(4)" ></li>
                        <li>
	                        <br>
	                       	&nbsp; <B>X</B> : <input id="xVal4" type="text" value="" size="15" style="background-color: #ECEDED; border:0; margin-top: 4px" readonly>
	               			<B>Y</B> : <input id="yVal4" type="text" value="" size="15" style="background-color: #ECEDED; border:0;" readonly>
	               		</li>
                    </ul>
                </div>
                <div id="m05" class="subMenu c2">
                <ul>
	                <li><a href="${ctx}/thematic.do" target="left" onclick="MapControl('map_clear')"><img src="${ctx}/images/subMenu4_on.gif"></a></li>
	                <li><img id="left_toggle5" src="${ctx}/images/subMenu_close.gif" onclick="toggleVisibleLeftMenu(5)" ></li>
	               	<li>
                        <br>
                    	&nbsp; <B>X</B> : <input id="xVal5" type="text" value="" size="15" style="background-color: #ECEDED; border:0; margin-top: 4px" readonly>
            			<B>Y</B> : <input id="yVal5" type="text" value="" size="15" style="background-color: #ECEDED; border:0;" readonly>
            		</li>
                </ul>
                </div>
                <div id="m06" class="subMenu c2">
                <ul>
	                <%-- <li><a href="${ctx}/usrLayerLoad.do?usrid=<%=usrid%>" target="left" onclick="MapControl('map_clear')"><img src="${ctx}/images/subMenu5_on.gif"></a></li> --%>
	                <li><a href="#" onclick="MapControl('map_clear')"><img src="${ctx}/images/subMenu5_on.gif"></a></li>
	                <li><img id="left_toggle6" src="images/subMenu_close.gif" onclick="toggleVisibleLeftMenu(6)" ></li>
	                <li>
                        <br>
                       	&nbsp; <B>X</B> : <input id="xVal6" type="text" value="" size="15" style="background-color: #ECEDED; border:0; margin-top: 4px" readonly>
               			<B>Y</B> : <input id="yVal6" type="text" value="" size="15" style="background-color: #ECEDED; border:0;" readonly>
               		</li>
                </ul>
                </div>
                <div id="m07" class="subMenu c2">
                <ul>
	                <li><a href="${ctx}/safetyRoad.do" target="left" onclick="MapControl('map_clear')"><img src="${ctx}/images/subMenu7_on.gif"></a></li>
	                <li><img id="left_toggle7" src="images/subMenu_close.gif" onclick="toggleVisibleLeftMenu(7)" ></li>
	                <li>
                        <br>
                       	&nbsp; <B>X</B> : <input id="xVal7" type="text" value="" size="15" style="background-color: #ECEDED; border:0; margin-top: 4px" readonly>
               			<B>Y</B> : <input id="yVal7" type="text" value="" size="15" style="background-color: #ECEDED; border:0;" readonly>
               		</li>
                </ul>
                </div>

            </div>
            <div id="topUtil">
                <ul id="tabmenu">
                    <li><a href="#" onClick="javascript:showHistory('n01',2,'Notab01');return false;" onKeyPress=""><img src="${ctx}/images/set01_on.gif" alt="분석도구" id="Notab01"></a></li>
                    <li><a href="#" onClick="javascript:showHistoryToggle();return false;" onKeyPress=""><img src="${ctx}/images/set02_off.gif" id="Notab02" alt="내비게이션"></a></li>
                </ul>
                <!-- 1 -->
                <div id="n01" class="set">
                    <ul>
                        <li><a href="#" class="roll" onclick="MapControl('cal_dist')"><img src="${ctx}/images/set11_off.gif" alt="거리측정"><img src="${ctx}/images/set11_on.gif" class="over" alt="거리측정"></a></li>
                        <li><a href="#" class="roll" onclick="MapControl('cal_hei')"><img src="${ctx}/images/set12_off.gif" alt="높이측정"><img src="${ctx}/images/set12_on.gif" class="over" alt="높이측정"></a></li>
                        <li><a href="#" class="roll" onclick="MapControl('cal_rect')"><img src="${ctx}/images/set13_off.gif" alt="면적측정"><img src="${ctx}/images/set13_on.gif" class="over" alt="면적측정"></a></li>
                        <li><a href="#" class="roll" onclick="MapControl('cal_volume')"><img src="${ctx}/images/set14_off.gif" alt="부피측정"><img src="${ctx}/images/set14_on.gif" class="over" alt="부피측정"></a></li>
                        <li><a href="#" class="roll" onclick="sliceToolView()"><img src="${ctx}/images/set15_off.gif" alt="단면분석"><img src="${ctx}/images/set15_on.gif" class="over" alt="단면분석"></a></li>
                        <li><a href="#" class="roll" onclick="slopeToolView()"><img src="${ctx}/images/set16_off.gif" alt="경사분석"><img src="${ctx}/images/set16_on.gif" class="over" alt="경사분석"></a></li>
                        <li></li>
                    </ul>
                </div>
                <!-- 2 -->
                <div id="n02" class="set c2" style="z-index:11000; display: none; " >
                <iframe id="navitoggle" name="navi" src="tool1.jsp" frameborder="0" width="436" height="112" scrolling="no"></iframe>
                </div>
            </div>
            <div id="tool">
                <ul>
					<!-- 날씨 S -->
                    <li><a href="#" onclick="weatherOnOff();mainToolMenu('tool8')" title="날씨정보"><img id="tool8" src="${ctx}/images/tool08_off.gif" alt="날씨정보"></a></li>
<%--                     <li><a href="#" onclick="weeklyWeatherInfo()" class="roll"><img src="${ctx}/images/tool09_off.gif" alt="주간날씨"><img src="${ctx}/images/tool09_on.gif" alt="주간날씨" class="over"></a></li> --%>
                	<!-- 날씨 E -->

                    <li><a href="#" onclick="MapControl('clickInformation');mainToolMenu('tool1')" title="시설물정보조회"><img id="tool1" src="${ctx}/images/tool01_off.gif" alt="정보"></a></li>
                    <li><a href="#" onclick="MapControl('cam_1stmode');mainToolMenu('tool2')" title="1인칭시점"><img id="tool2" src="${ctx}/images/tool02_off.gif" alt="1인칭"></a></li>
                    <li><a href="#" onclick="MapControl('cam_3rdmode');mainToolMenu('tool3')" title="3인칭시점"><img id="tool3" src="${ctx}/images/tool03_on.gif" alt="3인칭"></a></li>
                    <li><a href="#" onclick="MapControl('move_hand');mainToolMenu('tool4')" title="손이동"><img id="tool4" src="${ctx}/images/tool04_on.gif" alt="손이동"></a></li>
                    <li><a href="#" onclick="MapControl('img_print')" class="roll" title="화면출력"><img src="${ctx}/images/tool05_off.gif" alt="출력"><img src="${ctx}/images/tool05_on.gif" alt="출력" class="over"></a></li>
                    <li><a href="#" onclick="MapControl('img_save')" class="roll" title="화면저장"><img src="${ctx}/images/tool06_off.gif" alt="화면저장"><img src="${ctx}/images/tool06_on.gif" alt="화면저장" class="over"></a></li>
                    <li><a href="#" onclick="MapControl('cam_total')" class="roll" title="전체화면"><img src="${ctx}/images/tool10_off.gif" alt="전체화면"><img src="${ctx}/images/tool10_on.gif" alt="전체화면" class="over"></a></li>
                    <li><a href="#" onclick="MapControl('map_clear')" class="roll"  title="초기화"><img src="${ctx}/images/tool07_off.gif" alt="초기화"><img src="${ctx}/images/tool07_on.gif" alt="초기화" class="over"></a></li>
                </ul>
             <div id="sliceTool" style="z-index:11000; display: none;">
                <iframe src="pop/sliceTool.jsp" frameborder="0" width="310" height="250" scrolling="no"></iframe>
             </div>
             <div id="slopeTool" style="z-index:11000; display: none;">
                <iframe src="pop/slope_pop.jsp" frameborder="0" width="310" height="300" scrolling="no"></iframe>
             </div>
            </div>
        </div>
    </div>
    <div id="container">
        <div id="aside">
            <iframe name="left" id="left" frameborder="0" width="100%" height="100%" src="search/jibun.jsp" style="height:100%"></iframe>
            <div id="aside_footer" class="aside_footer">
                <h3 class="blind">본문 마지막 참조링크들</h3>
				<!--<div style="background-image: url('images/bottom_ci.gif'); cursor: pointer;" onclick="helpPopup()">
                	&nbsp;X : <input id="xVal" type="text" value="" size="15" style="background-color: #E3E4EC; border:0; margin-top: 4px" readonly="readonly">
                	Y : <input id="yVal" type="text" value="" size="15" style="background-color: #E3E4EC; border:0;" readonly="readonly">
                		<a href="#" onclick="helpPopup()" style="float:left;">

                    	</a>
                	<br><br>
                </div> -->
                <ul class="afooter_lst">
                    <li style="float:left; background-image: url('images/bottom/left_bottom_bg.gif'); height: 36px; padding-top: 3px">
                    	<a href="#" onclick="openNotice()" style="margin-left: 17px;">
		                    <img src="images/bottom/left_bottom_btn_1.gif" height="22px;">
                    	</a>
                    	<a href="#" onclick="helpPopup()" style="margin-left: 5px;"> 
		                    <img src="images/bottom/left_bottom_btn_2.gif" height="22px;">
                    	</a>
                    	&nbsp;&nbsp;&nbsp;&nbsp;
                    </li>
                </ul>
            </div>
            <div class="aside_line"></div>
        </div>
        <hr>
        <div id="content">
            <h2 class="blind">지도영역</h2>
            <div id="map_area">
                <h2 class="blind">일반지도뷰</h2>
                <div id="egis_map" class="egis_map c5"> 
                    <script type="text/javascript">
                                xdk();
					</script>
					<script type="text/javascript">
							   	tds();
			    	</script>
					<script type="text/javascript">
							   	tdk();
			    	</script>
                </div>
            </div>
            <hr>
<!--         </div> -->
    </div>
</div>
<form id="adminForm" name="adminForm" action="${ctx}/admin.do" method="post">
	<input type="hidden" id="adminUsrid" name="adminUsrid" />
</form>
</body>
</html>