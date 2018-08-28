<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jxl.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath }" scope="request" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css"/>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>내주제도</title>
<script type="text/javascript">
//엑셀업로드
function excelupLoad(){
	top.MapControl('cam_total');
	var frm = document.getElementById("frm");
	if(frm.fileUrl.value == ""){
		alert("파일을 선택해주세요.");
		return; 
	}
	var fileNameLen = frm.fileUrl.value.length;
	if(frm.fileUrl.value.substring(fileNameLen-3, fileNameLen) != "xls"){
		alert("확장자가 xls인 엑셀파일을 선택해 주세요.");
		return;
	}
	
	if ($("#jibun").attr("checked")){
		
		frm.action = '${ctx}/thematicJibun.do';
		frm.submit();
		
	}else if($("#doro").attr("checked")){  //도로명
		
/*		var nowDate = new Date();
		alert("시작"+nowDate.getSeconds() + "초" + nowDate.getMilliseconds()); */
		
		frm.action = '${ctx}/thematicDoro.do';
		frm.submit();
		
/* 		var nowDate2 = new Date();
		alert("종료"+nowDate2.getSeconds() + "초" + nowDate2.getMilliseconds()); */
	}else if($("#pointXY").attr("checked")){  //좌표
		//alert("3");		

		frm.action = '${ctx}/thematicPoint.do';
		frm.submit();
	}else if($("#pol").attr("checked")){  //좌표
		//alert("3");		

		frm.action = '${ctx}/thematicPolygon.do';
		frm.submit();
	}
}

//해당 좌표 위치 포인터 생성
function doView(layer,keycode,colorSize,thematicName){

	//alert("thematicName : " + thematicName);
	if(keycode==null||keycode==""){
		alert("엑셀 데이터 중 [" + thematicName + "] 부분에 잘못된 데이터가 있습니다.");
	}else{
		var pos = top.XDOCX.XDSrcObjPosition(layer, keycode, false);
		pos = pos.split(',');
		
		//top.searchXDPointPosition(pos[0], pos[2]);
		pos[0];
		pos[1] = top.XDOCX.XDTerrGetPointHeight(pos[0], pos[2]);
		pos[2];
		var symbol_id = colorSize+'_'+pos[1];
		var symbol_img = getThematicPath()+colorSize;
		var symbolURL = WEB_SERVER_URL+"/images/thematic/" + colorSize;
		top.XDOCX.XDWebFileDownload(symbolURL, getThematicPath()+colorSize);
	 	thematicSymbol('thematic_map', symbol_id, pos[0], pos[1], pos[2], thematicName , 255, 240, 240, 240, symbol_img, false);
	}
	top.XDOCX.XDMapRender();
}

//해당 좌표 위치 포인터 생성
function doViewPoint(posX,posY,colorSize,thematicName){

	if(posX==null||posX==""||posY==null||posY==""){
		alert("엑셀 데이터 중 [" + thematicName + "] 부분에 잘못된 데이터가 있습니다.");
	}else{
		var pos = posX+','+posY;
		pos = pos.split(',');
		pos[0];
		pos[1];
		pos[2] = top.XDOCX.XDTerrGetPointHeight(pos[1], pos[0]);
		var symbol_id = colorSize+'_'+pos[1];
		var symbol_img = getThematicPath()+colorSize;
		var symbolURL = WEB_SERVER_URL+"/images/thematic/" + colorSize;
		top.XDOCX.XDWebFileDownload(symbolURL, getThematicPath()+colorSize);
	 	thematicSymbol('thematic_map', symbol_id, pos[1], pos[2], pos[0], thematicName , 255, 230, 230, 230, symbol_img, false);
	 	
	}
	top.XDOCX.XDMapRender();
	
}

//내주제도 심볼 생성
function thematicSymbol(layer_name, id, ix, iy, iz, txt, op, r, g, b, symbolImg, isMapRender){

	top.XDOCX.XDLaySetEditable(layer_name);
	top.XDOCX.XDRefSetColor(op, r, g, b); // 색상값 지정(A, R, G, B)
	top.XDOCX.XDRefSetPos(ix, iy, iz); // 좌표값 지정
	top.XDOCX.XDRefSetFontStyle("고딕체", 13, true, true, 1, 0, 0, 0);
//	top.XDOCX.XDRefSetFontStyle("굴림",12,true,true,1,212,244,255);
	top.XDOCX.XDObjCreateText(id, txt, symbolImg); //객체생성 ID, 명칭, 이미지경로
	//top.XDOCX.XDRefSetColor(255, 0, 0, 0);
	if(isMapRender || isMapRender == null || isMapRender == ''){
		top.XDOCX.XDMapLoad();
		top.XDOCX.XDMapRender();
	}
}

