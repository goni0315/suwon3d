var MAINUSERID = "";
var usrid ="";
var conip = "";
// 메인메뉴
// 서브좌메뉴와 컨텐츠부분 height값 비교해서 같게해줌
window.onload = function adjustLayout() {
	if (document.getElementById("leftMenu") && document.getElementById("subContent")) {
		
		if (document.getElementById("leftMenu").offsetHeight > document.getElementById("subContent").offsetHeight) {			
			document.getElementById("subContent").style.height = document.getElementById("leftMenu").offsetHeight + "px";
		}
	}
};

var BROWSER_IE=0;
var BROWSER_CHROME=1;
var BROWSER_FIREFOX=2;
var BROWSER_SAFARI=3;
var BROWSER_OPERA=4;
var BROWSER_MOZILLA=5;
var BROWSER_NETSCAPE=6;
var BROWSER_ORDERS=7;		
// 로그인 함수
function doLogin(usrid,systemFalg){
	// alert(usrid);
	var pUsrid = encodeURIComponent(usrid); // 검색어 인코딩
	var url = "getUserInfo.do?usrid="+pUsrid;
	var sucFlag = false;
	$.ajax({
		type:"get",
		// asyn:true,
		timeout : 10000,
		url: url,
		dataType: "json",
		// contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		error : function(request, status, error) {
		     alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
		    },
		success : function(result){
			if(result[0].returnCode == "S"){
				SucFlag = true;
				setUsrInfo(result[0].userInfo);
				
				if(systemFalg == "main"){ // 메인 시스템에서 접속할 경우
					
					if(result[0].userInfo.aut_cde=="SYS001"){ // 관리자일 경우 관리자
																// 페이지 이동 버튼 생성
						
						adminPcNominate(usrid, conip);
						// makeAdminButton(result[0].userInfo.usrid);
						
						
					}
					openPopup();
					initSystem();
					
				}else{ // 관리자 페이지 접속 경우
					if(result[0].userInfo.aut_cde!="SYS001"){ // 관리자로 다시 한번
																// 확인해서 권한 없으면
																// 에러페이지로
						alert("관리자 권한이 없습니다.");
						location.href= "error.jsp";
					}else{
						$('#topUsrname').text(result[0].userInfo.usrname);
					}
					openPopup();
				}
			}else{
				alert("사용자 정보가 없습니다. \n 관리자에게 문의하세요");
				location.href = "error.jsp";
			}
		}	
		
	});
}

// 저장되어져 있는 레이어 아이디 확인
function doLayerLoad(usrid){
	var pUsrid = encodeURIComponent(usrid);
	MAINUSERID = pUsrid;
	// alert("MAINUSERID : " + MAINUSERID);
	var url = "usrLayerChk.do?usrid="+pUsrid;
	var sucFlag = false;
	$.ajax({
		type:"get",
		timeout : 10000,
		url: url,
		dataType: "text",
		error : function(request, status, error) {
			alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
		},
		success : function(result){
			if(result != 0){
				// alert("pUsrid : " + pUsrid);
				layerLoadT(pUsrid);
			}else{
				// alert("null");
				layerLoadF(pUsrid);
			}
		}	
		
	});
}
function setAdminPcNominate(usrid, conip){
	this.usrid=usrid;
	this.conip=conip;	
}
function adminPcNominate(usrid, conip){
var url = "adminPCNominate.do?usrid="+usrid+"&conip="+conip;

$.ajax({
	type:"get",
	timeout : 10000,
	url: url,
	dataType: "text",
	error : function(request, status, error) {
	     alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
	    },
	success : function(result){
		
		//db에 값이 없음 등록안되어 있는 경우
if(result==0){
//	var adminStr =  '<li><a href="javascript:addPC()" id="addPC" class="pc">지정PC등록</a></li>';
//	$('#tabmenu').append(adminStr);
	$("#addPC").show();
	
	//db에 등록이 되어 있는 경우
} else if(result==1){
	//makeAdminButton();
	$("#goadmin").show();
	$("#delPC").show();
	$("#gobldg").show();
	
	//등록된 ip가 다른 경우
} else if(result==2){
	$("#addPC").hide();
	$("#delPC").hide();
	$("#gobldg").hide();
	$("#goadmin").hide();
} else if(result==3){
	alert("에러");
	
}
		
	}	
	
});
	
}

