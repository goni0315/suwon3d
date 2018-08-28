<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xml:lang="ko">
<head>
<link rel="stylesheet" type="text/css" href="../css/gislayout.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>3차원공간정보활용시스템</title>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script> 
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/layer.js"></script>
<script type="text/javascript" src="${ctx}/js/xdk.js"></script>

<script type="text/javascript">
var tdsPath='';
function libExe(){
		alert("시설물을 입지할 위치를 지도에서 클릭해 주세요.");
		top.setWorkMode("3ds_input");
		top.XDOCX.XDUISetWorkMode(20);
}

function libHand(){
    top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDUISetWorkMode(1);
}

function libClear(){
    top.XDOCX.XDUIClearInputPoint();
    top.MapControl('map_clear');
	top.XDOCX.XDUISetWorkMode(1);
	TDS_VIEW.XDMapRender();
}


function sel3ds(value){
	if (value == "") return;
	var val = value.split("#");
	preview(val[0], val[1]);
}

function preview(tds, jpg){
	//alert(tds + "/////"+ jpg);
	if (tds == "") return;
	if (jpg == "") return;
	
	var url = top.WEB_SERVER_URL_SB + "/symbols/lib/";
	var path = top.m_workPath;
	
	if (!(TDS_VIEW.XDUIFileExist(path + tds + ".3DS") || TDS_VIEW.XDUIFileExist(path + tds + ".3ds"))){
		if (!(TDS_VIEW.XDWebFileDownload(url + tds + ".3DS", path + tds + ".3DS") || TDS_VIEW.XDWebFileDownload(url + tds + ".3ds", path + tds + ".3ds"))) {
			alert("3DS 모델링 로딩에 실패하였습니다");
			return;
		}
	}
	//alert("url : " + url + jpg +" // path : "+  path + jpg);
	if (!TDS_VIEW.XDUIFileExist(path + jpg + ".JPG")){
		TDS_VIEW.XDWebFileDownload(url + jpg + ".JPG", path + jpg + ".JPG");
		TDS_VIEW.XDWebFileDownload(url + jpg + ".jpg", path + jpg + ".jpg");
		TDS_VIEW.XDWebFileDownload(url + jpg + ".png", path + jpg + ".png");
		TDS_VIEW.XDWebFileDownload(url + jpg + ".PNG", path + jpg + ".PNG");
		//TDS_VIEW.XDWebFileDownload(url + jpg, path + jpg);
	}
	
	var ln = TDS_VIEW.XDLayGetEditable();
	var objkey = "2";
	//TDS_VIEW.XDMapRenderLock(true);
	TDS_VIEW.XDObjDelete(ln, objkey);
	//TDS_VIEW.XDMapRenderLock(false);
	// 다운 받으면 화면에 보이기
	if (TDS_VIEW.XDUIFileExist(path + tds + ".3DS")){
		tdsPath = path + tds + ".3DS";
		
		//TDS_VIEW.XDRefSetPos(250, 0, 250);
		TDS_VIEW.XDObjInsert3DS(objkey, tdsPath, 200);
		TDS_VIEW.XDSrcLocalObject(ln, objkey);
		
		TDS_VIEW.XDMapRender();
	} else if( TDS_VIEW.XDUIFileExist(path + tds + ".3ds")){
		tdsPath = path + tds + ".3ds";
		
		//TDS_VIEW.XDRefSetPos(250, 0, 250);
		TDS_VIEW.XDObjInsert3DS(objkey, tdsPath, 200);
		TDS_VIEW.XDSrcLocalObject(ln, objkey);
					
		TDS_VIEW.XDMapRender();
	}else{
		alert("3DS 모델링 로딩에 실패하였습니다.");
	}
}


function page_load(){
	/* var url = top.WEB_SERVER_URL_SB + "/symbols/BASE";
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
	 */
	//TDS_VIEW.XDCtrlSetView(0);
	 
	TDS_VIEW.InitDirect3D();
    TDS_VIEW.XDObjInsert3DS("1", "C:\\xdcashe\\checker.3DS", 0);
	
	TDS_VIEW.XDMapRender();
	
	
}

