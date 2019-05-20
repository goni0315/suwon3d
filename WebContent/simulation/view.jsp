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
<script type="text/javascript">
var count = 1;
var addCount;
var viewList = '';

//조망권 기준점 선택
function selectJomang(){
   	top.setObj('1');

	if (top.XDOCX.XDAnsJomangListCount() < 1){
		alert("기준점을 선택한 후 '조장지점 설정' 버튼을 클릭하여 방향점을(최대5개) 입력해 주세요.");	
	}else{
	   	var count = top.XDOCX.XDAnsJomangListCount();
	   	if(count > 5){
		   	alert("방향점은 5개까지만 입력 가능합니다.");
		   	return;
	   	}else{
		   	alert("방향점 "+count+"를 입력해주세요 .");	
	   	}
	}
	top.XDOCX.XDAnaJomangElement(top.getObj());
   
	top.XDOCX.XDUISetWorkMode(94);
	top.setSimulMode(103);
	top.XDOCX.XDLayCreate(9, "Temporary2");
	top.XDOCX.XDLaySetEditable("Temporary2");
	
}
function fileSave(){ //input button 생성
	var filepath = top.XDOCX.XDUIOpenFileDlg(false, "txt");
	if (filepath == "") { 
		return; }
	var rows = tableTest.rows.length;
	var pos = viewList.split(",");
	var sText = '';
	if(pos[1] == 'POSX'){
		for(var i = 5; i < pos.length; i++)
		{
			if(i%4 == 0 && i%5 == 0){
				if(i%4 == 0){
					sText= sText+pos[i]+"\n";
				}
			}else{
				if(i%5 == 0){
					sText = sText + pos[i]+",";
				}else if(i%4 == 0){
					sText= sText+pos[i]+"\n";
				}else{
					sText = sText+pos[i]+",";
				}
			}
		}
	}else{
		for(var i = 1; i < pos.length; i++)
		{
			if(i%4 == 0 && i%5 == 0){
				if(i%4 == 0){
					sText= sText+pos[i]+"\n";
				}
			}else{
				if(i%5 == 0){
					sText = sText + pos[i]+",";
				}else if(i%4 == 0){
					sText= sText+pos[i]+"\n";
				}else{
					sText = sText+pos[i]+",";
				}
			}
		}
	}
	var r_sText = 'xd_jomang3\n'+sText;
	var a = top.XDOCX.XDUISaveTxtFile(filepath, r_sText); 
	if(a == true){
		alert("txt파일이 저장이 완료됬습니다.");
	}
}

function fileLoad(){
	if(jomangStr == ''){
		alert("기준점을  선택해주세요");
		return false;
	}
	var rows = tableTest.rows.length;
	var filepath = top.XDOCX.XDUIOpenFileDlg(true, "txt");
	if (filepath == "") { 
		return; 
	}
	if(rows != 1){
		clearAll();
	}
	var i = top.XDOCX.XDUIOpenTxtFile(filepath);
	var strList = i.split('\n');
	var list = '';

	if(strList.length >= 2 && strList[0] == 'xd_jomang3'){
		for(var i = 1; i < strList.length-1; i++)
		{
			list = list +","+ strList[i];
		}
		var pos = list.split(",");
		var cnt = pos.length-1;
		//alert(cnt);
		viewList = '';
		var ant = 1;
		for (var i=1; i < cnt;)
		{
			makeTbl(ant, pos[i], pos[i+1], pos[i+2], pos[i+3]);
			i = i+4;
			ant++;
		}
		mgrdata('s2');
	}else{
		alert('지원하지 않는 형식의 파일입니다.');
	}
	
}

function clearAll(){
	 var rows = tableTest.rows.length;
	 //alert(rows);
	 for(var i = 0; i < rows; i++)
	 { 	
			tableTest.deleteRow('0');	
	 }
	 viewList = '';

	top.XDOCX.XDLaySetEditable("Temporary");
	top.XDOCX.XDLayClear("Temporary");
	top.XDOCX.XDAnsJomangListClear();
	top.XDOCX.XDLaySetEditable("Temporary2");
	top.XDOCX.XDLayRemove("Temporary2");
	//top.setOperationMode(1);
	top.XDOCX.XDUISetWorkMode(1);
	top.XDOCX.XDMapRender();
	$('#tableTest').append($(
	'<col class="w_40"/>'+
	'<col />'+
    '<col />'+
    '<col />'+
    '<tr align="center">'+
	    '<th align="center">No</th>'+
	    '<th align="center">X</th>'+
	    '<th align="center">Y</th>'+
	    '<th align="center">Z</th>'+
    '</tr>'
	));
	
}

