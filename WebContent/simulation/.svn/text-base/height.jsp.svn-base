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
<script type="text/javascript" src="${ctx}/js/layer.js"></script>

<script type="text/javascript">

//객체 선택
function choose(){
	top.XDOCX.XDUISetWorkMode(6); 
	
}

//영역 선택
function polygonArea(){
	alert("영역을 그린 후 마우스 오른쪽을 클릭하면 선택됩니다.");
	top.XDOCX.XDUISetWorkMode(10);
	
}

//원형 선택
function roundArea(){
	alert("영역을 드레그한 후 마우스 오른쪽을 클릭하면 선택됩니다.");
	top.XDOCX.XDUISetWorkMode(11);
	
}

//평균 높이 실행
function avgHighExe(){
	var count = top.XDOCX.XDSelGetCount();
    if (count == 0)
    {
        alert("객체을 선택해 주세요.");
        return;
    }
    
    var keyCode;
    var layerName;
	var aveHeight = 0;
	for (var i = 0; i <= count - 1; i++)
    {
        pos = i;
       var retStr = top.XDOCX.XDSelGetCode(i);
       var retParts = retStr.split("#");
        if ((retParts[0] != null))
            layerName = retParts[0];
        if ((retParts[1] != null))
            keyCode = retParts[1];
            
        retStr = top.XDOCX.XDObjectGetBox(layerName, keyCode);
        retParts = retStr.split(",");
        if ((retParts[1] != null))
            bottomHeight = retParts[1];
        if ((retParts[4] != null))
            topHeight = retParts[4];
      
        objHeight = topHeight - bottomHeight;
       
        if (i == 0)
        {
            minHeight = objHeight;
            maxHeight = objHeight;
        }
        else
        {
            if (objHeight < minHeight)
            {
                minHeight = objHeight;
            }
            if (objHeight > maxHeight)
            {
                maxHeight = objHeight;
            }
        }
        aveHeight = aveHeight + objHeight;

        var cnt =i+1;
        
        var lyr_nm = layerName;
		var lyr = top.getLayerInfoByEName(lyr_nm);
		
		if(lyr){
			lyr_nm = lyr['lary_nm'];
		}
        var cnt =i+1;
        $('#result').append($(
        		'<tr onclick="selectRow(this);">'+
				'	<td width="25" align="center">'+cnt+'<input type="hidden" id="laynm'+cnt+'" value="'+layerName+'"/></td>'+
				'	<td width="70" align="center" title="'+lyr_nm+'" style="overflow: hidden; text-overflow:ellipsis; white-space:nowrap;">'+lyr_nm+'</td>'+
				'	<td width="80" align="center" title="'+keyCode+'" style="overflow: hidden; text-overflow:ellipsis; white-space:nowrap;">'+keyCode+'</td>'+
				'	<td align="right">'+ parseInt(objHeight*100)/100+'</td>'+
				'</tr>'
		));

        
        top.XDOCX.XDLaySetEditable("Temporary");
        top.XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 0, 0, 0);
        top.XDOCX.XDRefSetColor(0, 0, 255, 0);
       
        
        var x =(parseFloat(retParts[0]) + parseFloat(retParts[3]))/2;
        var y =(parseFloat(retParts[1]) + parseFloat(retParts[4]))/2;
        var z =(parseFloat(retParts[2]) + parseFloat(retParts[5]))/2;
        top.XDOCX.XDRefSetPos(parseFloat(x), parseFloat(y), parseFloat(z));
        top.XDOCX.XDObjCreateText(i+"_", parseInt(objHeight*100)/100 +"m", "");
       
        //pv.XDOCX.XDSetMouseState((short)MouseState.MOVE_GRAB);

        top.XDOCX.XDRenderData();
    }
	
	aveHeight = aveHeight / count;

	document.getElementById('LowHeight0').value = (parseInt(minHeight*100)/100).toFixed(2);
	document.getElementById('HiHeight0').value = (parseInt(maxHeight*100)/100).toFixed(2);
	document.getElementById('AvgHeight0').value = (parseInt(aveHeight*100)/100).toFixed(2);

	document.getElementById('LowHeight1').value = ((parseInt(minHeight) /parseInt(AvgFloor.value)*10)/10).toFixed(2);
	document.getElementById('HiHeight1').value = ((parseInt(maxHeight) /parseInt(AvgFloor.value)*10)/10).toFixed(2);
	document.getElementById('AvgHeight1').value = ((parseInt(aveHeight)/parseInt(AvgFloor.value)*10)/10).toFixed(2);
    top.XDOCX.XDSelClear();
    //clsMapControl.setMouseState(MouseState.MOVE_GRAB);
   top.XDOCX.XDUISetWorkMode(1);
	
}
function selectRow(obj){
	var data = new Array();
	$.each($(obj).find('td'), function(){
		data.push($(this).text());
	});
	data[1] = $('#laynm'+data[0]).val();
	var pos = top.XDOCX.XDObjGetPosition(data[1], data[2]);
	if(pos){
		pos = pos.split(',');
		if(pos.length == 3){
			var angle = top.XDOCX.XDCamGetAngle();
			top.searchXDPointPosition(pos[0], pos[2], null, null, null, angle, "test");
		}
	}
	
	
// 	data[1] = $('#laynm'+data[0]).val();
//     top.XDOCX.XDSrcLocalObject(data[1], data[2]);
//     top.XDOCX.XDCamSetDistance(130);
//     top.XDOCX.XDSetSelected(data[1], data[2]);
}