</script>
<script type="text/javascript">

	function highModelSearch(lib_ajax){
		$.ajax({
			type:"POST",
			url:"${ctx}/modelLibList.do",
			data :"&lib_ajax=" + lib_ajax ,
			dataType:"json",
			contentType : "application/x-www-form-urlencoded;charset=UTF-8",
			error : function(request, status, error) {
			     //통신 에러 발생시 처리
			     alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
			    },
			success : modelLibMidList
		});
	}

	function modelLibMidList(arr){
		$("#libNm").find("option").remove();	
		$("#libNm").append("<option value='0'>---중분류선택---</option>");	
		$.each(arr, function() {		
			$("#libNm").append("<option value='"+this.libm_cde+"'>"+this.libm_nm+"</option>");
		});
	}
	
	function midModelSearch(libm_cde){
		var libl_cde = document.getElementById("modelLibs").value;
		$.ajax({
			type:"POST",
			url:"${ctx}/modelLibSmallList.do",
			data :"&libl_cde="+libl_cde+"&libm_cde=" + libm_cde,
			dataType:"json",
			contentType : "application/x-www-form-urlencoded;charset=UTF-8",
			error : function(request, status, error) {
			     //통신 에러 발생시 처리
			     alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
			    },
			success : modelLibLowList
		});
	}
	function modelLibLowList(arr){
		$("#modelList").find("option").remove();
		$.each(arr, function() {
		$("#libSmallNm").append(
				"<option value=" + this.lib_file + '#' + this.texture_file + ">" + this.lib_nm +"</option>"
				);
		});
	}
	function modelSearch() {
		var frm = document.getElementById("frm");
		var modelLibs = $("#modelLibs option:selected").val();
		var libNm = $("#libNm option:selected").val();
		var modelCode = modelLibs + libNm;
		
		if(libNm != '0'){
			$("input[name='modelCode']").val(modelCode); 
			frm.action = 'modelSearch.do';
			frm.target = 'searchList';
			frm.submit();
		}
	}
	
</script>

</head>

<body onLoad="page_load();">

	<form id="frm" action="" method="post">
		<div id="panel" class="panel_main">
			<div id="title">
				<div id="category">
					<ul style="width: 320px;">
						<li style="float: left;">
							<a href="facility.jsp" target="left">
								<img src="../images/btn_lib_sel_on.gif" />
							</a>
						</li>
						<li style="float: right">
							<a href="facility_add.jsp" target="left">
								<img src="../images/btn_lib_add_off.gif" />
							</a>
						</li>
						<li style="padding-top: 15px; clear: both;"><img src="../images/category_SIDE.gif" /></li>
						<li>
							<label>시설분류</label>
							<select id="modelLibs" name="modelLibs" style="width: 150px;" onChange="highModelSearch(this.value)">
									<option value="0">-----대분류-----</option>
									<option value="B">건축</option>
									<option value="T">교통시설</option>
									<option value="R">철도시설</option>
									<option value="S">특수시설</option>
									<option value="E">기타시설</option>
									<option value="P">수목</option>
							</select>
						</li>
						<li>
						<label>시설물</label>
							<select id="libNm" name="libNm" style="width: 150px;" onChange="midModelSearch(this.value)">
									<option value="0">-----중분류-----</option>
							</select>
						</li>
						<li style="height: 200px;">
							<div id="modelList" style="height: 200px; background-color: #FFF; border: solid 1px #2c3444; clear: both;" >
								<select id="libSmallNm" style="height: 200px;width: 100%;" size="14" onchange='sel3ds(this.value)'>
								</select>
							</div>
							<br style="clear: both;" />
						</li>
						<li style="float: left; margin-top: 10px;">
							<a href="#" onclick="libExe();">
								<img src="../images/btn_add.gif" width="96" height="24" />
							</a>
						</li>
						<li style="float: left;margin: 10px 3px 3px 3px;">
							<a href="#" onclick="libHand();">
								<img src="../images/btn_move.gif" width="62" height="24" />
							</a>
							<a href="#" onclick="libClear()">
								<img src="${ctx}/images/btn_analysis_cancel.gif" width="96" height="24" />
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</form>
    <div align="center"> 
        <h4><img src="${ctx}/images/result_title1.gif" alt="결과" width="340" height="34"/></h4>
        <div id="preview_window" style="width:256px; height:200px; z-index:100; border:solid 1px #2c3444; scrolling:no; #999999; background:#7878ff;margin:10px; ">
			<script type="text/javascript">tds();</script>
		</div>
    </div>
</body>
</html>
