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
	
	
// 반경 검색을 실행
function radiusSearch() {
	
	//검색할 레이어 목록
	var layers=["KO3D_BLDG_3D_COMMON","KO3D_BLDG_3D_GENERAL","KO3D_BLDG_3D_INDUSTRY","KO3D_BLDG_3D_PUBLIC","KO3D_BLDG_3D_SERVICE","KO3D_BLDG_3D_MEDICALWELFARE","KO3D_BLDG_3D_CULTURALEDUCATION","KO3D_BLDG_3D_ETC"];
	var form = document.getElementById('frm');
	var search_radius = document.getElementById('search_radius');
	
	//검색 반경이 0일 경우
	if(search_radius.value == '0') {
		alert("검색반경을 입력하세요.");
		search_radius.focus();
		return;
	}
	
	//기준위치가 선택되지 않았을 경우
	if(form.radius_x.value == "" || form.radius_y.value == "") {
		alert("기준위치선택을 하세요");
		radiusSelectPoint();
		return;
	}
	
	//var radius_x = form.radius_y.value;
	//var radius_y = form.radius_x.value;
	
	top.setObj(self);
	
	//form.bldgShpName.value = top.getBldgShpName();
	form.bldgShpName.value =document.getElementById("bldgType").value;
	//var len;
	//var tmpArray;
							 		
	top.setWorkMode("radious");

	top.XDOCX.XDSelClear();
	
	radius_result = "";
	
	var tmpResult = "";
	var tmpResult2 = "";
	for(var k=0;k<layers.length;k++){
		if(form.bldgShpName.value=="blank"){
			
			//alert(layers[k]+"//"+parseFloat(form.radius_x.value)+"//"+parseFloat(form.radius_y.value)+"//"+search_radius.value);
			
			tmpResult = top.XDOCX.XDSrcNetRoundSearch(layers[k],parseFloat(form.radius_x.value), parseFloat(form.radius_y.value), search_radius.value);
			
			//alert(layers[k]+","+tmpResult+","+tmpResult2);
			
			tmpResultSet();
			
		} else{
			if(k == form.bldgShpName.value){
				//alert(layers[form.bldgShpName.value]+"//"+parseFloat(form.radius_x.value)+"//"+parseFloat(form.radius_y.value)+"//"+search_radius.value);
				
				tmpResult = top.XDOCX.XDSrcNetRoundSearch(layers[form.bldgShpName.value],parseFloat(form.radius_x.value), parseFloat(form.radius_y.value), search_radius.value);
				
				//alert(layers[k]+","+tmpResult+","+tmpResult2);
				
				tmpResultSet();
			}
		}
	}

	function tmpResultSet(){
		//alert("tmpResult : " + tmpResult);
		if(tmpResult!=0){
			var tmpResult3 = tmpResult.split(",");
			//alert("tmpResult3 : " + tmpResult3);
			for (var j = 1; j < tmpResult3.length; j++) {
				if (tmpResult3[j] != "") {
					if (tmpResult2 != "") { tmpResult2 += ","; }
					tmpResult2 += tmpResult3[j];
				}
			}
			//alert("tmpResult2 : " + tmpResult2);
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

//검색이 될 경우 해당 반경에 대한 평면 폴리곤 생성
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

//데이터 초기화
function clearDataR() {

	radius_result = "";
	top.setWorkMode("");
}

//레이어 초기화
function removeLay() {
	top.XDOCX.XDLayRemove(top.getMLayer2());

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
<div id="panel">
<div id="title">
<div id="category">
<form id="frm" action="${ctx}/radious/reseult.do" method="post" target="searchResult">
		<input type="hidden" id="type" name="type" value="searchRadius" />
		<input type="hidden" name="radius_y" />
		<input type="hidden" name="radius_x" />
		<input type="hidden" name="bldgShpName" value=""/>
		<input type="hidden" name="searchlist"/>
		<input type="hidden" name="pageNum" id="pageNum" value=""/>
		<ul style="width:320px;">
       <li style="float:left;"><img src="${ctx}/images/btn_R_search_on.gif" /></li>
        <li style="float:right"><a href="${ctx}/search/regionSearch.jsp" target="left"><img src="${ctx}/images/btn_A_search_off.gif" style="cursor:pointer"/></a></li>
        <li style=" padding-top:15px;clear:both; "><img src="${ctx}/images/category_SIDE.gif"  /></li>
        </ul>
         <ul>
        <li class="f_whit_am">반경 위치 설정</li>
        <li style="float:left;"><img src="${ctx}/images/btn_Loc_point.gif" onclick="radiusSelectPoint();" style="cursor:pointer"/></li>       
        <li></li>
        </ul>
<fieldset style="padding:5px;">
        <legend class="f_whit_am">반경검색 옵션</legend>
             <ul>

            <li style="float:left;">
              <label for="textfield">검색반경</label>
              	<input type="text" name="search_radius" id="search_radius" style="width:120px; height:14px;padding-left:5px"onkeypress="keypress()" />
              	m
            </li>
            <li style="float:left;">
              <label for="textfield">건물 분류</label>
              <select name="bldgType" id="bldgType" style="width:120px; float:left;">
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
        </form><a href="#" onclick="radiusSearch();"><img src="${ctx}/images/btn_search.gif" style="float:right; margin:10px 0 10px 0"/></a>
</div>
</div>
    <div>
        <h4><img src="${ctx}/images/result_title.gif" alt="결과" width="340" height="34"/></h4>
        <div id="bbsCont" style="height:100%; overflow-y:yes; width:340px;">
        <iframe id="searchResult" name="searchResult" src="${ctx}/radious/blinkResultList.do"
						frameborder="0" width="100%" style="height: 520px" scrolling="no" />
					<table border="0" cellpadding="0" cellspacing="0" class="wps_100"
						title="list" summary="list">
					</table>
        </div>
    </div>
</div>
</body>
</html>