function addPC(){	
	
	if(confirm("지정 PC로 등록 하시겠습니까?") == true){
		
		var url = "addAdminPCNominate.do?usrid="+this.usrid+"&conip="+this.conip;
		
		$.ajax({
			type:"get",
			timeout : 10000,
			url: url,
			dataType: "text",
			error : function(request, status, error) {
			     alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
			    },
			success : function(result){
				if(result==0)
               alert("등록 되었습니다");	
				//makeAdminButton();
				$("#goadmin").show();
				$("#addPC").hide();
				$("#delPC").show();
				$("#gobldg").show();
			}	
			
		});
		
		
	}
	
}

function delPC(){
	
	if(confirm("지정 PC를 해지 하시겠습니까?") == true){
		
		var url = "delAdminPCNominate.do?usrid="+this.usrid+"&conip="+this.conip;
		
		$.ajax({
			type:"get",
			timeout : 10000,
			url: url,
			dataType: "text",
			error : function(request, status, error) {
			     alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
			    },
			success : function(result){
				if(result==0)
	alert("해지 되었습니다");	
				$("#goadmin").hide();
				$("#addPC").show();
				$("#delPC").hide();
				$("#gobldg").hide();
			}	
			
		});
		
		
	}
	
}


// 아이디가 저장되어져 있다면 레이어 목록 호출
function layerLoadT(usrid) {
	var pUsrid = encodeURIComponent(usrid);
	var url = "layerLoadList.do?usrid="+pUsrid;
	var sucFlag = false;
	$.ajax({
		type:"get",
		timeout : 10000,
		url: url,
		dataType: "json",
		error : function(request, status, error) {
			alert("layerLoad code : " + request.status + "\r\nmessage : " + request.reponseText);
		},
		success : function(result){
			// alert("result : " + result);
			newResult(result);
			
		}	
		
	});
}

// 아이디가 저장되어져 있지 않을 경우 기본 레이어 목록 호출
function layerLoadF(usrid) {
	var pUsrid = encodeURIComponent(usrid);
	var url = "layerLoadList.do?usrid="+pUsrid;
	var sucFlag = false;
	$.ajax({
		type:"get",
		timeout : 10000,
		url: url,
		dataType: "json",
		error : function(request, status, error) {
			alert("layerLoad code : " + request.status + "\r\nmessage : " + request.reponseText);
		},
		success : function(result){
			// alert("result222 : " + result);
			newResult(result);
			
		}	
		
	});
}

var VYN = "";
var SYN = "";
function newResult(result) {
	for(var i=0;i<result.length;i++){
		if(result[i].f_view == "Y"){
			VYN = true;
		}else{
			VYN = false;
		}
		if(result[i].f_sel == "Y"){
			SYN = true;
		}else{
			SYN = false;
		}
		// alert("result[i].hide_low : " + result[i].hide_low +
		// "///result[i].hide_high" + result[i].hide_high);
		// XDOCX.XDLaySetHiddenValue(result[i].eng_nm,result[i].hide_low,result[i].hide_high);
		XDOCX.XDLaySetVisible(result[i].eng_nm,VYN);
		XDOCX.XDLaySetSelectable(result[i].eng_nm,SYN);
	}
}

// 네비게이션 토글
function showHistoryToggle(){
	
	var chk = document.getElementById("n02");
	
	if(chk.style.display == "none"){	
		showHistory('n02',2,'Notab02');
		
	} else{
		showHistory('n01',2,'Notab01');
		
	}
	
}

