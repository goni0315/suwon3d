<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>3차원공간정보활용시스템</title>

<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript" src="${ctx}/js/json2.js"></script>
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<script type="text/javascript" src="${ctx}/js/common.js"></script>

<script type="text/javascript">


var chg_truck = 'chg_truck';
var chg_vol = 'chg_vol';	
var baseUrl = '${ctx}/images/test01.gif';
var slopeUrl = '${ctx}/images/test02.gif';

//성절토 영역 설정
function cutArea(){
	var hei_min;
	var hei_max;
	var hei_average;
	var hei_change;
	top.setWorkMode('set_rect');
	top.XDOCX.XDUISetWorkMode(24);
}

//성절토 취소
function cutCancel(){
	top.XDOCX.XDUIClearInputPoint();
	
	hei_change.value = '';
	hei_average.value = '';
	hei_min.value = '';
	hei_max.value = '';
	img_base.value = '';
	img_slope.value = '';
	document.getElementById("resultView").style.display = "none";
	top.XDOCX.XDUISetWorkMode(1);
	if (top.XDOCX.XDTerrEditCount() > 0){
		top.XDOCX.XDTerrEditUndo();
	}
}

//바닥면 이미지 찾기
function baseImgSearch(){
	var fileName = top.XDOCX.XDUIOpenFileDlg(true, 'jpg,bmp');
	if (fileName != ""){
		if (top.XDOCX.XDUIFileExist(fileName)){
			document.getElementById('img_base').value = fileName;	
			img_preview('img_base', fileName);
		}
	}
}
//경사면 이미지 찾기
function slopeImgSearch(){
	var fileName = top.XDOCX.XDUIOpenFileDlg(true, 'jpg,bmp');
	if (fileName != ""){
		if (top.XDOCX.XDUIFileExist(fileName)){
			document.getElementById('img_slope').value = fileName;	
			img_preview('img_slope', fileName);
		}
	}
}
//성절토 실행
function cutExe(){

	if ('run'){		// 실행
		if (top.XDOCX.XDUIInputPointCount() < 3) { //3개미만의 지점 찍고 실행시 얼럿창
			alert("성/절토를 실행할 영역을 지정하세요");
			return;	
		}

		var imgBasePath = img_base.value;
		var imgSlopePath = img_slope.value;
		if (imgBasePath == "") {
			imgBasePath = top.m_workPath + "base.jpg"; //성절토 기본이미지 경로
		}
		if (imgSlopePath == "") {
			imgSlopePath = top.m_workPath + "slop.jpg";
		}

		var angle = 0;
		angle = slope_angle.value;
		
		var result = top.XDOCX.XDTerrCutEdit(parseInt(hei_change.value), angle, imgBasePath, imgSlopePath);
		rs_total.value = Math.round(result * 100) / 100;
		
		rs_cnt.value = Math.ceil(rs_total.value / rs_vol.value);
		
		top.XDOCX.XDUIClearInputPoint();
		top.XDOCX.XDUISetWorkMode(1);
		}
	if (chg_truck){		// 트럭선택
		rs_vol.value = rs_truck.value;
		if (rs_total.value != ""){
			rs_cnt.value = Math.ceil(rs_total.value / rs_vol.value);
		}
	}
	if (chg_vol){		// 트럭의 적재부피
		if (rs_total.value != ""){
			rs_cnt.value = Math.ceil(rs_total.value / rs_vol.value);
		}		
	}
	document.getElementById("resultView").style.display = "block";
}

function ttr(){
	if (chg_truck){		// 트럭선택
		rs_vol.value = rs_truck.value;
		if (rs_total.value != ""){
			rs_cnt.value = Math.ceil(rs_total.value / rs_vol.value);
		}
	}
	if (chg_vol){		// 트럭의 적재부피
		if (rs_total.value != ""){
			rs_cnt.value = Math.ceil(rs_total.value / rs_vol.value);
		}		
	}
	rs_cnt.value = Math.ceil(rs_total.value / rs_vol.value);
}

//미리보기
function img_preview(mode, src){

	if (mode == "img_slope") {
		//document.getElementById('img_slope_preview').style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + src + "',sizingMethod=scale)";
		var filepath = src.replace(/\\/gi,'/');
		filepath = filepath.replace(':\\',':/');
		preview_src = "file:///"+filepath;
		document.getElementById("img_slope_preview").style.backgroundImage="url(" + preview_src + ")";
		img_slope_src = src;
	} else if (mode == "img_base") {
		//document.getElementById('img_base_preview').style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + src + "',sizingMethod=scale)";
		var filepath = src.replace(/\\/gi,'/');
		filepath = filepath.replace(':\\',':/');
		preview_src = "file:///"+filepath;
		document.getElementById("img_base_preview").style.backgroundImage="url(" + preview_src + ")";
		img_base_src = src;
	}
}
//저장
function cutSave() {
	var cnt = top.XDOCX.XDTerrEditCount() - 1;
	if (cnt < 0) { /* alert('성절토 '); */ return; }
    var fileName = top.XDOCX.XDUIOpenFileDlg(false, 'dat');
    
    if (fileName != ""){
        top.XDOCX.XDTerrSaveEditTerrain(fileName, 0, cnt);
        var saveName = fileName.split("\\");
    	var nameSize = saveName.length-1;
    	var rSaveName = saveName[nameSize];
    	alert(rSaveName + " 으로 저장되었습니다.");
    }
}
//열기
function cutLoad() {
	var fileName = top.XDOCX.XDUIOpenFileDlg(true, 'dat');
    
    if (fileName != ""){
    	if (top.XDOCX.XDUIFileExist(fileName)){			
        	top.XDOCX.XDTerrLoadEditTerrain(fileName);
    		top.XDOCX.XDMapLoad();
    	}
    }
}
</script>
</head>

