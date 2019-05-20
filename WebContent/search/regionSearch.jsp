<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xml:lang="ko">
<head>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<title>3차원공간정보활용시스템</title>
<script type="text/javascript">
var mode = 1;
var layer_list = "";

var search_result = ""; // 영역검색 결과    
var radius_type = ""; // 반경검색 대상 레이어명

var minX = "";
var minY = "";
var maxX = "";
var maxY = "";

function doSearch(){
	var layerlist=["KO3D_BLDG_3D_COMMON","KO3D_BLDG_3D_GENERAL","KO3D_BLDG_3D_INDUSTRY","KO3D_BLDG_3D_PUBLIC","KO3D_BLDG_3D_SERVICE","KO3D_BLDG_3D_MEDICALWELFARE","KO3D_BLDG_3D_CULTURALEDUCATION","KO3D_BLDG_3D_ETC"];
	
	var form = document.SearchFrm;
	
	top.setObj(self);
	
	if (top.XDOCX.XDExInputPointNum <= 0) {
		alert("검색 영역이 없습니다.");
		return;
	}
	
	clearData();
	
	search_result = "";
	
	top.setSpaceMode(1);
	
	radius_layer_idx = 0;
	
	top.MakeMLayer(top.getMLayer(), 1);
	top.XDOCX.XDLaySetEditable(top.getMLayer());
	top.TmpRefColor(200, 255, 0, 0);
	top.XDOCX.XDObjCreatePolygon("tmpRect", "", 0, 0);
	top.GetRefColor();
	top.XDOCX.XDLaySetEditable(top.getTmpLayer());
			
	if (form.search_layer.options.selectedIndex == 0) {
		for (var i = 0; i < layerlist.length; i++) {
			var tmpResult = 0;
			if (layerlist[i] != "") {
				tmpResult = top.XDOCX.XDSrcNetRegionSearch(layerlist[i]);
			}
			if (tmpResult != 0) {
				tmpResult = tmpResult.split(",");
				for (var j = 1; j < tmpResult.length; j++) {
					if (tmpResult[j] != "") {
						if (search_result != "") { search_result += ","; }
						search_result += "'" + tmpResult[j] + "'";
					}
				}
			}
		}		
	} else {
		var tmpResult = 0;
		if (layerlist[i] != "") {
			tmpResult = top.XDOCX.XDSrcNetRegionSearch(layerlist[form.search_layer.value]);
		}
		if (tmpResult != 0) {
			tmpResult = tmpResult.split(",");
			for (var j = 1; j < tmpResult.length; j++) {
				if (tmpResult[j] != "") {
					if (search_result != "") { search_result += ","; }
					search_result += "'" + tmpResult[j] + "'";
				}
			}
		}
	}
	
	top.XDOCX.XDUIClearInputPoint();
	
	if (search_result != "") {
		statistics2();
	} else {
		alert("선택영역에 검색내용이 없습니다.");
	}
}	

function statistics2() {
	var form = document.SearchFrm;
	
	top.setSpaceMode(0);
		
	form.searchlist.value = search_result;
		 
	if (form.search_layer.options.selectedIndex > 1) {
		form.search_lay.value = form.search_layer.options[form.search_layer.options.selectedIndex].text;
	} else {
		form.search_lay.value = "";	
	}
	form.submit();	
}

function clearData()
{
	search_result = "";
	
	top.setSpaceMode(0);
	if (top.existLayer(top.getMLayer())) {
		top.XDOCX.XDLayRemove(top.getMLayer());
	}
	top.XDOCX.XDMapLoad();
	top.XDOCX.XDSetMouseState(1);
	top.XDOCX.XDMapRender();
}


function rangeWriteMode() {
	minX = "";
	minY = "";
	maxX = "";
	maxY = "";
	
	var form = document.SearchFrm;
	
	form.radius_x.value = "";
	form.radius_y.value = "";
	
	top.setObj(self);
	top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDMapClearTempLayer();
	top.XDOCX.XDRenderData();
	top.XDOCX.XDSetMouseState(24);
	top.setSpaceMode(1);
}