// 탭메뉴
function showHistory(viewObj,chkNum,onImg) {// 보일Obj ID/Obj 갯수/ //하위ID,
											// 체크넘(탭갯수), 현재ID
		
	if(viewObj!=null) {// 선택 레이어 보임
		
		document.getElementById(viewObj).style.display="block";
		top.document.getElementById("sliceTool").style.display = "none";
		if((chkNum!=null) && (!isNaN(chkNum))) {// 대신 숨길 레이어가 있다면 숨김
			var hideObj = new String;
			var selObjNum = parseInt(viewObj.substring(viewObj.length-1,viewObj.length));
			hideObj = viewObj.substr(0,viewObj.length-1);
			
			// 최상단 메뉴 클릭 시 해당 메뉴의 첫번째 페이지 보여주기
			switch (viewObj) {
				case 'm01':
					writeLog("110000","지도검색"); // 접속 로그 기록
					document.getElementById('left').src = 'search/jibun.jsp';					 
					break;
				case 'm02':
					writeLog("120000","시설물입지"); // 접속 로그 기록
					document.getElementById('left').src = 'facility/facility.jsp';
					break;
				case 'm03':
// writeLog("130000","경관시뮬레이션"); //접속 로그 기록
					writeLog("130000","시뮬레이션"); // 접속 로그 기록
					document.getElementById('left').src = 'simulation/gasi.jsp';
					break;
				case 'm04':
					writeLog("140000","침수시뮬레이션"); // 접속 로그 기록
					document.getElementById('left').src = 'flooding/flooding_search.jsp';
					break;
				case 'm05':
					writeLog("150000","내주제도"); // 접속 로그 기록
					document.getElementById('left').src = 'thematic.do';
					break;
				case 'm06':
					writeLog("160000","레이어"); // 접속 로그 기록
// document.getElementById('left').src = 'usrLayerLoad.do?usrid=21027059';
					// alert("MAINUSERID : " + MAINUSERID);
					document.getElementById('left').src = 'layerList.do?usrid=' + MAINUSERID;
					break;
				case 'm07':
					writeLog("220000","안전길"); // 접속 로그 기록
					document.getElementById('left').src = 'safetyRoad.do';
					break;
			}
			
			for(var i=1;i<=chkNum;i++)	{
				if(i!=selObjNum)	{
					hideObj = hideObj.concat(i);
					document.getElementById(hideObj).style.display="none";
					hideObj = viewObj.substr(0,viewObj.length-1);
				}
			}
			
			if (onImg!=null) {// 마우스over/out시 이미지on/of 수정
				document.getElementById(onImg).src = document.getElementById(onImg).src.replace("off.gif", "on.gif");
				var offImg	= new String;
				var selImgNum = parseInt(onImg.substring(onImg.length-1,onImg.length));
				offImg = onImg.substr(0,onImg.length-1);

				for(var i=1;i<=chkNum;i++)	{
					if(i!=selImgNum)	{
						offImg = offImg.concat(i);
						document.getElementById(offImg).src = document.getElementById(offImg).src.replace("on.gif", "off.gif");
						offImg = onImg.substr(0,onImg.length-1);
					}
				}
			}
		}
	}
}
// 로그쌓기 TEST중
function MM_nbGroup(viewObj,chkNum,onImg){
	switch (onImg) {
	case 'subMenu01off':
		writeLog("100100","지번"); // 접속 로그 기록
		break;
	case 'subMenu02off':
		writeLog("100200","도로명주소"); // 접속 로그 기록
		break;
	case 'subMenu03off':
		writeLog("100300","건물"); // 접속 로그 기록
		break;		
	}
}
// 60진법 -> 10진법
function convertLonLat(degree, min, sec){
	var cord;
	cord=new Number(degree)+(new Number(min)/60)+(new Number(sec)/3600);
	return cord;
}
function makeOption(selectBox,value,name){
	var select=selectBox;
	var optCount=select.options.length;
	select.options[optCount]=new Option(name,value);
}
function mapDivHandle(){
	var mapDiv = document.getElementById("maparea");
	mapDiv.style.width = document.documentElement.clientWidth;
	mapDiv.style.height = document.documentElement.clientHeight;
}