<body style="background: url(${ctx}/images/category_bg1.gif)">
	<div id="panel">
		<div id="title">
			<div id="category1">
				<ul style="width: 320px;">
					<li class="f_whit_am">선택영역 설정</li>
					<li style="float: left;">
						<a href="#" onclick="cutArea()">
							<img src="${ctx}/images/btn_Edit_A_sel.gif" />
						</a>
					</li>
					<li style="float: left; margin: 0 0 0 3px;">
						<a href="#" onclick="cutCancel()">
							<img src="${ctx}/images/btn_analysis_cancel.gif" width="96" height="24" />
						</a>
					</li>
                    <li></li>
					<li style="margin-top: 10px; height: 90px; clear: both;">
						<fieldset style="padding:5px;">
							<legend class="f_whit_am">높이설정</legend>
							<ul>
								<li style="float: left;"><label for="hei_average" style="width: 60px;">평균높이</label>
									<input type="text" name="hei_average" id="hei_average" style="width: 70px" value="" readonly/> m
								</li>
								<li></li>
								<li style="float: left;"><label for="textfield" style="width: 60px;">최고</label>
									<input type="text" name="hei_min" id="hei_min" style="width: 70px" value="" readonly/> m
								</li> 
								<li><label for="textfield" style="width: 40px; margin-left:10px;"> 최저</label>
									<input type="text" name="hei_max" id="hei_max" style="width: 70px" value="" readonly/> m
								</li>
								<li style="clear: both; float: left;"><label for="textfield" style="width: 60px;">높이조절</label> 
									<input type="text" name="hei_change" id="hei_change" style="width: 70px" value=""/> m
								</li>
								<li><label for="textfield" style="width: 40px;margin-left:10px;"> 경사도</label>
									<input type="hidden" value="" id="rd_slope_type1" name="rd_slope_type" checked/>
									<input id="slope_angle" value="45" size="6" />도
								</li>
							</ul>
						</fieldset>
					</li>
					<li style="margin-top: 20px; height: 190px; clear: both;">
						<fieldset style="padding:5px;">
					        <legend class="f_whit_am">분석이미지</legend>
					        <ul>
						        <li style="margin-top:10px;"><b>바닥면</b></li>
						        <li>바닥면 이미지
						        	<input type="text" value="" id="img_base" name="img_base" readOnly/>
						        	<input type="button" value="찾기" onclick="baseImgSearch()">
						        </li>
						        <li><div id="img_base_preview" style="background: url(${ctx}/images/test01.gif); height:20px;"></div></li>
						        <li style="margin-top:10px;"><b>경사면</b></li>
						        <li>경사면 이미지
						        	<input type="text" value="" id="img_slope" readOnly/>
						        	<input type="button" value="찾기" onclick="slopeImgSearch()">
						        </li>
						        <li><div id="img_slope_preview" style="background: url(${ctx}/images/test02.gif); height:20px;"></div></li>
					        </ul>
				        </fieldset>
					</li>
                    </ul>
                    <ul style="margin-top:10px;">
					<li><a href="#" onclick="cutSave()"><img src="${ctx}/images/btn_save.gif"/></a>
						<a href="#" onclick="cutLoad()"><img src="${ctx}/images/btn_open_on.gif"/></a>
					</li>
					<li><a href="#" onclick="cutExe()" style="float:right;"><img src="${ctx}/images/btn_ok.gif" alt=""/></a>
					</li>
					<li style="height: 180px; margin-top: 10px;">
						<fieldset id="resultView" style="display: none;"> 
							<legend class="f_whit_am"> 측정 결과</legend>
							<ul>
								<li><label for="rs_total" style="width: 100px;">토공량</label>
									<input type="text" name="rs_total" id="rs_total"/> ㎡
								</li>
								<li>
									<label for="textfield" style="width: 100px;">덤프트럭환산</label>
								</li>
								<li>
									<label for="textfield" style="width: 100px;">트럭종류</label>
										<select name="rs_truck" id="rs_truck" onChange="chg_truck" onclick="ttr()">
											<option	value="35" selected="selected">8톤</option>
											<option value="15">15톤</option>
											<option value="24">24톤</option>
											<option value="25.5">25.5톤</option>
											<option value="27">27톤</option>
										</select>
								</li>
								<li>
									<label for="textfield" style="width: 100px;">대당부피</label>
									<input value="10.0" id="rs_vol" onChange="chg_vol" />㎡
									<input type="text" id="rs_cnt" name="rs_cnt" readOnly />대
								</li>
								<li></li>
							</ul>
						</fieldset>
					</li>
				</ul>

			</div>
		</div>
	</div>
</body>
</html>