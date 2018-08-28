<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<script type="text/javascript">


function gasPipeInfo(ftr_idn){	
 
	var w=window.open(WEB_SERVER_URL+"/GasPipeInfo.do?ftr_idn="+ftr_idn,"_blank","width=450px,height=200px");	
//	alert("ftr_idn : " + ftr_idn);
//	w.moveTo(screen.availWidth/2-700/2,screen.availHeight/2 - 550/2);	
}
</script>
<body>
<form id="frm" action ="" method = "get">
	 관리번호 :
	<input type="text" id="ftr_idn" name="ftr_idn" value="" ><!-- value="36383" --> 
	<input type="button"  name="ftr_" onclick="gasPipeInfo(ftr_idn.value)"   value="검색"><br><br><br>
</form>
</body>
</html>