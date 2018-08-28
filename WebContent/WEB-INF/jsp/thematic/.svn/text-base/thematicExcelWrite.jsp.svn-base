<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.io.File" %>
<%@ page import="jxl.Workbook" %>
<%@ page import="jxl.write.*" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>좌표지점 엑셀 추출</title>

<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script><!--callScript의 제이쿼리 함수를 위해 적용  -->
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<script type="text/javascript" src="${ctx}/js/common.js"></script>
</head>

<body>
<c:forEach var="thematic" items="${thematicExcelWriteList}">	
<input type="hidden" id="thematicPosX" name="thematicPosX" value="${thematic.pointX }"/> 
<input type="hidden" id="thematicPosY" name="thematicPosY" value="${thematic.pointY }"/>
</c:forEach>

<script>
 	window.close();
	location.href = "${ctx}/excel/thematicPoint.xls"; // 해당 위치 엑셀다운
//	location.href = "${ctx}/safetyRoad.do";
</script> 
</body>
</html>