function clearRect() {
	top.setSpaceMode(0);
	top.XDOCX.XDMapClearTempLayer();
	if (top.existLayer(top.getMLayer())) {
		top.XDOCX.XDLayRemove(top.getMLayer());
	}
	top.XDOCX.XDMapLoad();
	top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDSetMouseState(1);
	top.XDOCX.XDMapRender();
}

//엔터 쳐서 검색
function keypress() { // 엔터로 검색 할 수 있게 이벤트 
	var kcode; 
	
	kcode = window.event.keyCode; 
	
	if(kcode==13){ //엔터 
		radiusSearch(); 
	} 
}
</script>
</head>

<body >
<form name="SearchFrm" id="SearchFrm" action="${ctx}/region/reseult.do" target="searchResult" method="post">
	<input type="hidden" name="searchlist"/>
	<input type="hidden" name="search_lay"/>
	<input type="hidden" name="radius_x" />
    <input type="hidden" name="radius_y" />
	<input type="hidden" name="pageNum" />
<div id="panel">
    <div id="title">
        <div id="category">
       <ul style="width:320px;">
       <li style="float:left;"><a href="radiousSearch.jsp" target="left"><img src="${ctx}/images/btn_R_search_off.gif" style="cursor:pointer"/></a>
        </li>
        <li style="float:right"><img src="${ctx}/images/btn_A_search_on.gif"/ style="cursor:pointer">
        </li>
        <li style=" padding-top:15px;clear:both; "><img src="${ctx}/images/category_SIDE.gif" /></li>
        <li class="f_whit_am">반경 위치 설정</li>
        <li style="float:left;margin:0 3px 0 0;"><img src="${ctx}/images/btn_A_set.gif" onClick="rangeWriteMode()" style="cursor:pointer"/></li>
        <li style="margin-bottom: 10px;"><img src="${ctx}/images/btn_A_reset.gif" onClick="clearRect()" style="cursor:pointer"/></li>
        </ul>
		<fieldset style="padding:5px;" >
        <legend class="f_whit_am">반경검색 옵션</legend>
             <ul>
            <li style=" clear:both; float:left;">
              <label for="textfield">건물 분류</label>
              <select name="search_layer" id="search_layer" style="width:130px;">
              <option value="blank">전체</option>
              	<option value="0">공동주택</option>
              	<option value="1">일반주택</option>
              	<option value="2">산업시설</option>
              	<option value="3">공공기관</option>
              	<option value="4">서비스시설</option>
              	<option value="5">의료/복지시설</option>
              	<option value="5">문화/교육시설</option>              	
				<option value="6">기타시설</option>  
              </select>
            </li>
            <li style=" clear:both;">
              <label for="textfield">검색어</label>
              	<input type="text" name="keyWord" id="keyWord" style="width:120px; height:14px;padding-left:5px; img-mode:active;"onkeypress="keypress()" />
            </li>
            </ul>
        </fieldset>
        <hr />
        <img src="${ctx}/images/btn_search.gif" onClick="doSearch()" style="cursor:pointer;float:right; margin:10px 0 10px 0"/>
	  </div>
    </div>
    <div>
        <h4><img src="${ctx}/images/result_title.gif" alt="결과" width="340" height="34"/></h4>
        <div id="bbsCont" style="height:100%; overflow-y:yes; width:340px;">
          <iframe id="searchResult" name="searchResult" src="${ctx}/region/blinkRadiousList.do" frameborder="0" width="100%" style="height: 620px" scrolling="no" />
					<table border="0" cellpadding="0" cellspacing="0" class="wps_100"
						title="list" summary="list">
					</table>
        </div>
        </div>
    </div>
</div>
</form>
</body>
</html>
