<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css" />
<title>3차원공간정보활용시스템</title>
</head>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script><!--callScript의 제이쿼리 함수를 위해 적용  -->
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<script type="text/javascript" src="${ctx}/js/xdk.js"></script>
<script type="text/javascript" src="${ctx}/js/layer.js"></script>
<script type="text/javascript" src="${ctx}/js/json2.js"></script><!-- 도로개설 -->
<script type="text/javascript">
var tdsPath = "";
//구간선택
function lightStart(){
	$('#preview_window').show();
	top.XDOCX.XDUISetWorkMode(21);
	
}
//구간선택취소
function lightPointCancel(){
	top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDUISetWorkMode(1);
	
}
//실행취소
function lightCancel(){
	//TDS_VIEW.XDLayClear(TDS_VIEW.XDLayGetEditable());
	top.XDOCX.XDUIClearInputPoint();//입력점 초기화
	top.XDOCX.XDUISetWorkMode(1);//이동 손모양
	//top.MapControl('map_clear');
	$("#img_path").val("");
	$("#light_hei").val("6.0");
	$("#light_gab").val("8");
	$("#light_angle").val("0");
}

function lightExe(){
	if ('run'){		// 실행
		if (top.XDOCX.XDUIInputPointCount() < 2) {
			alert('2개 이상의 지점을 입력하세요');
			return;
		}
	
		if (tdsPath == "") {
			alert('3DS 모델링 파일을 선택하세요');
			return;
		}
		
		var objkey = getCurrDate();
		top.XDOCX.XDObjCreate3DSymbol(objkey, tree_gab.value, tree_hei.value, tree_angle.value, tdsPath);	
		
        top.XDOCX.XDUIClearInputPoint(); 
        top.XDOCX.XDUISetWorkMode(1);
	}
}

function preview(tds, png){
	if (tds == "") return;
	if (png == "") return;
	
	//alert(tds + ' : tds');
	//alert(png + ' : png');
	
	if (sl_img_type1){
		var url = top.WEB_SERVER_URL_SB + "/symbols/light/";
		var path = top.m_workPath + "kopss/light/";
		
		if (!TDS_VIEW.XDUIFileExist(path + tds + ".3DS")){
			if (!TDS_VIEW.XDWebFileDownload(url + tds + ".3DS", path + tds + ".3DS")) {
				alert("3DS 모델링 로딩에 실패하였습니다");
				return;
			}
		}
		if (!TDS_VIEW.XDUIFileExist(path + png + ".png")){
			TDS_VIEW.XDWebFileDownload(url + png + ".png", path + png + ".png");
		}

		var ln = TDS_VIEW.XDLayGetEditable();
		var objkey = "2";
		TDS_VIEW.XDObjDelete(ln, objkey);
		// 다운 받으면 화면에 보이기
		if (TDS_VIEW.XDUIFileExist(path + tds + ".3DS")){
			tdsPath = path + tds + ".3DS";
			
			TDS_VIEW.XDRefSetPos(250, 0, 250);
			TDS_VIEW.XDObjInsert3DS(objkey, tdsPath, 150);
			TDS_VIEW.XDSrcLocalObject(ln, objkey);
						
			TDS_VIEW.XDMapRender();
		} else {
			alert("3DS 모델링 로딩에 실패하였습니다.");
		}
	}
}

function sel3ds(value){
	if (value == "") return;
	var info = value.split("#");
	
	preview(info[0], info[1]);
}


function imgSearch(){
	var fileName = TDS_VIEW.XDUIOpenFileDlg(true, '3ds');
	if (fileName != ""){
		if (TDS_VIEW.XDUIFileExist(fileName)){
			document.getElementById('img_path').value = fileName;	

			var ln = TDS_VIEW.XDLayGetEditable();
			var objkey = "2";
			TDS_VIEW.XDObjDelete(ln, objkey);

			if (TDS_VIEW.XDUIFileExist(fileName)){
				tdsPath = fileName;
				
				//TDS_VIEW.XDRefSetPos(250, 0, 250);
				TDS_VIEW.XDObjInsert3DS(objkey, fileName, 150);
				TDS_VIEW.XDSrcLocalObject(ln, objkey);
				
				TDS_VIEW.XDMapRender();
			} else {
				alert("3DS 모델링 로딩에 실패하였습니다.");
			}
		}
	}
}

