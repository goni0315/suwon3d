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

<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script><!--callScript의 제이쿼리 함수를 위해 적용  -->
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<script type="text/javascript" src="${ctx}/js/common.js"></script>
<script type="text/javascript">

//엑셀파일 불러오기
function excelSafetyupLoad(){

	top.MapControl('cam_total');
	var frm = document.getElementById("frm");
	if(frm.safetyFile.value == ""){
		alert("파일을 선택해주세요.");
		return; 
	}
	var fileNameLen = frm.safetyFile.value.length;
	if(frm.safetyFile.value.substring(fileNameLen-3, fileNameLen) != "xls"){
		alert("확장자가 xls인 엑셀파일을 선택해 주세요.");
		return;
	}
	
	frm.action = '${ctx}/safetyRoadExcel.do';
	frm.submit();
	
}

var rmodelNo;
var rlightSize;
//보안등 3DS파일 불러오기
function onLoadSymbol(){
	top.XDOCX.XDLayCreateEX(0, 'SAFETY_ROAD', 1, 30000); 
	top.XDOCX.XDLayCreateEX(0, 'SAFETY_ROAD_T', 1, 30000);

		//좌표
 		<c:forEach var="safety" items="${safetyExcelList}">
 		
 			//보안등
 			if('${safety.modelNo}' == 1){
 				rmodelNo = 'SL7';//일반
 			}else if('${safety.modelNo}' == 2){
 				rmodelNo = 'SL10';//초롱형
 			}else if('${safety.modelNo}' == 3){
 				rmodelNo = 'SL8';//벽면
 			}else if('${safety.modelNo}' == 4){
 				rmodelNo = 'SL9';//벽면
 			}else if('${safety.modelNo}' == 5){
 				rmodelNo = 'cctv_01';//CCTV
 			}

 			//조도분포도
 			if('${safety.lightSize}' == 1){
 				rlightSize = '10';
			}else if('${safety.lightSize}' == 2){
				rlightSize = '15';
			}else if('${safety.lightSize}' == 3){
				rlightSize = '20';
			}else if('${safety.lightSize}' == 4){
				rlightSize = '25';
			}else if('${safety.lightSize}' == 5){
				if('${safety.modelNo}' == 5){
					rlightSize = '50';
				}else{
					rlightSize = '30';
				}
			}
 			
			doViewPoint('${safety.pointX}','${safety.pointZ}', '${safety.pointY}',rmodelNo + '_50' + rlightSize + '.3ds','${safety.name}');
		</c:forEach>
}

//엑셀데이터 검증 및 해당 좌표에 아이콘과 텍스트 넣기
function doViewPoint(posX,posZ,posY,model,safeRoadName){
	
	if(posX==null||posX==""||posZ==null||posZ==""||posY==null||posY==""){
		alert("엑셀 데이터 중 [" + safeRoadName + "] 부분에 잘못된 데이터가 있습니다.");
	}else{
		var pos = posX+','+posY+','+posZ;
		pos = pos.split(',');
		pos[0];
		pos[1];
//		pos[2] = top.XDOCX.XDTerrGetHeight(pos[0], pos[1]);
		pos[2];
		var symbol_id = model + '_'+pos[1];
		var symbol_img = getThematicPath() + model;
		var symbolURL = WEB_SERVER_URL+"/images/safety/" + model;
		var symbolURL2 = WEB_SERVER_URL+"/images/safety/" + rmodelNo + ".png";
		
		top.XDOCX.XDWebFileDownload(symbolURL, getThematicPath() + model);
		top.XDOCX.XDWebFileDownload(symbolURL2, getThematicPath() + rmodelNo + ".png");
		
	 	safetySymbol('SAFETY_ROAD', symbol_id, pos[1], pos[2], pos[0], safeRoadName , 255, 230, 230, 230, symbol_img, false);
	 	safetyText('SAFETY_ROAD_T', symbol_id, pos[1], pos[2], pos[0], safeRoadName , 255, 230, 230, 230, symbol_img, false);
	 	
	}
	top.XDOCX.XDMapRender();
	
}

//심볼 옵션값 지정
function safetySymbol(layer_name, id, ix, iy, iz, txt, op, r, g, b, symbolImg, isMapRender){

	top.XDOCX.XDLaySetEditable(layer_name);
	top.XDOCX.XDRefSetColor(op, r, g, b); // 색상값 지정(A, R, G, B)
	top.XDOCX.XDRefSetPos(ix, iy, iz); // 좌표값 지정
	top.XDOCX.XDRefSetFontStyle("바탕체", 13, true, true, 1, 0, 0, 0);
	top.XDOCX.XDObjInsert3DS(id, symbolImg, 0); //37은 배율
	if(isMapRender || isMapRender == null || isMapRender == ''){
		top.XDOCX.XDMapLoad();
		top.XDOCX.XDMapRender();
	}
}

