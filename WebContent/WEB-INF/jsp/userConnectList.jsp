<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
	String today = formatter.format(new java.util.Date()); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사용자 접속 정보 목록</title>
<script type="text/javascript">
	function searchReset() {
		var value = document.searchForm;
		value.startDate.value="";
		value.endDate.value="";
		value.usrid.value="";
	}
	function testValue() {
		var value = document.searchForm;
		value.startDate.value="20140114";
		value.endDate.value=<%=today%>;
		value.usrid.value="001017521";
	}
</script>
</head>
<body>
<form name="searchForm" action="userConnectList.do" method="get">
검색날짜 : <input type="text" id="startDate" name="startDate" value="20140114"> ~ 
<input type="text" id="endDate" name="endDate" value="<%=today%>">
사용자 ID : <input type="text" id="usrid" name="usrid" value="001017521">
<input type="submit" value="검색">
<input type="button" value="초기화" onclick="searchReset()">
<input type="button" value="테스트값" onclick="testValue()">
</form>
<table>
		<tr align="center">
			<td>번호</td>
			<td>사용자ID</td>
			<td>사용자 접속IP</td>
			<td>사용자 접속시간</td>
			<td>사용자 접속브라우저</td>
			<td>사용자 접속경로</td>
		</tr>
	<c:forEach var="userConnectInfo" items="${connectListVos}">
		<tr align="center">
			<td>${userConnectInfo.con_seq}</td>
			<td>${userConnectInfo.usrid} |</td>
			<td>${userConnectInfo.com_add} |</td>
			<td>${userConnectInfo.str_tme} |</td>
			<td>${userConnectInfo.con_brw} </td>
			<td>${userConnectInfo.con_pth} </td>
		</tr>
	</c:forEach>
</table>


</body>
</html>