//보임여부
function layerCtrl(){
	if(top.XDOCX.XDLayGetVisible('thematic_map') != false){
		top.XDOCX.XDLaySetVisible('thematic_map', false);
	}else{
		top.XDOCX.XDLaySetVisible('thematic_map', true);
	}
}
var rColor = "";
//해당 심볼 번호와 매칭하여 로드
function onLoadSymbol(){
	top.XDOCX.XDLayCreateEX(0, 'thematic_map', 1, 30000); // 내주제도
		//지번
		<c:forEach var="thematic" items="${excelJibunList}">
			if('${thematic.color}' == 1){
				rColor = "red";
			}else if('${thematic.color}' == 2){
				rColor = "yellow";
			}else if('${thematic.color}' == 3){
				rColor = "green";
			}else if('${thematic.color}' == 4){
				rColor = "blue";
			}else if('${thematic.color}' == 5){
				rColor = "violet";
			}else if('${thematic.color}' == 6){
				rColor = "pink";
			}else if('${thematic.color}' == 7){
				rColor = "black";
			}else if('${thematic.color}' == 8){
				rColor = "gray";
			}else if('${thematic.color}' == 9){
				rColor = "cyan";
			}else if('${thematic.color}' == 10){
				rColor = "brown";
			}
			
			doView('KO3D_PL_BBND', '${thematic.pnu}', rColor + '${thematic.numSize}.png','${thematic.name}');
	 	</c:forEach>
	 	//도로명
	 	<c:forEach var="thematic" items="${excelDoroList}">
			if('${thematic.color}' == 1){
				rColor = "red";
			}else if('${thematic.color}' == 2){
				rColor = "yellow";
			}else if('${thematic.color}' == 3){
				rColor = "green";
			}else if('${thematic.color}' == 4){
				rColor = "blue";
			}else if('${thematic.color}' == 5){
				rColor = "violet";
			}else if('${thematic.color}' == 6){
				rColor = "pink";
			}else if('${thematic.color}' == 7){
				rColor = "black";
			}else if('${thematic.color}' == 8){
				rColor = "gray";
			}else if('${thematic.color}' == 9){
				rColor = "cyan";
			}else if('${thematic.color}' == 10){
				rColor = "brown";
			}
			doView('KO3D_NADD_BLDG_T', '${thematic.bd_mgt_sn}',rColor + '${thematic.numSize}.png','${thematic.name }');
 		</c:forEach>
		//좌표
 		<c:forEach var="thematic" items="${excelPointList}">
			if('${thematic.color}' == 1){
				rColor = "red";
			}else if('${thematic.color}' == 2){
				rColor = "yellow";
			}else if('${thematic.color}' == 3){
				rColor = "green";
			}else if('${thematic.color}' == 4){
				rColor = "blue";
			}else if('${thematic.color}' == 5){
				rColor = "violet";
			}else if('${thematic.color}' == 6){
				rColor = "pink";
			}else if('${thematic.color}' == 7){
				rColor = "black";
			}else if('${thematic.color}' == 8){
				rColor = "gray";
			}else if('${thematic.color}' == 9){
				rColor = "cyan";
			}else if('${thematic.color}' == 10){
				rColor = "brown";
			}
			doViewPoint('${thematic.pointX}', '${thematic.pointY}',rColor + '${thematic.numSize}.png','${thematic.name }');
		</c:forEach>
		
		//폴리곤
		var polygonBoundaryList = "";
		<c:forEach var="thematic" items="${polygonBoundaryList}">
			polygonBoundaryList = "${polygonBoundaryList}";
	 	</c:forEach>
	 	if(polygonBoundaryList != ""){
		 	polygonBoundaryList = polygonBoundaryList.split("#");
		 	for(var i = 0;i < polygonBoundaryList.length;i++){
		 		//alert((polygonBoundaryList[i]).replace("\\{st_astext=MULTILINESTRING\\(\\(",""));
		 		var list = (polygonBoundaryList[i].replace("{st_astext=MULTILINESTRING((","")).replace("))}","");
		 		console.log("list : " + list);
		 		createPlane(list);
		 	}
	 	}
}
	 	