// 페이지내에 html 생성
function infoInit(val){
	var map = document.getElementById("left_menu");
	map.innerHTML = val;
}


function jsonCallBack(){
	var jarr = json.parse("./js/statics.json");
	alert(jarr);
}


// 중복제거 함수
Array.prototype.unique=function() {
     var a={};
     for(var h=0;h<this.length;h++){
      if(typeof a[this[h]] == "undefined") a[this[h]] = 1;
     }
     this.length = 0;
     for(var i in a)
      this[this.length] = i;
     return this;
}


/*
 * 천단위 콤마 생성
 * 
 * @param value @return
 */
function comma(value, sosu) {
	var point = "";
	var returnValue = "";

	value = value.toString();

	if (value.indexOf(".") > 0) {
		point = value.substring(value.indexOf("."), sosu ? value.indexOf(".") + sosu + 1 : value.length);
		value = value.substring(0,value.indexOf("."));
	}

	if (value.length > 3) {
		for (var z = 0; z <= value.length; z++) {
			if( ((z) % 3 == 0) && (z) != value.length &&  z != 0 ) {
				returnValue =  ","+ value.charAt( value.length - (z) )+ returnValue;
			} else {
				returnValue =  value.charAt( value.length - (z) ) + returnValue;
			}
		}
		return returnValue + point;
	}

	return value + point;
}

/**
 * <b></b>태그 걸루주는 함수
 * 
 * @param item
 *            검사할 객체
 */
function charReplace(item){
	var newItem="";
	
	// console.log("[" + item + "] // " + typeof(item));
	
	if(typeof(item) == "string"){
		if(item!="" ||item!=null){
			newItem = item.replace(/<b>/gim,'');
			newItem = newItem.replace(/<\/b>/gi,'');
			if(newItem==""||newItem==null){
				newItem = "-";
			}
		}
	}
	
	return newItem;
}
/**
 * 응답 메세지 처리
 */
function doResponseData(msg){
	var isNoAgree = true;
	
	if(msg && typeof(msg) == 'string' && msg.indexOf('__NO_LOGIN') == 0){
		isNoAgree = false;
		
		var arr_req_info = msg.split('#');
		
		if(arr_req_info.length > 1){
			alert(arr_req_info[1]);
		}
		
		if(arr_req_info.length == 3){
			top.location.href = arr_req_info[2];
		}else if(arr_req_info.length == 4){
			top.location.href = arr_req_info[2]+'?backurl='+arr_req_info[3];
		}
	}else if(msg && typeof(msg) == 'string' && msg.indexOf('__ERROR') == 0){
		isNoAgree = false;
	}
	
	return isNoAgree;
}

