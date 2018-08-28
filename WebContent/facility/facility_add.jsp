<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>3차원공간정보활용시스템</title>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script><!--callScript의 제이쿼리 함수를 위해 적용  -->
<script type="text/javascript" src="${ctx}/js/xdk.js"></script>
<script type="text/javascript">
//3ds 파일 찾기
function libSearch(){
	if ('tds_path'){
		var fileName = TDS_VIEW.XDUIOpenFileDlg(true, '3ds');
		if (fileName != ""){
			if (TDS_VIEW.XDUIFileExist(fileName)){
				document.getElementById('tds_path').value = fileName;	

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
}

//시설물 삽입
function libExe(){
	alert("시설물을 입지할 위치를 지도에서 클릭해 주세요.");
	top.setWorkMode("3ds_input");
	top.XDOCX.XDUISetWorkMode(20);
}
//손이동
function libHand(){
    top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDUISetWorkMode(1);
}

//시설물 취소
function libClear(){
	//TDS_VIEW.XDLayClear(TDS_VIEW.XDLayGetEditable());
	top.XDOCX.XDUISetWorkMode(1);
	top.XDOCX.XDUIClearInputPoint();
	top.MapControl('map_clear');
}

//미리보기 맵 로딩
function page_load(){
/* 	var url = top.WEB_SERVER_URL_SB + "/symbols/BASE";
	var path = top.m_workPath + "BASE";
	
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
	}
	
	//TDS_VIEW.XDCtrlSetView(0); */
	
	TDS_VIEW.InitDirect3D();
    TDS_VIEW.XDObjInsert3DS("1", "C:\\xdcashe\\checker.3DS", 0);
	
	TDS_VIEW.XDMapRender();
}
</script>
</head>

<body onload="page_load();">
	<div id="panel">
		<div id="title">
			<div id="category">
				<ul style="width: 320px;">
					<li style="float: left;"><a href="facility.jsp" target="left"><img src="${ctx}/images/btn_lib_sel_off.gif" /></a></li>
					<li style="float: right"><a href="facility_add.jsp" target="left"><img src="${ctx}/images/btn_lib_add_on.gif" /></a></li>
					<li style="padding-top: 15px; clear: both;"><img src="${ctx}/images/category_SIDE.gif" /></li>
					
					<li class="f_whit_am">사용자 라이브러리 추가</li>
					<li>
						<input type="hidden" value="" id="bli_img_type2" name="bli_img_type" checked/>
						<input type="text" id="tds_path" name="tds_path" style="width:270px" readOnly>
						<input type="button" onclick="libSearch()" style="width:40px; height:22px;" value="찾기">
					</li>
					<li style="float: left; margin-top: 10px;">
						<a href="#" onclick="libExe();">
							<img src="../images/btn_add.gif" width="96" height="24" />
						</a>
					</li>
					<li style="float: left; margin: 10px 3px 3px 3px;">
						<a href="#" onclick="libHand();">
							<img src="../images/btn_move.gif" width="62" height="24" />
						</a>
					</li>
					<li style=" float: left;margin: 10px 0 0 0;">
						<a href="#" onclick="libClear()">
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