//조망권 시작
function jomangRun_Click(){
	var iJomangSpeed = 0;
	var sliderSpeed = document.getElementById("slider1input").value;
	var jomangHigh = document.getElementById("txtHeight").value;
	if(jomangHigh == ""){
		jomangHigh = 0;
	}
	iJomangSpeed = (50 - sliderSpeed) * 10;
	if (iJomangSpeed > 0){
		top.setJomangSpeed(iJomangSpeed);
	}
    if (top.XDOCX.XDAnsJomangListCount() > 2){
	    top.XDOCX.XDCamSetSmooth(false);
	    top.XDOCX.XDLaySetVisible("Temporary2", false);
	    
	    top.XDOCX.XDAnsViewProspectHigh(top.XDOCX.XDAnsJomangListCount(), top.getJomangSpeed(), jomangHigh);
	
	    top.XDOCX.XDLaySetVisible("Temporary2", true);
	    top.XDOCX.XDUISetWorkMode(1);
		top.XDOCX.XDMapRender();
	    top.XDOCX.XDCamSetSmooth(true);
    }else{
        alert("조망권보기를 시작하기 위해서는 기준점과 2개 이상의 지점을 입력하여야 됩니다.");
    }
}

function mgrdata(value){
	
	var rows = tableTest.rows.length;
	var pos = jomangStr.split(",");
	
	top.XDOCX.XDLaySetEditable("Temporary");
	top.XDOCX.XDLayClear("Temporary");
	top.XDOCX.XDLaySetEditable("Temporary2");
	top.XDOCX.XDLayRemove("Temporary2");
	
	top.XDOCX.XDAnsJomangListClear();
	top.XDOCX.XDMapRenderLock(true);
	top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDSelClear();
	top.XDOCX.XDMapClearTempLayer();
	top.XDOCX.XDAnsClear();
	top.XDOCX.XDAnsClearSlice();
	top.XDOCX.XDUIDistanceClear();
	top.XDOCX.XDMapRenderLock(false);
	top.XDOCX.XDMapRender();
	
	top.XDOCX.XDLaySetEditable("Temporary");
	top.XDOCX.XDRefSetFontStyle("굴림", 12, false, true, 1, 255, 255, 255);
	top.XDOCX.XDRefSetColor(0, 0, 0, 0);
	top.XDOCX.XDRefSetPos(pos[0],pos[1],pos[2]);
	top.XDOCX.XDObjCreateText("기준점", "기준점", top.getWorkPath() + "\\texture\\BlueP.png");
	top.XDOCX.XDLaySetEditable("Temporary2");
	top.XDOCX.XDAnsJomangListInsert(pos[0],pos[1],pos[2]);
	top.XDOCX.XDMapRender();
        
	for(var i =1; i < rows + 1; i++){
		
		var count = document.getElementById('tno'+i).value;
		var pos_x = document.getElementById('tx'+i).value;
		var pos_z = document.getElementById('tz'+i).value;
	    
		if (checkHigh.checked == true){
			var pos_y = document.getElementById("txtHeight").value;
		}else{
	 		var pos_y = document.getElementById('ty'+i).value;				 
		}
		
		document.getElementById('ty'+i).value = pos_y;
		top.XDOCX.XDLaySetEditable("Temporary");
		top.XDOCX.XDRefSetFontStyle("굴림", 12, false, true, 1, 255, 255, 255);
		top.XDOCX.XDRefSetColor(0, 0, 0, 0);
		top.XDOCX.XDRefSetPos(pos_x, pos_y, pos_z);
		//top.XDOCX.XDObjCreateText("방향점" + Convert.ToString(top.XDOCX.XDAnsJomangListCount()), "방향점" + Convert.ToString(top.XDOCX.XDAnsJomangListCount()), Application.StartupPath + "\\images\\GreenP.png");
		top.XDOCX.XDObjCreateText("방향점" + count, "방향점" + count, top.getWorkPath() + "\\texture\\GreenP.png");            
		top.XDOCX.XDLaySetEditable("Temporary2");
		top.XDOCX.XDAnsJomangListInsert(pos_x, pos_y, pos_z);
		top.XDOCX.XDMapRender();
	}
}
/*
 *  조망 분석
 */
function setJomangIn(posX, posY, posZ)
{
	jomangStr = posX+","+posY+","+posZ;
}

