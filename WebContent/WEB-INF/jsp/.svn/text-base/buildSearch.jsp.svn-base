<!-- 
	수원시 3차원 활용시스템 메인 >> 검색기능 >> 도로명검색 결과 페이지
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>도로명검색결과</title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/css/common.css" />

<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/roadView.js"></script>
<script type="text/javascript" src="${ctx}/js/Properties.js"></script>
<script type="text/javascript" src="${ctx}/js/xml2json.js"></script>
<!-- <script type="text/javascript" src="${ctx}/js/GeoTrans.js"></script>  -->
<script type="text/javascript" src="${ctx}/js/proj4js-compressed.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.xdomainajax.js"></script>
<script type="text/javascript" src="${ctx}/js/common.js"></script>


<script>

 //좌표 변환 관련 prj4.js [S]
Proj4js.defs["SR-ORG:6640"] = "+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=600000 +ellps=GRS80 +units=m +no_defs";
Proj4js.defs['WGS84경위도'] = '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs';
Proj4js.defs['KATEC'] =
'+proj=tmerc +lat_0=38 +lon_0=128 +k=0.9999 +x_0=400000 +y_0=600000 +ellps=bessel +towgs84=-146.43,507.89,681.46,0,0,0,0 +units=m +no_defs';

Proj4js.reportError = function(msg) { alert(msg); }
  
var wgs84 = new Proj4js.Proj('WGS84경위도');
var grs80tm = new Proj4js.Proj('SR-ORG:6640');
var katec = new Proj4js.Proj('KATEC');
//좌표 변환 관련 prj4.js [E]

/*KLIS 한국토지 정보 시스템연계 링크걸기(부동산 정보 열람) */
function jibunInfo(pnu){
	
	var w=window.open("http://klis.gg.go.kr/sis/main.do","_blank","width=100px,height=100px");
	var url="http://klis.gg.go.kr/sis/info/baseInfo/baseInfo.do?";
	url+="service=baseInfo&landcode="+pnu+"&gblDivName=baseInfo&scale=0&gyujae=0";
	var win="";
	try{
		win=window.open(url,"addrInfoWin","");
		w.close();
	}catch(e){
		if(w!='null'){
			w.close();
		}
	}	
}
/*
 * 좌표이동
 */
function doView(layer, keycode){
	
	top.MapControl('cam_3rdmode');
	var pos = top.XDOCX.XDSrcObjPosition(layer, keycode, false);
	pos = pos.split(',');
	//alert("layer : " + layer + "|" +pos);
	top.searchXDPointPosition(pos[0], pos[2]);
	
}

/**
 * 로드뷰 분기 함수  
 */
function doRoadView(keycode,flag){
	
	var pos = top.XDOCX.XDSrcObjPosition('KO3D_PL_BBND', keycode, false);
	
	pos = pos.split(',');
		
	var p = new Proj4js.Point(pos[0],pos[2]);
	
	if(flag=="daum"){
		Proj4js.transform(grs80tm, wgs84, p);
		//alert((Math.round(p.x*1000)/1000) +"  /// " + (Math.round(p.y*1000)/1000));
		ShowRoadView(Math.round(p.x*1000)/1000,Math.round(p.y*1000)/1000); //건물 좌표에는 로드뷰 정보가 없어서 반올림해서 표현
		
		
	}else{
		Proj4js.transform(grs80tm, katec, p);
		ShowStreetView(Math.round(p.x),Math.round(p.y));
		
	}
}

 

</script>
</head>
<!--  건물검색어 입력 항목과 검색결과가 나타나는 페이지 -->
<body>
	<div id="bbsCont" style="height: 100%; width: 340px; overflow-y: auto;" >
		<table border="0" cellpadding="0" cellspacing="0"
			title="list" summary="list">
			<col class="w_30" />
			<col />
			<col class="w_60" />
			<thead>
				<tr>
					<th>No</th>
					<th>수원시 DB 검색결과</th>
					<th>정보</th>
				</tr>
				<c:if test="${not empty boardList}">
					<c:forEach var="sms" items="${boardList}" varStatus="status">
						<tr>
							<td rowspan="3" align="center" class="f_dblue_b">${status.count}</td>
							<td class="f_orange_b" onclick="javascript:doView('KO3D_PL_BBND', '<c:out value="${sms.pnu}"></c:out>')" style="cursor: pointer;">${sms.buld_nm}<c:if test="${not empty sms.buld_nm_dc}"><span class="f_olive">(${sms.buld_nm_dc})</span></c:if></td>
							<td align="center"></td>
						</tr>
						<tr>
							<td>${sms.sgg_nm} ${sms.rn} ${sms.buld_mnnm}
								<c:if test="${sms.buld_slno!=0}">- ${sms.buld_slno}</c:if>
							</td>
								<!--  여기 이동 기능 삽입해주세요 -->
							<td align="center">
							<img
								src="${ctx}/images/btn_land2.gif" alt="토지대장"
								style="cursor: pointer;" onclick="jibunInfo('${sms.pnu}')" />
							</td><!-- "return false;" -->
						</tr>
						<tr>
							<td>${sms.sgg_nm} ${sms.addr } ${sms.lnbr_mnnm}
								<c:if test="${sms.lnbr_slno!=0}">- ${sms.lnbr_slno}</c:if>
							</td>
							<td align="center">
								<!-- 로드뷰 기능 삽입 예정 아직 구현 안됨 -->
								<img src='${ctx}/images/potal/daum.png' alt='로드뷰' style='cursor: pointer;' onclick='doRoadView("${sms.pnu}","daum")' />&nbsp;&nbsp;
								<img src='${ctx}/images/potal/naver.png' alt='거르뷰' style='cursor: pointer;' onclick='doRoadView("${sms.pnu}","naver")'/>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</thead>
			<c:if test="${empty boardList}">
				<tr>
					<td colspan=5>검색된 결과가 없습니다.</td>
				</tr>
			</c:if>
		</table>
		<br>
		<c:if test="${total_dataCount != 0}">
			<div align="center">
				<span style="font-size: 12px;height:40px">${pageIndexList}</span>
			</div>
		</c:if>
	</div>
</body>
</html>


 
 