//텍스트 옵션값 지정
function safetyText(layer_name, id, ix, iy, iz, txt, op, r, g, b, symbolImg, isMapRender){

	top.XDOCX.XDLaySetEditable(layer_name);
	top.XDOCX.XDRefSetColor(op, r, g, b); // 색상값 지정(A, R, G, B)
	top.XDOCX.XDRefSetPos(ix, iy, iz); // 좌표값 지정
	top.XDOCX.XDRefSetFontStyle("바탕체", 13, true, true, 1, 0, 0, 0);
	top.XDOCX.XDObjCreateText(id, txt, symbolImg); //객체생성 ID, 명칭, 이미지경로
	
	if(isMapRender || isMapRender == null || isMapRender == ''){
		top.XDOCX.XDMapLoad();
		top.XDOCX.XDMapRender();
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var chkCnt;
var chkId;
var chkIdDel = "";
var chkDel;
var delPosX;
var delPosZ;
var delPosY;
//지도 상의 좌표 값을 테이블로 저장
function safetyPosPoint() {
	//top.cnt = 0;
	top.setWorkMode("safety");
	top.XDOCX.XDUISetWorkMode(20);
}


//체크한 목록만 지우기
var ln = top.XDOCX.XDLayGetEditable();
function safetyPosDelete() {
	chkDel = "del";
	var posX = top.safetyPosX;
	var posZ = top.safetyPosZ;
	var posY = top.safetyPosY;
	
	delPosX = posX.split(",");
	delPosZ = posZ.split(",");
	delPosY = posY.split(",");
	
		for(var i=1;i<=chkCnt;i++){
			var ckId = i;
			if(document.getElementById(ckId) != null){
				if(document.getElementById(ckId).checked == true){
					chkIdDel = chkIdDel + ckId + ','; 					
					top.XDOCX.XDRefSetPos(delPosX[i-1],delPosY[i-1], delPosZ[i-1]);
					top.XDOCX.XDObjDelete(ln, i);
/* 					
					delPosX[i-1] = "del";
					delPosY[i-1] = "del";
					delPosZ[i-1] = "del"; */
					
					$("#tr" + i).remove();
					//alert('delPosX[ ' + i + '] : ' + delPosX[i] + '////////////////delPosX[ ' + i + '] : ' + delPosX[i]);
				}
			}
		}
	document.getElementById("chkAll").checked = false;
}

//취소 -> 손모양
function safetyHand(){
    top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDUISetWorkMode(1);
}

//전체 선택 해제
function safety_check(checked){
	for(var i=1;i<=chkCnt;i++){
		var ckId = i;
		if(document.getElementById(ckId) != null){
			if(document.getElementById(ckId).checked != true){
				document.getElementById(ckId).checked = true;
			}else{
				document.getElementById(ckId).checked = false;	
			}
		}
	}
}

//초기화
function safety_clear() {
	top.cnt = 1;
	chkCnt = 1;
	top.safetyPosX="";
	top.safetyPosZ="";
	top.safetyPosY="";
    top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDUISetWorkMode(1);
    top.MapControl('map_clear');
    $('#result').empty();
	$('#result').append($('<tr>'+ 
		'<tr>'+
		'<tr>'+
			'<th><input type="checkbox" id="chkAll" onClick="safety_check(this.checked)"></th>'+
			'<th align="center"></th>'+
			'<th align="center">No</th>'+
			'<th align="center">X</th>'+
			'<th align="center">Z</th>'+
			'<th align="center">Y</th>'+
		'</tr>'
	));
}

//엑셀추출
function excelSafetyWrite(){
	var posX = top.safetyPosX;
	var posZ = top.safetyPosZ;
	var posY = top.safetyPosY;
	
	var sortPosX = posX.split(",");
	var sortPosZ = posZ.split(",");
	var sortPosY = posY.split(",");
	
	var newPosX = "";
	var newPosZ = "";
	var newPosY = "";
	
	var chkIdD = chkIdDel.split(",");
 	if(chkDel == "del"){
		for(var i=0;i<chkCnt;i++){
			if(chkIdD[i+1] != i){
				newPosX += sortPosX[i] + ",";
				newPosZ += sortPosZ[i] + ",";
				newPosY += sortPosY[i] + ",";
			}
		}
	}else if(chkDel != "del"){
		newPosX = sortPosX;
		newPosZ = sortPosZ;
		newPosY = sortPosY;
	}
		location.href = "${ctx}/safetyWrite.do?xPoint="+newPosX+"&zPoint="+newPosZ+"&yPoint="+newPosY+"&cnt="+cnt;
		safety_clear();
	//location.href = "${ctx}/safetyWrite.do?xPoint="+top.safetyPosX+"&yPoint="+top.safetyPosY+"&cnt="+cnt;
}

</script>
</head>
<body style="background: url($%7Bctx%7D/images/category_bg1.gif)" onload="onLoadSymbol();">
	<form id="frm" name="safetyForm" action="" method="post" enctype="multipart/form-data">
		<div id="panel">
			<div id="title">
				<div id="category1">
					<ul style="width: 320px;">
						<li class="f_whit_am">보안등(CCTV) 위치정보 조회</li>
						<li >지도화면에 보안등(CCTV) 설치 위치를 설정해주세요.</li>
						<li style="float: left;">
							<a href="#" onclick="safetyPosPoint()">
								<img src="${ctx}/images/btn_Loc_point2.gif" />
							</a>
						</li> 
						<li style="float: left; margin: 0 0 0 3px;">
							<a href="#" onclick="safetyHand()">
								<img src="${ctx}/images/btn_move.gif"/>
							</a>
						</li>
						<li style="float: left; margin: 0 0 0 3px;">
							<a href="#" onclick="safetyPosDelete()">
								<img src="${ctx}/images/btn_chk_del.png" />
							</a>
						</li>
						<li  style="float: left; margin: 0 0 0 3px;">
							<a href="#" onclick="safety_clear()">
								<img src="${ctx}/images/btn_reset.gif" />
							</a>
						</li>
						<li style="margin-top: 10px"><img src="${ctx}/images/category_SIDE1.gif" /></li>
						<li style="height: 170px;">
							<div id="bbsCont" style="height: 160px; overflow-y: scroll; width: 310px; background: #FFF; border: solid 1px #333333;">
								<table id="result" border="0" cellpadding="0" cellspacing="0" class="wps_100" summary="가시결과list">
									<col class="w_40" />
									<col />
									<col />
									<tr>
										<th ><input type="checkbox" id="chkAll" onClick="safety_check(this.checked)"></th>
										<th align="center"></th>
										<th align="center">No</th>
										<th align="center">X</th>
										<th align="center">Z</th>
										<th align="center">Y</th>
									</tr>
								</table>
							</div>
						</li>
					</ul>
					<a href="#">
						<img src="${ctx}/images/btn_excel_out.gif" style="float:right;" onclick="excelSafetyWrite()"/>
					</a>
					<div align="center"> 
						<%-- <img src="${ctx}/images/safety/safetyexplain.jpg" style="margin-top: 10px;"/> --%> 
						<fieldset style="clear:both;padding:5px;margin-top:10px;">
	  						<legend class="f_whit_am" align="left">안전길 범례</legend>
							<ul>
								<li style="float: left;">
									※ 추출하신 엑셀파일은 해당 안전길 범례를 참고하여
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>보안등(CCTV)</b>, <b>조도분포도(반경)(m)</b>를 입력해주세요.
								</li>
								<li> </li>
								<li> </li>
							</ul>
									<table width="300px" height="180px" align="center" border="2" cellspacing="0" cellpadding="3" bordercolor="#999999" style="border-collapse:collapse;" rules="all" frame="hsides">
										<tr bgcolor="#EAEAEA"> 
											<td colspan="2" width="150px">보안등(CCTV)</td>
											<td colspan="2" width="150px">조도분포도(반경)(m)</td>  
										</tr>
										<tr>  
											<td width="77px">1</td>
											<td width="77px">일자형</td>
											<td width="77px">1</td>
											<td width="77px">8</td>
										</tr>
										<tr bgcolor="#EAEAEA">
											<td>2</td>
											<td >초롱형</td>
											<td >2</td>
											<td >10</td>
										</tr>
										<tr>
											<td >3</td>
											<td >전주부착형</td>
											<td >3</td>
											<td >12</td>
										</tr>
										<tr bgcolor="#EAEAEA">
											<td >4</td>
											<td >벽면부착형</td>
											<td >4</td>
											<td >15</td>
										</tr>
										<tr>
											<td >5</td>
											<td >CCTV</td>
											<td >5</td>
											<td >20<br>(CCTV:50)</td>
										</tr>
									</table>
						</fieldset>
					</div>
						 
					<ul style="width: 320px; clear:both; ">
						<li style="clear: both; margin-top: 5px;"><img src="${ctx}/images/category_SIDE1.gif" /></li>
						<li class="f_whit_am">안전길 시뮬레이션</li>
						<li >시뮬레이션 할 사용자 엑셀 파일을 등록해주세요.</li>
						<li style="float: left;">
	
						</li>
						<li>
	                    <label>경로</label><input name="safetyFile" id="safetyFile" type="file" alt="경로">
	                    </li>
					</ul>
<!-- 						<a href="#" onclick="avgHighExe()"> -->
					<a href="#" onclick="excelSafetyupLoad();">							
						<img src="${ctx}/images/btn_excel_in.gif" alt="엑셀등록" style="float:right;"/>
					</a>
				</div>
			</div>
		</div>
	</form>
</body>
</html>