//국공유지
function createPlane(list) {
	if(list == "" || list == null ){
		return;
	}
	var strPoi = list;
	strPoi = strPoi.split(",");
	for (var i = 0; i < strPoi.length; i++) {
		info = strPoi[i].split(" "); 
		//console.log("info[0] : " + info[0] + " // info[1] : " + info[1]);
		var alt = top.XDOCX.XDTerrGetHeight(info[0],info[1]);
		top.XDOCX.XDUIInput3DPoint(info[0], alt+1, info[1]);
	}
	top.XDOCX.XDObjectCreatePolygon(top.getCurrDate(),0,255,0,80,1);
	//top.XDOCX.XDObjectCreatePolygon("3",0,255,0,80,1);
	top.XDOCX.XDUIClearInputPoint();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var chkCnt;
var chkId;
var chkIdDel = "";
var chkDel;
var delPosX;
var delPosZ;
var delPosY;
//지도 상의 좌표 값을 테이블로 저장
function thematicPosPoint() {
	//top.cnt = 0;
	top.setWorkMode("thematic");
	top.XDOCX.XDUISetWorkMode(20);
}


//체크한 목록만 지우기
var ln = top.XDOCX.XDLayGetEditable();
function thematicPosDelete() {
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
function thematicMove(){
    top.XDOCX.XDUIClearInputPoint(); 
	top.XDOCX.XDUISetWorkMode(1);
}

//전체 선택 또는 해제
function thematic_check(checked){
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
function thematicPosClear() {
	top.cnt = 1;
	chkCnt = 1;
	top.thematicPosX="";
	top.thematicPosZ="";
	top.thematicPosY="";
    top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDUISetWorkMode(1);
    top.MapControl('map_clear');
    $('#thematicResult').empty();
	$('#thematicResult').append($('<tr>'+ 
		'<tr>'+
		'<tr>'+
			'<th><input type="checkbox" id="chkAll" onClick="safety_check(this.checked)"></th>'+
			'<th align="center"></th>'+
			'<th align="center">No</th>'+
			'<th align="center">X</th>'+
			'<th align="center">Y</th>'+
		'</tr>'
	));
}

//엑셀추출
function exceltThematicWrite(){
	var posX = top.thematicPosY;
	var posY = top.thematicPosX;
	
	var sortPosX = posX.split(",");
	var sortPosY = posY.split(",");
	
	var newPosX = "";
	var newPosY = "";
	
	var chkIdD = chkIdDel.split(",");
 	if(chkDel == "del"){
		for(var i=0;i<chkCnt;i++){
			if(chkIdD[i+1] != i){
				newPosX += sortPosX[i] + ",";
				newPosY += sortPosY[i] + ",";
	 	
			}
		}
	}else if(chkDel != "del"){
		newPosX = sortPosX;
		newPosY = sortPosY;
	}
		location.href = "${ctx}/thematicWrite.do?xPoint="+newPosX+"&yPoint="+newPosY;
		thematicPosClear();
	//location.href = "${ctx}/safetyWrite.do?xPoint="+top.safetyPosX+"&yPoint="+top.safetyPosY+"&cnt="+cnt;
}

function posPointListView(mode){
	if(mode == "pos"){
		document.getElementById("posPointList").style.display = "block";
	}else{
		document.getElementById("posPointList").style.display = "none";
	}
}
</script>
</head>

<body style="background:url(${ctx}/images/category_bg1.gif)" onload="onLoadSymbol();">
	<form id="frm" name="thematicForm" action="" method="post" enctype="multipart/form-data"><!-- enctype="multipart/form-data"  -->
		<div id="panel">
	    	<div id="title">
	        	<div id="category1">
	       			<ul style="width:320px;">
	        			<li style="float:left;width:45px">
	        				<label for="textfield"><input name="thematic" id="jibun" type="radio" value="1" onclick="posPointListView('etc')" checked/> 
	          					지번
	          				</label>
	          			</li>
	        			<li style="float:left;width:57px;margin:0 0 0 2px;"> 
	        				<label for="textfield"><input name="thematic" id="doro" type="radio" value="2" onclick="posPointListView('etc')"/> 
	          					도로명
	          				</label>
	          			</li>
	        			<li style="float:left;width:45px;margin:0 0 0 2px;">
	        				<label for="textfield"><input name="thematic" id="pointXY" type="radio" value="3" onclick="posPointListView('pos')"/> 
	         					좌표
	         				</label>
	         			</li>  
	        			<li style="float:left;width:55px;margin:0 0 0 2px;">
	        				<label for="textfield"><input name="thematic" id="pol" type="radio" value="4" onclick="posPointListView('etc')"/> 
	         					국공유지
	         				</label>
	         			</li>
	        			<li style="float:right;"><a href="${ctx}/excel/FUC-1158.xls"><img src="${ctx}/images/btn_download.gif"/></a></li>
						<li style="height:40px;"></li>
	        			<li class="f_whit_am" style="clear:both;"><input type="file" id="fileUrl" name="fileUrl" style="float:left;height:22px;" value=""><img src="${ctx}/images/btn_upload.gif" onclick="excelupLoad();" style="float:right;cursor:pointer;"/></li>
	        			 
	        			<li style="padding-top:10px;clear:both; "><img src="${ctx}/images/category_SIDE.gif" /></li>
	        			<li style="height:300px;">
							<div>
								<div id="posPointList" style="display: none;">

									<!-- <b>양식 내려받기 : 내 주제도 양식 (엑셀파일)을 내려 받을 수 있습니다.</b><br> 
		        					<br />
									<b>작성파일 올리기 : 작성된 양식(엑셀파일)을 선택한 후, 검증단계를 거쳐 지도화면에 표출합니다.</b><br>
									<p class="bullet_mf"><strong>양식내용 참고</strong><br /> 
						  			1. 명칭<br />2. 시군구<br/>3. 읍면동<br/>4. 산구분<br />5. 본번<br />
									6. 부번<br />7. 색상(엑셀양식 색상 참고)<br />8. 수치(1~10)<br/>9. 정보분류<br /> -->
									<ul style="width: 320px;" id="XYthematic">
										<li class="f_whit_am">내주제도 좌표 위치 정보 조회</li>
										<li>지도화면에 표현할 좌표 위치를 설정해주세요.</li>
										<li style="float: left;">
											<a href="#"	onclick="thematicPosPoint()">
												<img src="${ctx}/images/btn_Loc_point2.gif" />
											</a>
										</li>
										<li style="float: left; margin: 0 0 0 3px;">
											<a href="#" onclick="thematicMove()">
												<img src="${ctx}/images/btn_move.gif" />
											</a>
										</li>
										<li style="float: left; margin: 0 0 0 3px;">
											<a href="#" onclick="thematicPosDelete()">
												<img src="${ctx}/images/btn_chk_del.png" />
											</a>
										</li>
										<li style="float: left; margin: 0 0 0 3px;">
											<a href="#" onclick="thematicPosClear()">
												<img src="${ctx}/images/btn_reset.gif" />
											</a>
										</li>
										<li style="margin-top: 10px"><img src="${ctx}/images/category_SIDE1.gif" /></li>
										<li style="height: 170px;">
											<div id="bbsCont" style="height: 160px; overflow-y: scroll; width: 310px; background: #FFF; border: solid 1px #333333;">
												<table id="thematicResult" border="0" cellpadding="0" cellspacing="0" class="wps_100" summary="가시결과list">
													<col class="w_40" />
													<col />
													<col />
													<tr>
														<th><input type="checkbox" id="chkAll" onClick="thematic_check(this.checked)"></th>
														<th align="center">No</th>
														<th align="center"></th>
														<th align="center">X</th>
														<th align="center">Y</th>
													</tr>
												</table>
											</div>
										</li>
									</ul>
									<a href="#">
										<img src="${ctx}/images/btn_excel_out.gif" style="float: right;" onclick="exceltThematicWrite()" />
									</a>
								</div>
							<fieldset style="clear:both;padding:5px;margin-top:10px;">
	  						<legend class="f_whit_am" align="left">내주제도 범례</legend>
							<ul>
								<li style="float: left;"> 
									※ 추출하신 엑셀파일은 해당 <b>내주제도 범례</b>를
									<br/>&nbsp;&nbsp;&nbsp;&nbsp;참고하여 주세요.
								</li>
								<li> </li>
								<li> </li>
							</ul>
									<table width="220px" height="220px" align="center" border="2" cellspacing="0" cellpadding="3" bordercolor="#999999" style="border-collapse:collapse;" rules="all" frame="hsides">
										<tr bgcolor="#EAEAEA" align="center"> 
											<td width="80px"><b>수치</b></td> 
											<td colspan="2" width="80px"><b>색상</b></td>  
										</tr>
										<tr align="center">  
											<td width="70px">1</td>
											<td width="70px">1</td>
											<td width="70px" bgcolor="RED"><b><font color="#ffffff">RED</font></b></td> 
										</tr>
										<tr bgcolor="#EAEAEA" align="center">
											<td >2</td>
											<td >2</td>
											<td bgcolor="YELLOW"><b><font color="#000000">YELLOW</font></b></td>
										</tr>
										<tr align="center">
											<td >3</td>
											<td >3</td>
											<td bgcolor="GREEN"><b><font color="#ffffff">GREEN</font></b></td>
										</tr>
										<tr bgcolor="#EAEAEA" align="center">
											<td >4</td>
											<td >4</td>
											<td bgcolor="BLUE"><b><font color="#ffffff">BLUE</font></b></td>
										</tr>
										<tr align="center">
											<td >5</td>
											<td >5</td>
											<td bgcolor="VIOLET"><b><font color="#ffffff">VIOLET</font></b></td> 
										</tr>
										<tr bgcolor="#EAEAEA" align="center">
											<td >6</td>
											<td >6</td>
											<td bgcolor="PINK"><b><font color="#ffffff">PINK</font></b></td>
										</tr>
										<tr align="center">
											<td >7</td>
											<td >7</td>
											<td bgcolor="BLACK"><b><font color="#ffffff">BLACK</font></b></td>
										</tr>
										<tr bgcolor="#EAEAEA" align="center">
											<td >8</td>
											<td >8</td>
											<td bgcolor="GRAY"><b><font color="#ffffff">GRAY</font></b></td>
										</tr>
										<tr align="center">
											<td >9</td>
											<td >9</td> 
											<td bgcolor="CYAN"><b><font color="#000000">CYAN</font></b></td>
										</tr>
										<tr bgcolor="#EAEAEA" align="center">
											<td >10</td>
											<td >10</td>
											<td bgcolor="BROWN"><b><font color="#ffffff">BROWN</font></b></td>
										</tr>
									</table>
									<br/>
							  <p class="bullet_mf"><strong>업로드 참고</strong><br/><br/>
									<font color="RED">*</font> <b>엑셀파일</b>만 업로드 가능합니다. <br/>
									<font color="RED">*</font> <b>첫번째 시트</b>에 데이터가 있어야 합니다. <br/>
									<font color="RED">*</font> 엑셀작성 시 중간에 <b>빈 셀</b>이 없어야 합니다<br/>
									<font color="RED">*</font> 확장자명은 <b>.xls</b> 이어야 합니다. <strong style="color:red">(xlsx 불가)</strong><br/>
									<font color="RED">*</font> 해당 범례의 수치는 <b>숫자가 클수록 지도 상에 <br/>&nbsp;&nbsp;표현되는 아이콘의 크기가 커집니다.</b><br/>
									<font color="RED">*</font> 정보 분류란은 필수는 아닙니다.
								</p>
						</fieldset>
							
							<br/>
							</div>
	        			</li>
	        			<%-- <li style="padding-top:10px;clear:both; "><img src="${ctx}/images/category_SIDE.gif" /></li> --%>
<%-- 	        			<li style="clear:both; "><img src="${ctx}/images/category_SIDE1.gif" /></li>
	        			<li class="f_whit_am" style="clear:both;"><input type="file" id="fileUrl" name="fileUrl" style="float:left;height:22px;" value=""><img src="${ctx}/images/btn_upload.gif" onclick="excelupLoad();" style="float:right;cursor:pointer;"/></li> --%>
	         		</ul>
	      		</div>
			</div>
		</div>
	</form>
</body>
</html>