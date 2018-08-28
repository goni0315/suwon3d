<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/gislayout.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>3차원공간정보활용시스템</title>

<script type="text/javascript" src="../js/XDControl.js"></script>
<script type="text/javascript" src="../js/common.js"></script>

<script type="text/javascript">//
    var djConfig = { isDebug:false, parseOnLoad:true };
</script>
<script type="text/javascript">
	//var top = null;
	var waterLay = "cWater";
	var waterKey = "waterPlane00";
	var waterKey2 = "waterPlane02";
	var cPosX = "";
	var cPosY = "";
	var cPosZ = "";
	
	//분석 영역 지정
	function setRect() {		
		if (top.XDOCX.XDLayGetObjectCount(waterLay) > 0) {
			top.XDOCX.XDLayClear("P_WATER");
			top.XDOCX.XDLayClear('Temporary');
		}
		top.setObj(self);
		top.setSimulMode(91);
		top.setOperationMode(24);
	} 
	
	//분석 결과 삭제
	function clearRect() {
		if (top.XDOCX.XDLayGetObjectCount(waterLay) > 0) {
			top.XDOCX.XDLayClear("P_WATER");
			top.XDOCX.XDLayClear('Temporary');
		}
		top.XDOCX.XDUIClearInputPoint();
		cPosX = "";
		cPosY = "";
		cPosZ = "";
		document.getElementById('Ambient').value = '0';
		document.getElementById('AmbientMin').value = '0';
		document.getElementById('AmbientMax').value = '0';
		top.setOperationMode(1);
	} 
	
	//분석 시작 - 물판 생성
	function createPlane() {
		if (top.XDOCX.XDUIInputPointCount() < 3) {
			alert("3개 이상의 지점을 입력하세요");
			return false;
		}
		
		var thickness = document.getElementById('AmbientMax').value;
		var avgHei = top.XDOCX.XDTerrGetAvgAlt();
		avgHei = parseFloat(avgHei);
	//	alert('선택 '+ avgHei + '\n'+ '입력 ' + parseFloat(Ambient.value));
		/*	
		if (parseFloat(Ambient.value) < avgHei) {
			alert('입력한 수위가 선택한 영역의 평균높이보다 낮습니다. \n선택한 영역의 평균높이는 '+avgHei+'m 입니다.');
			Ambient.focus();
			return false;
		}
		*/
		
		var strPoi = "";
		for (var i = 0; i < top.XDOCX.XDUIInputPointCount(); i++) {
			if (i > 0) strPoi += "#";
			strPoi += top.XDOCX.XDUIGetInputPoint(i);
		}
		
		top.XDOCX.XDUIClearInputPoint();
		strPoi = strPoi.split("#");
	//	thickness = Ambient.value;
		var hei = document.getElementById('Ambient').value - thickness;
	//	var hei = parseFloat(Ambient.value) -  avgHei;
		for (var i = 0; i < strPoi.length; i++) {
			info = strPoi[i].split(","); 
			top.XDOCX.XDUIInput3DPoint(info[0],  hei, info[2]);
		}
		
	//	alert('선택 '+ avgHei + '\n'+ '입력 ' + parseFloat(Ambient.value) +'\n'+ hei);
	
	/*  XD.XDLayCreate 13, "P_WATER"                ' 물판 레이어 생성 13번이 물판이다.
 	    XD.XDLaySetEditable "P_WATER"               ' 편집 레이어 지정
    	XD.XDObjCreateWater CStr(m_id)              ' InputPoint가 3개 이상 있는 경우에 생성 가능하다 
    	
		top.XDOCX.XDLayCreate(13,"P_WATER");
		top.XDOCX.XDLaySetEditable("P_WATER");
		top.XDOCX.XDObjCreateWater("P_WATER");*/
		
		top.XDOCX.XDLaySetEditable(waterLay);
		top.XDOCX.XDObjCreateBuild(waterKey, thickness, "", 0);
		top.XDOCX.XDLaySetEditable("Temporary");
		
		top.GetRefColor();
		top.TmpRefColor(150, 255, 0, 0);
		top.XDOCX.XDObjCreateLine(waterKey+'Ambient', 1, true);
		top.XDOCX.XDUIClearInputPoint();
		top.setOperationMode(1);
		top.XDOCX.XDMapRender();
	}
	
	
	function waterUp() {
		var dis = document.getElementById("moveDist").value;
		MoveObject(dis);
		document.getElementById('Ambient').value = parseFloat(document.getElementById('Ambient').value, 2) + parseFloat(dis);
	}

	function waterDown() {
		var dis = document.getElementById("moveDist").value; 
		dis = (parseFloat(dis) * -1);
		MoveObject(dis);
		document.getElementById('Ambient').value = parseFloat(document.getElementById('Ambient').value, 2) + parseFloat(dis);
	}
	
	var m_ox, m_oy, m_oz = 0.0;
	// 현재 선택 객체 좌표 받기
	function getObjectCenterPoint(lName, key, by, h) {
		var temp, pa;
		temp = top.XDOCX.XDObjGetBox(lName, key);
		if(temp=="") return false;
		
		pa = temp.split(",");
		m_ox = eval(pa[0]) + (eval(pa[3]) - eval(pa[0]))/2;
		if (by == true) {
			m_oy = h;
		} else {
			m_oy = eval(pa[1]);
		}
		m_oz = eval(pa[2]) + (eval(pa[5])-eval(pa[2]))/2;
		
		return true;
	}
	function MoveObject(value) {
		var dis = value;
		var mx;
		
		if(dis == ""){
			alert("이동거리를 입력하여주세요.");
			return;
		}

		if(getObjectCenterPoint(waterLay, waterKey, false, 0) == true) {
			top.XDOCX.XDObjMove(waterLay, waterKey, m_ox, m_oy+parseFloat(dis), m_oz, true);
			top.XDOCX.XDMapRender();
		}
	}

	function page_load() {
	//	top = window.dialogArguments;
	//	top.XDOCX.XDMapSetUnderGround(true);
	//	top.setTerrainAlpha(true);
		
		if (top.XDOCX.XDLayGetObjectCount("P_WATER") < 0) {
			top.TmpRefColor(150, 0, 191, 255);
			top.XDOCX.XDLayCreateEX(0, waterLay, 1, 50000);
			top.XDOCX.XDMapLoad();
			top.XDOCX.XDLaySetInstColor(waterLay);
			top.GetRefColor();
		} else {
			top.XDOCX.XDLaySetVisible(waterLay, true);
			//var rect = top.XDOCX.XDObjGetBox(waterLay, waterKey);
			//if (rect != "") {
			//	rect = rect.split(",");
			//	curHei.value = Math.round(rect[1] * 10) / 10;
			//}
		}
		top.XDOCX.XDMapRender();
	}

	function setCenter() {
		top.setObj(self);
		top.setOperationMode(20);		
		top.setSimulMode(96);
		
		if (top.XDOCX.XDLayGetObjectCount(waterLay) > 0) {
			top.XDOCX.XDLayClear(waterLay);
		}
	}
	
