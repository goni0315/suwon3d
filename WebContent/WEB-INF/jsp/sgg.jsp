<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시군구조회</title>
</head>
<body>
	
		<table>
		<tr>
			<td>
				<select>
					<option value="41113">권선구</option>
					<option value="41117">영통구</option>
					<option value="41111">장안구</option>
					<option value="41115">팔달구</option>
				</select>
			</td>
			<td>
				<input type="submit" value="검색">
			</td>
		</tr>
		</table>
		
		<c:forEach var="sms" items="${sggList}">
	<tr>
		<td>${sms.sgg_cd}, ${sms.sgg_nm}</td><br/><br/>
	</tr>
	</c:forEach>
</body>
</html>