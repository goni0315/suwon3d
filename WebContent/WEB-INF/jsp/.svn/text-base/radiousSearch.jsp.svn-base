<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xml:lang="ko">
<head>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css"/>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>3차원공간정보활용시스템</title>
<script language="javascript" src="${ctx}/js/XDControl.js"></script>
<script type="text/javascript">
var rect_layer = "laySearchRect";	//반경검색 레이어

	//기준 위치 선택
	function radiusSelectPoint() {	
		top.setObj(self);
		top.setOperationMode(20);
		top.setWorkMode("radious");
		//top.setSpaceMode(2);
	}
	
	
// 반경 검색을 실행 한다.
function radiusSearch() {
	var layers=["KO3D_BLDG_3D_COMMON","KO3D_BLDG_3D_GENERAL","KO3D_BLDG_3D_INDUSTRY","KO3D_BLDG_3D_PUBLIC","KO3D_BLDG_3D_SERVICE","KO3D_BLDG_3D_MEDICALWELFARE","KO3D_BLDG_3D_CULTURALEDUCATION","KO3D_BLDG_3D_ETC"];
	var form = document.getElementById('frm');
	var search_radius = document.getElementById('search_radius');
	
	if(search_radius.value == '0') {
		alert("검색반경을 입력하세요.");
		search_radius.focus();
		return;
	}
	
	if(form.radius_x.value == "" || form.radius_y.value == "") {
		alert("기준위치선택을 하세요");
		radiusSelectPoint();
		return;
	}
	
	var radius_x = form.radius_x.value;
	var radius_y = form.radius_y.value;
	
	top.setObj(self);
	
	//form.bldgShpName.value = top.getBldgShpName();
	form.bldgShpName.value =document.getElementById("bldgType").value;
	var len;
	var tmpArray;
							 		
	top.setWorkMode("radious");
	top.XDOCX.XDSelClear();
	
	radius_result = "";
	
	var tmpResult = "";
	var tmpResult2 = "";
	for(var k=0;k<layers.length;k++){
		if(form.bldgShpName.value=="blank"){
			tmpResult = top.XDOCX.XDSrcNetRoundSearch(layers[k],parseFloat(form.radius_x.value), parseFloat(form.radius_y.value), search_radius.value);
//			alert(layers[k]+" : "+tmpResult);
			alert(layers[k]+","+tmpResult+","+tmpResult2);
			abc();
		} else{
			if(k==form.bldgShpName.value){
				tmpResult = top.XDOCX.XDSrcNetRoundSearch(layers[form.bldgShpName.value],parseFloat(form.radius_x.value), parseFloat(form.radius_y.value), search_radius.value);
			abc();
			}
		}
	}

	function abc(){
		if(tmpResult!=0){
			var tmpResult3 = tmpResult.split(",");
			for (var j = 1; j < tmpResult3.length; j++) {
				if (tmpResult3[j] != "") {
					if (tmpResult2 != "") { tmpResult2 += ","; }
					tmpResult2 += tmpResult3[j];
				}
			}
		}
	}
			if (tmpResult2 != "") {
				radius_result = tmpResult2;
			}



	top.setWorkMode("");

	if (radius_result != "") {
		doSearchR();
	} else {
		alert("선택영역에 검색된 결과가 없습니다.");
	}
}	
function doSearchR(){
	var form = document.getElementById('frm');

	var radius_x = form.radius_x.value;
	var radius_y = form.radius_y.value;
	var radius_r = form.search_radius.value;
	var radius_seg = parseInt((radius_r / 10) * 36);
	var height = top.XDOCX.XDTerrGetHeight(parseFloat(radius_x), parseFloat(radius_y));
	
	top.XDOCX.XDLaySetEditable(top.getMLayer2());
	top.XDOCX.XDUIInputCircle(parseFloat(radius_x), height, parseFloat(radius_y), parseFloat(radius_r), radius_seg);
	top.TmpRefColor(200, 100, 255, 100);
	top.XDOCX.XDObjCreatePolygon("tmpRadius", "", 0, 0);
	top.GetRefColor();
	top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDLaySetEditable(top.getTmpLayer());
	top.XDOCX.XDRenderData();

	form.searchlist.value = radius_result;
	top.setWorkMode("");
	
	clearDataR(); 
//	alert(form.searchlist.value);
	form.submit();
}

function clearDataR() {
	radius_result = "";
	top.setWorkMode("");
}

function removeLay() {
	top.XDOCX.XDLayRemove(top.getMLayer2());
}
</script>

</head>
<body >
<div id="panel">
    <div id="title">
        <div id="category">
        <form id="frm" action="${ctx}/radious/reseult.do" method="post" target="searchResult">
		<input type="hidden" id="type" name="type" value="searchRadius">
		<input type="hidden" name="radius_x" />
		<input type="hidden" name="radius_y" />
		<input type="hidden" name="bldgShpName" value="">
		<input type="hidden" name="searchlist"/>
		<input type="hidden" name="pageNum" id="pageNum" value=""/>   
       <ul style="width:320px;">
       <li style="float:left;"><a href="left3.html" target="left"><img src="${ctx}/images/btn_R_search_on.gif"/></a>
        </li>
        <li style="float:right"><a href="left31.html" target="left"><img src="${ctx}/images/btn_A_search_off.gif"/></a>
        </li>
        <li style=" padding-top:15px;clear:both; "><img src="${ctx}/images/category_SIDE.gif"  /></li>
        <li class="f_whit_am">반경 위치 설정</li>
        <li style="float:left;"><img src="${ctx}/images/btn_Loc_point.gif" width="96" height="24" onClick="radiusSelectPoint();"/></li>
        <li style="margin:0 0 0 3px;"></li>

        </br>
		<fieldset >
        <legend class="f_whit_am">반경검색 옵션</legend>
             <ul>

            <li style="float:left;">
              <label for="textfield">검색반경</label>
                <input type="text" name="search_radius" id="search_radius" />
            m</li>
            <li style=" clear:both; float:left;">
              <label for="textfield">건물 분류</label>
              <select name="bldgType" id="bldgType">
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
            <li style=" clear:both; float:left;">
              <label for="textfield">검색어</label>
              <input type="text" name="keyWord" id="keyWord" />
            </li>
            </ul>
        </fieldset>

        <hr />
        <li style="margin:10px 0 10px 0; float:right;"><a href="#" onClick="radiusSearch();"><img src="../images/btn_search.gif"/></a></li>
        </ul>
        </form>
	  </div>
    </div>
    <div>
        <h4><img src="../images/result_title1.gif" alt="결과" width="340" height="34"/></h4>
       <iframe id="searchResult" name="searchResult" src="${ctx}/radious/reseult.do" frameborder="0" width="100%" style="height: 100%" scrolling="no" />
    </div>
</div>
</body>
</html>
