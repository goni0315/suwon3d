<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>3차원공간정보활용시스템</title>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript">
var left="left";
var north="north";
var south="south";
var right="right";
var up="up";
var down="down";
var angle = 5;
var dist = 5;		
var m_ox, m_oy, m_oz = 0.0;
var obj_move_horizon='obj_move_horizon';
var obj_move_vertical='obj_move_vertical';
var obj_rotate='obj_rotate';

//키보드로 건물 이동		
	$(document).keydown(function(event){	
		
		if(top.XDOCX.XDSelGetCount() >= 1) {
			
				if(event.keyCode == '37'){		
					objMove("left");
				}else if(event.keyCode == '38'){
					objMove("north");
				} else if(event.keyCode == '39'){
					objMove("right");
				} else if(event.keyCode == '40'){
					objMove("south");				
				}				
		}				
	});	

//객체 선택
function choose(){ 
	top.XDOCX.XDUISetWorkMode(6);
}
//다각선택
function selfChoose(){ 
	top.XDOCX.XDUISetWorkMode(11);
}
//선택취소
function chooseCancel(){ 
	top.XDOCX.XDSelClear();
	top.XDOCX.XDUISetWorkMode(1);
}
//수평이동
function widthMove(){ 
	if (top.XDOCX.XDSelGetCount() < 1) {
		document.getElementById("RadioGroup1_0").checked=false;
		alert('선택된 객체가 없습니다.');
		return;
	}	
	top.XDOCX.XDUISetWorkMode(41);
	
}
//수직이동
function highMove(){ 
	if (top.XDOCX.XDSelGetCount() < 1) {
		document.getElementById("RadioGroup1_1").checked=false;
		alert('선택된 객체가 없습니다.');
		return;
	}	
	top.XDOCX.XDUISetWorkMode(42);
}
//회전
function turnMove(){ 
	if (top.XDOCX.XDSelGetCount() < 1) {
		document.getElementById("RadioGroup1_2").checked=false;
		alert('선택된 객체가 없습니다.');
		return;
	}		
	top.XDOCX.XDUISetWorkMode(43);
	
}
//이동
function objMove(mode){
	if (sel_layer.value == ""){	
		if(top.XDOCX.XDSelGetCount() < 1) {
			alert("선택된 객체가 없습니다.");    
			return ;
		}
		for(var i = 0; i < top.XDOCX.XDSelGetCount(); i++) {
			var info = top.XDOCX.XDSelGetCode(i);
			info = info.split("#");

			if (!getObjectCenterPoint(info[0], info[1], false, 0)) return;

			var value = parseInt(dist);
			if (mode == "left"){		// 위치이동_수평
				top.XDOCX.XDObjMove(info[0], info[1], m_ox-value, m_oy, m_oz, true);
			}else if (mode == "north"){		// 회전		
				top.XDOCX.XDObjMove(info[0], info[1], m_ox, m_oy, m_oz+value, true);
			}else if (mode == "south"){		// 선택		
				top.XDOCX.XDObjMove(info[0], info[1], m_ox, m_oy, m_oz-value, true);
			}else if (mode == "right"){		// 위치이동_수직
				top.XDOCX.XDObjMove(info[0], info[1], m_ox+value, m_oy, m_oz, true);
			}else if (mode == "up"){		// 초기화		
				top.XDOCX.XDObjMove(info[0], info[1], m_ox, m_oy+value, m_oz, true);
			}else if (mode == "down"){		// 초기화			
				top.XDOCX.XDObjMove(info[0], info[1], m_ox, m_oy-value, m_oz, true);
			}
		}

	}else{
		var ln = sel_layer.value;
		
		if (top.XDOCX.XDLayGetObjectCount(ln) > 0 ){
			for (var i = 0; i < top.XDOCX.XDLayGetObjectCount(ln); i++){
				var key = top.XDOCX.XDLayGetObjectKey(ln, i);
				
				if (!getObjectCenterPoint(ln, key, false, 0)) return;
			
				var value = parseInt(dist);
				if (mode == "left"){		// 위치이동_수평
					top.XDOCX.XDObjMove(ln, key, m_ox-value, m_oy, m_oz, true);
				}else if (mode == "north"){		// 회전		
					top.XDOCX.XDObjMove(ln, key, m_ox, m_oy, m_oz+value, true);
				}else if (mode == "south"){		// 선택		
					top.XDOCX.XDObjMove(ln, key, m_ox, m_oy, m_oz-value, true);
				}else if (mode == "right"){		// 위치이동_수직
					top.XDOCX.XDObjMove(ln, key, m_ox+value, m_oy, m_oz, true);
				}else if (mode == "up"){		// 초기화		
					top.XDOCX.XDObjMove(ln, key, m_ox, m_oy+value, m_oz, true);
				}else if (mode == "down"){		// 초기화			
					top.XDOCX.XDObjMove(ln, key, m_ox, m_oy-value, m_oz, true);
				}		
			}			
		}else{
			alert("선택된 객체가 없습니다.");    
			return ;
		}
	}
	top.XDOCX.XDMapRender();
}
//회전방향설정
function objRotate(value,course){
	if (sel_layer.value == ""){
		
		if(top.XDOCX.XDSelGetCount() < 1) {
			alert("선택된 객체가 없습니다.");    
			return ;
		}
		for(var i = 0; i < top.XDOCX.XDSelGetCount(); i++) {
			var info = top.XDOCX.XDSelGetCode(i);
			info = info.split("#");
			
			if(value != 0){
				top.XDOCX.XDObjSetRotate(info[0], info[1], 1, value);
			}else{
				if(course == 'right'){
					//오른쪽
					var angle1 = angle - (angle * 2);
					top.XDOCX.XDObjSetRotate(info[0], info[1], 1, angle1);
				}else if(course == 'left'){
					//왼쪽
					top.XDOCX.XDObjSetRotate(info[0], info[1], 1, angle);
				}
			}
		}		
	}	
	top.XDOCX.XDMapRender();
}