// 아작스 요청용
function ajaxRequest(url, param, collback, methodType){
	if(typeof(param) != 'string'){
		param = $(param).serialize();
	}
	$.ajax({
		type: (methodType ? methodType : 'post'),
		url: url,
		data: param,
		success: function(res){
			if(doResponseData(res)){
				if(collback) collback(res);
			}
		}
	});
}
function browserCheck(){
	appName = navigator.appName;
	agent = navigator.userAgent;
	
	var str1 = "현재 접속하신 웹브라우저가 \"";
	var str2 = "\" 입니다. \n모든 기능이 \"Internet Explorer\"에 최적화 되어 있어 정상작동이 되지 않을 수 있습니다.";
	var browser = "";
	
	if (agent.indexOf("OPR") >= 0) {
		browser ="OPERA";
		
		alert(str1 + browser + str2);
		return BROWSER_OPERA;
	} else if (agent.indexOf("Firefox") >= 0 || agent.indexOf("Minefield") >= 0) {
		browser ="FIREFOX";
		alert(str1 + browser + str2);
		return BROWSER_FIREFOX;
	} else if (agent.indexOf("Chrome") >= 0) {
		browser ="CHROME";
		alert(str1 + browser + str2);
		return BROWSER_CHROME;
	} else if (agent.indexOf("Safari") >= 0) {
		browser ="SAFARI";
		alert(str1 + browser + str2);
		return BROWSER_SAFARI;
	} else if (agent.indexOf("MSIE") >= 0 || agent.indexOf("Trident") >= 0) {
		
		return BROWSER_IE;
	} else if (appName.indexOf("Mozilla") >= 0) {
		browser ="MOZILLA";
		alert(str1 + browser + str2);
		return BROWSER_MOZILLA;
	} else if (appName.indexOf("Netscape") >= 0) {
		browser ="NETSCAPE";
		alert(str1 + browser + str2);
		return BROWSER_NETSCAPE;
	} else {
		return BROWSER_ORDERS;
	}
};

function CloseWindow() 
{
	window.close();
	self.close();
	window.opener = window.location.href; 
	self.close();
	window.open('about:blank', '_self').close();
}

function browserCheck2(){
	appName = navigator.appName;
	agent = navigator.userAgent;
	
	if (agent.indexOf("OPR") >= 0) {
		return BROWSER_OPERA;
	} else if (agent.indexOf("Firefox") >= 0 || agent.indexOf("Minefield") >= 0) {
		return BROWSER_FIREFOX;
	} else if (agent.indexOf("Chrome") >= 0) {
		return BROWSER_CHROME;
	} else if (agent.indexOf("Safari") >= 0) {
		return BROWSER_SAFARI;
	} else if (agent.indexOf("MSIE") >= 0 || agent.indexOf("Trident") >= 0) {
		return BROWSER_IE;
	} else if (appName.indexOf("Mozilla") >= 0) {
		return BROWSER_MOZILLA;
	} else if (appName.indexOf("Netscape") >= 0) {
		return BROWSER_NETSCAPE;
	} else {
		return BROWSER_ORDERS;
	}
};
function ieVersionCheck(){
	
	var mode;
	var agentStr = navigator.userAgent;
	if (agentStr.indexOf("Trident/5.0") > -1) {
		if (agentStr.indexOf("MSIE 7.0") > -1)
			mode = 1;	// IE9 Compatibility View
		else
			mode = 2;	// IE9
	}else if (agentStr.indexOf("Trident/4.0") > -1) {
		if (agentStr.indexOf("MSIE 7.0") > -1)
			mode = 3;	// IE8 Compatibility View
		else
			mode = 4;	// IE8
	}else if (agentStr.indexOf("Trident/6.0") > -1) {
		if (agentStr.indexOf("MSIE 7.0") > -1)
			mode = 6;	// IE10 Compatibility View
		else
			mode = 7;	// IE11
	}else if (agentStr.indexOf("Trident/7.0") > -1) {
			mode = 8;	
	}else{
		mode = 5;	// IE7
	}
	return mode;
};

function nsVersionCheck(){
	
	var v,mv,mode;
	if (/Chrome/.test(navigator.userAgent)) {
  		 v = /Chrome\/([\d\.]+) Safari/.exec(navigator.appVersion)[1];
  		mv = /(\d+)\./.exec(v)[1];
  		if(mv>31){	// chrome v32 upper
  			mode=1;
  		}else{		// chrome v31 minor
  			mode=2;
  		}		
		}else if (/Firefox/.test(navigator.userAgent)) {
			v = /Firefox\/([\d\.]+)/.exec(navigator.userAgent)[1];	
			mv = /(\d+)\./.exec(v)[1];
		mode=3;
	}else if (/Safari/.test(navigator.userAgent)) {
	  v = /Version\/([\d\.]+) Safari/.exec(navigator.appVersion)[1];
	  mv = /(\d+)\./.exec(v)[1];
		mode=4;
	}
	return mode;
};		
function objectCheck(id){
	var install_check=false;
	for (var i=0; i < navigator.plugins.length; i++){

				if(navigator.plugins[i].name.indexOf(id)!=-1){
					install_check=true;
					break;
				}
			}
	return install_check;
}

