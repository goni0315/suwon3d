<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<SCRIPT>
	function layOnOff(value){
		if(value=='weather'){
			var clsNm = document.getElementById("weather").className;
			if(clsNm=='off'){
				top.loadWeatherInfo();
				top.XDOCX.XDLaySetVisible("WEATHER",true);
				clsNm = "on";
			}else{
				top.XDOCX.XDLaySetVisible("WEATHER",false);
				top.XDOCX.XDUISetWorkMode(1);
				clsNm = "off";
			}
			document.getElementById("weather").className=clsNm;
		}
	}
	</SCRIPT>
</head>
<body>
<table>
<!-- 
		<tr align=center>		
			<td>0</td>
			<td>날씨</td>
			<td><a href="#" onclick="layOnOff('weather');return false;" class='off' id="weather">WEATHER</a></td>
			<td>1</td>
			<td>10000</td>
			<td>WEATHER</td>
			<td>날씨정보</td>
			<td>레이어(점)</td>
			<td>255</td>
			<td>255</td>
			<td>255</td>
			<td>N</td>
		</tr>
		 -->
	<c:forEach var="layerList" items="${layerListVos}">
		<tr align="center">
			<td>${layerList.lay_seq}</td>
			<td>${layerList.grp_nm}</td>
			<td>${layerList.file_nm}</td>
			<td>${layerList.hide_low}</td>
			<td>${layerList.hide_high}</td>
			<td>${layerList.eng_nm}</td>
			<td>${layerList.kor_nm}</td>
			<td>${layerList.data_type}</td>
			<td>${layerList.color_r}</td>
			<td>${layerList.color_g}</td>
			<td>${layerList.color_b}</td>
			<td>${layerList.f_view}</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>