function getObjectCenterPoint(lName, key, by, h) {
	var temp, pa;
	temp = top.XDOCX.XDObjGetBox(lName, key);
	if(temp=="") {
		alert(false);
		return false;
	}
	
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
//객체선택
function buildChoose(){ 
	top.Refresh();
	top.XDOCX.XDUISetWorkMode(6);
 	document.getElementById("RadioGroup1_0").checked=false;
 	document.getElementById("RadioGroup1_1").checked=false;
 	document.getElementById("RadioGroup1_2").checked=false;
 	document.getElementById("RadioGroup1_3").checked=false;
 	document.getElementById("RadioGroup1_4").checked=false;
 	
 	document.getElementById("type1").checked=false;
 	document.getElementById("type2").checked=false;
 	document.getElementById("hei_type1").checked=false;
 	document.getElementById("hei_type2").checked=false;
 	

  	document.getElementById("resize_hei").value="";
  	document.getElementById("resize_floor").value="";
 	
 	
}
//객체사각선택
function buildRectChoose(){ 
	top.Refresh();
	top.XDOCX.XDUISetWorkMode(8);
 	document.getElementById("RadioGroup1_0").checked=false;
 	document.getElementById("RadioGroup1_1").checked=false;
 	document.getElementById("RadioGroup1_2").checked=false;
 	document.getElementById("RadioGroup1_3").checked=false;
 	document.getElementById("RadioGroup1_4").checked=false;
 	

  	document.getElementById("resize_hei").value="";
  	document.getElementById("resize_floor").value="";
  	
 	document.getElementById("type1").checked=false;
 	document.getElementById("type2").checked=false;
 	document.getElementById("hei_type1").checked=false;
 	document.getElementById("hei_type2").checked=false;
  	
}
//객체선택취소
function buildChooseCancel(){ 
	top.XDOCX.XDSelClear();
	top.XDOCX.XDUISetWorkMode(1);
	

  	document.getElementById("resize_hei").value="";
  	document.getElementById("resize_floor").value="";
 	
 	document.getElementById("RadioGroup1_0").checked=false;
 	document.getElementById("RadioGroup1_1").checked=false;
 	document.getElementById("RadioGroup1_2").checked=false;
 	document.getElementById("RadioGroup1_3").checked=false;
 	document.getElementById("RadioGroup1_4").checked=false;
 	
 	document.getElementById("type1").checked=false;
 	document.getElementById("type2").checked=false;
 	document.getElementById("hei_type1").checked=false;
 	document.getElementById("hei_type2").checked=false;

	
}
//높이조절
function highControl(){ 
	if ('height'){		
		if (top.XDOCX.XDSelGetCount() < 1) {
		 	document.getElementById("RadioGroup1_3").checked=false;
			alert('선택된 객체가 없습니다.');
			return;
		}
		top.XDOCX.XDUISetWorkMode(45);
	}
	
}
//수평크기
function widthControl(){
	if ('width'){
		if (top.XDOCX.XDSelGetCount() < 1) {
		 	document.getElementById("RadioGroup1_4").checked=false;
			alert('선택된 객체가 없습니다.');
			return;
		}
		top.XDOCX.XDUISetWorkMode(46);
	}
}
function editExe(){
	var type1 = document.getElementById("type1");
	var hei_type1 = document.getElementById("hei_type1");
// 	if (sel_layer.value != ""){
	if (true){
		if(top.XDOCX.XDSelGetCount() < 1) {
			alert("선택된 객체가 없습니다.");    
			return ;
		}
		if (type1.checked){
			for(var i = 0; i < top.XDOCX.XDSelGetCount(); i++) {
				temp = top.XDOCX.XDSelGetCode(i);
				pa = temp.split("#");
				var m_selObj_lName = pa[0];
				var m_selObj_Id = pa[1];

				var box = top.XDOCX.XDObjGetBox(m_selObj_lName, m_selObj_Id);
				
				if (box != "") {
					var xy = box.split(",");
					var before_height = xy[4]-xy[1];	// 객체높이
								
					if(top.XDOCX.XDObjSetScale(m_selObj_lName, m_selObj_Id, resize_x.value / 100, resize_y.value / 100, resize_z.value / 100)==true){
						box = top.XDOCX.XDObjGetBox(m_selObj_lName, m_selObj_Id);
						xy = box.split(",");
						var after_height = xy[4]-xy[1];	// 객체높이
						
					   //건물의 중심을 기준으로 크기변경, 고로 땅에 붙이자
						var value = (after_height - before_height) / 2;
						if(getObjectCenterPoint(m_selObj_lName, m_selObj_Id, false, 0)==true){
							top.XDOCX.XDObjMove(m_selObj_lName, m_selObj_Id, m_ox, (parseFloat(m_oy)+value), m_oz, true);
						}
					}
				}
			}
		}else{
			var hei = 0;
			if (hei_type1.checked){
				height = resize_hei.value;
			}else{
				height = 3 * resize_floor.value;
			}
			
			for(var i = 0; i < top.XDOCX.XDSelGetCount(); i++) {
				temp = top.XDOCX.XDSelGetCode(i);
				pa = temp.split("#");
				var m_selObj_lName = pa[0];
				var m_selObj_Id = pa[1];

				var box = top.XDOCX.XDObjGetBox(m_selObj_lName, m_selObj_Id);
				
				if (box != "") {
					var xy = box.split(",");
					var current_height = xy[4]-xy[1];	// 객체높이
					
					// 배율계산
					var times = height/current_height;
				
					if(top.XDOCX.XDObjSetScale(m_selObj_lName, m_selObj_Id, 1, times, 1)==true){
					   //건물의 중심을 기준으로 크기변경, 고로 땅에 붙이자
						var value = (height - current_height) / 2;
						if(getObjectCenterPoint(m_selObj_lName, m_selObj_Id, false, 0)==true){
							top.XDOCX.XDObjMove(m_selObj_lName, m_selObj_Id, m_ox, (parseFloat(m_oy)+value), m_oz, true);
						}
					}
				}
			}
		}
	}else{
		var ln = sel_layer.value;
		if (top.XDOCX.XDLayGetObjectCount(ln) > 0){
			if (type1.checked){		
				for (var i = 0; i < top.XDOCX.XDLayGetObjectCount(ln); i++){
					var key = top.XDOCX.XDLayGetObjectKey(ln, i);

					var box = top.XDOCX.XDObjGetBox(ln, key);
					
					if (box != "") {
						var xy = box.split(",");
						var before_height = xy[4]-xy[1];	// 객체높이
									
						if(top.XDOCX.XDObjSetScale(ln, key, resize_x.value / 100, resize_y.value / 100, resize_z.value / 100)==true){
							box = top.XDOCX.XDObjGetBox(ln, key);
							xy = box.split(",");
							var after_height = xy[4]-xy[1];	// 객체높이
							
						   //건물의 중심을 기준으로 크기변경, 고로 땅에 붙이자
							var value = (after_height - before_height) / 2;
							if(getObjectCenterPoint(ln, key, false, 0)==true){
								top.XDOCX.XDObjMove(ln, key, m_ox, (parseFloat(m_oy)+value), m_oz, true);
							}
						}
					}
				}
			}else{
				var hei = 0;
				if (hei_type1.checked){
					height = resize_hei.value;
				}else{
					height = 3 * resize_floor.value;
				}

				for (var i = 0; i < top.XDOCX.XDLayGetObjectCount(ln); i++){
					var key = top.XDOCX.XDLayGetObjectKey(ln, i);

					var box = top.XDOCX.XDObjGetBox(ln, key);
					
					if (box != "") {
						var xy = box.split(",");
						var current_height = xy[4]-xy[1];	// 객체높이
						
						// 배율계산
						var times = height/current_height;
					
						if(top.XDOCX.XDObjSetScale(ln, key, 1, times, 1)==true){
						   //건물의 중심을 기준으로 크기변경, 고로 땅에 붙이자
							var value = (height - current_height) / 2;
							if(getObjectCenterPoint(ln, key, false, 0)==true){
								top.XDOCX.XDObjMove(ln, key, m_ox, (parseFloat(m_oy)+value), m_oz, true);
							}
						}
					}
				}
			}
		}else{
			alert("레이어 내에 객체가 없습니다.");    
			return ;
		}
	}
	top.XDOCX.XDMapRender();
}

//복사
function copy(){ 
	if (top.XDOCX.XDSelGetCount() == 1){
		var objCode = top.XDOCX.XDSelGetCode(0);
		objCode = objCode.split("#");
		if (top.XDOCX.XDObjExportXDO(objCode[0], objCode[1], top.getXDWorkPath() + "objCopy.xdo")){
			top.setObjCopy(objCode[1]);	
			top.XDOCX.XDSelClear();
		}
		
	}else if (top.XDOCX.XDSelGetCount() > 1){
		alert('단일객체에 대하여 실행가능합니다.');
	}else{
		alert('객체를 선택하세요');
	};
}
//잘라내기
function cut(){ 
	if (top.XDOCX.XDSelGetCount() == 1){
		var objCode = top.XDOCX.XDSelGetCode(0);
		objCode = objCode.split("#");
		if (top.XDOCX.XDObjExportXDO(objCode[0], objCode[1], top.getXDWorkPath() + "objCopy.xdo")){
			top.setObjCopy(objCode[1]);	
			top.XDOCX.XDSelDelete();
		};
	}else if (top.XDOCX.XDSelGetCount() > 1){
		alert('단일객체에 대하여 실행가능합니다.');
	}else{
		alert('객체를 선택하세요');
	}
}
//붙여넣기
function paste(){ 
	if (top.getObjCopy() != ""){
		top.setWorkMode('obj_paste');
		top.XDOCX.XDUISetWorkMode(20);
	}else{
		alert('붙여넣기할 객체가 없습니다.');
	}
}
//삭제
function delet(){ 
	if (top.XDOCX.XDSelGetCount() > 0){
		if(confirm('선택한 객체를 삭제합니다.')){
			top.XDOCX.XDSelDelete();
		}
	}else{
		alert('삭제할 객체를 선택하세요');
	}
}
//복사취소
function copyCancel(){ 
	top.setObjCopy('');
	top.XDOCX.XDUISetWorkMode(1);
};

function getObjectCenterPoint(lName, key, by, h) {
	var temp, pa;
	temp = top.XDOCX.XDObjGetBox(lName, key);
	if(temp=="") {
		return false;
	}
	
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

//직접변경 : 배율
function selfChange(type) {
	if(type != 'magnification'){
		if(type == 'resize_hei'){
			hei_type1.checked;
		}else if(type == 'resize_floor'){
			hei_type2.checked;
		}
		resize_x.disabled;
		resize_y.disabled;
		resize_z.disabled;
	}else{
		resize_hei.disabled;
		resize_floor.disabled;
	}
	
}


//라이브러리 저장
function libSave() {
	
	if(parent.chk==1){
		var saveChk = confirm("불러온 레이어(xdl)파일은 저장되지 않습니다. \n 그래도 계속 하시겠습니까? \n (3ds,png,jpg만 저장됩니다)"); 
		if(saveChk){
			
			var fileName = top.XDOCX.XDUIOpenFileDlg(false, 'xdl');
			if (fileName != ""){
				top.XDOCX.XDLayerWriteFile("Temporary",fileName);
				var saveName = fileName.split("\\");
				var nameSize = saveName.length-1;
				var rSaveName = saveName[nameSize];
				alert(rSaveName + " 으로 저장되었습니다.");
			}else{
				alert("저장이 취소되었습니다.");
			}			
			return;
		}	
		
		return;		
	}
	
	
	var fileName = top.XDOCX.XDUIOpenFileDlg(false, 'xdl');
	if (fileName != ""){
		top.XDOCX.XDLayerWriteFile("Temporary",fileName);
		var saveName = fileName.split("\\");
		var nameSize = saveName.length-1;
		var rSaveName = saveName[nameSize];
		alert(rSaveName + " 으로 저장되었습니다.");
	}else{
		alert("저장이 취소되었습니다.");
	}
}

var cnt = 1;
//라이브러리 불러오기
function libLoad() {
	var fileName = top.XDOCX.XDUIOpenFileDlg(true, 'xdl');
	if (fileName != ""){
		top.XDOCX.XDLayReadFile(fileName);
		top.XDOCX.XDMapLoad();
		var loadName = fileName.split("\\");
		var nameSize = loadName.length-1;
		var rLoadName = loadName[nameSize];
		
		var rrLoad = rLoadName.split(".");
		var popup = top.XDOCX.XDLayerGetBox(rrLoad[0]);
		
		if(parent.chkXDL(rrLoad[0])){
			return;
		}
		
		alert(rrLoad[0] + " / "+ popup);
		parent.chk = 1;
		/* $("#loadList").append($(
			'<tr id="tr' + cnt + '">'+
				'<td>' + cnt + '</td><td>'+
				'<input type="checkbox">'+ 
			'</td><td>' + rLoadName + '</td></tr>'
		)); */
	}
	cnt++;
}

//라이브러리 삭제
function libDelete() {
	
}
</script>
</head>
<body style="background: url(${ctx}/images/category_bg1.gif);"  >
	<div id="panel">
		<div id="title">
			<div id="category1">
				<ul style="width: 320px;">
<%-- 					<li style="float: left;">
						<a href="edit_move.jsp" target="left">
							<img src="${ctx}/images/btn_edit_move_off.gif" />
						</a>
					</li>
					<li style="float: right">
						<a href="edit.jsp" target="left">
							<img src="${ctx}/images/btn_edit_on.gif" />
						</a>
					</li> --%>
<%-- 					<li style="padding-top: 10px; clear: both;">
						<img src="${ctx}/images/category_SIDE.gif" />
					</li> --%>
					<li class="f_whit_am">대상설정</li>
					<li style="float: left; margin-top: 0px;">
						<input type="hidden" name="sel_layer" id="sel_layer">
						<a href="#" onclick="buildChoose()">
							<img src="${ctx}/images/btn_obj.gif" alt="객체선택"/>
						</a>
					</li>
					<li style="float: left; margin:0 0 0 3px;">
<!-- 						<input type="hidden" name="sel_layer" id="sel_layer"> -->
						<a href="#" onclick="buildRectChoose()">
							<img src="${ctx}/images/btn_sel_A.gif" alt="영역선택"/>
						</a>
					</li>
					<li style="float: left; margin: 0px 0 0 3px;">
						<a href="#" onclick="buildChooseCancel()">
							<img src="${ctx}/images/btn_cancel.gif" alt="취소" />
						</a>
					</li>
<%-- 					<li style="padding-top: 5px; clear: both;"><img src="${ctx}/images/category_SIDE1.gif" /></li> --%>
				</ul>
				<fieldset style="padding:5px; clear: both; margin-top:35px; height: 110px;" >
					<legend class="f_whit_am">마우스 이동</legend>
					<ul>
						<li style="float: left; margin-right: 5px;">
							<label> 
								<input name="RadioGroup1" type="radio" id="RadioGroup1_0" value="라디오" onclick="widthMove()"/> 수평이동
							</label>
						</li>
						<li style="float: left; margin-right: 5px;">
							<label>
								<input type="radio" name="RadioGroup1" value="라디오" id="RadioGroup1_1" onclick="highMove()"/> 수직이동
							</label>
						</li>
						<li>
							<label>
								<input type="radio" name="RadioGroup1" value="라디오" id="RadioGroup1_2" onclick="turnMove()"/> 회전
							</label>
						</li>
							<li style="float:left; margin-right: 5px;">
							<label> 
								<input name="RadioGroup1" type="radio" id="RadioGroup1_3" value="라디오" onclick="highControl()" /> 높이조절
							</label>
						</li>
						<li style="float:left;">
							<label> 
								<input type="radio" name="RadioGroup1" value="라디오" id="RadioGroup1_4" onclick="widthControl()" /> 넓이조절
							</label>
						</li>
						<li style="clear: left;">
<span style="color: red; font-weight: 100; bottom: 0;">※쉬프트키를 누르면 객체를 다중선택 할 수 있습니다</span><br>
<span style="color: red; font-weight: 100; bottom: 0;">영역선택 후 마우스 이동 기능 사용시 컨트롤키를 눌러주세요※</span>						
						</li>
					</ul>
				</fieldset>
				<br>
				<fieldset  style="padding:5px;">
					<legend class="f_whit_am">버튼식 이동</legend>
					<ul>
						<li style="float: left;"><label for="textfield2">이동거리</label>
							<input type="text" name="textfield2" id="textfield2" onChange="dist=this.value;" maxlength="10" value="5"/> m</li>
						<li style=" clear:both;height: 70px;">
							<table border="0" cellpadding="0" cellspacing="0" summary="편집 콘트롤 버튼">
								<tr>
									<td rowspan="2">
										<a href="#" onclick="objMove(left)">
											<img src="${ctx}/images/btn_control_01.gif" alt="왼쪽" />
										</a>
									</td>
									<td>
										<a href="#" onclick="objMove(north)"><img src="${ctx}/images/btn_control_02.gif" alt="전방" /></a>
									</td>
									<td rowspan="2">
										<a href="#" onclick="objMove(right)">
											<img src="${ctx}/images/btn_control_03.gif" alt="오른쪽" />
										</a>
									</td>
									<td>
									  <a href="#" onclick="objMove(up)">
									    <img src="${ctx}/images/btn_control_05.gif" alt="상승"  />
								      </a>								    </td>
								</tr>
								<tr>
									<td>
										<a href="#" onclick="objMove(south)"><img src="${ctx}/images/btn_control_06.gif" alt="후방" /></a>
									</td>
									<td>
									  <a href="#" onclick="objMove(down)">
									    <img src="${ctx}/images/btn_control_07.gif" alt="하강" />
								      </a>								    </td>
								</tr>
								
							</table>

						</li>
					</ul>
				</fieldset>
				<br>
				<fieldset  style="padding:5px;">
					<legend class="f_whit_am">시설물 회전</legend>
					<ul>
						<li style="float: left;">
						<label for="textfield3">회전각도<br /></label> 
							<input type="text" name="textfield3" id="textfield3" onChange="angle=this.value;" maxlength="3" value="15"/> 도
						</li>
						<li style=" clear:both; margin-bottom: 10px;">
							<a href="#" onclick="objRotate(0,left)">
								<img src="${ctx}/images/btn_rot_01.gif">
							</a>
							<a href="#" onclick="objRotate(0,right)">
								<img src="${ctx}/images/btn_rot_02.gif">
							</a>
						</li>
					</ul>
				</fieldset>
<!-- 				<fieldset style="padding:5px; clear: both; margin-top: 10px;"> -->
<!-- 					<legend class="f_whit_am">마우스 편집</legend> -->
<!-- 					<ul> -->
<!-- 						<li style="float: left;"> -->
<!-- 							<label>  -->
<!-- 								<input name="RadioGroup2" type="radio" id="RadioGroup1_0" value="라디오" onclick="highControl()" /> 높이조절 -->
<!-- 							</label> -->
<!-- 						</li> -->
<!-- 						<li style="float: left;"> -->
<!-- 							<label>  -->
<!-- 								<input type="radio" name="RadioGroup2" value="라디오" id="RadioGroup1_1" onclick="widthControl()" /> 수평크기 -->
<!-- 							</label> -->
<!-- 						</li> -->
<!-- 					</ul> -->
<!-- 				</fieldset> -->
			<br>
				<fieldset style="padding:5px">
					<legend class="f_whit_am"><input name="type" type="radio" id="type1" onclick="selfChange('magnification')"> 
					배율조절</legend>
					<ul>
						<li style="float: left;">
							<label for="resize_x">동서 </label> 
							<input type="text" name="resize_x" id="resize_x" value="100"/> %
						</li>
	
						<li style="float: left;">
							<label for="resize_z">남북<br /> </label>
							<input type="text" name="resize_z" id="resize_z" value="100"/> %
						</li>
											<li style="float: left;">
							<label for="resize_y">높이<br /> </label> 
							<input type="text" name="resize_y" id="resize_y" value="100"/> %
						</li>
					</ul>
						
					<legend class="f_whit_am" style="margin-bottom: 5px; clear: both;" ><input type="radio" name="type" id="type2"> 
					높이변경</legend>
					<ul>
						<li style="float: left;">
							<label for="resize_hei">시설물 높이 </label>
							<input type="radio" name="hei_type" id="hei_type1">
							<input type="text" name="resize_hei" id="resize_hei" /> m
						</li>
						<li style="float: left;">
							<label for="resize_floor">시설물 층수 </label>
							<input type="radio" name="hei_type" id="hei_type2"> 
							<input type="text" name="resize_floor" id="resize_floor" /> 층
						</li>
							
											
					<li style="clear: left;">
							<a href="#" onclick="editExe()">
														<img src="${ctx}/images/btn_ok.gif" /> 
						</a>
							</li>		
					</ul>
			
				</fieldset>
					

				<br>
				<fieldset style="padding:5px">
					<legend class="f_whit_am">시설물 저장/불러오기</legend>
					<table border="0" cellpadding="0" cellspacing="0" >
						<tr>
							<td>
								<a href="#" onclick="libSave()" style="margin-right: 5px;">
									<img src="${ctx}/images/btn_save.gif"/>
								</a>
							</td>
							<td>
								<a href="#" onclick="libLoad()" style="margin-right: 5px;">
									<img src="${ctx}/images/btn_open_on.gif"/>
								</a>
							</td>

							
							<%-- <td>
								<a href="#" onclick="libDelete()"  style="margin-left: 5px;">
									<img src="${ctx}/images/btn_delete.gif"/>
								</a>
							</td> --%>
						</tr>
					</table>

				</fieldset>
				
<!-- 				<fieldset style="padding:5px">
					<legend class="f_whit_am">시설물 불러오기 목록</legend>
					<table id="loadList" border="0" >
						<tr>
							<td align="center">No</td>
							<td align="center">Chk</td>
							<td align="center">Name</td>
						</tr>
					</table>
				</fieldset> -->
<!-- 				<ul> -->
<!-- 					<li style="margin-top: 10px; float: right;"> -->
<!-- 						<a href="#" onclick="editExe()"> -->
<%-- 							<img src="${ctx}/images/btn_ok.gif" /> --%>
<!-- 						</a> -->
<!-- 					</li> -->
<!-- 				</ul> -->
			</div>
		</div>
	</div>
</body>
</html>