// 사용자 정보 담을 객체
var usrInfoObj = {
		usrname : "",
		usrid : "",
		part : "",
		duta_name : "",
		aut_cde : "",
		aut_des : "",
		deptname : ""
};
// 사용자 정보 저장
function setUsrInfo(info){
		this.usrInfoObj.usrname = info.usrname; 
		this.usrInfoObj.usrid = info.usrid;
		this.usrInfoObj.part = info.part;
		this.usrInfoObj.duta_name = info.duta_name;
		this.usrInfoObj.aut_cde = info.aut_cde;
		this.usrInfoObj.aut_des = info.aut_des;
		this.usrInfoObj.deptname = info.deptname;
}

// 사용자 정보 가져오기
function getUserInfo(){
	return this.usrInfoObj; 
}
// 관리자 페이지 이동하는 버튼 생성
function makeAdminButton(){
	// var adminStr = '<li><a href="javascript:adminSubmit()">관리자페이지</a></li>';
	var adminStr =  '<li><a href="javascript:adminSubmit()"><img src="/Suwon3d/images/goadmin.png" alt="분석도구" id="goadmin"></a></li>';
	$('#tabmenu').append(adminStr);
}
// 시설물 리스트 팝업
function buildingManagement(){
window.open("buildingManagement.do?pageNum=1","시설물 리스트","fullscreen=no, width=700px, height=600px, toolbar=no, status=no, scrollbars=no, location=no, menubar=no","_blank");
}

// 관리자 페이지로 이동
function adminSubmit(){
	var uinfo = getUserInfo();
	
	$('#adminUsrid').val(uinfo.usrid);
	
	$('#adminForm').attr("target", "_blank");
	
	$('#adminForm').submit();
}
/**
 * ajax로 로그 저장하는 함수
 * 
 * @params menuid 메뉴 아이디, menuname 메뉴 이름
 */
function writeLog(menuid, menuname){
		// usrname, usrid, part,deptname,
		// alert(menuname);
		var usrInfo = getUserInfo(); // 사용자 정보 가져오기
		
		var pUsrname = encodeURIComponent(usrInfo.usrname); // 검색어 인코딩
		var pDeptname = encodeURIComponent(usrInfo.deptname); // 검색어 인코딩
		var pMenuname = encodeURIComponent(menuname); // 검색어 인코딩
// var url =
// getMainContextPath()+"/writeLog.do?usrname="+pUsrname+"&usrid="+usrInfo.usrid+"&part="+usrInfo.part+"&deptname="+pDeptname+"&menuid="+menuid+"&menuname="+pMenuname;
// //요청 url
		var url = "/Suwon3d/writeLog.do?usrname="+pUsrname+"&usrid="+usrInfo.usrid+"&part="+usrInfo.part+"&deptname="+pDeptname+"&menuid="+menuid+"&menuname="+pMenuname; // 요청
																																											// url
		
		$.ajax({
			type:"get",
			// asyn:true,
			timeout : 10000,
			url: url,
			dataType: "json",
			// contentType : "application/x-www-form-urlencoded;charset=UTF-8",
			error : function(request, status, error) {
			    // alert("writeLog code : " + request.status + "\r\nmessage : "
				// + request.reponseText);
			    },
			success : function(result){
				if(result[0].returnCode == 'S'){
					return true;
				}else{
				// alert("로그기록 실패 ");
				}
			}
		});
}

