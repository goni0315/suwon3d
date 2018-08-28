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

<script type="text/javascript" src="${ctx}/js/json2.js"></script><!-- 도로개설 -->
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<script type="text/javascript">
var img_path = 'img_path';
var cooiseImage = '';
var imgPath = "";

//구간 선택
function roadChoise(){
	top.XDOCX.XDUISetWorkMode(21);//포인터 입력
}

//선택취소
function roadPointCancle(){
	top.XDOCX.XDUIClearInputPoint();//입력점 초기화
	top.XDOCX.XDUISetWorkMode(1);//이동 손모양
	//top.MapControl('map_clear');
}
//실행취소
function roadCancle(){
	top.XDOCX.XDUIClearInputPoint();//입력점 초기화
	top.XDOCX.XDUISetWorkMode(1);//이동 손모양
	top.MapControl('map_clear');
	$("#img_path").val("");
	$("#road_width").val("0");
	document.getElementById("img_prv").style.backgroundImage="";
}
//실행
function roadExe(){
	if ('run'){		// 실행
		imgPath = document.getElementById('img_path');
	   
		var imgName = document.getElementById('img_path').value;//여기서 다시 받아와야 함
		if (top.XDOCX.XDUIInputPointCount() < 2) {
			alert('2개 이상의 지점을 입력하세요');
			return;
		}
		if (imgPath == "") {
			alert('텍스쳐 이미지를 선택하세요');
			return;
		}
		
		var objkey = getCurrDate();//연월일시분초
		var trans = 100 * 2.55;//불투명도
		var width = road_width.value;//도로폭조절
		top.XDOCX.XDObjCreateLineRoad(objkey, width, trans, 255, 255, 255, imgName);
        top.XDOCX.XDUIClearInputPoint();//입력점 초기화
        top.XDOCX.XDMapLoad();//맵 로딩
        top.XDOCX.XDUISetWorkMode(1);//마우스 상태를 기본 이동상태로
	}
}

//이미지 찾기
function imgSearch(){	// shp 파일 찾기
	var fileName = top.XDOCX.XDUIOpenFileDlg(true, 'jpg,bmp,gif');
	if (fileName != ""){
		if (top.XDOCX.XDUIFileExist(fileName)){
			document.getElementById('img_path').value = fileName;	
			img_preview(fileName);
		}
	}
}

//미리보기
function img_preview(src){
	if (!top.XDOCX.XDUIFileExist(src)) {
		alert("파일이 존재하지 않습니다.");
		return;
	}
	//document.getElementById('img_prv').style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + src + "',sizingMethod=scale)";
	var filepath = src.replace(/\\/gi,'/');
	filepath = filepath.replace(':\\',':/');
	preview_src = "file:///"+filepath;
	document.getElementById("img_prv").style.backgroundImage="url(" + preview_src + ")";
}
</script>
</head>

<body >
	<div id="panel">
		<div id="title">
			<div id="category">
				<ul style="width: 320px;">
					<li style="float: left;"><a href="road.jsp" target="left"><img src="${ctx}/images/btn_lib_road_off.gif" /></a></li>
					<li style="float: right"><a href="road_add.jsp" target="left"><img src="${ctx}/images/btn_lib_add_on.gif" /></a></li>
					<li style="padding-top: 15px; clear: both;"><img src="${ctx}/images/category_SIDE.gif" /></li>
					<li class="f_whit_am">도로구간설정</li>
					<li style="float: left; margin-top: 0px;">
						<a href="#" onclick="roadChoise()">
							<img src="${ctx}/images/btn_section.gif" width="96" height="24" />
						</a>
					</li>
					<li style="float: left;margin: 0px 0 0 3px;">
						<a href="#" onclick="roadPointCancle()">
							<img src="${ctx}/images/btn_move.gif" width="62" height="24" />
						</a>
					</li>
					<li style="padding-top: 15px; clear: both;">
						<img src="${ctx}/images/category_SIDE.gif" />
					</li>
					<li class="f_whit_am">사용자 라이브러리 추가</li>
					<li>
						<input type="text" id="img_path" name="img_path" style="width:250px" readOnly/>
						<input type="button" value="찾기" style="width:40px; height:22px; cursor:hand;" onClick="imgSearch()"/>
					</li>
					<li>
						<img src="${ctx}/images/category_SIDE1.gif" />
					</li>
				</ul>
				<input name="rd_img_type" type="hidden" id="rd_img_type2" checked="checked" />
				<fieldset style="padding:5px;">
					<legend class="f_whit_am">도로옵션</legend>
					<ul>
						<li style="float: left;">
							<label for="road_width">도로폭</label> 
							<input type="text" name="road_width" id="road_width" value="10" /> m
						</li>
					</ul>
				</fieldset>
				<ul>
					<li style="float: left; margin: 10px 0 10px 3px;">
						<a href="#" onclick="roadExe()">
							<img src="${ctx}/images/btn_add.gif" width="96" height="24" />
						</a>
					</li>
					<li style="float: left;margin: 10px 0 10px 3px;">
						<a href="#" onclick="roadCancle();">
								<img src="${ctx}/images/btn_analysis_cancel.gif" width="96" height="24" />
							</a>
					</li>
				</ul>
			</div>
		</div>
		<div align="center">
			<h4>
				<img src="${ctx}/images/result_title1.gif" alt="결과" width="340" height="34" />
			</h4>
			<div id="img_prv" name="img_prv" style="height: 200px; width: 256px; background-color: #FFF; border: solid 1px #2c3444; margin: 10px;"></div>
		</div>
	</div>
</body>
</html>