</script>
</head>

<body style="background:url(../images/category_bg1.gif)" onLoad="page_load()">
<div id="panel">
    <div id="title">
        <div id="category1">
       <ul style="width:320px;">
        <li class="f_whit_am">물판 생성</li>
        <li style="float:left; margin-top:5px;"><a href="#" onclick="setRect()"><img src="../images/btn_edit.gif"/></a></li>
        <li style="margin:5px 0 0 3px;float:left;"><a href="#" onclick="clearRect()"><img src="../images/btn_edit_del.gif" /></a></li>
        <li style="margin:5px 0 0 3px;float:left;"><a href="#" onclick="createPlane()"><img src="../images/btn_cre.gif"/></a></li>
        <li style=" padding-top:5px;clear:both; ">
        	<img src="../images/category_SIDE.gif" />
        </li>
        </ul>
		<fieldset >
        <legend class="f_whit_am">침수시뮬레이션 옵션</legend>
             <ul style="padding:5px;" >
            <li style="float:left;">
              <label for="AmbientMax">최대높이</label>
              <input type="text" name="AmbientMax" id="AmbientMax" />m
            </li>
            <li style=" clear:both;">
              <label for="AmbientMin">최저높이</label>
              <input type="text" name="AmbientMin" id="AmbientMin" />m
            </li>
            <li style=" clear:both;">
              <label for="Ambient">침수수위</label>
              <input type="text" name="Ambient" id="Ambient" />m
            </li>
            <li style=" clear:both;">
              <label for="moveDist">이동단위</label>
                 <select id="moveDist" name="moveDist" style="width:55px;">
					<option value="0.1">0.1</option>
					<option value="0.2">0.2</option>
					<option value="0.5" selected>0.5</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="5">5</option>
					<option value="10">10</option>
              	</select>
              m</li>
            </ul>
        </fieldset>

        <hr />
        </br>
        <ul>
        <li class="f_whit_am">물판 상하 이동</li>
        <li style="float:left;">
        	<a href="#" onclick="waterUp()">
        		<img src="../images/btn_up.gif"/>
        	</a>
        </li>
        <li style="margin:0 0 0 3px;">
        	<a href="#" onclick="waterDown()">
	       		<img src="../images/btn_down.gif"/>
	       	</a>
        </li>
        <li></li>
        </ul>
	  </div>
    </div>
</div>
</body>
</html>