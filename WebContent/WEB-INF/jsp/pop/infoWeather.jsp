<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>수원시 주간날씨정보</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<c:set var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<c:set var="staticSourcePath" value="http://105.1.2.121/data" scope="request" />

<link href="${contextPath}/css/weather/base.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/css/weather/ui-lightness/jquery-ui.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/css/weather/common.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/css/weather/layout.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${contextPath}/js/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript" src="${contextPath}/js/weather.js"></script>
</head>

<body style="background-color: #014A85">
<table width="518" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="95" height="25" valign="top"  style="background-image:url(${contextPath}/images/Weather/weather_topbg.gif);"><img src="${contextPath}/images/Weather/weather_top01.gif" width="94" height="23" /></td>
    <td width="423" align="right" valign="top"  style="background-image:url(${contextPath}/images/Weather/weather_topbg.gif);"><table width="316" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="230" align="left"><span class="f_whit">기준: ${ tm }</span></td>
          <td width="64"><a href="javascript:location.reload();"><img src="${contextPath}/images/traffic/its_top_re.gif" alt="" width="64" height="23" /></a></td>
          <td width="22"><img src="${contextPath}/images/traffic/its_top_close.gif" alt="" width="22" height="23" onclick="window.close();" style="cursor: hand;" /></td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td height="72" colspan="2" valign="top" style="background-image:url(${contextPath}/images/Weather/body_bg.gif);">
    <!-- class="typew" -->
    <table width="511" border="0" cellpadding="0" cellspacing="0">
    	<tr>
    		<c:forEach var="item" items="${ listWeekWeather }" varStatus="status">
    			<c:if test="${ status.index < 7 }">
		    		<td>
		    			<table border="0" cellpadding="0" cellspacing="0">
		    				<tr>
		        				<td class="f_w_whit">${ item.tmEf }(${ item.dayOfWeek })</td>
		        			</tr>
		        			<tr>
		        				<td width="73"><script type="text/javascript">getWeatherImgTag('${staticSourcePath}/symbols/symbol/weather/', '${ item.wf }');</script><!-- img src="${context7Path}/images/Weather/1.png" width="73" height="50" / --></td>
		        			</tr>
		        			<tr>
		        				<td class="f_w_whit">${ item.wf }</td>
		        			</tr>
		        			<tr>
		        				<td class="f_w_whit_n">${ item.tmn }℃ / ${ item.tmx }℃</td>
		        			</tr>
		    			</table>
		    		</td>
	    		</c:if>
    		</c:forEach>
    	</tr>
    </table>
</td>
  </tr>
</table>
<table width="518" border="0" cellpadding="0" cellspacing="0" style="background-image:url(${contextPath}/images/Weather/weather_topbg.gif);">
  <tr>
    <td width="95" valign="top"><img src="${contextPath}/images/Weather/weather_top02.gif" alt="" width="94" height="23" /></td>
    <td width="423" height="25" class="f_whit">${ suwonDongVO.value }</td>
  </tr>
  <tr>
    <td height="72" colspan="2" valign="top" style="background-image:url(${contextPath}/images/Weather/body_bg.gif);">
    
    <!-- class="typew" -->
    <table width="511" border="0" cellpadding="0" cellspacing="0">
    	<tr>
    		<c:forEach var="item" items="${ listDongWeather }" varStatus="status">
    			<c:if test="${ status.index < 7 }">
		    		<td>
		    			<table border="0" cellpadding="0" cellspacing="0">
		    				<tr>
		    					<td>
		    						<!-- <td class="f_w_whit">${ item.strDay }${ item.strHour }</td> -->
		    						<td class="f_w_whit">${ item.strHour }(${ item.dayOfWeek })</td>
		    					</td>
		    				</tr>
		    				<tr>
		    					<td>
		    						<td width="73"><script type="text/javascript">getWeatherImgTag('${staticSourcePath}/symbols/symbol/weather/', '${ item.wfKor }');</script><!-- img src="${contextPath}/images/Weather/1.png" alt="" width="73" height="50" / --></td>
		    					</td>
		    				</tr>
		    				<tr>
		    					<td>
		    						<td class="f_w_whit">${ item.wfKor }</td>
		    					</td>
		    				</tr>
		    				<tr>
		    					<td>
		    						<td class="f_w_whit_n">${ item.temp }℃</td>
		    					</td>
		    				</tr>
		    				<tr>
		    					<td>
		    						<td class="f_w_whit_n">
		    							<c:if test="${ not empty item.tmn }">${ item.tmn }℃</c:if><c:if test="${ empty item.tmn }">없음</c:if>/${ item.tmx }℃
		    						</td>
		    					</td>
		    				</tr>
		    			</table>
		    		</td>
	    		</c:if>
	    	</c:forEach>
    	</tr>
    </table>
</td>
  </tr>
</table>
</body>
</html>