function page_load(){
/* 	var url = top.WEB_SERVER_URL_SB + "/symbols/BASE";
	var path = top.m_workPath;
	
	if (!TDS_VIEW.XDUIFileExist(path + ".xdw")){
		TDS_VIEW.XDWebFileDownload(url + ".xdw", path + ".xdw");
	}
	if (!TDS_VIEW.XDUIFileExist(path + ".xdi")){
		TDS_VIEW.XDWebFileDownload(url + ".xdi", path + ".xdi");
	}
	if (!TDS_VIEW.XDUIFileExist(path + ".xdl")){
		TDS_VIEW.XDWebFileDownload(url + ".xdl", path + ".xdl");
	}
	
// 	if (TDS_VIEW.XDUIFileExist(path + ".xdw")){
// 		TDS_VIEW.XDReadXDWFile(path + ".xdw");
// 	}
	if (TDS_VIEW.XDUIFileExist(path + ".xdl")){
		TDS_VIEW.XDLayReadFile(path + ".xdl");
	} */
	
	//TDS_VIEW.XDCtrlSetView(0);
	
	TDS_VIEW.InitDirect3D();
    TDS_VIEW.XDObjInsert3DS("1", "C:\\xdcashe\\checker.3DS", 0);
    
	TDS_VIEW.XDMapRender();
}
</script>
<body onload="page_load();">
	<div id="panel">
		<div id="title">
			<div id="category">
				<ul style="width: 320px;">
					<li style="float: left;">
						<a href="streetlamp.jsp" target="left">
							<img src="${ctx}/images/btn_lib_streetlamp_off.gif" />
						</a>
					</li>
					<li style="float: right">
						<a href="streetlamp_add.jsp" target="left">
							<img src="${ctx}/images/btn_lib_add_on.gif" />
						</a>
					</li>
					<li style="padding-top: 15px; clear: both;"><img src="${ctx}/images/category_SIDE.gif" /></li>
					<li class="f_whit_am">가로등 구간설정</li>
					<li style="float: left; margin-top: 0px;">
						<a href="#" onclick="lightStart()"><img src="${ctx}/images/btn_section.gif" width="96" height="24" /></a>
					</li>
					<li style="float: left;margin: 0px 0 0 3px;">
						<a href="#" onclick="lightPointCancel()"><img src="${ctx}/images/btn_move.gif" width="62" height="24" /></a>
					</li>
					<li style="padding-top: 5px; clear: both;">
						<img src="${ctx}/images/category_SIDE.gif" />
					</li>
					<li class="f_whit_am">사용자 라이브러리 추가</li>
					<li>
						<input type="text" id="img_path" name="img_path" style="width:250px" readOnly/>
						<input type="button" value="찾기" style="width:40px; height:22px; cursor:hand;" onClick="imgSearch()"/>
					</li>
					<li><img src="${ctx}/images/category_SIDE1.gif" /></li>
				</ul>
				<fieldset style="padding:5px">
					<legend class="f_whit_am">가로등 옵션</legend>
					<ul>
						<li style="float: left;">
							가로등 높이
							<input type="text" name="tree_hei" id="tree_hei" value="6.0" /> 
							m
						</li>
						<li style="clear: both;">
							가로등 간격
							  <input type="text" name="tree_gab" id="tree_gab" value="8" /> m
						</li>
						<li style="clear: both;">
							가로등 방향
							<input type="text" name="tree_angle" id="tree_angle" value="0" /> 도
						</li>
					</ul>
				</fieldset>
				<ul>
					<li style="float: left; margin: 10px 0 10px 3px;">
						<a href="#" onclick="lightExe()">
							<img src="${ctx}/images/btn_add.gif" width="96" height="24" />
						</a>
					</li>
					<li style="float: left; margin: 10px 0 10px 3px;">
						<a href="#" onclick="lightCancel();">
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
			<div id="preview_window" style="width:256px; height:200px; z-index:100; border:solid 1px #2c3444; scrolling:no; #999999; background:#7878ff;margin:10px; ">
			  <script type="text/javascript">tds();</script>
		  </div>
		</div>
	</div>
	
	
</body>
</html>
