<%
	// 툴바 >> 분석 및 효과  >> 단면분석 화면 페이지
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>단면도보기</title>
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<script type="text/javascript" src="${ctx}/js/common.js"></script>
<script type="text/javascript" src="${ctx}/js/layer.js"></script>
<style type="text/css">
#helpy {
	position:absolute;
	left:280px;
	top:71px;
	width:21px;
	height:87px;
	z-index:999999;
}
#helpx {
	position:absolute;
	left:689px;
	top:492px;
	width:100px;
	height:13px;
	z-index:999999;
}
</style>

<script type="text/javascript">

//페이지로딩시 레이어목록을 가져와서 화면 왼쪽에 표시한다.
var top = window.opener;

function page_load() {
	var TDOCX = document.getElementById("TDOCX");
	if(TDOCX == null || TDOCX == ''){
		alert('TDOCX가 설치되지 않았습니다.\n상단의 노란색 알림줄을 클릭하여 TDOCX를 설치하십시오.');
		return false;
	}

    var tdwfile = "";
	
	document.TDOCX.XTDClearAllData();
	 
    document.TDOCX.XTDReadSliceMapFile(top.getSliceFile());
    
    var lcnt, idx;
    var lName="";
    lcnt = document.TDOCX.XTDGetLayerCount();
    for(idx=0;idx<lcnt;idx++) {
        lName = document.TDOCX.XTDGetLayerName(idx);
   //     var tmpInfo = top.getLayInfo(lName, true);
        if(lName!="TEPORARY") addRow( lName, 2, 0, 202);
        if (lName == 'RDL_RDSN_PS') {
	        document.TDOCX.XTDSetLineAttribute(0, 2, 2, 0, 202);
	        document.TDOCX.XTDLayerSetAttribute("맨홀");
        } else if (lName == 'UF_WTL_PIPE_LM'  ) {
        	document.TDOCX.XTDSetFillAttribute(1, 124, 104, 238, 124, 104, 238);
	     	document.TDOCX.XTDLayerSetAttribute("하수관거");
        } else if (lName == 'UF_SWL_PIPE_LM'  ) {
        	document.TDOCX.XTDSetFillAttribute(1, 124, 104, 238, 124, 104, 238);
	     	document.TDOCX.XTDLayerSetAttribute("하수관거");
        }
    }
	document.TDOCX.XDRenderData();
}


//레이어 목록 화면에 그리기.

function addRow(layerName, r, g, b){
	if(r>240&&g>240&&b>240)r=g=b=240;
    var tbody = document.getElementById("LAYER_TBL").getElementsByTagName("TBODY")[0];
    tbody.align = "center";
	var lastrow = tbody.rows(tbody.rows.length-1);
	
    var row = document.createElement("TR");
    var td1 = document.createElement("TD");  
    var td2 = document.createElement("TD");
    var td3 = document.createElement("TD");   
	
	var opener = window.opener;
//  var tmp = opener.getLayName(layerName, true);
//    if(tmp=='mark')tmp="표고";
//    if(tmp=='line')tmp="격자";
    if(layerName!="mark"&&layerName!="line"){
		if(layerName.toUpperCase().indexOf("SWL")<=0&&layerName.toUpperCase().indexOf("WTL")<=0)return;
    }
    td2.appendChild(document.createTextNode(layerName));
    row.appendChild(td1);
    row.appendChild(td2);
    row.appendChild(td3);
    
    if(document.TDOCX.XTDGetLayerState(layerName, 0)==true) {
   		td1.innerHTML="<input type='checkbox' name='cheack_"+ lastrow + "' id='cheack"+ lastrow +"' onclick=javascript:changeVisible('" + layerName + "'); checked='1'>";
    } else {
        td1.innerHTML="<input type='checkbox' name='cheack_"+ lastrow + "' id='cheack"+ lastrow +"' onclick=javascript:changeVisible('" + layerName + "'); checked='0'>";
    }
      
    var tmpL = layerName.split('_');
    var strHtml = '';
 //   var rgb = RGBtoHex(r,g,b);
	if (layerName != 'mark' && layerName != 'line' && layerName != 'TERR' && tmpL[0] == 'UG') {
	    strHtml = "<input type='text' style='height:13px; width:13px; border:0px;";
	    strHtml += "background-color:#"+ rgb + "' readonly>&nbsp;"
   		td3.innerHTML = strHtml;
    }
    tbody.appendChild(row);
}


//레이어 보기 상태 변경
function changeVisible(lName) {
    var visible;
    visible = document.TDOCX.XTDGetLayerState(lName, 0);
    
    if(visible==true) {
        document.TDOCX.XTDLayerSetVisible(lName, false);
    }else {
        document.TDOCX.XTDLayerSetVisible(lName, true);
    }
    document.TDOCX.XDRenderData();
}