function makeTbl(countNo, pos_X, pos_Y, pos_Z, str){
	viewList = viewList+","+pos_X+","+pos_Y+","+pos_Z+","+str;
	if(countNo != 'NO'){
		pos_X = parseFloat(pos_X).toFixed(2);
		pos_Y = parseFloat(pos_Y).toFixed(2);
		pos_Z = parseFloat(pos_Z).toFixed(2);
	}
	addCount = countNo;

		$('#tableTest').append($(
				'<tr>'+
				'<td align="center"><input type="text" id="tno'+addCount+'" value="'+countNo+'" name="tno'+addCount+'" size="1" style="border:0;" readonly /></td>'+
				'<td align="center"><input type="text" id="tx'+addCount+'" value="'+pos_X+'" name="tx'+addCount+'" size="9" style="border:0;" readonly /></td>'+
				'<td align="center"><input type="text" id="ty'+addCount+'" value="'+pos_Y+'"name="ty'+addCount+'" size="4" style="border:0;" readonly /></td>'+
				'<td align="center"><input type="text"  id="tz'+addCount+'" value="'+pos_Z+'" name="tz'+addCount+'" size="9" style="border:0;" readonly /></td>'+
				'</tr>'
	    ));
	count++;
}
</script>
<script type="text/javascript" for="XDOCX" event="MouseUp(Button, Shift, sx, sy)" >
	MouseUpEventHandler(Button, Shift, sx, sy);
</script>
</head>
<body style="background: url(${ctx}/images/category_bg1.gif)">
	<div id="panel">
		<div id="title">
			<div id="category1" style="margin-top: 35px;">
				<ul style="width: 320px;">
					<li style="float: left;">
						<a href="view.jsp" target="left">
							<img src="${ctx}/images/btn_view_A_on.gif" />
						</a>
					</li>
					<li style="float: left; margin-left: 4px;">
						<a href="view_point.jsp" target="left">
							<img src="${ctx}/images/btn_view_point_off.gif" />
						</a>
					</li>
					<li style="float: right">
						<a href="view_line.jsp" target="left">
							<img src="${ctx}/images/btn_view_line_off.gif" />
						</a>
					</li>
					<li style="padding-top: 15px; clear: both;">
						<img src="${ctx}/images/category_SIDE.gif" />
					</li>
					<li class="f_whit_am">조망점</li>
					<li style="float: left;">
						<a href="#" onclick="selectJomang()">
							<img src="${ctx}/images/btn_view_set.gif" />
						</a>
					</li>
					<li style="float:left; margin:0 0 0 3px;">
						<a href="#" onclick="clearAll()">
							<img src="${ctx}/images/btn_analysis_cancel.gif" width="96" height="24" />
						</a>
					</li>
					<li></li>
					<li class="f_whit_am" style="clear: both; margin-top: 10px;">방향점 리스트</li>
					<li style="height: 180px;">
						<div id="bbsCont1" style="height:170px; overflow-y:yes; width:310px; background:#FFF; border:solid 1px #333333; ">
				          <table id="tableTest" border="0" cellpadding="0" cellspacing="0" class="wps_100" summary="가시결과list">
				          	<col class="w_40"/>
							<col />
				            <col />
				            <col />
				            <tr align="center">
				              <th align="center">No</th>
				              <th align="center">X</th>
				              <th align="center">Z</th>
				              <th align="center">Y</th>
				            </tr>
				
				          </table>
				        </div>
					</li>
				</ul>
						<fieldset style="padding:5px;">
							<legend class="f_whit_am">높이값 설정 </legend>
							<label for="checkHigh" style="width: 100px;"> 
								<input name="checkHigh" id="checkHigh" type="checkbox" value="" /> 높이값적용
							</label>
							<input type="text" name="txtHeight" id="txtHeight" />
						</fieldset>
						<hr /> </br>
						<fieldset style="padding:5px;">
							<legend class="f_whit_am">시뮬레이션 속도 설정 </legend>
							<label for="slider1input" style="width: 100px;">시뮬레이션 속도</label> 
							<input name="slider1input"  id="slider1input" size="4" value="10" style="width: 30px; text-align: right;"/>
							
						</fieldset>
						<hr />
						<a href="#" onclick="jomangRun_Click()">
							<img src="${ctx}/images/btn_ok.gif"  style="margin:10px 0 10px 0; float:right;"/>
						</a>
			</div>
		</div>
	</div>
</body>
</html>