/**
 * 메뉴 아이디를 넣으면 현재 로그인한 유저의 권한과 비교해서 권한이 있으면 콜백함수를 실행 없으면 얼럿창 밑 false반환
 * 
 * @param menuid
 */ 
function checkMenuAut(menuid,callbackFn){
	// usrname, usrid, part,deptname,
	var usrInfo = getUserInfo(); // 사용자 정보 가져오기
	var usrAut = usrInfo.aut_cde;
	
	var url = "${ctx}/checkMenuAut.do?menuid="+menuid; // 요청 url
	
	var checkFlag = false;
	
	$.ajax({
		type:"get",
		// asyn:false,
		timeout : 10000,
		url: url,
		dataType: "json",
		// contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		error : function(request, status, error) {
		     alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
		    },
		success : function(result){
			if(result[0].menuaut > usrAut || result[0].menuaut == usrAut){
				// checkFlag = true;
				callbackFn();
			}else{
				// checkFlag = false;
				alert("권한이 없습니다. \n 관리자에게 문의하세요");
				return false;
			}
		}
	});
}

function getContextPath(){
	return window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
}
function openNotice(){
	var options = {
	        height: 300, // sets the height in pixels of the window.
	        width: 600, // sets the width in pixels of the window.
	        toolbar: 0, // determines whether a toolbar (includes the forward
						// and back buttons) is displayed {1 (YES) or 0 (NO)}.
	        scrollbars: 0, // determines whether scrollbars appear on the
							// window {1 (YES) or 0 (NO)}.
	        status: 0, // whether a status line appears at the bottom of the
						// window {1 (YES) or 0 (NO)}.
	        resizable: 0, // whether the window can be resized {1 (YES) or 0
							// (NO)}. Can also be overloaded using resizable.
	        left: 300, // left position when the window appears.
	        top: 300, // top position when the window appears.
	        center: 0, // should we center the window? {1 (YES) or 0 (NO)}.
						// overrides top and left
	        createnew: 0, // should we create a new window for each occurance
							// {1 (YES) or 0 (NO)}.
	        location: 0, // determines whether the address bar is displayed
							// {1 (YES) or 0 (NO)}.
	        menubar: 0 // determines whether the menu bar is displayed {1 (YES)
						// or 0 (NO)}.
	    };
	var url = getContextPath() + "/popNoticeList.do";
	
	var parameters = "location=" + options.location +
					 ",menubar=" + options.menubar +
					 ",height=" + options.height +
					 ",width=" + options.width +
					 ",toolbar=" + options.toolbar +
			         ",scrollbars=" + options.scrollbars +
			         ",status=" + options.status +
			         ",resizable=" + options.resizable +
			         ",left=" + options.left +
			         ",screenLeft=" + options.left +
			         ",top=" + options.top +
			         ",screenTop=" + options.top;
		
	window.open(url,"Notice",parameters);
}

function openPopup(){
	$.ajax({
		type:"get",
		// asyn:false,
		timeout : 10000,
		url: getMainContextPath()+"/countPopup.do",
		dataType: "json",
		error : function(request, status, error) {
		     alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
		    },
		success : makePopup
	});
}

