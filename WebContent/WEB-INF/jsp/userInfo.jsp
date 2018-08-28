<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사용자 정보조회페이지</title>
</head>
<body>
	<form action = "userInfoSearch.do" method="get">
	사용자 로그인시: <input type = "text" value="001017521" name="usrId">
	<input type = "submit" value="로그인">
		<c:forEach var="sms" items="${userInfoList}" >
			<tr>       
				<td>${sms.usrid} ${sms.com_add} ${sms.str_tme} ${sms.con_brw} ${sms.con_pth}</td>	
			</tr>
		</c:forEach>
	</form>
</body>
</html>