// 마우스 모드 변경
function setTDOperationMode(mode) {
    document.TDOCX.XTDSetMouseState(mode);
}

// 전체보기
function setZoomAll() {
    document.TDOCX.XTDZoomAll();
}

// 단면도 이미지 저장
function saveImageFile() {
    document.TDOCX.XDScreenToBmpFile();

}

function page_close() {
	window.close();
}

</script>

</head>

<!-- <body onLoad="page_load()" onunload="top.layVis(false); top.Refresh();" > -->
<body onLoad="page_load()" onunload="top.Refresh();" >
<table width="802" border="0" cellpadding="0" cellspacing="0" >
  <tr>
    <td colspan="2"><table width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr style="background-image:url(${ctx}/images/pop/pop_title_bg.gif)">
        <td width="185"><img src="${ctx}/images/pop/pop_title4.gif" alt="" width="122" height="35"></td>
        <td align="right"><img src="${ctx}/images/pop/pop_title_end.gif" alt="" width="134" height="35"></td>
        <td width="44" align="right"><img src="${ctx}/images/pop/pop_title_cclose.gif" alt="" width="44" height="35" onclick="javascript:page_close();" style="cursor:hand;"></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td width="270">
    <table width="270" border="0" cellpadding="0" cellspacing="0" style="background-image:url(${ctx}/images/pop/pop_menu_bg.gif)">
      <tr>
        <td width="10"><img src="${ctx}/images/pop/pop_menu_start.gif" width="10" height="33"></td>
        <td width="20" colspan="2">&nbsp;</td>
        <td width="10" align="right"><img src="${ctx}/images/pop/pop_menu_end.gif" width="10" height="33"></td>
      </tr>
    </table>
    <table width="270" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td width="10" style="background-image:url(${ctx}/images/pop/left_bg.gif)"></td>
        <td height="441" valign="top" bgcolor="#f8f8f8"><img src="${ctx}/images/pop/dan_list_title.gif" width="235" height="20" alt=""/>
          <table width="236" border="0" cellspacing="0" cellpadding="0" id="LAYER_TBL">
            <tr>
              <td align="center" width="31" style="height: 14px" ></td>
              <td align="center" width="175"></td>
              <td align="center" width="30"></td>
            </tr>
          </table></td>
        <td width="10" style="background-image:url(${ctx}/images/pop/right_bg.gif)"></td>
      </tr>
      <tr>
        <td height="15" style="background-image:url(${ctx}/images/pop/left_bott.gif)"></td>
        <td style="background-image:url(${ctx}/images/pop/bott_bg.gif)"></td>
        <td style="background-image:url(${ctx}/images/pop/right_bott.gif)"></td>
      </tr>
    </table></td>
    <td width="532" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" style="background-image:url(${ctx}/images/pop/pop_menu_bg.gif)">
      <tr>
        <td height="33" valign="top"><img src="${ctx}/images/pop/top_icon.gif" alt="" width="442" height="33" border="0" usemap="#Map" ></td>
        <td align="right" valign="top"><img src="${ctx}/images/pop/pop_menu_end.gif" alt="" width="10" height="33"></td>
      </tr>
    </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" >
        <tr>
          <td width="10" style="background-image:url(${ctx}/images/pop/left_bg.gif)"></td>
          <td height="441" valign="top" bgcolor="#e9e9e9" style="background-image:url(${ctx}/images/toolbar/Analysis/sub_left_side.gif); background-repeat:repeat-y;padding-left:1px;"><script type="text/javascript">tdk();</script></td>
          <td width="10" style="background-image:url(${ctx}/images/pop/right_bg.gif)"></td>
        </tr>
        <tr>
          <td height="15" style="background-image:url(${ctx}/images/pop/left_bott.gif)"></td>
          <td style="background-image:url(${ctx}/images/pop/bott_bg.gif)"></td>
          <td style="background-image:url(${ctx}/images/pop/right_bott.gif)"></td>
        </tr>
    </table></td>
  </tr>
</table>


<map name="Map">
  <area shape="rect" coords="16,6,71,31" href="#" alt="확대" onclick="setTDOperationMode(1); return false;">
  <area shape="rect" coords="79,7,142,30" href="#" alt="축소" onclick="setTDOperationMode(3); return false;">
  <area shape="rect" coords="152,7,221,30" href="#" alt="이동" onclick="setTDOperationMode(8); return false;">
  <area shape="rect" coords="226,7,313,30" href="#" alt="전체보기" onclick="setZoomAll(); return false;">
  <area shape="rect" coords="318,6,430,30" href="#" alt="이미지저장" onclick="saveImageFile(); return false;">
</map>
</body>
</html>
