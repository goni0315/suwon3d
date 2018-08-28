<%
	// 툴바 >> 분석 및 효과 >> 침수분석  화면 페이지
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>침수분석</title>
<script type="text/javascript">//
    var djConfig = { isDebug:false, parseOnLoad:true };
</script>
<script type="text/javascript">
	var top = null;
	var waterLay = "cWater";
	var waterKey = "waterPlane00";
	var waterKey2 = "waterPlane02";
	var cPosX = "";
	var cPosY = "";
	var cPosZ = "";
	
	//분석 영역 지정
	function setRect() {		
		if (top.XDOCX.XDLayGetObjectCount(waterLay) > 0) {
			top.XDOCX.XDLayClear(waterLay);
			top.XDOCX.XDLayClear('Temporary');
		}
		top.setObj(self);
		top.setSimulMode(91);
		top.setOperationMode(24);
	} 
	
	//분석 결과 삭제
	function clearRect() {
		if (top.XDOCX.XDLayGetObjectCount(waterLay) > 0) {
			top.XDOCX.XDLayClear(waterLay);
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
		document.getElementById('Ambient').value = parseFloat(document.getElementById('Ambient').value) + parseFloat(dis);
	}
	
	function up() {
		var dis = document.getElementById("moveDist").value;
		MoveObject(dis);
		document.getElementById('Ambient').value = parseFloat(document.getElementById('Ambient').value) + parseFloat(dis);
	} 

	function waterDown() {
		var dis = document.getElementById("moveDist").value; 
		dis = (parseFloat(dis) * -1);
		MoveObject(dis);
		document.getElementById('Ambient').value = parseFloat(document.getElementById('Ambient').value) + parseFloat(dis);
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
		top = window.dialogArguments;
	//	top.XDOCX.XDMapSetUnderGround(true);
	//	top.setTerrainAlpha(true);
		
		if (top.XDOCX.XDLayGetObjectCount(waterLay) < 0) {
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

	function selText() {
		if (selSetType[1].checked == true) {
			tr1.style.display="none";
			tr2.style.display="block";
		} else {
			tr2.style.display="none";
			tr1.style.display="block";
		}
	}

	function setCenter() {
		top.setObj(self);
		top.setOperationMode(20);		
		top.setSimulMode(96);
		
		if (top.XDOCX.XDLayGetObjectCount(waterLay) > 0) {
			top.XDOCX.XDLayClear(waterLay);
		}
	}

	function page_unload() {
		try {
			if (top.XDOCX.XDLayGetObjectCount(waterLay) > 0) {
				top.XDOCX.XDLayClear(waterLay);
				top.XDOCX.XDLayClear('Temporary');
			//	top.setTerrainAlpha(true);
			}
		} catch(ex) {
			
		}
	}
	
	function page_close() {
		window.close();
	}
	
	
	function log_Menu(lgType, mId) {
		var userIp = '<%=session.getAttribute("userip")%>';
		var userId = '<%=session.getAttribute("userid")%>';
		var deptNm = '<%=session.getAttribute("userdept")%>';
		
		var bro_ver = navigator.appName;
		if (bro_ver == 'Microsoft Internet Explorer') {
			if(navigator.appVersion.indexOf("MSIE 7.0")>=0) {
				bro_ver = bro_ver + ' 7.0';
			} else if(navigator.appVersion.indexOf("MSIE 8.0")>=0) {
				bro_ver = bro_ver + ' 8.0';
			} else if(navigator.appVersion.indexOf("MSIE 9.0")>=0) {
				bro_ver = bro_ver + ' 9.0';
			} else {
				bro_ver = bro_ver + ' 6.0';
			}
		}
		
		dwr.engine.beginBatch();
		YiDwrAct.updateLog(userIp, userId, lgType, mId, deptNm, bro_ver, {
			callback : function(result) {
				if (result) {
					createPlane();
				} else {
					return;
				}
			}
		});
		dwr.engine.endBatch();
	}
	
	function checkP(lg_type, mId) {
		var perm = '<%=session.getAttribute("user_permission")%>';
		permissionCheck(lg_type, perm, mId);
	}
</script>

</head>

<body onLoad="javascript:page_load()"  onUnload="javascript:page_unload()">
<form id="frm" name="frm">
<input type="hidden" id="curHei" name="curHei" value="90">
<table width="363" border="0" cellpadding="0" cellspacing="0" >
  <tr>
    <td colspan="3"><table width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td width="185"></td>
        <td align="right"></td>
        <td width="44" align="right"><input type="button" value="종료"  alt="" width="44" height="35" onclick="javascript:page_close();" style="cursor:hand;"></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td width="346" bgcolor="#f8f8f8"><table width="342" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="17" colspan="4" align="center">
        	<input type="button" value="영역지정" width="80" height="21" onClick="javascript:setRect();" style="cursor:hand;">
        	<input type="button" value="분석"  width="46" height="21" onClick="javascript:createPlane();" style="cursor:hand;">
        	<input type="button" value="초기화"  alt="" width="46" height="21" onClick="javascript:clearRect();" style="cursor:hand;"></td>
      </tr>
      <tr>
        <td width="80" height="30" align="center">최저높이</td>
        <td width="75"><input id="AmbientMin" name="AmbientMin" type="text" value="0" style="text-align:right; width:55px;" readonly="readonly" />
        m</td>
        <td width="80" height="30" align="center">최고높이</td>
        <td width="75"><input id="AmbientMax" name="AmbientMax" type="text" value="0" style="text-align:right; width:55px;" readonly="readonly" />
        m</td>
      </tr>
      <tr>
      	<td width="80" height="30" align="center">침수수위</td>
        <td width="75" ><input id="Ambient" name="Ambient" type="text" value="0" style="text-align:right; width:55px;" />
        m</td>
        <td width="80" height="30" align="center">이동단위</td>
        <td width="75" >
       	 <select id="moveDist" name="moveDist" style="width:55px;">
			<option value="0.1">0.1</option>
			<option value="0.2">0.2</option>
			<option value="0.5">0.5</option>
			<option value="1" selected>1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="5">5</option>
			<option value="10">10</option>
			</select>
        m</td>
      </tr>
      <tr>
      	<td height="40" colspan="4" align="right">
	      	<input type="button" value="업" alt="" width="51" height="54" onClick="waterUp();return false;" style="cursor:hand;">
	      	<input type="button" value="다운"  alt="" width="49" height="54" onClick="waterDown();return false;" style="cursor:hand;">
      	</td>
      </tr>
    </table></td>
</table>
</form>
</body>
</html>
