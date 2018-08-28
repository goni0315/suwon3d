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

//객체선택
function buildChoose(){ 
	top.XDOCX.XDUISetWorkMode(6);
}
//객체사각선택
function buildRectChoose(){ 
	top.XDOCX.XDUISetWorkMode(8);
}
//객체선택취소
function buildChooseCancel(){ 
	top.XDOCX.XDSelClear();
	top.XDOCX.XDUISetWorkMode(1);
	
 	document.getElementById("resize_x").value="";
 	document.getElementById("resize_y").value="";
 	document.getElementById("resize_z").value="";
 	document.getElementById("resize_hei").value="";
 	document.getElementById("resize_floor").value="";

	
}
//높이조절
function highControl(){ 
	if ('height'){		
		if (top.XDOCX.XDSelGetCount() < 1) {
			alert('객체를 선택하세요');
			return;
		}
		top.XDOCX.XDUISetWorkMode(45);
	}
	
}
//수평크기
function widthControl(){
	if ('width'){
		if (top.XDOCX.XDSelGetCount() < 1) {
			alert('객체를 선택하세요');
			return;
		}
		top.XDOCX.XDUISetWorkMode(46);
	}
}
function editExe(){

	var type1 = document.getElementById("type1");
	var hei_type1 = document.getElementById("hei_type1");
	if (sel_layer.value != ""){	
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
		alert(rrLoad[0] + " / "+ popup);
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
<body style="background: url(${ctx}/images/category_bg1.gif)">
	<div id="panel">
		<div id="title">
			<div id="category1">
				<ul style="width: 320px;">
					<li style="float: left;">
						<a href="edit_move.jsp" target="left">
							<img src="${ctx}/images/btn_edit_move_off.gif" />
						</a>
					</li>
					<li style="float: right">
						<a href="edit.jsp" target="left">
							<img src="${ctx}/images/btn_edit_on.gif" />
						</a>
					</li>
					<li style="padding-top: 10px; clear: both;">
						<img src="${ctx}/images/category_SIDE.gif" />
					</li>
					<li class="f_whit_am">대상설정</li>
					<li style="float: left; margin-top: 0px;">
						<input type="hidden" name="sel_layer" id="sel_layer">
						<a href="#" onclick="buildChoose()">
							<img src="${ctx}/images/btn_obj.gif" alt="객체선택"/>
						</a>
					</li>
					<li style="float: left; margin:0 0 0 3px;">
						<input type="hidden" name="sel_layer" id="sel_layer">
						<a href="#" onclick="buildRectChoose()">
							<img src="${ctx}/images/btn_sel_A.gif" alt="영역선택"/>
						</a>
					</li>
					<li style="float: left; margin: 0px 0 0 3px;">
						<a href="#" onclick="buildChooseCancel()">
							<img src="${ctx}/images/btn_cancel.gif" alt="취소" />
						</a>
					</li>
					<li style="padding-top: 5px; clear: both;"><img src="${ctx}/images/category_SIDE1.gif" /></li>
				</ul>
				<fieldset style="padding:5px">
					<legend class="f_whit_am">마우스</legend>
					<ul>
						<li style="float: left;">
							<label> 
								<input name="RadioGroup2" type="radio" id="RadioGroup1_0" value="라디오" onclick="highControl()" /> 높이조절
							</label>
						</li>
						<li style="float: left;">
							<label> 
								<input type="radio" name="RadioGroup2" value="라디오" id="RadioGroup1_1" onclick="widthControl()" /> 수평크기
							</label>
						</li>
					</ul>
				</fieldset>
				</br>
				<fieldset style="padding:5px">
					<legend class="f_whit_am"><input name="type" type="radio" id="type1" onclick="selfChange('magnification')"> 
					배율조절</legend>
					<ul>
						<li style="float: left;">
							<label for="resize_x">동서 </label> 
							<input type="text" name="resize_x" id="resize_x"/> %
						</li>
						<li style="float: left;">
							<label for="resize_y">남북<br /> </label> 
							<input type="text" name="resize_y" id="resize_y"/> %
						</li>
						<li style="float: left;">
							<label for="resize_z">높이<br /> </label>
							<input type="text" name="resize_z" id="resize_z"/> %
						</li>
					</ul>
				</fieldset>
				<hr />
				</br>
				<fieldset style="padding:5px">
					<legend class="f_whit_am"><input type="radio" name="type" id="type2"> 
					직접변경</legend>
					<ul>
						<li style="float: left;">
							<label for="resize_hei">시설물높이 </label>
							<input type="radio" name="hei_type" id="hei_type1">
							<input type="text" name="resize_hei" id="resize_hei" /> m
						</li>
						<li style="float: left;">
							<label for="resize_floor">시설물 층수 </label>
							<input type="radio" name="hei_type" id="hei_type2"> 
							<input type="text" name="resize_floor" id="resize_floor" /> 층
						</li>
					</ul>
				</fieldset>

				<hr />
				</br>
				<fieldset style="padding:5px">
					<legend class="f_whit_am">시설물 저장/불러오기</legend>
					<table border="0" cellpadding="0" cellspacing="0" >
						<tr>
							<td>
								<a href="#" onclick="libSave()">
									<img src="${ctx}/images/btn_save.gif"/>
								</a>
							</td>
							<td>
								<a href="#" onclick="libLoad()"  style="margin-left: 5px;">
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
				</br>
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
				<ul>
					<li style="margin-top: 10px; float: right;">
						<a href="#" onclick="editExe()">
							<img src="${ctx}/images/btn_ok.gif" />
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>