//평균 높이 클리어
function highClaer() {
	top.XDOCX.XDLayClear("Temporary");
	top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDAnsClear();
	top.XDOCX.XDSelClear();
	top.XDOCX.XDUIDistanceClear();
	top.XDOCX.XDUIAreaClear();
	top.XDOCX.XDUIClearMemo();
	top.XDOCX.XDMapResetRTT();
	top.XDOCX.XDUISetWorkMode(1);
	document.getElementById('AvgFloor').value = 2.5;
	document.getElementById('LowHeight0').value = 0;
	document.getElementById('HiHeight0').value = 0;
	document.getElementById('AvgHeight0').value = 0;
	document.getElementById('LowHeight1').value = 0;
	document.getElementById('HiHeight1').value = 0;
	document.getElementById('AvgHeight1').value = 0;
	$('#result').empty();
    $('#result').append($(
			 '<table id="result" border="0" cellpadding="0" cellspacing="0" class="wps_100" summary="가시결과list">'+
				'<col class="w_40" />'+
				'<col />'+
				'<col />'+
				'<col />'+
				'<tr>'+
					'<th>No</th>'+
					'<th>레이어</th>'+
					'<th>고유</th>'+
					'<th>높이(m)</th>'+
				'</tr>'+
			'</table>'
	));
}
</script>
</head>

<body style="background: url(${ctx}/images/category_bg1.gif)">
	<div id="panel">
		<div id="title">
			<div id="category1">
				<ul style="width: 320px;">
					<li class="f_whit_am">영역선택</li>
					<li style="float: left;">
						<a href="#" onclick="choose()">
							<img src="${ctx}/images/btn_obj.gif" />
						</a>
					</li>
					<li style="float: left; margin: 0 0 0 3px;">
						<a href="#" onclick="roundArea()">
						<img src="${ctx}/images/btn_sel_A.gif" />
						</a>
					</li>
					<li style="float: left; margin: 0 0 0 3px;">
						<a href="#" onclick="polygonArea()">
							<img src="${ctx}/images/btn_sel_R.gif" />
						</a>
					</li>
					<li  style="float: left; margin: 0 0 0 3px;">
						<a href="#" onclick="highClaer()">
							<img src="${ctx}/images/btn_analysis_cancel.gif" width="96" height="24" />
						</a>
					</li>
					<li style="padding-top: 10px; clear: both;">
						<img src="${ctx}/images/category_SIDE.gif" />
					</li>
					<li><label for="textfield">층 높이</label>
						<input name="AvgFloor" type="text" id="AvgFloor" value="2.5" /> m
					</li>
					<li style="clear: both;"><img src="${ctx}/images/category_SIDE1.gif" /></li>
					<li class="f_whit_am" style="clear: both; margin-top: 10px;">분석대상</li>
					<li style="height: 190px;">
						<div id="bbsCont" style="height: 170px; overflow-y: scroll; width: 310px; background: #FFF; border: solid 1px #333333;">
							<table id="result" border="0" cellpadding="0" cellspacing="0" class="wps_100" summary="가시결과list">
								<col class="w_40" />
								<col />
								<col />
								<col />
								<tr>
									<th>No</th>
									<th>레이어</th>
									<th>고유</th>
									<th>높이(m)</th>
								</tr>
								
							</table>
						</div>
					</li>
				</ul>
						<fieldset style="padding:5px;">
							<legend class="f_whit_am">평균높이 결과 값</legend>
							<ul>
								<li><label for="textfield" style="width: 100px;">최저높이</label>
									<input name="LowHeight0" type="text" id="LowHeight0" style="width: 60px;" value="0" readonly/>m 
									<input name="LowHeight1" type="text" id="LowHeight1" style="width: 60px;" value="0" readonly />층
								</li>
								<li><label for="textfield" style="width: 100px;">최고높이</label>
									<input name="HiHeight0" type="text" id="HiHeight0" style="width: 60px;" value="0" readonly />m 
									<input name="HiHeight1" type="text" id="HiHeight1" style="width: 60px;" value="0" readonly />층
								</li>
								<li><label for="textfield" style="width: 100px;">평균높이</label>
									<input name="AvgHeight0" type="text" id="AvgHeight0" style="width: 60px;" value="0" readonly />m 
									<input name="AvgHeight1" type="text" id="AvgHeight1" style="width: 60px;" value="0" readonly />층
								</li>
							</ul>
						</fieldset>
						<a href="#" onclick="avgHighExe()">
							<img src="${ctx}/images/btn_ok.gif" style="margin-top: 10px;float:right;"/>
						</a>
			</div>
		</div>
	</div>
</body>
</html>