function makePopup(result){
	var options = {
	        height: 528, // sets the height in pixels of the window.
	        width: 352, // sets the width in pixels of the window.
	        toolbar: 0, // determines whether a toolbar (includes the forward
						// and back buttons) is displayed {1 (YES) or 0 (NO)}.
	        scrollbars: 0, // determines whether scrollbars appear on the
							// window {1 (YES) or 0 (NO)}.
	        status: 0, // whether a status line appears at the bottom of the
						// window {1 (YES) or 0 (NO)}.
	        resizable: 0, // whether the window can be resized {1 (YES) or 0
							// (NO)}. Can also be overloaded using resizable.
	        left: 0, // left position when the window appears.
	        top: 0, // top position when the window appears.
	        center: 0, // should we center the window? {1 (YES) or 0 (NO)}.
						// overrides top and left
	        createnew: 0, // should we create a new window for each occurance
							// {1 (YES) or 0 (NO)}.
	        location: 0, // determines whether the address bar is displayed
							// {1 (YES) or 0 (NO)}.
	        menubar: 0 // determines whether the menu bar is displayed {1 (YES)
						// or 0 (NO)}.
	    };
	var popLeftPadding = 1;

	for(var i=0 ; i < result.length ; i++){
		var bod_seq = result[i].bod_seq;
		var url = getMainContextPath()+"/openPopup.do?bod_seq="+bod_seq;
		var pop_id = "popup_"+bod_seq;
		popLeftPadding = i * (options.width + 29);
			
		var parameters = "location=" + options.location +
						 ",menubar=" + options.menubar +
						 ",height=" + options.height +
						 ",width=" + options.width +
						 ",toolbar=" + options.toolbar +
				         ",scrollbars=" + options.scrollbars +
				         ",status=" + options.status +
				         ",resizable=" + options.resizable +
				         ",left=" + popLeftPadding +
				         ",screenLeft=" + popLeftPadding +
				         ",top=" + options.top +
				         ",screenTop=" + options.top;
		
		if(getCookie(pop_id) != "done") {
			window.open(url,"",parameters);	
		}	
	}
}
// 팝업 리사이즈
function PopupAutoResize(divId) {
	var thisX = parseInt(document.getElementById(divId).scrollWidth);
	var thisY = parseInt(document.getElementById(divId).scrollHeight);
	thisX = thisX+6;
	var maxThisX = screen.width - 50;
	var maxThisY = screen.height - 50;
	var marginY = 0;
	
	var mode = browserCheck2(); // 브라우저 체크
	
	// 브라우저별 높이 조절.
	if(mode == 0){ // ie
		var iemode = ieVersionCheck();
		if(iemode == 1 ||iemode == 2 ){ // IE9 & Compatibility View
			thisY = thisY+38;
		}else if(iemode == 3 || iemode == 4){ // IE8 & Compatibility View
			thisY = thisY+40;
		}else if(iemode == 6){ // IE10 Compatibility View
			thisY = thisY+40; marginY = 20;
		}else if(iemode == 7 || iemode == 8){ // IE11
			thisY = thisY+38;
		}else{    // IE7
			marginY = 40;
		}		
	}
	else if(mode == 1){
		marginY = 70; // Chrome
	}
	else if(mode == 2){
		marginY = 60;   // Firefox
		thisX = thisX +2;
	}
	else if(mode == 3){
		marginY = 35; // Safari
	}
	else if(mode == 4){
		marginY  = 80;   // Opera
		thisX = thisX +2;
	}
	else if(mode == 5){
		marginY = 60;   // Mozilla
	}
	else if(mode == 6){
		marginY = -2;  // Netscape
	}
	else if(mode == 7){ // Other
		marginY = 20; thisY = thisY+40; 
	}
	if (thisX > maxThisX) {
	  	window.document.body.scroll = "yes";
	  	thisX = maxThisX;
	}
	if (thisY > maxThisY - marginY) {
	 	window.document.body.scroll = "yes";
		thisX += 19;
	 	thisY = maxThisY - marginY;
	}
	window.resizeTo(thisX+10, thisY+marginY);		
}

function getCookie(name) {
	var nameOfCookie = name + "=";
	var x = 0;
	while(x<= document.cookie.length) {
		var y = (x+nameOfCookie.length);
		if(document.cookie.substring(x,y)==nameOfCookie) {
	   		if((endOfCookie = document.cookie.indexOf(";", y)) == -1) {
	  		  	endOfCookie = document.cookie.length;
	   		}
	   		return unescape(document.cookie.substring(y, endOfCookie));
	  	}
	  	x = document.cookie.indexOf(" ", x)+1;
	  	if(x==0) {
	   		break;
	  	}
 	} 
 	return "";
}