<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>대장정보조회</title>
<link href="css/realEstateCss/realEstateCommon.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
</head>
<script type="text/javascript">
var splitLandList = "${landUsuallyHeader}".split("&");

var bldgKCDList = splitLandList[0];
var dongNmList = splitLandList[1];
var bldgNmList = splitLandList[2];
var bldgKNmList = splitLandList[3];
var gareaList = splitLandList[4];


function UsuallyListView() {
	
	var rBldgKCDList = bldgKCDList.split(",");
	var rDongNmList = dongNmList.split(",");
	var rBldgNmList = bldgNmList.split(",");
	var rBldgKNmList = bldgKCDList.split(",");
	var rGareaList = gareaList.split(",");
	
	for(var i=0;i <= rBldgKCDList.length-2;i++){
		$('#landUsually').append($(
				'<tr>' + 
				'<td align="center">' + rBldgKCDList[i] + '</td>' +
				'<td align="center">' + rDongNmList[i] + '</td>' +
				'<td align="center">' + rBldgNmList[i] + '</td>' +
				'<td align="center">' + rBldgKNmList[i] + '</td>' +
				'<td align="center">' + rGareaList[i] + '</td>' +
				'</tr>'
				));
	}
}
/* 
//동명칭
function priceListView() {
	var rPriceList = priceList.split(",");
	for(var i=0;i <= rPriceList.length-2;i++){
		var val = addComma(rPriceList[i]);
		$('#price').append($('<td align="center">\\' + val + '원</td>'));
	}
}

//건물명칭
function landAreaListView() {
	var rLandAreaList = landAreaList.split(",");
	for(var i=0;i <= rLandAreaList.length-2;i++){
		$('#land').append($('<td align="center">' + rLandAreaList[i] + '㎥</td>'));
	}
}

//건물종류명
function bldgAreaListView() {
	var rBldgAreaList = bldgAreaList.split(",");
	for(var i=0;i <= rBldgAreaList.length-2;i++){
		$('#bldg').append($('<td align="center">' + rBldgAreaList[i] + '㎥</td>'));
	}
}

//연면적
function bldgAreaListView() {
	var rBldgAreaList = bldgAreaList.split(",");
	for(var i=0;i <= rBldgAreaList.length-2;i++){
		$('#bldg').append($('<td align="center">' + rBldgAreaList[i] + '㎥</td>'));
	}
} */

</script>
<body onload="UsuallyListView()">
<div id="wrap">
	<div id="header">
    	<ul class="menu_tab">
        	<li><a href="${ctx}/realEstateCadastre.do?pnu=${pnu}">토지정보</a></li>
            <li><a href="${ctx}/realEstateGeneralHeader.do?pnu=${pnu}" class="on">건축정보</a></li>
        </ul>
    </div>
    <div id="container">
    	<ul class="sub_tab">
        	<li><a href="${ctx}/realEstateGeneralHeader.do?pnu=${pnu}">건축물대장 총괄표제부</a></li>
            <li><a href="${ctx}/realEstateUsuallyHeader.do?pnu=${pnu}" class="on">건축물대장 일반/표제부</a></li>
            <!-- <li><a href="#">건축물대장 전유부</a></li> -->
        </ul>
		<div class="content">
          <table id="landUsually" cellpadding="0" cellspacing="0" class="t_style02">
          	<colgroup>
            	<col width="20%" />
                <col width="20%" />
                <col width="20%" />
                <col width="20%" />
                <col width="20%" />
            </colgroup>
          	<tr>
            	<th>건물종류번호</th>
                <th>동명칭</th>
                <th>건물명칭</th>
                <th>건물종류명</th>
                <th>연면적</th>
            </tr>
            <!-- <tr>
            	<td><input id="landInfo0" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
                <td><input id="landInfo1" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
                <td><input id="landInfo2" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
                <td><input id="landInfo3" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
                <td><input id="landInfo4" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
            </tr> -->
          </table>
          <p class="explain">*자료가 없거나, 조회내용 외 상세한 정보를 원하시면 관련 부서에 문의하시기 바랍니다.</p>
        <!-- <div class="save">
        	<a href="#"><img src="images/btn_save.gif"></a>
        </div> -->
      </div>
    </div>
</div>
</body>
</html>